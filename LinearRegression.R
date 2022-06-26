
#  Dependencies 
library(shiny)
library(shinydashboard)
library(ggplot2)
library(MASS)
library(plotly)
library(ggpubr)
library(tidyverse)
library(ISLR)
library(broom)
library(DT)
library(ggfortify)
library(leaps)
library(boot)

# Set the working directory
#setwd("/Users/rodneydavermann/Desktop/Assignment4")

# Initiate the app
ui <- dashboardPage(skin = "yellow",title = "Linear Regression by BERINGS",
                    dashboardHeader(
                      title = "Learn Simple and Multiple Linear Regression",
                      titleWidth = 400
                      
                    ), 
                    dashboardSidebar(br("Most Commands"),
                      sidebarMenu(id="tabs",
                                  menuItem("Home", tabName="home", icon=icon("home")),
                                  menuItem("Dataset", tabName="data", icon=icon("file")),
                                  menuItem("Charts", tabName="chart", icon=icon("bar-chart")),
                                  menuItem("Simple Linear Regression",tabName="analyze",icon=icon("book"))
                      ),
                      
                      width=250
                    ),
                    dashboardBody(
                      tags$head(tags$style(HTML('
      .main-header .logo {
        font-family: "Lucida Handwriting", Cursive;
        font-weight: bold;
        font-size: 16px;
      }
    ')))
                      ,
                      tabItems(
                        tabItem(tabName="home",
                                h2("Home About us here.")
                                
                        ),
                        tabItem(tabName="chart",
                                # display the items inside boxes
                                fluidRow(
                                  box(width=9 ,plotOutput("scatterplot1",width = "auto"),
                                      title = "Scatterplot using Hits to predict Salary", solidHeader = TRUE,
                                      collapsed = T,
                                      status = "info",
                                      collapsible = T, backbround="pink"
                                  ),
                                  box(width=3 ,radioButtons("otherelements","Add to the scatterplot:",c("Regression Line"="regline","Linear Equation"="linereg","Coefficient of Determination"="coefdet","Mean of Y"="meany")),
                                      title="New Indicators",
                                      solidHeader = TRUE,
                                      collapsed = T,
                                      status = "info",
                                      collapsible = T
                                  )
                                  
                                  
                                ),
                                fluidRow(
                                  box(width=9 ,plotOutput("residualplot",width = "auto"),
                                      title = "Residual Plot for Hits and Salary", solidHeader = TRUE,
                                      collapsed = T,
                                      status = "info",
                                      collapsible = T
                                    
                                  )
                                )
                                
                                
                        ),
                        # Display Hitters dataset from the data table
                        tabItem(tabName="data",
                                fluidRow(
                                  box(
                                    # Data table title
                                    h2("Hitters dataset"),
                                    DT::dataTableOutput("hitters",width = "100%", height ="auto"),width=12
                                    
                                    
                                  )
                                  
                                )
                        ),
                        tabItem(tabName="analyze",
                                fluidRow(
                                  box(verbatimTextOutput("slm"),
                                      title = "Linear Regression Model", collapsed = T, collapsible = T, status = "success",
                                      solidHeader = T,width=6),
                                  
                                  
                                  box(title = "Test for a statistical significant of the regression relationship",collapsed = T, collapsible = T, 
                                      status = "success",solidHeader = T,width=6,
                                      h3("Hypothesis:)
                                      H0: b1 = 0 # There is no relationship
                                      H1: b1 =! 0 # There is relationship
                                      Decision Rule: Reject H0 if p-value is less than alpha (In this case 0.05).

                                     br(
                                     . Because p-value: 8.531e-14 is less than 0.05, we have enough evidence to reject H0 and accept H1.
                                      . The two variables (Hits and Related) are related, and there is a statistically significant relationship between them.
                                      . Even we Reject the null hypothesis H0: b1 = 0 and concluding that the relationship between Hits and Salary is statistically significant does not enable us to conclude that a cause-and-effect relationship is present between Hits and Salary.")
                                     ) 
                                  
                                ))
                      )
                    )
                    
                    
                    
                    #fluidRow(
                    #box(
                    #title = "Scatterplot Interpretation", collapsed = T, collapsible = T, status = "success",
                    #solidHeader = T ##success, info, warning, danger)
                    
)

server <- function(input, output) { 
  # Read the  Hitters dataset from ISLR package
  Hitters <- ISLR::Hitters
  
  # Clean the Hitters dataset by dropping NA value
  Hitters_Fixed <-na.omit(Hitters)
  
  # Assign the linear model to a variable named slm_output
  attach(Hitters_Fixed)
  # Display slm_output's result using summary function
  slm_output <-lm(Salary~Hits)
  
  output$scatterplot1 <- renderPlot({
    switch(input$otherelements,
           "regline"= ggplot(Hitters_Fixed, aes(x=Hits, y=Salary))+geom_point(color="dark green")+
             # Name of the plot
             ggtitle(" Distribution of the salary based on the numbers of hits")+
             # Center the title of the plot
             theme(plot.title=element_text(vjust = -4.5, hjust = 0.5))+
             # Display the linear equation
             geom_smooth(method="lm", color="blue"),
             
           "linereg"= ggplot(Hitters_Fixed, aes(x=Hits, y=Salary))+geom_point(color="dark green")+
             # Name of the plot
             ggtitle(" Distribution of the salary based on the numbers of hits")+
             geom_smooth(method="lm", color="blue")+
             # Display the equation of the linear regression, and adjust its position
             stat_regline_equation(label.x=25, label.y=2000)+
             # Center the title of the plot
             theme(plot.title=element_text(vjust = -4.5, hjust = 0.5)),
           
           
           "coefdet" = ggplot(Hitters_Fixed, aes(x=Hits, y=Salary))+geom_point(color="dark green")+
             # Name of the plot
             ggtitle(" Distribution of the salary based on the numbers of hits")+
             geom_smooth(method="lm", color="blue")+
             # Display the equation of the linear regression, and adjust its position
             stat_regline_equation(label.x=25, label.y=2000)+
             # Center the title of the plot
             theme(plot.title=element_text(vjust = -4.5, hjust = 0.5))+ 
             # Display the coefficient of determination (R squared) of the linear regression, 
             # and adjust its position
             stat_cor(aes(label=..rr.label..), label.x=25, label.y=1750),
           
           "meany" = ggplot(Hitters_Fixed, aes(x=Hits, y=Salary))+geom_point(color="dark green")+
             # Name of the plot
             ggtitle(" Distribution of the salary based on the numbers of hits")+
             geom_smooth(method="lm", color="blue")+
             # Display the equation of the linear regression, and adjust its position
             stat_regline_equation(label.x=25, label.y=2000)+
             # Center the title of the plot
             theme(plot.title=element_text(vjust = -4.5, hjust = 0.5))+ 
             # Display the coefficient of determination (R squared) of the linear regression, 
             # and adjust its position
             stat_cor(aes(label=..rr.label..), label.x=25, label.y=1750)+ 
           #display the horizontal salary mean line
           geom_hline(yintercept = mean(Hitters_Fixed$Salary),color="dark red")
           )
    
    
    
    
    })
  
  output$residualplot <- renderPlot({
    # using broom package and augment function to plot the residuals 
    slm_output_1 <- augment(slm_output)
    # draw residual segments
    ggplot(Hitters_Fixed, aes(x=Hits, y=Salary))+geom_point(color="dark green")+
      # Name of the plot
      ggtitle(" Residuals plot for observed salary values and the fitted regression line.")+
      # Display the linear regression line and the confidence region
      geom_smooth(method = "lm",color="blue")+
      # Center the title of the plot
      theme(plot.title=element_text(vjust = -4.5, hjust = 0.5))+
      # Draw the error segment with geom_segment from ggplot2
      geom_segment(aes(xend=slm_output_1$Hits, yend=slm_output_1$.fitted),color="brown")
    
  })
    
  
  
  
  # Assign the linear model to a variable named slm_output
  attach(Hitters_Fixed)
  # Display slm result using summary function
  output$slm <- renderPrint({
    summary(lm(Salary~Hits))
  })  
  
  # Rendering the hitters dataset and some columns
  output$hitters<-renderDataTable({
    tags$head(tags$style( type = 'text/css',  '.renderDataTable{ overflow-x: scroll; }'))
    Hitters_Fixed
  })
  
  
  
}

shinyApp(ui, server)