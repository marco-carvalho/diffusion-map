library(ggplot2)

file <- read.table("datasets/oc_12_2500_1000_1.0_p019_0710_1.eigen.csv")
ggplot(
  file, 
  aes(
    V1, 
    V2,
    color = V5
  )
) + geom_point()

set.seed(20)
irisCluster <- kmeans(file[, 1:3], 2)
irisCluster

table(irisCluster$cluster, file$V5)

irisCluster$cluster <- as.factor(irisCluster$cluster)
ggplot(
  file, 
  aes(
    V1, 
    V2,
    color = irisCluster$cluster
  )
) + geom_point()
