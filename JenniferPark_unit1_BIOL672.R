#Name: Jennifer Park
#Operating system: RStudio

library('ggplot2')
library('fitdistrplus')
library('reshape2')

#Question 2
#Dataset of 5000 random numbers
#Uniform distribution
library(ggplot2)

#generating random numbers using normal distribution
dataset<-rnorm(5000)
#sample mean
mean(dataset)
#sample standard deviation
sd(dataset)
#histogram with density line using ggplot
ggplotdata<-data.frame(value=dataset)
myplot1<-ggplot(ggplotdata, aes(value))+
  geom_histogram(aes(y=after_stat(density)), color="purple", fill="lightpink")+
  geom_density(color="green",lwd=1)+geom_function(fun=dnorm, color="blue", lwd=1)+
  labs(title="Histogram of Normal Distribution")
#normal curve overlay

print(myplot1)


