library(shiny)

ui <- list(
  tags$script(
    "
var i = 0;
setInterval(
  function(){
    Shiny.onInputChange('counter',{count:i});
    i++
  },
  1000
)
"    
  )
)
server <- function(input,output,session){
  #session$onInputReceived(function(x){str(x)})
  observeEvent(input$counter,{
    cat("counting: ",input$counter$count,"\n")
  })
}

runApp(list(ui=ui,server=server))
