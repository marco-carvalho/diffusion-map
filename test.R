source("lib.R")
library("plot3D")

a <- replicate(4, round(runif(20, 1, 7), 2)) 
write.csv(a)

eigen <- eigen_matrix(
  as.matrix(
    x = dist(
      x = apply(
        X = a,
        MARGIN = 2,
        FUN = normalize_column
      )
    )
  )
)

write.csv(eigen$vectors[,2:4])

par(mfrow=c(3,1))
plot(
  x = eigen$vectors[, 2],
  pch = 16
)
legend(
  x = 'topleft',
  legend = unique(df.col),
  col = 1:length(df.col),
  pch = 16
)
plot(
  x = eigen$vectors[, 2],
  y = eigen$vectors[, 3],
  pch = 16
)
legend(
  x = 'bottomleft',
  legend = unique(df.col),
  col = 1:length(df.col),
  pch = 16
)
scatter3D(
  x = eigen$vectors[, 2], 
  y = eigen$vectors[, 3], 
  z = eigen$vectors[, 4], 
  colvar = NULL,
  pch = 16
)
legend(
  x = 'bottomleft',
  legend = unique(df.col),
  col = 1:length(df.col),
  pch = 16
)
