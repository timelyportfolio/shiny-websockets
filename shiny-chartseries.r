library(quantmod)
library(shiny)

shinyApp(
  ui <- plotOutput(
    "plotA",
    brush=brushOpts(id="plot_brush", direction="x")
  ),
  server <- function(input, output, session){
    # harder to do < day so try that
    data_xts <- as.xts(
      runif(10),
      seq.POSIXt(as.POSIXct(Sys.Date()),by="hour",length.out=10)
    )
    cs <- new.env()
    output$plotA <- renderPlot({
      cs<<-chart_Series(data_xts)
      # harder if zoomed; unlikely I think but still
      #  figure it out
      #zoom_Chart(5:8)
      cs
    })
    
    observe({
      b <- input$plot_brush
      str(c(b$xmin,b$xmax))
      # need to convert x values to date range
      # cs$Env$xdata[csEnv$subset]
      if(!is.null(b))
        print(
          index(cs$Env$xdata[cs$Env$xsubset,])[c(ceiling(b$xmin),floor(b$xmax))]
        )
    })
  }
)


# now with GSOC PerformanceAnalytics
library(PerformanceAnalytics)
library(shiny)

data(managers)


# not working; check indexes and bar extents
shinyApp(
  ui <- plotOutput(
    "plotA",
    brush=brushOpts(id="plot_brush", direction="x")
  ),
  server <- function(input, output, session){
    
    output$plotA <- renderPlot({
      charts.PerformanceSummary(managers)
    })
    
    observe({
      b <- input$plot_brush
      str(b)
      # need to convert x values to date range
      # cs$Env$xdata[csEnv$subset]
      cs <- xts:::current.xts_chob()
      # with charts.PerformanceSummary
      if(!is.null(b))
        print(
          index(cs$Env$xdata[cs$Env$xsubset,])[
            c(
              max(1,b$xmin*nrow(cs$Env$xdata)),
              min(b$xmax*(nrow(cs$Env$xdata)),nrow(cs$Env$xdata))
            )
          ]
        )
    })
  }
)




library(quantmod)
library(shiny)
aapl <- getSymbols("AAPL", auto.assign=FALSE)
aapl <- adjustOHLC(aapl)


shinyApp(
  ui <- plotOutput(
    "plotA",
    brush=brushOpts(id="plot_brush", direction="x")
  ),
  server <- function(input, output, session){
    cs <- new.env()
    output$plotA <- renderPlot({
      cs <<- chart_Series(aapl["2015::2016",], name="Apple")
      cs
      add_Vo()
      add_SMA(50)
    })
    
    observe({
      b <- input$plot_brush
      str(c(b$xmin,b$xmax))
      # need to convert x values to date range
      # cs$Env$xdata[csEnv$subset]
      if(!is.null(b))
        print(
          index(cs$Env$xdata[cs$Env$xsubset,])[
            c(
              max(1,ceiling(b$xmin)),
              min(floor(b$xmax),nrow(cs$Env$xdata))
            )
          ]
        )
    })
  }
)
