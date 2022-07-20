# annotate-genes
Filter GO annotations for a list of genes using mygene.info via R

## Installation
The `annotate-genes.R` script contains a set of functions that you can source in order to make them available in your R environment.

_Note: the dependency on the [mygene](https://bioconductor.org/packages/release/bioc/html/mygene.html) package proved to be tricky on a M1X Mac (see notes in script)._

## Usage
Once you have successfully sourced the function-containting script, `annotate-genes.R`, then you can simply pass a list of genes to the `makeAnnotationDF` function to generate an R-friendly data.frame with the GO annotations you want. Query genes can be provided as symbols, NCBI Gene IDs or Ensembl IDs.

For example:
```
my.gene.list <- c("sox9", "tbx5")

#annotate with GO terms from the molecular function branch
my.df <- makeAnnotationDF(my.gene.list, species='mouse', go.branch = "MF")

#or, annotate only with MF GO terms that contain "transcription factor"
my.df2 <- makeAnnotationDF(my.gene.list, species='mouse', go.branch = "MF", pattern="^.*transcription factor.*$")
```

And the output include the query gene, GO term name, GO ID, [evidences](https://wiki.geneontology.org/index.php/Guide_to_GO_Evidence_Codes) and [qualifiers](https://wiki.geneontology.org/index.php/Annotation_Relations):
```
   gene                                                                            term         id evidences      qualifiers
1  sox9                                                            beta-catenin binding GO:0008013   IDA,IPI enables,enables
2  sox9                             cis-regulatory region sequence-specific DNA binding GO:0000987       IDA         enables
3  sox9                                                                     DNA binding GO:0003677       IDA         enables
4  sox9        DNA-binding transcription activator activity, RNA polymerase II-specific GO:0001228       IDA         enables
5  sox9                                       DNA-binding transcription factor activity GO:0003700   IDA,IMP enables,enables
6  sox9           DNA-binding transcription factor activity, RNA polymerase II-specific GO:0000981       IDA         enables
7  sox9                                                       pre-mRNA intronic binding GO:0097157       IDA         enables
8  sox9                                                                 protein binding GO:0005515       IPI         enables
9  sox9           RNA polymerase II cis-regulatory region sequence-specific DNA binding GO:0000978       IDA         enables
10 sox9                                                   sequence-specific DNA binding GO:0043565       IDA         enables
11 sox9                                     transcription cis-regulatory region binding GO:0000976       IDA         enables
12 tbx5                                                                     DNA binding GO:0003677       IDA         enables
13 tbx5        DNA-binding transcription activator activity, RNA polymerase II-specific GO:0001228       IDA         enables
14 tbx5                                       DNA-binding transcription factor activity GO:0003700       IDA         enables
15 tbx5                                                                 protein binding GO:0005515       IPI         enables
16 tbx5           RNA polymerase II cis-regulatory region sequence-specific DNA binding GO:0000978       IDA         enables
17 tbx5 RNA polymerase II transcription regulatory region sequence-specific DNA binding GO:0000977       IDA         enables
```

See the parameter options per function in the `annotate-genes.R` script.

