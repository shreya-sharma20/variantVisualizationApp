ui = dashboardPage(
  title = "Variant Data Visualization",
  header = dashboardHeader(title = "Variant Data Visualization"),
  controlbar = NULL,
  footer = NULL,
  fullscreen = TRUE,
  dark = NULL,
  scrollToTop = TRUE,
  sidebar = bs4DashSidebar(
    disable = FALSE,
    status = "primary",
    skin = "light",
    elevation = 3,
    width = 250,
    sidebarMenu(
        id = "sidebarMenu",
        menuItem(
          text = "IGV Visualization",
          tabName = "exploreTab",
          icon=icon("dna")
        ),
        menuItem(
          text = "Data Visualization",
          tabName = "plotTab",
          icon=icon("vials")
        )
      ),
    div(style = "position: absolute; bottom: 0; width: 95%; overflow-x: hidden;",
        tags$a(
            href="https://procogia.com",target="_blank",
            tags$img(src = "procogia-logo.png", style = "max-width: 90%; height: auto; display: block; margin-left: auto; margin-right: auto; padding-bottom: 25px;")
        )
    )
  ),
  body = dashboardBody(
    tabItems(
        tabItem(
          tabName = "exploreTab",
          fluidRow(
            box(
                width=12,
                title="IGV Visualization", solidHeader = TRUE, collapsible = TRUE, 
                igvShinyOutput('igvShiny')
            )
          ),
          fluidRow(
            box(
                width=12,
                title="Variant Data", solidHeader = TRUE, collapsible = TRUE, 
                DT::DTOutput("vcfDataTable")
            )
          )
        ),
        tabItem(
          tabName = "plotTab",
            fluidRow(
                column(
                    width = 6,
                    plotlyOutput("varDpPlot")
                ),
                column(
                    width = 6,
                    plotlyOutput("varQualPlot")
                )
            ),
            br(),
            fluidRow(
                column(
                    width = 6,
                    plotlyOutput("varTypePlot")
                ),
                column(
                    width = 6,
                    plotlyOutput("varTiTvPlot")
                )
            )
        )
    )
  )
)