server <- function(input, output, session) {
    output$varTiTvPlot <- renderPlotly({
      req(vcfData$vcf)
      
      # Apply the function to classify each substitution
      vcf_data <- vcfData$vcf %>%
        mutate(Substitution_Type = mapply(classify_substitution, REF, ALT)) %>%
        filter(!is.na(Substitution_Type))

      # Count occurrences of each substitution type
      substitution_counts <- vcf_data %>%
        dplyr::count(Substitution_Type)

      # Plot the results
      p <- ggplot(substitution_counts, aes(x = Substitution_Type, y = n, fill = Substitution_Type)) +
        geom_bar(stat = "identity") +
        labs(x = "Substitution Type", y = "Count", title = "Counts of Transitions and Transversions") +
        theme_minimal() +
        scale_fill_manual(values = c("skyblue", "lightcoral")) +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))

      p %>% ggplotly()

    })

    output$varTypePlot <- renderPlotly({
        req(vcfData$vcf)

        # Count variant types
        variant_type_counts <- vcfData$vcf %>% dplyr::count(VariantType)

        # Plot
        p <- ggplot(variant_type_counts, aes(x = VariantType, y = n, color=VariantType, fill=VariantType)) +
                geom_bar(stat = "identity") +
                theme_minimal() +
                labs(title = "Distribution of Variant Types", x = "Variant Type", y = "Count")
        p %>% ggplotly()

    })

    output$varQualPlot <- renderPlotly({
      req(vcfData$vcf)

      qual_df <- vcfData$vcf %>% select(QUAL) %>% as.data.frame()
      qual_df$QUAL <- as.numeric(qual_df$QUAL)
      qual_df <- na.omit(qual_df)

      p <- ggplot(qual_df, aes(x = QUAL)) +
      geom_histogram(binwidth = 0.01, fill = "dodgerblue1", color = "black", alpha=0.7) +
      theme_minimal() +
      labs(title = "Distribution of Variant Quality Scores", x = "Quality Score", y = "Count")

      p %>% ggplotly()
    })

    output$varDpPlot <- renderPlotly({
      req(vcfData$vcf)
      vcf_data <- vcfData$vcf

      # Line plot of Depth of Coverage (DP) across positions on chromosome
      p <- ggplot(vcf_data, aes(x = start, y = DP)) +
        geom_line(color = "palevioletred2") +
        geom_point(color = "palevioletred2", size = 1) +
        labs(x = "Genomic Position", y = "Depth of Coverage (DP)", title = "Depth of Coverage Across Chromosome 19") +
        theme_minimal() +
        scale_x_continuous(breaks = scales::pretty_breaks(n = 10)) +
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))


      p %>% ggplotly()
    })

    output$vcfDataTable <- DT::renderDT({
        req(vcfData$vcf)
        data <- vcfData$vcf %>% select(-paramRangeID) %>% select(-width) %>% select(-strand)
        colnames(data) <- c("Chromosome","Start","End","Ref","Alt","Quality","Filter","Type","DP")
        DT::datatable(
            data,
            class = "compact cell-border stripe",
            options = list(
                scrollX = TRUE,
                searching=TRUE,
                pageLength = 5,
                dom='Bfrtip'
            ),
            rownames= FALSE,
            selection = list(
                mode = 'single',
                selected = 1,
                target="row"
            ),
            filter='bottom'
        )
    })

    output$igvShiny <- renderIgvShiny({ 
        options <- igvShiny::parseAndValidateGenomeSpec(genomeName="hg38",  initialLocus="MEF2C")
        igvShiny::igvShiny(options)
    })
 
    observeEvent(input$vcfDataTable_rows_selected,{
        chr <- vcfData$vcf[input$vcfDataTable_rows_selected,1]
        start <- vcfData$vcf[input$vcfDataTable_rows_selected,2] - 100
        end <- vcfData$vcf[input$vcfDataTable_rows_selected,3] + 100
        peak <- paste0(chr,":",start,"-",end)
        igvShiny::showGenomicRegion(id="igvShiny", session=session, region=peak)
        loadVcfTrack(session, id="igvShiny", trackName="VCF", vcfData$obj)
    })
}