#Name: Jennifer Park
#Operating system: RStudio

#Unit 1 Assignment - PART 2
#import libraries
library('ggplot2')
library('dplyr')
library ('dgof')
library('readxl')

#QUESTION 7
#find appropriate data set from my field (food waste) for series of multivariate statistical tests
#found household food waste data from kaggle - https://www.kaggle.com/datasets/mutamwamataka/fw-data

#read excel file
fw_data <- read_excel("/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/FW Data new.xls")

#extract columns of interest- household_size, income, occupation, weekly_grocery_expenditure, purchase_quantity, and waste_quantity
#extract first 100 rows as too many rows of data
fw_data_extracted <- fw_data[(1:100), c("Household_Size", "Income", "Occupation", "Weekly_Grocery_Expenditure", "Purchase_Quantity", "Waste_Quantity")]
print(fw_data_extracted)

#write table of extracted columns
write.table(fw_data_extracted, file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/FW_Data_Tab.txt', quote=FALSE, sep=" \t ", row=FALSE)

#shape data to only include certain columns - household_size, income, occupation, weekly_grocery_expenditure, purchase_quantity, and waste_quantity
#note took out euro symbol next to income as symbol makes it difficult to shape data
#use read.table function to read table from external file and shape data
data <- read.table("/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_1/FW_Data_Tab.txt", header=TRUE)
house_size = data$Household_Size
house_income = data$Income
house_occupation = data$Occupation
house_grocery = data$Weekly_Grocery_Expenditure
house_purchasequantity = data$Purchase_Quantity
house_FW = data$Waste_Quantity

print(data)
myFW.data <- data.frame(
  house_occupation,
  house_size,
  house_income,
  house_grocery,
  house_purchasequantity,
  house_FW
)

#print data
print(myFW.data)
#print summary of FW data
print(summary(myFW.data))


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


