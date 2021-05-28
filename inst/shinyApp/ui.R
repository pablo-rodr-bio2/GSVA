dashboardPage(
  title = "GSVA Shiny Application",
  dark = TRUE,
  header = bs4DashNavbar(
    title = bs4DashBrand( title = "GSVA Shiny Application", image = "GSVA.png", opacity = 1)
  ),
  
  sidebar = dashboardSidebar(
    width = "320px",
    minified = FALSE,
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
    ),
    br(),
    div(h3("DATA INPUT", style="font-weight: bold"), align = "center"),
    br(),
    matrixUI("matrix1"),
    geneSetsUI("genes1"),
    fluidRow(
      column(width = 12, align ="center",
             div("CHANGE DEFAULT SETTINGS?", align = "center"),
             # actionButton(inputId = "arg", label = "CHANGE")
             # materialSwitch(inputId = "arg", label = "CHANGE", status = "success")
             switchInput(inputId = "arg", value = FALSE)
             )
      ),
    br(),
    fluidRow(
      column(width = 12, align = "center",
             actionButton("button", "RUN", class = "run-btn", icon = icon("play-circle"),
                          width = "10vw"),
             downloadUI("download"),
             closeBtnUI("close")
             )
      )
  ),
  
  body = dashboardBody(
    shinyjs::useShinyjs(),
    add_busy_spinner(spin = "cube-grid", position = "bottom-right",
                     height = "100px", width = "100px"),
    fluidRow(
      box(
        width = 12,
        collapsible = FALSE,
        headerBorder = FALSE,
        tabsetPanel(id = "Panels", type="tabs",
                    tabPanel("Samples",
                             textOutput("errorsGsva"),
                             htmlOutput("text1"),
                             plot1_UI("plot1"),
                             br(),
                             fluidRow(
                               column(
                                 width = 12,
                                 align = "center",
                                 tableOutput("result")
                               )
                             )
                    ),
                    tabPanel("GeneSets",
                             uiOutput("text2"),
                             htmlOutput("text3"),
                             plot2_UI("plot2"),
                             plot3_UI("plot3")
                    ),
                    tabPanel("Session Info",
                             verbatimTextOutput("sessionInfo"))
        )
      )
    )
  ),
  controlbar = dashboardControlbar(
    id = "controlbar",
    overlay = FALSE,
    controlbarMenu(
      controlbarItem(
        title = "PARAMETERS",
        argumentsDataUI("argumentsInput")
      )
    )
  )
)
