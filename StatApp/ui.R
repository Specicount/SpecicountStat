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
    ),
    
    tabPanel(
        title = "Percentage Data Plots",
        sidebarLayout(
            sidebarPanel(
                numericInput("occ", "Occurence:", 0.05, min = 0),
                numericInput("abun", "Maximum Abundance:", 0, min = 0),
                selectInput("yl", "Y-Axis", c("ID", "Depth", "Age"))
            ),
            mainPanel(
                plotOutput("pct_plot")
            )
            
        )
    ),
    
    tabPanel(
        title = "CCA Plot",
        sidebarLayout(
            sidebarPanel(
                numericInput("occ", "Occurence:", 0.05, min = 0),
                numericInput("abun", "Maximum Abundance:", 0, min = 0),
                selectInput("yl", "Y-Axis", c("ID", "Depth", "Age"))
            ),
            mainPanel(
                plotOutput("cca_plot")
            )
            
        )
    ),
    
    tabPanel(
        title = "PCA Plot",
        sidebarLayout(
            sidebarPanel(
                numericInput("occ", "Occurence:", 0.05, min = 0),
                numericInput("abun", "Maximum Abundance:", 0, min = 0),
                selectInput("yl", "Y-Axis", c("ID", "Depth", "Age"))
            ),
            mainPanel(
                plotOutput("pca_plot")
            )
            
        )
    ),
    
    tabPanel(
        title = "DCA Plot",
        sidebarLayout(
            sidebarPanel(
                numericInput("occ", "Occurence:", 0.05, min = 0),
                numericInput("abun", "Maximum Abundance:", 0, min = 0),
                selectInput("yl", "Y-Axis", c("ID", "Depth", "Age"))
            ),
            mainPanel(
                plotOutput("dca_plot")
            )
            
        )
    ),
    
    tabPanel(
        title = "Species Accumulation Curve",
        sidebarLayout(
            sidebarPanel(
                numericInput("occ", "Occurence:", 0.05, min = 0),
                numericInput("abun", "Maximum Abundance:", 0, min = 0),
                selectInput("yl", "Y-Axis", c("ID", "Depth", "Age"))
            ),
            mainPanel(
                plotOutput("sp_accum_curve")
            )
            
        )
    )
    
))