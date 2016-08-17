shinyUI(pageWithSidebar(
  headerPanel("Exploring 'lda' model by predicting 'cut', 'color' and 'clarity' from 'diamonds' dataset"),
  sidebarPanel(
    sliderInput('testpct', '% of test partition of \'diamonds\' dataset',value = 10, min = 5, max = 25, step = 2,),
    radioButtons("y", "Predicted Value",
                 c("cut" = "cut",
                   "color" = "color",
                   "clarity" = "clarity"),selected = c("cut")),
    img(src='doc.jpeg', align = "middle", width=450, height=450)
  ),
  mainPanel(
    plotOutput('plot')
  )
))