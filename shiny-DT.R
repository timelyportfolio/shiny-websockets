# playing with chrome extensions to debug shiny

library(shiny)
library(DT)

options(shiny.trace=TRUE)

shinyApp(
  ui = dataTableOutput('dt'),
  server = function(input, output, session){
    output$dt <- renderDataTable(
      datatable(iris)
    )
  }
)
