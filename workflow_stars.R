################################################################################
# downloading packages
################################################################################

# install.packages("plot3D")

################################################################################
# using downloaded packages
################################################################################

library("plot3D")

################################################################################
# using lib
################################################################################

source("lib.R")

################################################################################
# loop through the df folder
################################################################################

for(i in dir(path = "datasets", pattern = "*.csv", full.names = T))
{
  file <- read.table(i)
  df <- stars_df(file)
  df.col <- stars_color_index(file)
  
  ##############################################################################
  # saving the eigenvectors plot by: defining the filename, ploting and saving
  ##############################################################################
  
  par(mfrow=c(1,2))

  plot(
    x = df$V1,
    y = df$V2,
    col = df.col + 1,
    pch = 16,
    xlab = "",
    ylab = ""
  )

  scatter3D(
    x = df$V1,
    y = df$V2,
    z = df$V3,
    colvar = NULL,
    col = df.col + 1,
    pch = 16,
    theta = 45,
    phi = 45
  )

  legend(
    x = 'bottomleft',
    legend = unique(df.col),
    col = 1:length(df.col),
    pch = 16
  )
  
  dev.copy(
    png,
    paste(
      substr(
        x = i,
        start = 1,
        stop = nchar(i)-3
      ),
      "png",
      sep = ""
    ),
    width = 8,
    height = 6,
    units = "in",
    res = 100
  )

  dev.off()
}