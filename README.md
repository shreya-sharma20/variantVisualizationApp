# variantVisualizationApp

- This application uses a pre-loaded VCF file to visualize variants in IGV (using `igvshiny` R library)
- The first tab of the application loads IGV and the variant data. User can select the row corresponding to the variant of interest in the variant table to visualize the variant in IGV.
- In the second tab, the app explores the variant data by constructing the following plots:
  - Scatter plot displaying depth of coverage across the entire chromnosome.
  - Histogram indicating the distribution of variant quality scores.
  - Bar plot indicating the count of SNPs and INDELS in the VCF file.
  - Bar plot indicating the transitions and transversions in the data.
 - The data is preloaded in the application. To acces the data, the following command can be executed in R:  
   `data <- system.file(package="igvShiny", "extdata", "chr19-cebpaRegion.vcf.gz")`
