
# libraries nd dependencies
library(agricolae)
library (shiny)
library(shinydashboard)

# Initiate the App
# Choose the red color for the app header
ui <- dashboardPage(skin = "red",
# Named the application
  dashboardHeader(title = "BERINGS EasyStat"),
# Elements or widgets of the application
  dashboardSidebar(
    sidebarMenu(
                menuItem("Home", tabName = "home", icon = icon("home")),
                menuItem("Descriptive Statistics",tabName = "desc_stat", icon = icon("calculator")),
                menuItem("Chart",icon = icon("bar-chart-o"),
                         menuSubItem("Scatterplot", tabName = "scatterplot",icon = icon("angle-double-right")),
                         menuSubItem("Bar Graph", tabName = "bargraph",icon = icon("angle-double-right")),
                         menuSubItem("Pie Chart", tabName = "piechart",icon = icon("angle-double-right")),
                         menuSubItem("Boxplot", tabName = "boxplot",icon = icon("angle-double-right")),
                         menuSubItem("Line Graph", tabName = "linechart",icon = icon("angle-double-right")),
                         menuSubItem("Choropleth Map", tabName = "choroplethmap",icon = icon("angle-double-right")),
                         menuSubItem("Heat Map", tabName = "heatmap",icon = icon("angle-double-right")),
                         menuSubItem("Three-Dimensional Scatter Plot", tabName = "threedimensionalscatterplot",icon = icon("angle-double-right"))
                          
                         ),
                fileInput("csv_file", " CSV File to Analyze",buttonLabel = "Browse", placeholder = "Please selec a file",
                          accept = c(
                            "text/csv",
                            "text/comma-separated-values,text/plain",
                            ".csv")),
                menuItem("Code", href = "https://github.com/davro76/BERINGS-EasyStat", icon = icon("code"))
                         
                )),
  
  dashboardBody(tags$head(tags$style(".sidebar-menu li { margin-bottom: 10px; }")),
               fluidRow(
                 box(
                   tabItems(
                     tabItem("home",
                             "About US")
                   )
                 )
               )
                )
  )


server <- function(input, output){}

shinyApp(ui,server)