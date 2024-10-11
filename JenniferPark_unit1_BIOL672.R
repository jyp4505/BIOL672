#Name: Jennifer Park
#Operating system: RStudio

#Unit 1 Assignment
#import ggplot library
library('ggplot2')
library('dplyr')


#Question 2
#Dataset of 5000 random numbers
#Normal distribution

#set same random 5000 numbers using set.seed function
set.seed(5000)
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

#Set output of plot
output_plot <-'/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/'

#save as histo.pdf
ggsave(paste0(output_plot,file='histo.pdf'), plot=myplot1)



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
  feed,
  weight
)

#print data
print(chick.data)
print(summary(chick.data))

#oneway ANOVA
weight.anova=oneway.test(weight~feed)
#print results of anova test
print(weight.anova)

anova_results <- ("p-value is 1.177E-08 and is less than 0.05, meaning the type of feed is significantly significant on the weight of the chicks and the null hypothesis is true")

#calculate the mean and standard error of the weight for each feed type
chick.mean.se<-chick.data %>%
  group_by(feed) %>%
  summarize(mean_weight=mean(weight),
            se_weight=sd(weight)/sqrt(n())
            )

#plot chick mean weight and error bars with ggplot
myplot2<- ggplot(chick.mean.se, aes(fill=feed, y=mean_weight, x=feed)) + 
  geom_bar(position=position_dodge(), stat="identity") + 
  geom_errorbar(aes(x=feed, ymin=mean_weight-se_weight, ymax=mean_weight+se_weight),width=0.4)+
  labs(title="Mean chick weight by feed with error bars", y="Mean Weight",x="Feed")
print(myplot2)

#Set output of plot
output_plot <-'/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/'

#save as chickweight_histo.pdf
ggsave(paste0(output_plot,file='chickweight_histo.pdf'), plot=myplot2)

#perform pairwise t-test
#bonferroni
bon.pairwise.t_test=pairwise.t.test(weight, feed, p.adjust.method="bonferroni")
print (bon.pairwise.t_test)

bonferroni_results <- ("results show that the p-value < 0.05 for the following feeds: 
horsebean and casein; linseed and casein; meatmeal and horsebean; 
soybean and casein; sobean and horsebean; sunflower and horsebean; 
sunflower and linseed; and sunflower and soybean
p-value < 0.05 indicates that the difference of the mean weight between the feeds is statistically significant and so the null hyopthesis should be rejected, which states that there is no signficant difference is expected
for the the feeds that have a p-value > 0.05, the difference of the mean weight between the feeds is not stastically significant so the null hypothesis is true")

#Benjamini-Hochberg
benhoch.pairwise.t_test=pairwise.t.test(weight, feed, p.adjust.method="hochberg")
print(benhoch.pairwise.t_test)

benhoch_results <- ("") #COME BACK TO THIS
#sink one-way ANOVA test and pairwise t-test results
sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/Q4_results.txt')
print(weight.anova)
print(bon.pairwise.t_test)
print(benhoch.pairwise.t_test)
sink()
#sink interpretation to separate text file
sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/Q4_Interpretation.txt')
print(anova_results)
print(bonferroni_results)
sink()


#QUESTION 5

