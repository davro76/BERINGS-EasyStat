library(shiny)

ui <-fluidPage(
  titlePanel(h3("Iris demonstration", align="center")),
  sidebarLayout(
    sidebarPanel(background="pink",
      selectInput("v_choice", "Select a variable to map:", choices=names(iris[,1:4])),
      sliderInput("bins", "Select the number of bins:", min=1,max=50,value=25),
      radioButtons("color", "Choose you color:", choices=c("Green"="green", "Yellow"="yellow", "Blue"="blue"), selected="green")
    ),
    mainPanel(plotOutput("iris_hist"),
              br(),
              verbatimTextOutput("summary"))
    
  ))
  
  server <- function(input,output){
    
    output$iris_hist <- renderPlot({
      bins=seq(min(iris[,input$v_choice]),max(iris[,input$v_choice]), length.out=input$bins+1)
      switch(
        input$color, 
        "green" = hist(iris[,input$v_choice],breaks=input$bins, main=paste("Histogram of",input$v_choice), xlab=input$v_choice,col="Green"),
        "yellow" = hist(iris[,input$v_choice],breaks=bins, main=paste("Histogram of",input$v_choice), xlab=input$v_choice,col="Yellow"),
        "blue" = hist(iris[,input$v_choice],breaks=input$bins, main=paste("Histogram of",input$v_choice), xlab=input$v_choice,col="Blue")
      )
      
    })
    
    output$summary <- renderPrint({
      summary(iris[,input$v_choice])
    })
  }
  
  shinyApp(ui = ui, server = server)
