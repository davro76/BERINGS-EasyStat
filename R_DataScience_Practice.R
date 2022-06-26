
# load required packages
library(tidyverse)
library(ggplot2)

# load mpg dataset
df <- ggplot2::mpg
# display variable names
names(mpg)

# create a scatterplot with dipl and hwy
ggplot(data = mpg)+geom_point(aes(x=displ,y=hwy),size=3, shape="triangle",color="blue")+
ggtitle("Scatterplot for Hwy and Displ") 

# chapter one Exercice one
ggplot() +
  geom_point(
    data = mpg,
    mapping = aes(x = displ, y = hwy,color=drv))
  
  