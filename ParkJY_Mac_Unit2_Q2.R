#Jennifer Park
#Unit 2 assignment

#import libraries 
library('e1071') #for svm
library('kernlab') #for kernal
library('ggplot2') #for plotting
library('dplyr') # for resampling
library('caret') # for confusion matrix
library ('grid') #for putting several plots on grid
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

#SVM
#perform support vector machines (SVM) using e1071

#mytest_svm <-  svm(Outcome~Pregnancies + Glucose + BloodPressure + SkinThickness + Insulin + BMI + DiabetesPedigreeFunction + Age, train_data, probability = TRUE, type = "C-classification", kernel = "linear", cost = 5)
mytest_svm <-  svm(Outcome~Pregnancies + Glucose + BloodPressure + SkinThickness + Insulin + BMI + DiabetesPedigreeFunction + Age, train_data, probability =TRUE, type = "C-classification", kernel = "polynomial", cost = 5, degree = 2, gamma = 4)
#mytest_svm <-  svm(Outcome~Pregnancies + Glucose + BloodPressure + SkinThickness + Insulin + BMI + DiabetesPedigreeFunction + Age, train_data, probability =TRUE, type = "C-classification", kernel = "radial",  cost = 5, gamma = 4)

#remove outcome column from training and test data for predict()
train_data_no_outcome <- train_data[,-which(colnames(train_data) == "Outcome")]
test_data_no_outcome <- test_data[,-which(colnames(test_data) == "Outcome")]

mypred_svm <- predict(mytest_svm, test_data_no_outcome, probability = FALSE, decision.values = TRUE)

#print summary
mySVM <- summary(mytest_svm)
print(mySVM)

#confusion matrix to evaluate scores of SVM model
print(as.factor(mypred_svm))
print(as.factor(test_data$Outcome))

mymatrix_svm <- confusionMatrix(as.factor(mypred_svm), as.factor(test_data$Outcome))
print(mymatrix_svm)

#sink confusion matrix into txt file - linear kernel function
#sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q2_confusion_matrix_svm_linear.txt')
#print(mymatrix_svm)
#sink()

#sink confusion matrix into txt file - polynomial kernel function
sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q2_confusion_matrix_svm_polynomial.txt')
print(mymatrix_svm)
sink()

#sink confusion matrix into txt file - radial basis kernel function
#sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q2_confusion_matrix_svm_radial.txt')
#print(mymatrix_svm)
#sink()


#######################################################################################################

#KSVM

#perform kernel support vector machine (KSVM) using kernlab
#first do kernal function tuning

#mytest_ksvm <- ksvm(as.matrix(train_data_no_outcome), train_data$Outcome, kernel = 'vanilladot') #linear kernel function
mytest_ksvm <- ksvm(as.matrix(train_data_no_outcome), train_data$Outcome, kernel = 'polydot') #polynomial kernel function
#mytest_ksvm <- ksvm(as.matrix(train_data_no_outcome), train_data$Outcome, kernel = 'rbfdot') #radial base kernel function

mypred_ksvm <- predict(mytest_ksvm, test_data_no_outcome, type='response')

#was getting -1 level when printing "mypred" so using ifelse statement to have all values greater than 0, 1, and anything below it 0
mypred_ksvm <- ifelse(mypred_ksvm > 0, 1, 0)

#print summary of ksvm
myKSVM <- summary(mypred_ksvm)
print(myKSVM)

#confusion matrix to evaluate scores of Kernel SVM model
print(as.factor(mypred_ksvm))
print(as.factor(data$Outcome[!sample_data]))

mymatrix_ksvm <- confusionMatrix(as.factor(mypred_ksvm), as.factor(data$Outcome[!sample_data]))
print(mymatrix_ksvm)


#sink confusion matrix into txt file - linear kernel function
#sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q2_confusion_matrix_ksvm_linear.txt')
#print(mymatrix_ksvm)
#sink()

#sink confusion matrix into txt file - polynomial kernel function
sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q2_confusion_matrix_ksvm_polynomial.txt')
print(mymatrix_ksvm)
sink()

#sink confusion matrix into txt file - radial basis kernel function
#sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q2_confusion_matrix_ksvm_radial.txt')
#print(mymatrix_ksvm)
#sink()

###################################################################################################################

#PLOTS

#show colored scatterplot to report correct and incorrect assignments
#some plots based on training data showing outcome as color
myplot1 <-ggplot(train_data, aes(Pregnancies, Glucose, colour = as.factor(train_data$Outcome))) + geom_point()
myplot2 <-ggplot(train_data, aes(Glucose, BMI, colour = as.factor(train_data$Outcome))) + geom_point()                                 
myplot3 <-ggplot(train_data, aes(Insulin, Age, colour = as.factor(train_data$Outcome))) + geom_point()                                 

#plots based on test data showing outcome as color
myplot4 <-ggplot(test_data, aes(Pregnancies, Glucose, colour = as.factor(test_data$Outcome))) + geom_point()
myplot5 <-ggplot(test_data, aes(Glucose, BMI, colour = as.factor(test_data$Outcome))) + geom_point()                                 
myplot6 <-ggplot(test_data, aes(Insulin, Age, colour = as.factor(test_data$Outcome))) + geom_point() 

#plots based on test data showing mypred_svm as color
myplot8 <-ggplot(test_data, aes(Pregnancies, Glucose, colour = as.factor(mypred_svm))) + geom_point()
myplot9 <-ggplot(test_data, aes(Glucose, BMI, colour = as.factor(mypred_svm))) + geom_point()                                 
myplot10 <-ggplot(test_data, aes(Insulin, Age, colour = as.factor(mypred_svm))) + geom_point() 

#plots based on test data showing mypred_ksvm as color
myplot11 <-ggplot(test_data, aes(Pregnancies, Glucose, colour = as.factor(mypred_ksvm))) + geom_point()
myplot12 <-ggplot(test_data, aes(Glucose, BMI, colour = as.factor(mypred_ksvm))) + geom_point()                                 
myplot13 <-ggplot(test_data, aes(Insulin, Age, colour = as.factor(mypred_ksvm))) + geom_point() 


#print plots
#pregnancies vs. glucose
grid.newpage()
pushViewport(viewport(layout = grid.layout(4, 1)))
print(myplot1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot4, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot8, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
print(myplot11, vp = viewport(layout.pos.row = 4, layout.pos.col = 1))

#glucose vs. BMI
grid.newpage()
pushViewport(viewport(layout = grid.layout(4, 1)))
print(myplot2, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot5, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot9, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
print(myplot12, vp = viewport(layout.pos.row = 4, layout.pos.col = 1))

#age vs. insulin
grid.newpage()
pushViewport(viewport(layout = grid.layout(4, 1)))
print(myplot3, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot6, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot10, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
print(myplot13, vp = viewport(layout.pos.row = 4, layout.pos.col = 1))

#save plots as pdf
#pdf("Q2_svm_ksvm_linear_scatter_plots.pdf")

#pregnancies vs. glucose
#grid.newpage()
#pushViewport(viewport(layout = grid.layout(4, 1)))
#print(myplot1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
#print(myplot4, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
#print(myplot8, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
#print(myplot11, vp = viewport(layout.pos.row = 4, layout.pos.col = 1))

#glucose vs. BMI
#grid.newpage()
#pushViewport(viewport(layout = grid.layout(4, 1)))
#print(myplot2, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
#print(myplot5, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
#print(myplot9, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
#print(myplot12, vp = viewport(layout.pos.row = 4, layout.pos.col = 1))

#age vs. insulin
#grid.newpage()
#pushViewport(viewport(layout = grid.layout(4, 1)))
#print(myplot3, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
#print(myplot6, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
#print(myplot10, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
#print(myplot13, vp = viewport(layout.pos.row = 4, layout.pos.col = 1))

#dev.off()

#save plots as pdf
pdf("Q2_svm_ksvm_polynomial_scatter_plots.pdf")

#pregnancies vs. glucose
grid.newpage()
pushViewport(viewport(layout = grid.layout(4, 1)))
print(myplot1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot4, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot8, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
print(myplot11, vp = viewport(layout.pos.row = 4, layout.pos.col = 1))

#glucose vs. BMI
grid.newpage()
pushViewport(viewport(layout = grid.layout(4, 1)))
print(myplot2, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot5, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot9, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
print(myplot12, vp = viewport(layout.pos.row = 4, layout.pos.col = 1))

#age vs. insulin
grid.newpage()
pushViewport(viewport(layout = grid.layout(4, 1)))
print(myplot3, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot6, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot10, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
print(myplot13, vp = viewport(layout.pos.row = 4, layout.pos.col = 1))

dev.off()

#save plots as pdf
#pdf("Q2_svm_ksvm_radial_scatter_plots.pdf")

#pregnancies vs. glucose
#grid.newpage()
#pushViewport(viewport(layout = grid.layout(4, 1)))
#print(myplot1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
#print(myplot4, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
#print(myplot8, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
#print(myplot11, vp = viewport(layout.pos.row = 4, layout.pos.col = 1))

#glucose vs. BMI
#grid.newpage()
#pushViewport(viewport(layout = grid.layout(4, 1)))
#print(myplot2, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
#print(myplot5, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
#print(myplot9, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
#print(myplot12, vp = viewport(layout.pos.row = 4, layout.pos.col = 1))

#age vs. insulin
#grid.newpage()
#pushViewport(viewport(layout = grid.layout(4, 1)))
#print(myplot3, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
#print(myplot6, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
#print(myplot10, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
#print(myplot13, vp = viewport(layout.pos.row = 4, layout.pos.col = 1))

#dev.off()



######################################################################################################

#interpretation
interpretation_file <- "Interpretation_Unit2.md"
myinterpretation <- file(interpretation_file, open = "a" )
writeLines(c(
  "",
  "",
  "QUESTION 2",
  "",
  "I utilized the same dataset as question 1 (diabetes) and used the support vector machine (SVM) 
  method (e.g. e1071) and the kernal SVM (KSVM) method and compared the classification accuracy between the 
  different kernal functions (e.g. linear, polynomial, and radial basis function) and methods.",
  "",
  "LINEAR KERNEL FUNCTION",
  "Using the linear function, the classification accuracy for svm and ksvm came out to be approximately 
  63% and 52.6%, respectively.  The plots show that when comparing the test data outcome to the
  predicted outcome using svm and ksvm, one can see that the colors in the svm plot match up better to the
  test data plat than the ksvm, therefore showing that has a higher classification accuracy.",
  "",
  "CONFUSION MATRIX",
  "1. Q2_confusion_matrix_svm_linear.txt",
  "2. Q2_confusion_matrix_ksvm_linear.txt",
  "",
  "PLOTS FOR LINEAR",
  "Q2_svm_ksvm_linear_scatter_plots.pdf",
  "",
  "POLYNOMIAL KERNEL FUNCTION",
  "Using the polynomial function, the classification accuracy for svm and ksvm came out to be approximately 
  68.6% and 52.9%, respectively.  Similar to the linear function, the plots show that when comparing the test data outcome to the
  predicted outcome using svm and ksvm, one can see that the colors in the svm plot match up better to the
  test data plat than the ksvm, therefore showing that has a higher classification accuracy.",
  "",
  "CONFUSION MATRIX",
  "1. Q2_confusion_matrix_svm_polynomial.txt",
  "2. Q2_confusion_matrix_ksvm_polynomial.txt",
  "",
  "PLOTS FOR POLYNOMIAL",
  "Q2_svm_ksvm_polynomial_scatter_plots.pdf",
  "",
  "RADIAL BASIS KERNEL FUNCTION",
  "Using the radial basis function, the classification accuracy for svm and ksvm came out to be approximately 
  66.4% and 54.5%, respectively.  Similar to the linear and polynomial function, the plots show that when comparing the test data outcome to the
  predicted outcome using svm and ksvm, one can see that the colors in the svm plot match up better to the
  test data plat than the ksvm, therefore showing that has a higher classification accuracy.",
  "",
  "CONFUSION MATRIX",
  "1. Q2_confusion_matrix_svm_radial.txt",
  "2. Q2_confusion_matrix_ksvm_radial.txt",
  "",
  "PLOTS FOR RADIAL BASIS",
  "Q2_svm_ksvm_radial_scatter_plots.pdf",
  "",
  "From the results, it seems that using svm function from the e1071 library had better accuracy
  than when using the ksvm function from the kernel library.  Even though svm has better accuracy,
  overall, the svm methods do not provide a better classification accuracy than the simple machine
  learning methods, like naive Bayes and LDA."
  

)
, con = myinterpretation)

close(con=myinterpretation)

