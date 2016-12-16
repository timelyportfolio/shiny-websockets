library(htmltools)
library(shiny)
library(pipeR)

bluebird <- htmlDependency(
  name="bluebird",
  version="3.4.6",
  src=c(href="https://unpkg.com/bluebird@3.4.6"),
  script=""
)

most <- htmlDependency(
  name="most",
  version="1.1.1",
  src=c(href="https://unpkg.com/most@1.1.1/dist/"),
  script="most.min.js"
)

domevent = htmlDependency(
  name="dom-event",
  version="1.3.2",
  src=c(href="https://unpkg.com/@most/dom-event@1.3.2"),
  script=""
)

# use https://github.com/mostjs/examples/blob/master/mouse-position/index.js
#   as a basis
ui <- tagList(
  tags$script(HTML(
    reactR::babel_transform(
"
const toCoords = e => `${e.clientX},${e.clientY}`
const render = s => { document.body.textContent = s }
const sendShiny = s => { Shiny.onInputChange('document_mousemove',s) }

mostDomEvent.mousemove(document)
  .map(toCoords)
  .startWith('move the mouse, please')
  .observe(render)

mostDomEvent.mousemove(document)
  .map(toCoords)
  .startWith('not moved')
  .observe(sendShiny)
"      
    )
    
  ))
) %>>%
  attachDependencies(list(bluebird,most,domevent))


server <- function(input,output,session) {
  observeEvent(input$document_mousemove, {print(input$document_mousemove)})
}

shinyApp(ui, server)