matrixUI <- function(id){
  ns <- NS(id)
  tagList(
    radioButtons(ns("matrixSourceType"),
                 label = h5("EXPRESSION MATRIX", style="font-weight: bold"),
                 choices = c("From file" = "fileMatrix",
                             "From workspace" = "varMatrix")),
    conditionalPanel(
      condition = "input.matrixSourceType == 'fileMatrix'", ns = ns,
      fileInput(ns("matrixFile"), label = NULL,
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv",".ods",".xls",".xlt"))
    ),
    conditionalPanel(
      condition = "input.matrixSourceType == 'varMatrix'", ns= ns,
      selectInput(ns("matrixVar"), label = NULL,
                  ls(envir=.GlobalEnv))
    )
  )
  
}

matrixServer <- function(id){
  moduleServer( id, function(input, output, session){
    matrix <- reactive({
      if(input$matrixSourceType=="fileMatrix"){
        if(is.null(input$matrixFile)) return(NULL) #this is in order to disable "run" btn
        matrix <- data.matrix(read.csv(file=input$matrixFile$datapath, row.names = 1L))
      } else {
        if(is.null(input$matrixVar)) return(NULL)
        matrix <- get(input$matrixVar)
      }
      matrix
    }) %>% bindCache({
      if(input$matrixSourceType == "fileMatrix"){
        input$matrixFile$name
      } else {
        input$matrixVar
      }
    })
  })
}
