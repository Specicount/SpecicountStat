#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(analogue)
library(vegan)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    get_data <- reactive({
        req(input$raw_file)
        
        df <- read.csv(input$raw_file$datapath,
                       header = TRUE,
                       sep = ",")
        return(df)
    })
    
    
    output$raw_data <- DT::renderDataTable({
        core <- get_data()
        DT::datatable(core, options = list(pageLength = 25, searching = FALSE))
    })
    
    output$raw_plot <- renderPlot({
        
        raw_data <- get_data()
        # Remove the total counts and spikes(first 8 columns)
        core <- raw_data[, c(8:ncol(raw_data))]
        
        # Define y axis
        ids <- raw_data$sample.ID
        
        # Filt the data above given occurance and maximum abundance
        core.fltd <- chooseTaxa(core, n.occ = 5, max.abun = 10)
        
        raw_plot <- Stratiplot(
            ids ~ .,
            data = core.fltd,
            sort = "wa",
            type = c("h", "l", "g"),
            ylab = 'Sample ID',
            xlab = 'Count'
        )
        
        return(raw_plot)
    })
})
