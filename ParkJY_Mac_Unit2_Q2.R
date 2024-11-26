#Jennifer Park
#Unit 2 assignment

#import libraries 
library('e1071') #for svm
library('kernlab') #for kernal
library('ggplot2') #for plotting
library('dplyr') # for resampling
library('caret') # for confusion matrix
library ('griad') #for putting several plots on grid
#QUESTION 2

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

#perform kernel support vector machine (KSVM)
#first do kernal function tuning
#mytest <- ksvm(as.matrix(train_data), myoutcome, kernel = 'vanilladot') #linear kernel function
#mytest <- ksvm(as.matrix(train_data), myoutcome, kernel = 'polydot') #polynomial kernel function
mytest <- ksvm(as.matrix(train_data), myoutcome, kernel = 'rbfdot') #radial base kernel function
mypred <- predict(mytest, test_data, type='response')

#was getting -1 level when printing "mypred" so using ifelse statement to have all values greater than 0, 1, and anything below it 0
mypred <- ifelse(mypred>0, 1, 0)

#print summary of ksvm
mySVM <- summary(mypred)
print(mySVM)

#confusion matrix to evaluate scores of Kernel SVM model
print(as.factor(mypred))
print(as.factor(data$Outcome[!sample_data]))

mymatrix <- confusionMatrix(as.factor(mypred), as.factor(data$Outcome[!sample_data]))
print(mymatrix)


#sink confusion matrix into txt file - linear kernel function
#sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q2_confusion_matrix_linear.txt')
#print(mymatrix)
#sink()

#sink confusion matrix into txt file - polynomial kernel function
#sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q2_confusion_matrix_polynomial.txt')
#print(mymatrix)
#sink()

#sink confusion matrix into txt file - radial basis kernel function
sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q2_confusion_matrix_radial.txt')
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
myinterpretation <- file(interpretation_file, open = "a" )
writeLines(c(
  "",
  "",
  "QUESTION 2",
  "",
  "I utilized the same dataset as question 1 (diabetes) and used the kernel support vector
  machine (KSVM) method and compared the classification accuracy between the 
  different kernal functions (e.g. linear, polynomial, and radial basis function).",
  "",
  "LINEAR KERNEL FUNCTION",
  "Using the linear function, the classification accuracy came out to be approximately 52.3%, 
  which is significantly less than the accuracy that was calculated in Q1 using
  the KNN method (e.g. 67.2%).  Similar to KNN, the plots for the test data 
  (pregnancies vs. glucose, glucose vs. bmi, and age vs. insulin) show that the outcome 
  from the dataset and the predicted outcomes in the KSVM using linear function showed some similarities
  in terms of color but one can clearly see the colors of some samples are not the same between
  the two graphs, indicating some inaccuracy in the classification.  The difference in colors
  are slightly more noticeable than when using KNN.",
  "",
  "CONFUSION MATRIX",
  "1.Q2_confusion_matrix_linear.txt",
  "",
  "PLOTS FOR LINEAR",
  "1. Q2_Scatter_Plots_BMI_vs._Glucose_Linear.pdf",
  "2. Q2_Scatter_Plots_Glucose_vs._Pregnancies_Linear.pdf",
  "3. Q2_Scatter_Plots_Insulin_vs._Age_Linear.pdf",
  "",
  "POLYNOMIAL KERNEL FUNCTION",
  "Using the polynomial function, the classification accuracy came out to be approximately 46%, 
  which is significantly less than the accuracy that was calculated in Q1 using
  the KNN method (e.g. 67.2%) and less than the accuracy using the linear function (e.g. 52.3%).
  The plots also show some similarities of the colors between the outcome from the dataset
  and the predicted outcomes (polynomial KSVM) but similar to the linear function, one can see
  the noticeable difference in colors between the two graphs, indicating several misclassifications.",
  "",
  "CONFUSION MATRIX",
  "1.Q2_confusion_matrix_polynomial.txt",
  "",
  "PLOTS FOR POLYNOMIAL",
  "1. Q2_Scatter_Plots_BMI_vs._Glucose_Poly.pdf",
  "2. Q2_Scatter_Plots_Glucose_vs._Pregnancies_Poly.pdf",
  "3. Q2_Scatter_Plots_Insulin_vs._Age_Poly.pdf",
  "",
  "RADIAL BASIS KERNEL FUNCTION",
  "Using the radial basis function, the classification accuracy came out to be approximately 57.2%, 
  which is still less than the accuracy that was calculated in Q1 using
  the KNN method (e.g. 67.2%) but higher than the accuracy using the linear function (e.g. 52.3%)
  and the polynymoial function (46%).
  The plots also show some similarities of the colors between the outcome from the dataset
  and the predicted outcomes (polynomial KSVM) but similar to the linear function and the
  polynomial function, one can see the noticeable difference in colors between the two graphs, 
  indicating several misclassifications.",
  "",
  "CONFUSION MATRIX",
  "1.Q2_confusion_matrix_radial.txt",
  "",
  "PLOTS FOR RADIAL BASIS",
  "1. Q2_Scatter_Plots_BMI_vs._Glucose_Radial.pdf",
  "2. Q2_Scatter_Plots_Glucose_vs._Pregnancies_Radial.pdf",
  "3. Q2_Scatter_Plots_Insulin_vs._Age_Radial.pdf",
  "",
  "From the results, it seems that out of the three different kernel functions, the radial basis
  kernel function produced the higest classification accuracy (e.g. 57.2%). However, it is still
  less than the accuracy seen using the KNN method (e.g. 67.2%), suggesting the simpler
  method, KNN, was better in terms of classification accuracy."

)
, con = myinterpretation)

close(con=myinterpretation)

