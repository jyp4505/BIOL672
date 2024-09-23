#Name: Jennifer Park
#Operating system: RStudio

#Unit 1 Assignment
#import ggplot library
library('ggplot2')
library('dplyr')


#Question 2
#Dataset of 5000 random numbers
#Normal distribution

#generating random numbers using normal distribution, classify as dataset
dataset<-rnorm(5000)
#sample mean of dataset
my_mean<-mean(dataset)
#sample standard deviation of dataset
my_sd<-sd(dataset)

#print mean and standard deviation of dataset
my_meansd<-data.frame(my_mean, my_sd)
print(my_meansd)

#histogram (pink) with density line (green) and normal curve (blue) using ggplot
ggplotdata<-data.frame(value=dataset)
myplot1<-ggplot(ggplotdata, aes(value))+
  geom_histogram(aes(y=after_stat(density)), color="purple", fill="lightpink")+
  geom_density(color="green",lwd=1)+geom_function(fun=dnorm, color="blue", lwd=1)+
  labs(title="Histogram of Normal Distribution")


#print myplot1
print(myplot1)

#Question 3
#print mean and sd to an external file
sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/desc.txt')
print(my_meansd)
sink()


#save Rplots.pdf as histo.pdf
ggsave(file="Rplots.pdf")
file.rename(from="Rplots.pdf",to="histo.pdf")

#Question 4
#data from R database - weight of chicks on different feeds
#sink data into read.table file
datasets::chickwts
write.table(chickwts, file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/chickwts_tab.txt', quote=FALSE, sep=" \t ", row=FALSE)

#use read.table function to read table from external file and shape data
data<-read.table("/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/chickwts_tab.txt",header=TRUE)
weight=data$weight
feed=data$feed

chick.data<-data.frame(
  weight,
  feed
)

#print data
print(chick.data)
print(summary(chick.data))

#oneway ANOVA
weight.anova=oneway.test(weight~feed)
#print results of anova test
print(weight.anova)


#plot chick.data 
myplot2<- ggplot(chick.data, aes(fill=feed, y=weight, x=feed)) + 
  geom_bar(position="dodge", stat="identity")+
print(myplot2)

#TRYING TO FIGURE OUT HOW TO ADD ERROR BARS TO BAR CHART

