
# libraries and dependencies
library(agricolae)
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

# Initiate the App
# Choose the red color for the app header
ui <- dashboardPage(skin = "red",
# Named the application
  dashboardHeader(title = "BERINGS EasyStat", titleWidth=250),
# Application widgets  
  dashboardSidebar(
    sidebarMenu(
                # Define home table
                menuItem("Home", tabName = "home", icon = icon("home")),
                
                # Define the descriptive statistic department
                menuItem("Descriptive Statistics", icon = icon("calculator"),
                         menuSubItem("Frequency Table",tabName = "pivottable",icon = icon("angle-double-right")),
                         menuSubItem("Measures of Location",tabName = "centraltendency",icon = icon("angle-double-right")),
                         menuSubItem("Measures of Variability",tabName = "dispersionmeasures",icon = icon("angle-double-right")),
                         menuSubItem("Distribution Shape",tabName = "distributionshape",icon = icon("angle-double-right"))),
                
                # Exploratory analysis department
                menuItem("Chart",icon = icon("chart-line"),
                         menuSubItem("Scatterplot", tabName = "scatterplot",icon = icon("angle-double-right")),
                         menuSubItem("Residualplot", tabName = "residualplot",icon = icon("angle-double-right")),
                         menuSubItem("Bar Graph", tabName = "bargraph",icon = icon("angle-double-right")),
                         menuSubItem("Pie Chart", tabName = "piechart",icon = icon("angle-double-right")),
                         menuSubItem("Boxplot", tabName = "boxplot",icon = icon("angle-double-right")),
                         menuSubItem("Line Graph", tabName = "linechart",icon = icon("angle-double-right")),
                         menuSubItem("Choropleth Map", tabName = "choroplethmap",icon = icon("angle-double-right")),
                         menuSubItem("Heat Map", tabName = "heatmap",icon = icon("angle-double-right")),
                         menuSubItem("Three-Dimensional Scatter Plot", tabName = "threedimensionalscatterplot",icon = icon("angle-double-right")),
                         menuSubItem("Gauge Plot", tabName = "gaugeplot",icon = icon("angle-double-right"))
                         
                         ),
                
                # Define the statistical inference department
                menuItem("Statistical Inference", icon = icon("exchange"),
                         menuSubItem("Interval Estimation", tabName="intervalestimation", icon = icon("angle-double-right")),
                         menuSubItem("Hypothesis Tests", tabName="hypothesistests", icon = icon("angle-double-right")),
                         menuSubItem("Two Populations Means", tabName="populationsmeans", icon = icon("angle-double-right")),
                         menuSubItem("Populations Variance", tabName="populationsvariances", icon = icon("angle-double-right"))
                         
                         
                         ),
                
                # upload file external file
                fileInput("csv_file", " CSV File to Analyze",buttonLabel = "Browse", placeholder = "Please selec a file",
                          accept = c(
                            "text/csv",
                            "text/comma-separated-values,text/plain",
                            ".csv")),
                
                # Code on Github
                menuItem("Code", href = "https://github.com/davro76/BERINGS-EasyStat", icon = icon("code"))
                         
                )),
  
# Main panel to display some input and outputs 
  dashboardBody(
    # Link CSS file to the Shiny App
    tags$head(tags$link(rel="stylesheet",type ="text/css",href="custom.css")),
     
    # Display input or output through row           
    fluidRow(
      
      box(
        tabItems(
          tabItem("home", "About US")
                   )
                 )
               )
                )
  )

# Define server or App back-end 
server <- function(input, output){}

# Run the App
shinyApp(ui,server)