###
# The Following line is debug only!!!
##
options(shiny.sanitize.errors = TRUE)
#####################################

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
        DT::datatable(core, options = list(pageLength = 10, searching = TRUE))
    })
    
    output$raw_plot <- renderPlot({
        
        raw_data <- get_data()
        # Remove the total counts and spikes(first 8 columns)
        core <- raw_data[, c(8:ncol(raw_data))]
        
        # Define y axis
        if (input$yl == "ID") {
            ids <- raw_data$sample.ID
        }
        else if (input$yl == "Depth") {
            ids <- raw_data$depth.cm
        }
        else {
            ids <- raw_data$age.cal.yrs.BP
        }
        
        # Filt the data above given occurance and maximum abundance
        core.fltd <- chooseTaxa(core, n.occ = input$occ, max.abun = input$abun)
        
        raw_plot <- Stratiplot(
            ids ~ .,
            data = core.fltd,
            sort = "wa",
            type = c("h", "l", "g"),
            ylab = input$yl,
            xlab = 'Count'
        )
        
        return(raw_plot)
    })
    
    output$pct_plot <- renderPlot({
        
        raw_data <- get_data()
        
        # Generate percentage data using raw data
        pct_data <- raw_data[, c(0:7)]
        # Count the pollens using sum !!Note that it is different from the total column
        # Ref: https://quantpalaeo.wordpress.com/2018/04/29/how-to-calculate-percent-from-counts-in-r/
        pct_data$count.sum <- rowSums(raw_data[, c(8:ncol(raw_data))])
        core <- raw_data[, c(8:ncol(raw_data))]
        core_pct <- core / rowSums(core)*100
        pct_data <- cbind(pct_data, core_pct)
        
        # Start creating graphs
        # Define y axis
        if (input$yl == "ID") {
            ids <- raw_data$sample.ID
        }
        else if (input$yl == "Depth") {
            ids <- raw_data$depth.cm
        }
        else {
            ids <- raw_data$age.cal.yrs.BP
        }
        
        # Remove the total counts and spikes(first 9 columns) since a count column has been added
        core <- pct_data[, c(9:ncol(raw_data))]
        
        # Filt the data using f maximum abundance attained and number of occurrences.
        core.fltd <- chooseTaxa(core, n.occ = input$occ, max.abun = input$abun)
        
        # Draw Palaeoecological Stratigraphic Diagram with percentage data
        Stratiplot(
            ids ~ .,
            data = core.fltd,
            sort = "wa",
            type = c("h", "l", "g"),
            ylab = input$yl,
            xlab = 'Percentage'
        )
    })
    
    output$cca_plot <- renderPlot({
        
        raw_data <- get_data()
        # Remove the total counts and spikes(first 8 columns)
        core <- raw_data[, c(8:ncol(raw_data))]
        
        core.cca <- cca(core)
        plot(core.cca, scaling = 1)
    })
    
    output$pca_plot <- renderPlot({
        
        raw_data <- get_data()
        # Remove the total counts and spikes(first 8 columns)
        core <- raw_data[, c(8:ncol(raw_data))]
        
        core.pca <- rda(core)
        plot(core.pca)
        
        biplot(core.pca, scaling = -1)
    })
    
    output$dca_plot <- renderPlot({
        
        raw_data <- get_data()
        # Remove the total counts and spikes(first 8 columns)
        core <- raw_data[, c(8:ncol(raw_data))]
        
        # get the dca data
        core.dca <- decorana(core)
        
        # plot the dca plot
        plot(core.dca)
        
        shnam <- make.cepnames(names(core))
        
        # pl <- plot(core.dca, display = "sp")
        # identify(pl, "sp", labels = shnam)
        stems <- colSums(core)
        plot(core.dca, dis = "sp", type = "n")
        sel <-
            orditorp(
                core.dca,
                dis = "sp",
                lab = shnam,
                priority = stems,
                pcol = "red",
                pch = "+"
            )
    })
    
    output$sp_accum_curve <- renderPlot({
        
        raw_data <- get_data()
        
        # Remove the total counts and spikes(first 8 columns)
        core <- raw_data[, c(8:ncol(raw_data))]
        
        # Draw Species Accumulation Curve
        sp1 <- specaccum(core)
        sp2 <- specaccum(core, "random", permutations = 100)
        sp2
        summary(sp2)
        plot(sp1, ci.type="poly", col="blue", lwd=2, ci.lty=0, ci.col="lightblue")
        boxplot(sp2, col="white", add=TRUE, pch="+")
        
        ## Fit Lomolino model to the exact accumulation
        mod1 <- fitspecaccum(sp1, "lomolino")
        coef(mod1)
        fitted(mod1)
        plot(sp1)
        ## Add Lomolino model using argument 'add'
        plot(mod1, add = TRUE, col=2, lwd=2)
        ## Fit Arrhenius models to all random accumulations
        mods <- fitspecaccum(sp2, "arrh")
        plot(mods, col="hotpink")
        boxplot(sp2, col = "yellow", border = "blue", lty=1, cex=0.3, add= TRUE)
        ## Use nls() methods to the list of models
        sapply(mods$models, AIC)
        
        mod <- cca(core)
    })
})
