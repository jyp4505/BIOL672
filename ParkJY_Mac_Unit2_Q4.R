#Jennifer Park
#Unit 2 assignment

#import libraries 

library('randomForest') #for random forest
library('ada') #for adaboost, binary classifier
library('ggplot2') #for plotting
library('dplyr') # for resampling
library('caret') # for confusion matrix
library ('grid') #for putting several plots on grid

#QUESTION 4

#import dataset from kaggle
#import diabetes set lara311/diabetes-dataset-using-many-medical-metrics
#read diabetes dataset
data <- read.csv('/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/diabetes_tab.csv')
Pregnancies = data$Pregnancies #number of pregnancies
Glucose = data$Glucose #glucose level
BloodPressure = data$BloodPressure #diastolic blood pressure (mm Hg)
SkinThickness = data$SkinThickness #triceps skinfold thickness (mm)
Insulin = data$Insulin #2-hour serum insulin (mu U/ml)
BMI = data$BMI #body mass index (kg/m^2)
DiabetesPedigreeFunction = data$DiabetesPedigreeFunction #function that scores likelihood of diabetes based on family history
Age = data$Age #age in years
Outcome = data$Outcome # whether person has diabetes, 1 = YES, 0 = NO

#set dataframe
dataframe = data.frame(Pregnancies, Glucose, BloodPressure, SkinThickness, 
                       Insulin, BMI, DiabetesPedigreeFunction, Age, Outcome)

#set subframe (w/o outcome)
subframe = data.frame(Pregnancies, Glucose, BloodPressure, SkinThickness, 
                      Insulin, BMI, DiabetesPedigreeFunction, Age)
print(subframe)

#shuffle dataframe (including Outcome)
shuffled_dataframe <- dataframe[sample(nrow(dataframe)), ]
print(shuffled_dataframe)

#split subframe dataset intro training and test datasets
#Try 20% test and 80% training, where 80% data is TRUE and 20% is FALSE
sample_data <- sample(c(TRUE, FALSE), nrow(dataframe), replace=TRUE, prob=c(0.8,0.2))

#TRUE values for training data
train_data <- dataframe[sample_data, ]

#FALSE values for test data
test_data <- dataframe[!sample_data, ]

#print train and test data
print(train_data)
print(test_data)

#print dimensions to confirm if training data is 80% and test data is 20%
print(dim(train_data))
print(dim(test_data))


#RANDOM FOREST
#perform random forest classifier
#change outcome to factor
dataframe$Outcome <- as.factor(dataframe$Outcome)
test_data$Outcome <- as.factor(test_data$Outcome)
train_data$Outcome <- as.factor(train_data$Outcome)
mytest_randomforest <- randomForest(Outcome~Pregnancies + Glucose + BloodPressure + SkinThickness
                        + Insulin + BMI + DiabetesPedigreeFunction + Age, train_data, ntree = 500)

#remove outcome column from training and test data for predict()
train_data_no_outcome <- train_data[,-which(colnames(train_data) == "Outcome")]
test_data_no_outcome <- test_data[,-which(colnames(test_data) == "Outcome")]

mypred_randomforest <- predict(mytest_randomforest, test_data_no_outcome, probability = FALSE, decision.values = TRUE)

print(mypred_randomforest)


#confusion matrix to evaluate scores of random forest
print(as.factor(mypred_randomforest))
print(as.factor(test_data$Outcome))
mymatrix <- confusionMatrix(as.factor(mypred_randomforest), as.factor(test_data$Outcome))
print(mymatrix)


#sink confusion matrix into txt file - random forest
sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q4_confusion_matrix_randomforest.txt')
print(mymatrix)
sink()



#interpretation
interpretation_file <- "Interpretation_Unit2.md"
myinterpretation <- file(interpretation_file, open = "a" )
writeLines(c(
  "",
  "",
  "QUESTION 4",
  "",
  "RANDOM FOREST",
  "",
  "I utilized the same dataset diabetes dataset from the previous questions (diabetes) 
  and used the random forest method to classify and determine calculate the accuracy.  
  The confusion matrix provided a classification accuracy of 74.4%, which
  is similar to the accuracies found in machine learning (e.g. naive bayes) and
  neural network.  However, the classification accuracy for random forest is significantly greater
  than the svm methods.",
  "",
  "CONFUSION MATRIX",
  "",
  "1. Q4_confusion_matrix_randomforest.txt"

  
)
, con = myinterpretation)

close(con=myinterpretation)


#########################################################################################################

#ADA BOOSTING
#now try adaptive boosting (adaboost) method
mytest_adaboost <-  ada(Outcome~Pregnancies + Glucose + BloodPressure + SkinThickness
                        + Insulin + BMI + DiabetesPedigreeFunction + Age, train_data) 

mypred_adaboost <- predict(mytest_adaboost, test_data_no_outcome, probability = FALSE, decision.values = TRUE)

print(mypred_adaboost)

#confusion matrix to evaluate scores of ada boost
print(as.factor(mypred_adaboost))
print(as.factor(test_data$Outcome))
mymatrix <- confusionMatrix(as.factor(mypred_adaboost), as.factor(test_data$Outcome))
print(mymatrix)


#sink confusion matrix into txt file - ada boost
sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q4_confusion_matrix_adaboost.txt')
print(mymatrix)
sink()

#interpretation
interpretation_file <- "Interpretation_Unit2.md"
myinterpretation <- file(interpretation_file, open = "a" )
writeLines(c(
  "",
  "ADABOOST",
  "",
  "I utilized the same dataset diabetes dataset from the previous questions (diabetes) 
  and used the adaboost method to classify and determine calculate the accuracy.  
  The confusion matrix provided a classification accuracy of 71.4%, which
  is similar to the accuracies found in machine learning (e.g. naive bayes),
  neural network, and random forest.  However, the classification accuracy for 
  random forest is significantly greater than the svm methods.",
  "",
  "Out of all the methods used, the neural network method provided the highest
  classification accuracy for the diabetes dataset, with an outcome of whether or not
  someone has diabetes.",
  "",
  "CONFUSION MATRIX",
  "",
  "1. Q4_confusion_matrix_adaboost.txt",
  
  
)
, con = myinterpretation)

close(con=myinterpretation)
