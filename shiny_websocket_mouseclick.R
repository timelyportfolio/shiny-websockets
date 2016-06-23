library(shiny)

#options(shiny.trace=TRUE)

accum_mouseclick <- list(x=integer(),y=integer())

ui <- list(
  tags$p("Click in the window and plot in R:"),
  tags$script(
"
document.onclick = sendPosition;

function sendPosition(){
  //debugger;
  Shiny.onInputChange('mouseclick',{x:event.x,y:event.y});
}
"    
  )
)
server <- function(input,output,session){
  #str(as.list(session$request))
  #session$onInputReceived(function(x){str(x)})
  observeEvent(input$mouseclick,{
    cat("mouseclick: ",jsonlite::toJSON(input$mouseclick),"\n")
    accum_mouseclick$x <<- c(accum_mouseclick$x,input$mouseclick$x)
    accum_mouseclick$y <<- c(accum_mouseclick$y,-input$mouseclick$y)
    if(length(accum_mouseclick$x)){
      plot(x=accum_mouseclick$x, y=accum_mouseclick$y)
    }
  })
}

runApp(list(ui=ui,server=server))



#ws.send(JSON.stringify({"method":"init","data":{}}))
#ws.send(JSON.stringify({"method":"update","data":{"mouseclick":{"x":10,"y":10}}}))
