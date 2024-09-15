## Background

#### VCF File
- A VCF (Variant Call Format) file is a standard text format used to store information about genetic variants, such as single nucleotide polymorphisms (SNPs) and insertions/deletions (INDELs) within a genome. 
- It includes details like the variant’s position, type, and quality. 
- The variant can be classified as a SNP or INDEL. SNPs (Single Nucleotide Polymorphisms) are variations at a single nucleotide position in the DNA sequence, while INDELs (Insertions/Deletions) refer to the addition or removal of small segments of DNA.
- Both types of variants can influence gene function and are crucial for studying genetic diversity and disease.

#### Integrative Genomics Viewer (IGV)
- IGV is a powerful tool for visualizing genomic data.
- It provides a graphical interface to examine the genomic context of variants, such as their exact locations, the surrounding sequence, and coverage depth. 
- This helps in understanding how variants might impact gene function or contribute to diseases.

## Variant Visualization Application
- This application uses a pre-loaded VCF file to visualize variants in IGV (using `igvshiny` R library)
- The first tab of the application loads IGV and the variant data. User can select the row corresponding to the variant of interest in the variant table to visualize the variant in IGV.
- In the second tab, the app explores the variant data by constructing the following plots:
  - Scatter plot displaying depth of coverage across the entire chromnosome.
  - Histogram indicating the distribution of variant quality scores.
  - Bar plot indicating the count of SNPs and INDELS in the VCF file.
  - Bar plot indicating the transitions and transversions in the data.
 - The data is preloaded in the application. To acces the data, the following command can be executed in R:  
   `data <- system.file(package="igvShiny", "extdata", "chr19-cebpaRegion.vcf.gz")`
