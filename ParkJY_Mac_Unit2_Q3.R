#Jennifer Park
#Unit 2 assignment

#import libraries 

library ('neuralnet') #for neuralnet
library('ggplot2') #for plotting
library('dplyr') # for resampling
library('caret') # for confusion matrix
library ('grid') #for putting several plots on grid

#QUESTION 3

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

#make sure length of class vector matches up with test data
print(length(myoutcome))

#perform neural network, 3 hidden layers
mytest <- neuralnet(Outcome~Pregnancies + Glucose + BloodPressure + SkinThickness
                    + Insulin + BMI + DiabetesPedigreeFunction + Age, 
                    test_data, hidden = 3, linear.output = FALSE)
print(mytest)
print(plot(mytest))
mypred <- predict(mytest, test_data, rep = 1, all.units = FALSE)
print(mypred)


#confusion matrix to evaluate scores of neural network
print(max.col(mypred))
Outcome_factor <- as.factor(data$Outcome[!sample_data])
print(as.integer(Outcome_factor))
Outcome_integer <- as.integer(Outcome_factor)
mymatrix <- confusionMatrix(as.factor(max.col(mypred)), as.factor(Outcome_integer))
print(mymatrix)


#sink confusion matrix into txt file - neural network
sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q3_confusion_matrix_neuralnet.txt')
print(mymatrix)
sink()



#interpretation
interpretation_file <- "Interpretation_Unit2.md"
myinterpretation <- file(interpretation_file, open = "a" )
writeLines(c(
  "",
  "",
  "QUESTION 3",
  "",
  "I utilized the same dataset as question 1 and 2 (diabetes) and used the neural network
   to calculate the accuracy.  The neuralnet provided a classification accuracy of 63.7%, which
  is more accurate than when using the radial basis KSVM in question 2 (e.g. 57.2%) but still 
  not as accurate as the KNN method (e.g. 67.2%).",
  "",
  "CONFUSION MATRIX",
  "1. Q3_confusion_matrix_neuralnet.txt",
  "",
  "NEURAL NETWORK",
  "Q3_neuralnet.pdf",
  ""
  
)
, con = myinterpretation)

close(con=myinterpretation)
