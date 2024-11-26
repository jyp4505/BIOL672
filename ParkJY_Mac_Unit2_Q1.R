#Jennifer Park
#Unit 2 assignment

#import libraries 
library('class') #for KNN
library('e1071') #for Naive Bayes
library('MASS') #for linear and quadratic discriminant analysis
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


#KNN CLASSIFIER
#perform knn, using k=3
#remove outcome column from training and test data for predict()
train_data_no_outcome <- train_data[,-which(colnames(train_data) == "Outcome")]
test_data_no_outcome <- test_data[,-which(colnames(test_data) == "Outcome")]

mypred_knn <- knn(train_data_no_outcome, test_data_no_outcome, train_data$Outcome, k=3, l = 0, prob = FALSE, use.all = TRUE)

#print summary of knn
myKNN <- summary(mypred_knn)
print(myKNN)

#confusion matrix to evaluate scores of KNN model
print(as.factor(mypred_knn))
print(as.factor(test_data$Outcome))

mymatrix_knn <- confusionMatrix(as.factor(mypred_knn), as.factor(test_data$Outcome))
print(mymatrix_knn)


#sink confusion matrix into txt file
sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q1_confusion_matrix_KNN.txt')
print(mymatrix_knn)
sink()

#show colored scatterplot to report correct and incorrect assignments
#some plots based on training data showing outcome as color
myplot1 <-ggplot(train_data, aes(Pregnancies, Glucose, colour = as.factor(train_data$Outcome))) + geom_point()
myplot2 <-ggplot(train_data, aes(Glucose, BMI, colour = as.factor(train_data$Outcome))) + geom_point()                                 
myplot3 <-ggplot(train_data, aes(Insulin, Age, colour = as.factor(train_data$Outcome))) + geom_point()                                 

#plots based on test data showing outcome as color
myplot4 <-ggplot(test_data, aes(Pregnancies, Glucose, colour = as.factor(test_data$Outcome))) + geom_point()
myplot5 <-ggplot(test_data, aes(Glucose, BMI, colour = as.factor(test_data$Outcome))) + geom_point()                                 
myplot6 <-ggplot(test_data, aes(Insulin, Age, colour = as.factor(test_data$Outcome))) + geom_point() 

#plots based on test data showing mypred_knn as color
myplot7 <-ggplot(test_data, aes(Pregnancies, Glucose, colour = as.factor(mypred_knn))) + geom_point()
myplot8 <-ggplot(test_data, aes(Glucose, BMI, colour = as.factor(mypred_knn))) + geom_point()                                 
myplot9 <-ggplot(test_data, aes(Insulin, Age, colour = as.factor(mypred_knn))) + geom_point() 

#print plots
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

#save plots as pdf
pdf("Q1_knn_scatter_plots.pdf")

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

dev.off()

#####################################################################################################

#NAIVE BAYES CLASSIFIER
#perform naive bayes
mytest_nbe <-  naiveBayes(Outcome~Pregnancies + Glucose + BloodPressure + SkinThickness
                      + Insulin + BMI + DiabetesPedigreeFunction + Age, 
                      test_data, laplace = 0) 
mypred_nbe <- predict(mytest_nbe, test_data_no_outcome, probability = FALSE, decision.values = TRUE)

#print summary of test
myNBE <- summary(mytest_nbe)
print(myNBE)

#confusion matrix to evaluate scores of Naive Bayes model
print(as.factor(mypred_nbe))
print(as.factor(test_data$Outcome))

mymatrix_nbe <- confusionMatrix(as.factor(mypred_nbe), as.factor(test_data$Outcome))
print(mymatrix_nbe)


#sink confusion matrix into txt file
sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q1_confusion_matrix_NBE.txt')
print(mymatrix_nbe)
sink()

#plots based on test data showing mypred_nbe as color
myplot10 <-ggplot(test_data, aes(Pregnancies, Glucose, colour = mypred_nbe)) + geom_point()
myplot11 <-ggplot(test_data, aes(Glucose, BMI, colour = mypred_nbe)) + geom_point()                                 
myplot12 <-ggplot(test_data, aes(Insulin, Age, colour = mypred_nbe)) + geom_point() 

#print plots
#pregnancies vs. glucose
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot4, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot10, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))


#glucose vs. BMI
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot2, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot5, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot11, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

#age vs. insulin
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot3, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot6, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot12, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

#save plots as pdf
pdf("Q1_nbe_scatter_plots.pdf")

#pregnancies vs. glucose
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot4, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot10, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))


#glucose vs. BMI
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot2, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot5, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot11, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

#age vs. insulin
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot3, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot6, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot12, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

dev.off()


##########################################################################################################

#LINEAR DISCRIMINANT ANALYSIS


#perform LDA
mytest_lda <- lda(Outcome~Pregnancies + Glucose + BloodPressure + SkinThickness
              + Insulin + BMI + DiabetesPedigreeFunction + Age, 
              test_data) 
mypred_lda <- predict(mytest_lda, test_data_no_outcome, prior = mytest_lda$prior, method = "predictive")
print(mytest_lda)
print(mypred_lda)
print(mypred_lda$class) 
mypred_lda_class = mypred_lda$class 

#print summary of test
myLDA <- summary(mytest_lda)
print(myLDA)

#confusion matrix to evaluate scores of LDA model
print(as.factor(mypred_lda_class))
print(as.factor(test_data$Outcome))

mymatrix_lda <- confusionMatrix(as.factor(mypred_lda_class), as.factor(test_data$Outcome))
print(mymatrix_lda)

#sink confusion matrix into txt file
sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q1_confusion_matrix_LDA.txt')
print(mymatrix_lda)
sink()

#plot LD
myLDplot <- plot(mytest_lda)
print(myLDplot)

#plots based on test data showing mypred_nbe as color
myplot13 <-ggplot(test_data, aes(Pregnancies, Glucose, colour = mypred_lda_class)) + geom_point()
myplot14 <-ggplot(test_data, aes(Glucose, BMI, colour = mypred_lda_class)) + geom_point()                                 
myplot15 <-ggplot(test_data, aes(Insulin, Age, colour = mypred_lda_class)) + geom_point() 

#print plots
#pregnancies vs. glucose
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot4, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot13, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

#glucose vs. BMI
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot2, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot5, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot14, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

#age vs. insulin
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot3, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot6, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot15, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

#save plots as pdf
pdf("Q1_lda_scatter_plots.pdf")

#pregnancies vs. glucose
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot4, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot13, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

#glucose vs. BMI
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot2, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot5, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot14, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

#age vs. insulin
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot3, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot6, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot15, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

dev.off()

##########################################################################################################

#QUADRATIC DISCRIMINANT ANALYSIS


#perform QDA
mytest_qda <- qda(Outcome~Pregnancies + Glucose + BloodPressure + SkinThickness
                  + Insulin + BMI + DiabetesPedigreeFunction + Age, 
                  test_data) 
mypred_qda <- predict(mytest_qda, test_data_no_outcome, prior = mytest_qda$prior, method = "predictive")
print(mytest_qda)
print(mypred_qda)
print(mypred_qda$class) 
mypred_qda_class = mypred_qda$class 

#print summary of test
myQDA <- summary(mytest_qda)
print(myQDA)

#confusion matrix to evaluate scores of QDA model
print(as.factor(mypred_qda_class))
print(as.factor(test_data$Outcome))

mymatrix_qda <- confusionMatrix(as.factor(mypred_qda_class), as.factor(test_data$Outcome))
print(mymatrix_qda)

#sink confusion matrix into txt file
sink(file='/Users/jenniferpark/Desktop/BIOL672/Assignments/Unit_2/Q1_confusion_matrix_QDA.txt')
print(mymatrix_qda)
sink()

#plot QD
myQDplot <- plot(mytest_qda)
print(myQDplot)

#plots based on test data showing mypred_nbe as color
myplot16 <-ggplot(test_data, aes(Pregnancies, Glucose, colour = mypred_qda_class)) + geom_point()
myplot17 <-ggplot(test_data, aes(Glucose, BMI, colour = mypred_qda_class)) + geom_point()                                 
myplot18 <-ggplot(test_data, aes(Insulin, Age, colour = mypred_qda_class)) + geom_point() 

#print plots
#pregnancies vs. glucose
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot4, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot16, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

#glucose vs. BMI
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot2, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot5, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot17, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

#age vs. insulin
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot3, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot6, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot18, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

#save plots as pdf
pdf("Q1_qda_scatter_plots.pdf")

#pregnancies vs. glucose
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot4, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot16, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

#glucose vs. BMI
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot2, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot5, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot17, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

#age vs. insulin
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1)))
print(myplot3, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(myplot6, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(myplot18, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

dev.off()

#########################################################################################################

#interpretation
interpretation_file <- "Interpretation_Unit2.md"
myinterpretation <- file(interpretation_file, open = "wt" )
writeLines(c(
  "",
  "QUESTION 1",
  "",
  "KNN",
  "Using the KNN method on the diabetes dataset, the classfication accuracy, or the
  percentage of correct assignments was approximately 65%. The plots for the test data 
  (pregnancies vs. glucose, glucose vs. bmi, and age vs. insulin) show that the outcome 
  from the dataset and the predicted outcomes in KNN shave similar colors of samples
  but one can clearly see the colors of some samples are not the same between
  the two graphs, indicating some inaccuracy in the classification.",
  "",
  "CONFUSION MATRIX",
  "Q1_confusion_matrix_KNN.txt",
  "",
  "PLOTS",
  "Q1_knn_scatter_plots.pdf",
  "",
  "NAIVE BAYES",
  "Using the naive Bayes method on the diabetes dataset, the classfication accuracy, or the
  percentage of correct assignments was approximately 72.6%. The accuracy is slightly higher
  than the accuracy seen in KNN.  The plots for the test data 
  (pregnancies vs. glucose, glucose vs. bmi, and age vs. insulin) show that the outcome 
  from the dataset and the predicted outcomes in naive Bayes have more the same colors of samples
  than KNN but one can still see the colors of some samples are not the same between
  the two graphs, indicating some inaccuracy in the classification.",
  "",
  "CONFUSION MATRIX",
  "Q1_confusion_matrix_NBE.txt",
  "",
  "PLOTS",
  "Q1_nbe_scatter_plots.pdf",
  "",
  "LDA",
  "Using the LDA method on the diabetes dataset, the classfication accuracy, or the
  percentage of correct assignments was approximately 79%. The accuracy is higher
  than the accuracy seen in both KNN and naive Bayes.  Similar to the other methods, 
  the plots for the test data (pregnancies vs. glucose, glucose vs. bmi, and age vs. insulin) 
  show that the outcome from the dataset and the predicted outcomes in naive Bayes 
  have very similar colors of samples but one can still see the colors of some samples are 
  not the same between the two graphs, indicating some minor inaccuracy in the classification.",
  "",
  "CONFUSION MATRIX",
  "Q1_confusion_matrix_LDF.txt",
  "",
  "PLOTS",
  "Q1_lda_scatter_plots.pdf",
  "",
  "QDA",
  "Using the QDA method on the diabetes dataset, the classfication accuracy, or the
  percentage of correct assignments was approximately 50%. The accuracy is signifcantly
  lower than the accuracies found in the other methods.  The plots for the test data 
  (pregnancies vs. glucose, glucose vs. bmi, and age vs. insulin) 
  show that the outcome from the dataset and the predicted outcomes in naive Bayes 
  have some similar colors of samples but one can clearly still see the colors of many samples are 
  not the same between the two graphs, indicating some major inaccuracy in the classification.",
  "", 
  "CONFUSION MATRIX",
  "Q1_confusion_matrix_QDA.txt",
  "",
  "PLOTS",
  "Q1_qda_scatter_plots.pdf",
  ""
  
  

)
, con = myinterpretation)

close(con=myinterpretation)

