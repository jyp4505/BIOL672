#Name: Jennifer Park
#Operating system: RStudio

library('ggplot2')
library('fitdistrplus')
library('reshape2')

#Question 2
#Dataset of 5000 random numbers
#Uniform distribution
library(ggplot2)

#generating random numbers using uniform distribution
dataset<-runif(5000)
#sample mean
mean(dataset)
#sample standard deviation
sd(dataset)
#histogram with density line using ggplot
ggplotdata<-data.frame(value=dataset)
myplot1<-ggplot(ggplotdata, aes(value))+
  geom_histogram(aes(y=after_stat(density)), color="purple", fill="lightpink")+
  geom_density()+
  geom_function(fun=dnorm, args=list(mean=0.5015054, sd=0.289315), color="blue")+
  labs(title="Histogram of Uniform Distribution")
#normal curve overlay

print(myplot1)


