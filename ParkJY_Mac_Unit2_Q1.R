#Jennifer Park
#Unit 2 assignment

#import libraries 
library('class') #for KNN
library('ggplot2') #for plotting
library('dplyr') # for resampling
library('caret') # for confusion matrix
library ('grid') #for putting several plots on grid

#QUESTION 1

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

#shuffle subframe (excluding Outcome)
shuffled_subframe <- subframe[sample(nrow(subframe)), ]
print(shuffled_subframe)

#split subframe dataset intro training and test datasets
#Try 20% test and 80% training, where 80% data is TRUE and 20% is FALSE
sample_data <- sample(c(TRUE, FALSE), nrow(subframe), replace=TRUE, prob=c(0.8,0.2))

#TRUE values for training data
train_data <- subframe[sample_data, ]

#FALSE values for test data
test_data <- subframe[!sample_data, ]

#print train and test data
print(train_data)
print(test_data)

#print dimensions to confirm if training data is 80% and test data is 20%
print(dim(train_data))
print(dim(test_data))

#class vector for training data (Outcome)
myoutcome = data$Outcome[sample_data]
print(myoutcome)

#make sure length of class vector matches up with test data
print(length(myoutcome))

#perform knn, using k=3
mypred <- knn(train_data, test_data, myoutcome, k=3, l = 0, prob = FALSE, use.all = TRUE)

#print summary of knn
myKNN <- summary(mypred)
print(myKNN)

#confusion matrix to evaluate scores of KNN model
print(as.factor(mypred))
print(as.factor(data$Outcome[!sample_data]))

mymatrix <- confusionMatrix(as.factor(mypred), as.factor(data$Outcome[!sample_data]))
print(mymatrix)


#sink confusion matrix into txt file
sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q1_confusion_matrix.txt')
print(mymatrix)
sink()

#show colored scatterplot to report correct and incorrect assignments
#some plots based on training data showing outcome as color
myplot1 <-ggplot(train_data, aes(Pregnancies, Glucose, colour = as.factor(data$Outcome[sample_data]))) + geom_point()
myplot2 <-ggplot(train_data, aes(Glucose, BMI, colour = as.factor(data$Outcome[sample_data]))) + geom_point()                                 
myplot3 <-ggplot(train_data, aes(Insulin, Age, colour = as.factor(data$Outcome[sample_data]))) + geom_point()                                 

#plots based on test data showing outcome as color
myplot4 <-ggplot(test_data, aes(Pregnancies, Glucose, colour = as.factor(data$Outcome[!sample_data]))) + geom_point()
myplot5 <-ggplot(test_data, aes(Glucose, BMI, colour = as.factor(data$Outcome[!sample_data]))) + geom_point()                                 
myplot6 <-ggplot(test_data, aes(Insulin, Age, colour = as.factor(data$Outcome[!sample_data]))) + geom_point() 

#plots based on test data showing mypred as color
myplot7 <-ggplot(test_data, aes(Pregnancies, Glucose, colour = as.factor(mypred))) + geom_point()
myplot8 <-ggplot(test_data, aes(Glucose, BMI, colour = as.factor(mypred))) + geom_point()                                 
myplot9 <-ggplot(test_data, aes(Insulin, Age, colour = as.factor(mypred))) + geom_point() 


#pregnancies vs. glucose
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot4, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot7, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))


#glucose vs. BMI
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot2, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot5, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot8, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

#age vs. insulin
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot3, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot6, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot9, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))



#interpretation
interpretation_file <- "Interpretation_Unit2.md"
myinterpretation <- file(interpretation_file, open = "wt" )
writeLines(c(
  "",
  "QUESTION 1",
  "",
  "I utilized KNN method to classify a new dataset using the pre-classified diabetes dataset.
  I shuffled the dataset, specifically the subframe which did not include the class (e.g. outcome),
  and split the dataset into 20% test data and 80% training data. Using the KNN function and the confusion
  matrix, I was able to find the the incorrect and correct assignments, along with how accurate the
  model was.  According the the matrix, the model correctly assigned 91 people as 0 or 
  not having diabetes (e.g. True negative), the model correctly assigned 28 people as 1
  or having diabetes (e.g. True positive), the model mistakenly assigned 31 people as 0 or not
  having diabetes (e.g. False negative), and the model mistakenly assigned 27 people as 1 or 
  having diabetes.  Therefore, the accuracy of the model turns out to be approximately 67.2%,
  showing that the model is somewhat accurate, but not that accurate in correctly classifying.",
  "",
  "CONFUSION MATRIX",
  "1. Q1_confusion_matrix.txt",
  "",
  "PLOTS",
  "1. Q1_Scatter_Plots_Glucose_vs._Pregnancies.pdf",
  "2. Q1_Scatter_Plots_Glucose_vs._BMI.pdf",
  "3. Q1_Scatter_Plots_Insulin_vs._Age.pdf",
  "",
  "The plots for the test data (pregnancies vs. glucose, glucose vs. bmi, and age vs. insulin) 
  show that the outcome from the dataset and the predicted outcomes in KNN showed some similarities
  in terms of color but one can clearly see the colors of some samples are not the same between
  the two graphs, indicating some inaccuracy in the classification."

)
, con = myinterpretation)

close(con=myinterpretation)

