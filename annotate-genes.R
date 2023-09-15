## FUNCTIONS TO ANNOTATE GENES WITH GO

# Query mygene.info in R
# http://www.bioconductor.org/packages/release/bioc/html/mygene.html

## Installation of "mygene" can be tricky with Mac M1 chip:
#BiocManager::install("mygene") #answer "Yes" to "install from source?" prompts
# may also need: brew install gfortran xz
# and replace lines in /Library/Frameworks/R.framework/Versions/4.2-arm64/Resources/etc/Makeconf:
# FC = /opt/homebrew/bin/gfortran -mtune=native
# FLIBS =  -L/opt/homebrew/Cellar/gcc/11.3.0_2/lib/gcc/11/gcc/aarch64-apple-darwin21/11 -L/opt/homebrew/Cellar/gcc/11.3.0_2/lib/gcc/11 -lgfortran -lemutls_w -lquadmath
# CPPFLAGS = -I/opt/R/arm64/include -I/opt/homebrew/include

library(mygene)
library(tidyverse)
options(dplyr.summarise.inform = FALSE)

#############
#' @title annotationDF2Matrix
#' @description generates a binary matrix of all unique terms (columns) 
#' annotating a set of genes (rows).
#' @param df = data.frame with gene and term columns (see makeAnnotationDF)
#' @return data.frame representing a binary matrix
#' @examples 
#' my.mtx <- annotationDF2Matrix(my.df)
annotationDF2Matrix <- function(df){
  # coming soon!
}

#############
#' @title makeAnnotationDF
#' @description generates a data.frame all unique terms 
#' annotating a list of genes, including term id, evidences and qualifiers.
#' @param gene.list = list of genes (see id.type)
#' @param id.type = type of IDs provided, either: symbol (default), entrezgene, ensembl.gene
#' @param species = organism source of genes, either: human (default), mouse, rat, 
#' fruitfly, nematode, zebrafish, thale-cress, frog and pig, or taxonomy id.
#' @param go.branch = branch of GO, either: "BP" (default), "MF", "CC"
#' @param evidence = evidence filter, either: "exp" (default) for experimental
#' codes only, "noiea" for everything except IEA, or "all" for everything
#' @param pattern = optional pattern to apply grep on GO term names
#' @details The output includes a column of evidences using the codes from GO:
#' http://geneontology.org/docs/guide-go-evidence-codes/
#' @return data.frame
#' @examples 
#' my.gene.list <- c("sox9", "tbx5")
#' my.df <- makeAnnotationDF(my.gene.list, species='mouse', go.branch = "MF")
#' my.df <- makeAnnotationDF(my.gene.list, species='mouse', go.branch = "MF", pattern="^.*transcription factor.*$")

makeAnnotationDF <- function (gene.list, id.type='symbol', species='human', 
                                  go.branch = "BP", evidence = "exp", 
                                  pattern = NULL){
  
  res <- queryMany(gene.list, scopes=id.type, fields=c('go'), species=species)
  
  # grab results for the selected GO branch
  res.go <- res$go.BP
  if (go.branch == "MF")
    res.go <- res$go.MF
  else if (go.branch == "CC")
    res.go <- res$go.CC
  
  # make simple, long df of query genes and filtered GO terms
  df <- data.frame(gene=character(),term=character(), id=character(),
                   evidences=character(), qualifiers=character())
  for (i in 1:length(res.go)){
    gene <- res$query[[i]]
    this.res.go <- as.data.frame(res.go[[i]])
    terms <- list()
    if(nrow(this.res.go) > 0){
      if(evidence == "exp"){
        terms <- this.res.go %>%
          filter(evidence %in% c("EDA","IDA","IPI","IMP","IMP","IGI","IEP")) %>%
          distinct(term,id,evidence,qualifier)
      } else if (evidence == "noiea"){
        terms <- this.res.go %>%
          filter(!evidence %in% c("IEA")) %>%
          distinct(term,id,evidence,qualifier)
      } else { #all
        terms <- this.res.go %>%
          distinct(term,id,evidence,qualifier)
      }
      if(nrow(terms) >0){
        df.this <- data.frame(gene, terms)
        if (!is.null(pattern)){
          df.this <- df.this %>%
            filter(grepl(pattern, term))
        }
        if(nrow(df.this > 0)){
          df.this <- df.this %>%
            group_by(gene, term, id) %>%
            summarise(evidences = paste(evidence, collapse = ","), qualifiers = paste(qualifier, collapse = ","))
          df <- rbind(df, df.this)
        }
      }
    }
  }
  
  return(as.data.frame(df))
}