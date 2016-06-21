library(htmltools)
library(shiny)

ui <- tagList(
  tags$head(
    tags$script(src="http://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react.min.js"),
    #tags$script(src="http://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.34/browser.min.js"),
    tags$script(src="http://rawgit.com/arqex/react-json/master/build/Json.js"),
    tags$link(href="http://rawgit.com/arqex/react-json/master/react-json.css",rel="stylesheet")
  ),
  tags$h1("react json editor"),
  tags$script(HTML(
'
var doc = {
  hola: "amigo",
  array: [1,2,3]
};

/*
// if you want to use JSX
React.render(
  <Json value={ doc } onChange={ logChange } />,
  document.body
);
*/
var Json;
var app = React.createElement(Json, {value: doc, onChange: logChange});
React.render(app, document.body);

function logChange( value ){
  console.log( value );
  Shiny.onInputChange("reactjson", {value:value});
}
'
  ))#,type="text/babel")
)

server <- function(input, output, session){
  observeEvent(
    input$reactjson,
    {
      str(input$reactjson$value)
    }
  )
}

runApp(list(ui=ui,server=server))