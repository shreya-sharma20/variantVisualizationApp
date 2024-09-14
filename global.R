library(shiny)
library(bs4Dash)
library(data.table)
library(dplyr)
library(igvShiny)
library(VariantAnnotation)
library(ggplot2)
library(dplyr)
library(plotly)



data <- system.file(package="igvShiny", "extdata", "chr19-cebpaRegion.vcf.gz")
vcfObject <- readVcf(data, "hg38")
vcf <- as.data.frame(rowRanges(vcfObject))

# Add REF and ALT values
vcf$REF <- sapply(ref(vcfObject), function(x) paste(x, collapse = ","))
vcf$ALT <- sapply(alt(vcfObject), function(x) paste(x, collapse = ","))
vcf$VariantType <- ifelse(nchar(vcf$REF) != nchar(vcf$ALT), "INDEL", "SNP")

dp <- info(vcfObject)$DP
vcf <- vcf %>% mutate(DP=dp)

vcfData <- reactiveValues()
vcfData$obj <- vcfObject
vcfData$vcf <- vcf

source('utilities.R')