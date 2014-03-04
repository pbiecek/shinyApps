library(shiny)
library(PIAAC)

tmp <- ls("package:PIAAC", all = TRUE)
lis <- tmp[nchar(tmp) == 3]

shinyUI(pageWithSidebar(
  headerPanel("PIAAC single variable"),
  
  sidebarPanel(
    tags$head(
      tags$link(rel="stylesheet", type="text/css", href="mojcss.css")
    ),
    selectInput(inputId = "country",
                label = "1. Choose the country",
                choices = lis,
                selected = "pol"),
    
    selectInput(inputId = "trust",
                label = "2. Choose trust variable",
                choices = c("I_Q06A", "I_Q07A", "I_Q07B"),
                selected = "I_Q06A"),
    selectInput(inputId = "variable",
                label = "3. Choose variable of interest",
                choices = c("PVLIT1", "PVNUM1", "GENDER_R", "AGE_R", "PARED", "EDCAT4", "READHOME", "B_Q01B", "ISCO12", "READWORK"),
                selected = "GENDER_R"),
    
    br()),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Model summary", dataTableOutput("modelSummary")),
        tabPanel("Graph", plotOutput("wyjscieGraph", height=400)) 
      )
    )))

