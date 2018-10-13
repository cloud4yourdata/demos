library(rpart) #recursive and partitioning trees
library(plotly) #data visualization
library(rpart.plot)
library(RColorBrewer)
library(rattle)
library(RWeka)

localWinePath <- "d:\\Repos\\Cloud4YourData\\Demos\\4DevKatowice2018\\MLRevoscale\\Data\\wines.csv"
wine<-read.csv2(localWinePath,header = TRUE, sep = ";")
colnames(wine)
plot_ly(data = wine, x =~quality, type = "histogram")

set.seed(1234)
wine_train <- sample(1:nrow(wine), 0.67 * nrow(wine))
wine_test <- wine[-wine_train,]

wine_train <- wine[1:3750, ]
wine_train
m.rpart <- rpart(quality ~. , data = wine_train)

fancyRpartPlot(m.rpart)