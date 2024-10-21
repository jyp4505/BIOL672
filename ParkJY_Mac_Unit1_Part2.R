#JenniferPark_unit1_BIOL672.r

#Operating system: MacOS Ventura 13.1

#Unit 1 Assignment - PART 2
#import libraries
library('ggplot2')
library('dplyr')
library ('dgof')
library('readr')

#QUESTION 7
#find appropriate data set from my field (sustainability) for series of multivariate statistical tests
#found household energy consumption data from 2020 Residential Energy Consumption Survey (RECS) by the US EIA - https://www.eia.gov/consumption/residential/data/2020/index.php?view=microdata
#I removed most of the columns and only left columns of interest and renamed them:
#region, household_size (number), household_income (scale where 1 is lowest and 16 is highest),
#electricity_use (thousand btu), electricity_cost ($), ng_use (natural gas, btu), ng_cost ($), 
#total_energy_use (thousand BTU), total_energy_cost ($)
#read cvs file
raw_energy_data <- read_csv("/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/recs2020_data.csv")

#extract first 200 rows from file
energy_data_extracted <- raw_energy_data[1:200,]
#write table of csv file

print(energy_data_extracted)

#write table of extracted columns
write.table(energy_data_extracted, file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/energy_data_tab.txt', quote=FALSE, sep = "\t ", row=FALSE)

#use read.table function to read table from external file and shape data
energy.data <- read.table("/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/energy_data_tab.txt", header=TRUE, row.names=NULL)
region = energy.data$region
household_size = energy.data$household_size
household_income = energy.data$household_income
electricity_use = energy.data$electricity_use
electricity_cost = energy.data$electricity_cost
ng_use = energy.data$ng_use
ng_cost = energy.data$ng_cost
total_energy_use = energy.data$total_energy_use
total_energy_cost = energy.data$total_energy_cost

print(energy.data)

#convert household income from continous (1 to 16) to categorical as these numbers represent different income brackets
cat_household_income = cut(household_income,
                           breaks = c(-Inf, 11, 14, Inf),
                           labels = c("$0-$49,999","$50,000 - $99,999", "$100,000 or more"),
                           right=FALSE)
                       
                           
myenergy.data <- data.frame(
  region,
  household_size,
  cat_household_income,
  electricity_use,
  electricity_cost,
  ng_use,
  ng_cost,
  total_energy_use,
  total_energy_cost
)

#print data
print(myenergy.data)
#print summary of household energy data
print(summary(myenergy.data))


#QUESTION 8
#Use "manova" function on data, where electricity, natural gas, 
#and total energy use and costs are dependent variables
#bind dependent variables
mydep <- cbind(electricity_use, electricity_cost, ng_use, ng_cost, total_energy_use, total_energy_cost)
print(mydep)

#monova test where independent variable must be categorical, in this case choose region
manova.test <- manova(mydep~region, data = myenergy.data)
#summzry of manova, using Pillai's trace
my.manova <- (summary(manova.test, test="Pillai"))
print(my.manova)


#plot of dependent variables and independent variable to see group means for each dependent variable
myplot1 <- ggplot(data = myenergy.data, mapping = aes(x = region, y = electricity_use)) + geom_boxplot() + labs(x = 'Region', y = 'Electricity Use') + theme(axis.text.x=element_text(angle=15), panel.background = element_rect(fill = 'grey50'))
myplot2 <- ggplot(data = myenergy.data, mapping = aes(x = region, y = electricity_cost)) + geom_boxplot() + labs(x = 'Region', y = 'Electricity Cost') + theme(axis.text.x=element_text(angle=15), panel.background = element_rect(fill = 'grey50'))
myplot3 <- ggplot(data = myenergy.data, mapping = aes(x = region, y = ng_use)) + geom_boxplot() + labs(x = 'Region', y = 'Natural Gas Use') + theme(axis.text.x=element_text(angle=15), panel.background = element_rect(fill = 'grey50'))
myplot4 <- ggplot(data = myenergy.data, mapping = aes(x = region, y = ng_cost)) + geom_boxplot() + labs(x = 'Region', y = 'Natural Gas Cost') + theme(axis.text.x=element_text(angle=15), panel.background = element_rect(fill = 'grey50'))
myplot5 <- ggplot(data = myenergy.data, mapping = aes(x = region, y = total_energy_use)) + geom_boxplot() + labs(x = 'Region', y = 'Total Energy Use') + theme(axis.text.x=element_text(angle=15), panel.background = element_rect(fill = 'grey50'))
myplot6 <- ggplot(data = myenergy.data, mapping = aes(x = region, y = total_energy_cost)) + geom_boxplot() + labs(x = 'Region', y = 'Total Energy Cost') + theme(axis.text.x=element_text(angle=15), panel.background = element_rect(fill = 'grey50'))

#print plots
print(myplot1)
print(myplot2)
print(myplot3)
print(myplot4)
print(myplot5)
print(myplot6)


interpretation_file <- "Q7-Q12_interpretation.md"
myinterpretation <- file(interpretation_file, open = "wt" )
writeLines(c(
  "",
  "",
  "QUESTION 8",
  "Since the p value is 2.2E-16 and is significantly smaller than 0.05, 
  there is significant impact of the independent variable, region, 
  to the dependent variables.  Therefore, the null hypothesis can be rejected.
  Also, at least one of the group means is significantly different from the 
  others, possible northeast based on the plots?"
), con = myinterpretation)
close(con = myinterpretation)

#QUESTION 9
#conduct multiple regression that tells how one variable is predicted by the remaining variables
#will use total energy use as the variable that is predicted by the remaining variables, 
#excluding region and income because they are categorical and not continous

#use lm function
mlr.test <- lm(total_energy_use ~ household_size + electricity_use 
                           + electricity_cost + ng_use + ng_cost + total_energy_cost,
                           data = myenergy.data)

#summary of multiple regression test results
my.mlr <- summary(mlr.test)
#print results
print(my.mlr)


interpretation_file <- "Q7-Q12_interpretation.md"
myinterpretation <- file(interpretation_file, open = "a" )
writeLines(c(
  "",
  "",
  "QUESTION 9",
  "For household_size, the p-value is 0.779 and significantly larger than 0.05.  
  There is a positive relationship between household_size and total_energy_use,
  in that when one unit of household_size is increased, the total_energy_use increased by approximately 96.6 units.
  Therefore, the relationship between household_size and total_energy_use is significant and positive.
  For electricity_use, the p-value is < 2E-16 and is significantly smaller than 0.05.
  There is a positive relationship between electricity_use and total_energy_use, in that
  when one unit of electricity_use is increased, the total_energy_use is increased by approximately 1 unit.
  Therefore, the relationship between electricity_use and total_energy_use is significant and positive.
  For electricity_cost, the p-value is < 2E-16 and is significantly smaller than 0.05.
  There is a negative relationship between electricity_cost and total_energy_use, in that
  when one unit of electricity_cost is increased, the total_energy_use is decreased by approximately 51 units.
  Therfore, the relationship between electricity_cost and total_energy_use is significant and negative.
  For ng_use, the p-value is < 2E-16 and is significantly smaller than 0.05.
  There is a positive relationship between ng_use and total_energy_use, in that
  when one unit of ng_use is increased, the total_energy_use is increased by approximately 92 units.
  Therefore, the relationship between ng_use and total_energy_use is significant and positive.
  For ng_cost, the p-value is < 2E-16 and is significantly smaller than 0.05.
  There is a negative relationship between ng_cost and total_energy_use, in that
  when one unit of ng_cost is increased, the total_energy_use is decreased by approximately 45 units.
  Therfore, the relationship between ng_cost and total_energy_use is significant and negative.
  For total_energy_cost, the p-value is < 2E-16 and is significantly smaller than 0.05.
  There is a positive relationship between total_energy_cost and total_energy_use, in that
  when one unit of total_energy_cost is increased, the total_energy_use is increased by approximately 51 units.
  Therfore, the relationship between total_energy_cost and total_energy_use is significant and positive.
  
  Given that if you increase one unit of electricity_use you increase one unit of total_energy_use,
  electricity_use seems to be the best or most significant predictor."
), con = myinterpretation)

close(con=myinterpretation)

#conduct multilple regression within one category, pick NORTHEAST (NE)
#use subset to specify category
mlr.NE.test <- lm(total_energy_use ~ household_size + electricity_use 
               + electricity_cost + ng_use + ng_cost + total_energy_cost,
               data = myenergy.data, subset = region == "NE")

#summary of multiple regression test results
my.mlr.NE <- summary(mlr.NE.test)

#print results
print(my.mlr.NE)

interpretation_file <- "Q7-Q12_interpretation.md"
myinterpretation <- file(interpretation_file, open = "a" )
writeLines(c(
  "When doing the regression focussing on the NORTHEAST (NE) region, for the most part,
  the relationships between the dependent variable (NE) and the other variables are the same
  as when the dependent variable covered all the regions.  However, the p-value for ng_use
  and ng_cost here is 0.01 and 0.05, which are higher than the previous analysis, <2E-16 and <2E-16, respectively.
  This may indicate that the relationship between total_energy_cost and ng_cost and ng_use may not be that significant.
  
  Electricity_use is still the best predictor or most significant predictor as 
  it has a low p-value and value of approximately 1."
), con = myinterpretation)

close(con=myinterpretation)


#QUESTION 10
#Unsure how to create a composite variable..........


#QUESTION 11
#choose hypothesis test or stastical method and compare it on original iris data set
#vs three or corrupted iris data sets
#will use corrupted dataset - iris_tab_missing.txt
#will use ANOVA

#First import original iris data set
#read table from txt
iris.data <- read.table(file="/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/iris_tab.txt", header=TRUE, row.names=NULL)
sepal_length=iris.data$sepal_length
sepal_width=iris.data$sepal_width
petal_length=iris.data$petal_length
petal_width=iris.data$petal_width
species=iris.data$species

#create data frame
my.iris.data<-data.frame(
  sepal_length,
  sepal_width,
  petal_length,
  petal_width,
  species
)

#print iris data and summary
print(my.iris.data)
print(summary(my.iris.data))

#now import corrupted data with missing text, name them with _cor at end
#note need to fill missing values with NA while reading table
iris.corrupt.data <- read.table(file="/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/iris_tab_missing.txt", header=TRUE, sep="\t", fill=TRUE)
sepal_length_cor=iris.corrupt.data$sepal_length
sepal_width_cor=iris.corrupt.data$sepal_width
petal_length_cor=iris.corrupt.data$petal_length
petal_width_cor=iris.corrupt.data$petal_width
species_cor=iris.corrupt.data$species

#create data frame
my.iris.corrupt.data<-data.frame(
  sepal_length_cor,
  sepal_width_cor,
  petal_length_cor,
  petal_width_cor,
  species_cor
)

#print iris data and summary
print(my.iris.corrupt.data)
print(summary(my.iris.corrupt.data))

#now do one-way ANOVA for each original and corrupted dataset
#original
petal_length.anova = oneway.test(petal_length~species) 
petal_width.anova = oneway.test(petal_width~species)
sepal_length.anova = oneway.test(sepal_length~species) 
sepal_width.anova = oneway.test(sepal_width~species)

#corrupted
petal_length_cor.anova = oneway.test(petal_length_cor~species_cor) 
petal_width_cor.anova = oneway.test(petal_width_cor~species_cor)
sepal_length_cor.anova = oneway.test(sepal_length_cor~species_cor) 
sepal_width_cor.anova = oneway.test(sepal_width_cor~species_cor)

#print original and corrupted ANOVA results
print(sepal_length.anova)
print(sepal_length_cor.anova)
print(sepal_width.anova)
print(sepal_width_cor.anova)
print(petal_length.anova)
print(petal_length_cor.anova)
print(petal_width.anova)
print(petal_width_cor.anova)

#interpretation
interpretation_file <- "Q7-Q12_interpretation.md"
myinterpretation <- file(interpretation_file, open = "a" )
writeLines(c(
  "",
  "QUESTION 11",
  "When comparing the original iris dataset to the corrupted datset, in this case
  missing data, there is no significant difference in the ANOVA results. The p-values
  in the corrupt dataset is still significant smaller than 0.05.  Therfore, it can be said
  that the method I chose, one-way ANOVA, is not that sensitive to the modifications."
), con = myinterpretation)

close(con=myinterpretation)


#QUESTION 12
#Use extended iris dataset to analyze the categorical and ordinal (likert scaled)
#results from purchase of iris flowers by customers
#read categorical (species, color, sold) and ordinal (attractiveness, likelytobuy, review)
#unsure of what numbers mean in ordinal variables but will assign values/meaning to each one
#attractiveness ranges from very unattractive to attractive (1 to 5), 
#likelytobuy ranges from highly unlikley to highly likely (-5 o 5)
#review ranges from very unsatisfied to very satisfied (1 to 5)

#read the categorical and ordinal variables from table
iris.purchase.data <- read.table(file="/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/iris_purchase.txt", header=TRUE, sep="\t")
species_pur = iris.purchase.data$species
color_pur = iris.purchase.data$color
attract_pur = iris.purchase.data$attractiveness
likelytobuy_pur = iris.purchase.data$likelytobuy
sold_pur = iris.purchase.data$sold
review_pur = iris.purchase.data$review

#create data fram, put categorical variables first then ordinal variables
my.iris.purchase.data <- data.frame(
  species_pur,
  color_pur,
  sold_pur,
  attract_pur,
  likelytobuy_pur,
  review_pur
)

#print data and summary
print(my.iris.purchase.data)
print(summary(my.iris.purchase.data))

#do kruskal wallis test as we are dealing with ordinal variables

#flowers sold and attractiveness
attract_sold.kw <- kruskal.test(attract_pur~sold_pur)
print(attract_sold.kw)

#flower sold and likelyhood to buy the flowers
likelytobuy_sold.kw <- kruskal.test(likelytobuy_pur~sold_pur)
print(likelytobuy_sold.kw)

#flowers sold and review of flowers
review_sold.kw <- kruskal.test(review_pur~sold_pur)
print(review_sold.kw)

#color of flowers and attractiveness
attract_color.kw <- kruskal.test(attract_pur~color_pur)
print(attract_color.kw)

#color of flowers and likelyhood to buy flowers
likelytobuy_color.kw <- kruskal.test(likelytobuy_pur~color_pur)
print(likelytobuy_color.kw)

#color of flowers and reviews of flowers
review_color.kw <- kruskal.test(review_pur~color_pur)
print(review_color.kw)

#species of flowers and attractiveness
attract_species.kw <- kruskal.test(attract_pur~species_pur)
print(attract_species.kw)

#species of flowers and likelyhood to buy flowers
likelytobuy_species.kw <- kruskal.test(likelytobuy_pur~species_pur)
print(likelytobuy_species.kw)

#species of flowers and reviews of flowers
review_species.kw <- kruskal.test(review_pur~species_pur)
print(review_species.kw)

#interpretation
interpretation_file <- "Q7-Q12_interpretation.md"
myinterpretation <- file(interpretation_file, open = "a" )
writeLines(c(
  "",
  "QUESTION 12",
  "The high p-values from the kruskal wallis tests show that there is no significant influence
  of the categorical variables (species, color, sold) on the ordinal variables 
  (attract, likelytobuy, review).  The only one that shows some significance is
  species and attractiveness."
), con = myinterpretation)

close(con=myinterpretation)


#QUESTION 13
#conduct a principal components analysis (PCA) on energy data
#make dataframe w/o categorical variables
without_cag.dataframe <- data.frame(
  electricity_use,
  electricity_cost,
  ng_use,
  ng_cost,
  total_energy_use,
  total_energy_cost
)

print(without_cag.dataframe)

#calculate the PCA and plot scree plot and biplot
myPCA <-  princomp(without_cag.dataframe, cor = TRUE)
summary(myPCA)
loadings(myPCA)
plot(myPCA, main="Scree plot of energy data",type= "lines")
biplot(myPCA)

#print loadings
print(loadings(myPCA))

#interpretation
interpretation_file <- "Q13-Q16_interpretation.md"
myinterpretation <- file(interpretation_file, open = "a" )
writeLines(c(
  "",
  "QUESTION 13",
  "The reduction of the data was succsessful as shown in the scree plot, where
  the bend or elbow of the curve occurs at component 3, which indicates
  the first three components are enough to explain the data and the rest can be
  ignored or ommitted.",
  "Based on the loadings, and only focusing on the first three components (principle
  components or PCs), PC 1 best describes the overall size variation because it has
  all positive loadings.",
  "It seems that the PC 3 is strongly driven by electricity_use given it is positive
  and has a large loading (0.711). "
), con = myinterpretation)

close(con=myinterpretation)


#QUESTION 14
#conduct a factor analysis
#extract 3 factors
myFACT <- factanal(without_cag.dataframe, 3, rotation="varimax")
print(myFACT, digits=2, cutoff=.3, sort=TRUE)
# plot factor 1 by factor 2
load <- myFACT$loadings[,1:2]
plot(load,type="n") # set up plot
text(load,labels=names(without_cag.dataframe),cex=.7) # add variable names


#QUESTION 15
#scatter plot of electricity_use and electricity_cost color by region
myscatterplot <- ggplot(myenergy.data, aes(x = electricity_use, y = electricity_cost, color = region)) + geom_point()

print(myscatterplot)

#looks like only one "cluster" but difficult to tell
#will use k=1 when calculating kmeans
mykmeans_test <- kmeans(without_cag.dataframe, 1, nstart = 1)
mykmeans <- summary(mykmeans_test)
print(mykmeans)

