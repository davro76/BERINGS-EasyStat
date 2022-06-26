library(shiny)

ui <-fluidPage(
  titlePanel(h3("Iris demonstration", align="center")),
  sidebarLayout(
    sidebarPanel(
                 selectInput("v_choice", "Select a variable to map:", choices=names(iris[,1:4])),
                 sliderInput("bins", "Select the number of bins:", min=1,max=50,value=25),
                 radioButtons("color", "Choose you color:", choices=c("Green", "Yellow", "Turquoise", "Pink"), selected="Pink")
    ),
    mainPanel(plotOutput("iris_hist"),
              br(),
              verbatimTextOutput("summary"))
    
  ))

server <- function(input,output){
  
  output$iris_hist <- renderPlot({
    bins=seq(min(iris[,input$v_choice]),max(iris[,input$v_choice]), length.out=input$bins+1)
    if(input$color=="Green"){col="Green"}
    if(input$color=="Yellow"){col="Yellow"}
    if(input$color=="Turquoise"){col="Turquoise"}
    if(input$color=="Pink"){col="Pink"}
    hist(iris[,input$v_choice],breaks=input$bins, main=paste("Histogram of",input$v_choice), xlab=input$v_choice,col=input$color)

  })
  
  output$summary <- renderPrint({
    summary(iris[,input$v_choice])
  })
}

shinyApp(ui = ui, server = server)
