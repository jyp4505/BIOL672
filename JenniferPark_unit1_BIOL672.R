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
#data from R database - the effect of vitamin c on tooth growth in guinea pigs
#Definitions: OJ=orange juice, VC= Asorbic Acid (VC), doses in mg/day
#sink data into read.table file
datasets::ToothGrowth
write.table(ToothGrowth, file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/gpigtooth_tab.txt', quote=FALSE, sep=" \t ", row=FALSE)

#use read.table function to read table from external file and shape data
data<-read.table("/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/gpigtooth_tab.txt",header=TRUE)
tooth_length=data$len
supplement=data$supp
dose=data$dose

gpigtooth.data<-data.frame(
  tooth_length,
  supplement,
  dose
)

#print data
print(gpigtooth.data)
print(summary(gpigtooth.data))

#oneway ANOVA where tooth length is dependent variable and supplement and doses are independent variables
tooth_length_supp.anova=oneway.test(tooth_length~supplement)
tooth_length_dose.anova=oneway.test(tooth_length~dose)
#print results of anova test
print(tooth_length_supp.anova)
print(tooth_length_dose.anova)
anova_results <- ("For tooth length and supplement, p-value is 0.06 and is greater than 0.05, meaning there is no significant difference between the supplement on the tooth growth on the guinea pigs and the null hypothesis is true.
                  For tooth length and dose, p-value is 2.812E-13 and is less than 0.05, meaning there is significant difference between the dosage amount on the tooth growth on the guinea pigs and the null hypothesis is rejected.")

#calculate the mean and standard error of the tooth length for each supplement and dose
gpig.mean.se<-gpigtooth.data %>%
  group_by(supplement,dose) %>%
  summarize(mean_length=mean(tooth_length),
            se_length=sd(tooth_length)/sqrt(n()),
            .groups='drop' #drop all groupings
            )

#plot tooth length by supplement error bars with ggplot
myplot2<- ggplot(gpig.mean.se, aes(fill=supplement, x=interaction(supplement,dose), y=mean_length)) + 
  geom_bar(position="dodge", stat="identity") + 
  geom_errorbar(aes(ymin=mean_length-se_length, ymax=mean_length+se_length),
                width=0.4)+
  labs(title="Mean tooth length by supplement and dose with error bars", y="Mean length",x="Supplement and Dosage")+
  scale_fill_manual(values=c("OJ"="orange", "VC"="blue"))
print(myplot2)

#Set output of plot
output_plot <-'/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/'

#save as gpigtooth_histo.pdf
ggsave(paste0(output_plot,file='gpigtooth_histo.pdf'), plot=myplot2)

#perform pairwise t-test
#bonferroni
#use interaction function to cover all the combinations of supplement and dose
bon.pairwise.t_test=pairwise.t.test(tooth_length, interaction(supplement,dose), p.adjust.method="bonferroni")
print (bon.pairwise.t_test)

bonferroni_results <- ("Results show that the p-value is greater than 0.05 for the following comparisons: VC 1 and OJ 0.5; OJ 2 and OJ 1; VC2 and OJ 1; and VC 2 and OJ 2, meaning that these comparisons are not stasticially significant to each other and therefore the null hypothesis is true.
                       The remaining p-values are less than 0.05, indicating that for these comparisions they are stastically significant so the null hypothesis is rejected.")

#Benjamini-Hochberg
benhoch.pairwise.t_test=pairwise.t.test(tooth_length, interaction(supplement,dose), p.adjust.method="hochberg")
print(benhoch.pairwise.t_test)

benhoch_results <- ("Compared to the bonferroni pairwise t-test...") #COME BACK TO THIS
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
print(benhoch.pairwise.t_test)
sink()


#QUESTION 5
#Apply Kruskal Wallis test to ANOVA input data to examine it without assumptions of normality
kruskal_wallis_supp<-kruskal.test(tooth_length~supplement)
kruskal_wallis_dose<-kruskal.test(tooth_length~dose)
print(kruskal_wallis_supp)
print(kruskal_wallis_dose)

kruskal_results <- ("Without assuming normality, using ANOVA input data, the p-value between tooth length and the type of supplement is 0.06343, which is still greater than 0.05, so there is no significant difference between the supplement on the tooth growth on the guinea pigs and the null hypothesis is true.
                    Without assuming normality, using ANOVA input data...") #COME BACK TO THIS

#test correlation between two or more categories (supplement and dose) using pearson and spearman methods
#first use pearson
pearson_cor<-cor(supplement, dose, method="pearson")
print(pearson_cor)

spearman_cor<-cor(tooth_length, dose, method="spearman")
print(spearman_cor)

correlation_results <- ("The pearson correlation between the tooth growth and dosage is 0.8283415, indicating a positive correlation.
                         The spearman rank between the tooth growth and the dosage is 0.8283415, indicating a positive monotonic association.")

#make scatter plots of the pearson and spearman
myplot3 <- ggplot(gpigtooth.data, aes(x=dose, y=tooth_length))+geom_point()
print(myplot3)

datasets:: ChickWeight