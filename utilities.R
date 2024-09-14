# Define a function to classify substitutions
classify_substitution <- function(ref, alt) {
    if (nchar(ref) == 1 && nchar(alt) == 1) {
    transitions <- c("A>G", "G>A", "C>T", "T>C")
    transversions <- c("A>C", "A>T", "G>C", "G>T", "C>A", "C>T", "T>A", "T>G")
    
    substitution <- paste(ref, ">", alt, sep = "")
    
    if (substitution %in% transitions) {
        return("Transition")
    } else if (substitution %in% transversions) {
        return("Transversion")
    } else {
        return(NA)
    }
    } else {
    return(NA)  # Handle cases that are not single nucleotide substitutions
    }
}