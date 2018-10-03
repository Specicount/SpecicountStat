#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
    title = "BioData Statistical Analysis",
    tabPanel(
        title = "Upload",
        fluidPage(
            column(
                width = 5,
                align = "left",
                fileInput(
                    "raw_file",
                    "Choose CSV File",
                    multiple = TRUE,
                    accept = c("text/csv",
                               "text/comma-separated-values,text/plain",
                               ".csv")
                )
            ),
            
            # Horizontal line ----
            tags$hr(),
            mainPanel(
                DT::dataTableOutput('raw_data')
            )
        )
    ),
    
    tabPanel(
        title = "Raw Data Plots",
        sidebarLayout(
            sidebarPanel(
                numericInput("occ", "Occurence:", 5, min = 0),
                numericInput("abun", "Maximum Abundance:", 0, min = 0),
                selectInput("yl", "Y-Axis", c("ID", "Depth", "Age"))
            ),
            mainPanel(
                plotOutput("raw_plot")
            )
            
        )
    )
    
))