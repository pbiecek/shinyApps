library(shiny)

lis <- c("aut",  "bel",   "cze", "dnk",  "esp",  "est",  "fin",  "fra",   "irl",  "ita",  "jpn",  "kor",  "nld",  "nor",  "pol",  "rus",  "svk",  "swe",  "usa")

shinyUI(pageWithSidebar(
  headerPanel("PIAAC single variable"),
  
  sidebarPanel(
      tags$script("(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
  ga('create', 'UA-5650686-6', 'icm.edu.pl');
  ga('send', 'pageview');"),
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

