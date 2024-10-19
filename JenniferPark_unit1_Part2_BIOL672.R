#Name: Jennifer Park
#Operating system: RStudio

#Unit 1 Assignment - PART 2
#import libraries
library('ggplot2')
library('dplyr')
library ('dgof')
library('readr')

#QUESTION 7
#find appropriate data set from my field (sustainability) for series of multivariate statistical tests
#found Filipino household expenditure data from kaggle - https://www.kaggle.com/code/issatingzon/exploratory-data-analysis
#read cvs file
exp_data <- read_csv("/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/Household_Income_Exp_Data.csv")

#extract columns of interest- household income, food expenditure, Housing and water expenditure, transportation expenditure, education expenditure, household head employment status, household size
#extract first 300 rows as too many rows of data
#I modified the column headers for the columns I am extracting to remove spacing/make easier to understand

exp_data_extracted <- exp_data[(1:300), c("household_income", "food_expenditure", "housing_water_expenditure", "transportation_expenditure", "education_expenditure", "employment_status", "household_size")]
print(exp_data_extracted)

#write table of extracted columns
write.table(exp_data_extracted, file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/Exp_Data_Tab.txt', quote=FALSE, sep=",", row=FALSE)

#use read.table function to read table from external file and shape data
data <- read.table("/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/Exp_Data_Tab.txt", header=TRUE, row.names=NULL)
house_income = data$household_income
food_exp = data$food_expenditure
housing_water_exp = data$housing_water_expenditure
transport_exp = data$transportation_expenditure
education_exp = data$education_expenditure
employment_status = data$employment_status
household_size = data$household_size

print(data)
myexp.data <- data.frame(
  household_size,
  employment_status,
  house_income,
  food_exp,
  housing_water_exp,
  transport_exp,
  education_exp
)

#print data
print(myexp.data)
#print summary of household expenditure data
print(summary(myexp.data))


#QUESTION 8
#Use "manova" function on data, where grocery expenditures, purchase quantity, and food waste quantity are dependent variables
#bind dependent variables
mydep <- cbind(house_grocery,house_purchasequantity, house_FW)
print(mydep)
#monova test where independent variable must be categorical, in this case house_occupation
manova.test <- manova(mydep~house_occupation, data = myFW.data)
#summzry of manova, using Pillai's trace
mymanova <- (summary(manova.test, test="Pillai"))
print(mymanova)

mymanova_results <- ("Since the p value is 0.5645 and is greater than 0.05, 
                     there is no significant impact of the independent variable, occupation, 
                     to the dependent variables, which are weekly grocery expenditures, 
                     food purchase quantity, and food waste quantity") #COME BACK TO THIS

#plot of dependent variables and independent variable
myplot1 <- ggplot(data = myFW.data, mapping = aes(x = house_occupation, y = house_grocery)) + geom_boxplot() + labs(x = 'Occupation', y = 'Weekly grocery expenditures') + theme(axis.text.x=element_text(angle=15), panel.background = element_rect(fill = 'grey50'))
myplot2 <- ggplot(data = myFW.data, mapping = aes(x = house_occupation, y = house_purchasequantity)) + geom_boxplot() + labs(x = 'Occupation', y = 'Purchase quantity') + theme(axis.text.x=element_text(angle=15), panel.background = element_rect(fill = 'grey50'))
myplot3 <- ggplot(data = myFW.data, mapping = aes(x = house_occupation, y = house_FW)) + geom_boxplot() + labs(x = 'Occupation', y = 'FW quantity') + theme(axis.text.x=element_text(angle=15), panel.background = element_rect(fill = 'grey50'))

print(myplot1)
print(myplot2)
print(myplot3)

#QUESTION 9
#conduct multiple regression that tells how one variable is predicted by the remaining variables


