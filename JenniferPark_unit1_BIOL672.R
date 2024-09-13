#Name: Jennifer Park
#Operating system: RStudio

library('ggplot2')
library('fitdistrplus')
library('reshape2')

#Question 2
#Dataset of 5000 random numbers
#Normal distribution
library(ggplot2)

#generating random numbers using normal distribution
dataset<-rnorm(5000)
#sample mean
mymean<-mean(dataset)
#sample standard deviation
mysd<-sd(dataset)

#print mean and standard deviation
mymeansd<-data.frame(mymean, mysd)
print(mymeansd)
#histogram with density line using ggplot
ggplotdata<-data.frame(value=dataset)
myplot1<-ggplot(ggplotdata, aes(value))+
  geom_histogram(aes(y=after_stat(density)), color="purple", fill="lightpink")+
  geom_density(color="green",lwd=1)+geom_function(fun=dnorm, color="blue", lwd=1)+
  labs(title="Histogram of Normal Distribution")

#print myplot1
print(myplot1)

#print mean and sd to an external file
sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/desc.txt')
print(mymeansd)
sink()
#HOW TO REMOVE THE 1 BEFORE MEAN AND SD?????

#save Rplots.pdf as histo.pdf
ggsave(myplot1, file="histo.pdf")
