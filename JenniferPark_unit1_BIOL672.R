#Name: Jennifer Park
#Operating system: RStudio

#Unit 1 Assignment
#import ggplot library
library('ggplot2')

#Question 2
#Dataset of 5000 random numbers
#Normal distribution

#generating random numbers using normal distribution
dataset<-rnorm(5000)
#sample mean
my_mean<-mean(dataset)
#sample standard deviation
my_sd<-sd(dataset)

#print mean and standard deviation
my_meansd<-data.frame(my_mean, my_sd)
print(my_meansd)

#histogram with density line using ggplot
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
#data from R database - weight versus age of chicks on different diets
#sink data into read.table file
datasets::ChickWeight
write.table(ChickWeight, file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/ChickWeight_tab.txt', sep="  ")

#use read.table function to read table from external file and shape data
data<-read.table("/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/ChickWeight_tab.txt",header=TRUE)
weight=data$weight
Time=data$Time
Chick=data$Chick
Diet=data$Diet

chick.data<-data.frame(
  weight,
  Time,
  Chick,
  Diet
)

print(chick.data)
print(summary(chick.data))

#oneway ANOVA
weight.anova=oneway.test(weight~Chick)
Time.anova=oneway.test(Time~Chick)
Diet.anova=oneway.test(Diet~Chick)

print(weight.anova)
print(Time.anova)
print(Diet.anova)
