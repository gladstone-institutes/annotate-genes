# GB-RT-1311

# source annotate-genes.R to load the functions used below.

## Oligo gene list
oligo.list <- read.table("~/Desktop/Oligo_DEGs_5Xfib_v_5X_withFullGeneName.csv", 
                         sep = ",",header = T, stringsAsFactors = F) 
# run makeAnnotationDF: 3 filters
oligo.df <- makeAnnotationDF(oligo.list$gene, species='mouse', go.branch = "MF", pattern="^.*transcription factor.*$")
oligo.df2 <- makeAnnotationDF(oligo.list$gene, species='mouse', go.branch = "CC", pattern="^.*plasma membrane.*$")
oligo.df3 <- makeAnnotationDF(oligo.list$gene, species='mouse', go.branch = "CC", pattern="^.*extracellular space.*$")
# save output
write.table(oligo.df, "~/Desktop/Oligo_DEGs_5Xfib_v_5X_withFullGeneName__MF_TF.csv",
            row.names = F, col.names = T, sep = ",")
write.table(oligo.df2, "~/Desktop/Oligo_DEGs_5Xfib_v_5X_withFullGeneName__CC_PM.csv",
            row.names = F, col.names = T, sep = ",")
write.table(oligo.df3, "~/Desktop/Oligo_DEGs_5Xfib_v_5X_withFullGeneName__CC_ES.csv",
            row.names = F, col.names = T, sep = ",")

## OPC gene list
opc.list <- read.table("~/Desktop/OPC_DEGs_5Xfib_v_5X_withFullGeneName.csv", 
                       sep = ",",header = T, stringsAsFactors = F) 
# run makeAnnotationDF: 3 filters
opc.df <- makeAnnotationDF(opc.list$gene, species='mouse', go.branch = "MF", pattern="^.*transcription factor.*$")
opc.df2 <- makeAnnotationDF(opc.list$gene, species='mouse', go.branch = "CC", pattern="^.*plasma membrane.*$")
opc.df3 <- makeAnnotationDF(opc.list$gene, species='mouse', go.branch = "CC", pattern="^.*extracellular space.*$")
# save output
write.table(opc.df, "~/Desktop/OPC_DEGs_5Xfib_v_5X_withFullGeneName__MF_TF.csv",
            row.names = F, col.names = T, sep = ",")
write.table(opc.df2, "~/Desktop/OPC_DEGs_5Xfib_v_5X_withFullGeneName__CC_PM.csv",
            row.names = F, col.names = T, sep = ",")
write.table(opc.df3, "~/Desktop/OPC_DEGs_5Xfib_v_5X_withFullGeneName__CC_ES.csv",
            row.names = F, col.names = T, sep = ",")