# annotate-genes
Filter GO annotations for a list of genes using mygene.info via R

## Installation
The `annotate-genes.R` script contains a set of functions that you can source in order to make them available in your R environment.

_Note: the dependency on the [mygene](https://bioconductor.org/packages/release/bioc/html/mygene.html) package proved to be tricky on a M1X Mac (see notes in script)._

## Usage
Once you have successfully sourced the function-containting script, `annotate-genes.R`, then you can simply pass a list of genes to the `makeAnnotationDF` function to generate an R-friendly data.frame with the GO annotations you want.

For example:
```
my.gene.list <- c("sox9", "tbx5")

#annotate with GO terms from the molecular function branch
my.df <- makeAnnotationDF(my.gene.list, species='mouse', go.branch = "MF")

#or, annotate only with MF GO terms that contain "transcription factor"
my.df2 <- makeAnnotationDF(my.gene.list, species='mouse', go.branch = "MF", pattern="^.*transcription factor.*$")
```

See the parameter options per function in the `annotate-genes.R` script.

