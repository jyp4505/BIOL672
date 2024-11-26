
QUESTION 1

KNN

Using the KNN method on the diabetes dataset, the classfication accuracy, or the
  percentage of correct assignments was approximately 65%. The plots for the test data 
  (pregnancies vs. glucose, glucose vs. bmi, and age vs. insulin) show that the outcome 
  from the dataset and the predicted outcomes in KNN shave similar colors of samples
  but one can clearly see the colors of some samples are not the same between
  the two graphs, indicating some inaccuracy in the classification.

CONFUSION MATRIX

Q1_confusion_matrix_KNN.txt

PLOTS

Q1_knn_scatter_plots.pdf

NAIVE BAYES

Using the naive Bayes method on the diabetes dataset, the classfication accuracy, or the
  percentage of correct assignments was approximately 72.6%. The accuracy is slightly higher
  than the accuracy seen in KNN.  The plots for the test data 
  (pregnancies vs. glucose, glucose vs. bmi, and age vs. insulin) show that the outcome 
  from the dataset and the predicted outcomes in naive Bayes have more the same colors of samples
  than KNN but one can still see the colors of some samples are not the same between
  the two graphs, indicating some inaccuracy in the classification.

CONFUSION MATRIX

Q1_confusion_matrix_NBE.txt

PLOTS

Q1_nbe_scatter_plots.pdf

LDA

Using the LDA method on the diabetes dataset, the classfication accuracy, or the
  percentage of correct assignments was approximately 79%. The accuracy is higher
  than the accuracy seen in both KNN and naive Bayes.  Similar to the other methods, 
  the plots for the test data (pregnancies vs. glucose, glucose vs. bmi, and age vs. insulin) 
  show that the outcome from the dataset and the predicted outcomes in naive Bayes 
  have very similar colors of samples but one can still see the colors of some samples are 
  not the same between the two graphs, indicating some minor inaccuracy in the classification.

CONFUSION MATRIX

Q1_confusion_matrix_LDF.txt

PLOTS

Q1_lda_scatter_plots.pdf

QDA

Using the QDA method on the diabetes dataset, the classfication accuracy, or the
  percentage of correct assignments was approximately 50%. The accuracy is signifcantly
  lower than the accuracies found in the other methods.  The plots for the test data 
  (pregnancies vs. glucose, glucose vs. bmi, and age vs. insulin) 
  show that the outcome from the dataset and the predicted outcomes in naive Bayes 
  have some similar colors of samples but one can clearly still see the colors of many samples are 
  not the same between the two graphs, indicating some major inaccuracy in the classification.

CONFUSION MATRIX

Q1_confusion_matrix_QDA.txt

PLOTS

Q1_qda_scatter_plots.pdf



QUESTION 2

I utilized the same dataset as question 1 (diabetes) and used the support vector machine (SVM) 
  method (e.g. e1071) and the kernal SVM (KSVM) method and compared the classification accuracy between the 
  different kernal functions (e.g. linear, polynomial, and radial basis function) and methods.

LINEAR KERNEL FUNCTION

Using the linear function, the classification accuracy for svm and ksvm came out to be approximately 
  63% and 52.6%, respectively.  The plots show that when comparing the test data outcome to the
  predicted outcome using svm and ksvm, one can see that the colors in the svm plot match up better to the
  test data plat than the ksvm, therefore showing that has a higher classification accuracy.

CONFUSION MATRIX

1. Q2_confusion_matrix_svm_linear.txt
2. Q2_confusion_matrix_ksvm_linear.txt

PLOTS FOR LINEAR

Q2_svm_ksvm_linear_scatter_plots.pdf

POLYNOMIAL KERNEL FUNCTION

Using the polynomial function, the classification accuracy for svm and ksvm came out to be approximately 
  68.6% and 52.9%, respectively.  Similar to the linear function, the plots show that when comparing the test data outcome to the
  predicted outcome using svm and ksvm, one can see that the colors in the svm plot match up better to the
  test data plat than the ksvm, therefore showing that has a higher classification accuracy.

CONFUSION MATRIX

1. Q2_confusion_matrix_svm_polynomial.txt
2. Q2_confusion_matrix_ksvm_polynomial.txt

PLOTS FOR POLYNOMIAL

Q2_svm_ksvm_polynomial_scatter_plots.pdf

RADIAL BASIS KERNEL FUNCTION

Using the radial basis function, the classification accuracy for svm and ksvm came out to be approximately 
  66.4% and 54.5%, respectively.  Similar to the linear and polynomial function, the plots show that when comparing the test data outcome to the
  predicted outcome using svm and ksvm, one can see that the colors in the svm plot match up better to the
  test data plat than the ksvm, therefore showing that has a higher classification accuracy.

CONFUSION MATRIX

1. Q2_confusion_matrix_svm_radial.txt
2. Q2_confusion_matrix_ksvm_radial.txt

PLOTS FOR RADIAL BASIS

Q2_svm_ksvm_radial_scatter_plots.pdf

From the results, it seems that using svm function from the e1071 library had better accuracy
  than when using the ksvm function from the kernel library.  Even though svm has better accuracy,
  overall, the svm methods do not provide a better classification accuracy than the simple machine
  learning methods, like naive Bayes and LDA.


QUESTION 3

NEURAL NETWORK

I utilized the same dataset as question 1 and 2 (diabetes) and used the neural network
   to calculate the accuracy.  The neuralnet provided a classification accuracy of 
   approximately 79.7%, which is significantly more accurate than when using the different 
   kernel functions in both svm and ksvm in question 2. Therefore, the neuralnetwork
   seems to have worked better than the support vector machine methods in terms of
   correclty classifying the outcomes.  In terms of comparing to simple machine learning, the accuracy
  is similar to naive bayes and LDA.

CONFUSION MATRIX

Q3_confusion_matrix_neuralnet.txt

PLOT

Q3_neuralnet.pdf



QUESTION 4

RANDOM FOREST

I utilized the same dataset diabetes dataset from the previous questions (diabetes) 
  and used the random forest method to classify and determine calculate the accuracy.  
  The confusion matrix provided a classification accuracy of 74.4%, which
  is similar to the accuracies found in machine learning (e.g. naive bayes) and
  neural network.  However, the classification accuracy for random forest is significantly greater
  than the svm methods.

CONFUSION MATRIX

1. Q4_confusion_matrix_randomforest.txt

ADABOOST

I utilized the same dataset diabetes dataset from the previous questions (diabetes) 
  and used the adaboost method to classify and determine calculate the accuracy.  
  The confusion matrix provided a classification accuracy of 71.4%, which
  is similar to the accuracies found in machine learning (e.g. naive bayes),
  neural network, and random forest.  However, the classification accuracy for 
  random forest is significantly greater than the svm methods.

Out of all the methods used, the neural network method provided the highest
  classification accuracy for the diabetes dataset, with an outcome of whether or not
  someone has diabetes.

CONFUSION MATRIX

1. Q4_confusion_matrix_adaboost.txt
