library(shiny)

shinyApp(
  ui=tagList(
    tags$script("Shiny.addCustomMessageHandler('special',function(e){console.log(e)})")
  ),
  server=function(input,output,session){
    observe(
      {
        invalidateLater(1000,session=session)
        print("sending")
        session$sendCustomMessage("special",list(msg="again"))
      }
    )
  }
)