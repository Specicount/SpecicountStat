library('shiny')
library('analogue')
library('vegan')

# Define UI for data upload app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Uploading Files"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select a file ----
      fileInput("raw_file", "Choose CSV File",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      
      # Horizontal line ----
      tags$hr(),
      
      numericInput("obs", "Occurence:", 10, min = 1, max = 100),
      verbatimTextOutput("value")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = "tabs",
                  tabPanel("Raw Plot", plotOutput("raw_plot")),
                  tabPanel("Table", tableOutput("raw_data"))
      )
      
    )
    
  )
)

# Define server logic to read selected file ----
server <- function(input, output) {
  
  output$contents <- renderTable({
    
    # input$raw_file will be NULL initially. After the user selects
    # and uploads a file, head of that data file by default,
    # or all rows if selected, will be shown.
    
    req(input$raw_file)
    
    df <- read.csv(input$raw_file$datapath,
                   header = TRUE,
                   sep = ",")
    
    return(df)
    
  })
  
  output$raw_data <- renderTable({
    req(output$contents)
    
    return(contents)
  })
  
  
}
# Run the app ----
shinyApp(ui, server)