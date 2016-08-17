library(shiny)
library(caret)
library(ggplot2)
library(e1071)
set.seed(998)


function(input, output) {
  
  predictors<-c("carat","depth","table","price","x","y","z")
  
  dts<-reactive({
    ds<-diamonds[ ,c(predictors,input$y)]
    ds[ ,length(names(ds))]<-as.factor(ds[ ,length(names(ds))])
    ds
  })
  output$plot <- renderPlot({
    dataset<-dts()
    trpct = 1-(input$testpct/100)
    inTrain <- createDataPartition(y=dataset[ ,c(length(names(dataset)))],
                                   p=trpct, list=FALSE)
    training <- dataset[inTrain,]
    testing <- dataset[-inTrain,]
    ldaModFit <- train(as.formula(paste(input$y,"~.")),data=training, method="lda")
    
    pred1 <- predict(ldaModFit,newdata=testing)
    prop.table(confusionMatrix(pred1,testing[ ,c(length(names(testing)))])$table)
#generate random data 
data = data.frame(testing[ ,c(length(names(testing
                                           
                                           
                                           )))],pred1)
names(data) = c("Actual", "Predicted") 
 
#compute frequency of actual categories
actual = as.data.frame(table(data$Actual))
names(actual) = c("Actual","ActualFreq")
 
#build confusion matrix
confusion = as.data.frame(table(data$Actual, data$Predicted))
names(confusion) = c("Actual","Predicted","Freq")
 
#calculate percentage of test cases based on actual frequency
confusion = merge(confusion, actual, by=c('Actual'))
confusion$Percent = confusion$Freq/confusion$ActualFreq*100
 
#render plot
# we use three different layers
# first we draw tiles and fill color based on percentage of test cases
tile <- ggplot() +
geom_tile(aes(x=Actual, y=Predicted,fill=Percent),data=confusion, color="black",size=0.1) +
labs(x="Actual",y="Predicted")
tile = tile + 
geom_text(aes(x=Actual,y=Predicted, label=sprintf("%.1f", Percent)),data=confusion, size=3, colour="black") +
scale_fill_gradient(low="gray88",high="green4")
 
# lastly we draw diagonal tiles. We use alpha = 0 so as not to hide previous layers but use size=0.3 to highlight border
tile = tile + 
geom_tile(aes(x=Actual,y=Predicted),data=subset(confusion, as.character(Actual)==as.character(Predicted)), color="black",size=0.3, fill="black", alpha=0) 
 
#render
tile + ggtitle(paste("Confusion matrix with ",input$testpct,"% test data. ","Predicted value : ",input$y, ", lda formula : ",paste(input$y,"~",paste(predictors,collapse=" + ")),sep=""))
  }, height=700)

}