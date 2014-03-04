library(likert)
library(shiny)
library(PIAAC)
library(Hmisc)
library(MASS)

#load("pol.rda")
#setwd("c:/_Przemek_/Dropbox/_ProjektyBiezace_/_PIAAC_/orderLogitApp/")

shinyServer(function(input, output) {
  output$modelSummary <- renderDataTable({
#    print("modelSummary")
    dat <- currentSetOfRows()
    
    if (class(dat[,input$variable]) == "numeric") {
      tmp <- unclass(by(dat$SPFWT0, list(cut(dat[,input$variable], 4), dat[,input$trust]), sum, na.rm=TRUE))
#      print("numeric")
    } else {
      tmp <- unclass(by(dat$SPFWT0, list(dat[,input$variable], dat[,input$trust]), sum, na.rm=TRUE))
#      print("class")
    }

    dat2 <- round(100*prop.table(tmp,1),1)
    dat2 <- data.frame(group=rownames(dat2), dat2)
#    print(dat2)
    dat2
  })
  
  currentSetOfRows         <- reactive({  
    cnt <- input$country
#    print("currentSetOfRows")
#    print(cnt)
    dat <- get(cnt)
    dat$ISCO12 <- substr(as.character(dat$ISCO08_C),1,1) %in% c("1", "2")
    dat$EDCAT4 <- factor(sapply(strsplit(as.character(dat$EDCAT6),split="[^A-Za-z][^A-Za-z]"), '[', 1) == "Tertiary", labels=c("b. Tertiary", "Tertiary"))
    dat1 <- na.omit(dat[,c("I_Q06A", "I_Q07A", "I_Q07B", "PVLIT1", "PVNUM1", "GENDER_R", "AGE_R", "PARED", "EDCAT4", "READHOME", "B_Q01B", "ISCO12", "READWORK", "SPFWT0")])
    dat1
  })
  
  output$wyjscieGraph <- renderPlot({
#    print("wyjscieGraph")
    dat <- currentSetOfRows()
    
    if (class(dat[,input$variable]) == "numeric") {
      tmp <- unclass(by(dat$SPFWT0, list(cut(dat[,input$variable], 4), dat[,input$trust]), sum, na.rm=TRUE))
#      print("numeric")
    } else {
      tmp <- unclass(by(dat$SPFWT0, list(dat[,input$variable], dat[,input$trust]), sum, na.rm=TRUE))
#      print("class")
    }
    
    ddat <- data.frame(Item=rownames(tmp), 100*prop.table(tmp,1))
#    print(ddat)
    plot(plot(likert(summary=ddat)))
  }, height=400)

})


