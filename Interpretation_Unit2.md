
QUESTION 1

I utilized KNN method to classify a new dataset using the pre-classified diabetes dataset.
  I shuffled the dataset, specifically the subframe which did not include the class (e.g. outcome),
  and split the dataset into 20% test data and 80% training data. Using the KNN function and the confusion
  matrix, I was able to find the the incorrect and correct assignments, along with how accurate the
  model was.  According the the matrix, the model correctly assigned 91 people as 0 or 
  not having diabetes (e.g. True negative), the model correctly assigned 28 people as 1
  or having diabetes (e.g. True positive), the model mistakenly assigned 31 people as 0 or not
  having diabetes (e.g. False negative), and the model mistakenly assigned 27 people as 1 or 
  having diabetes.  Therefore, the accuracy of the model turns out to be approximately 67.2%,
  showing that the model is somewhat accurate, but not that accurate in correctly classifying.

CONFUSION MATRIX
1. Q1_confusion_matrix.txt

PLOTS
1. Q1_Scatter_Plots_Glucose_vs._Pregnancies.pdf
2. Q1_Scatter_Plots_Glucose_vs._BMI.pdf
3. Q1_Scatter_Plots_Insulin_vs._Age.pdf

The plots for the test data (pregnancies vs. glucose, glucose vs. bmi, and age vs. insulin) 
  show that the outcome from the dataset and the predicted outcomes in KNN showed some similarities
  in terms of color but one can clearly see the colors of some samples are not the same between
  the two graphs, indicating some inaccuracy in the classification.


QUESTION 2

I utilized the same dataset as question 1 (diabetes) and used the kernel support vector
  machine (KSVM) method and compared the classification accuracy between the 
  different kernal functions (e.g. linear, polynomial, and radial basis function).

LINEAR KERNEL FUNCTION
Using the linear function, the classification accuracy came out to be approximately 52.3%, 
  which is significantly less than the accuracy that was calculated in Q1 using
  the KNN method (e.g. 67.2%).  Similar to KNN, the plots for the test data 
  (pregnancies vs. glucose, glucose vs. bmi, and age vs. insulin) show that the outcome 
  from the dataset and the predicted outcomes in the KSVM using linear function showed some similarities
  in terms of color but one can clearly see the colors of some samples are not the same between
  the two graphs, indicating some inaccuracy in the classification.  The difference in colors
  are slightly more noticeable than when using KNN.

CONFUSION MATRIX
1.Q2_confusion_matrix_linear.txt

PLOTS FOR LINEAR
1. Q2_Scatter_Plots_BMI_vs._Glucose_Linear.pdf
2. Q2_Scatter_Plots_Glucose_vs._Pregnancies_Linear.pdf
3. Q2_Scatter_Plots_Insulin_vs._Age_Linear.pdf

POLYNOMIAL KERNEL FUNCTION
Using the polynomial function, the classification accuracy came out to be approximately 46%, 
  which is significantly less than the accuracy that was calculated in Q1 using
  the KNN method (e.g. 67.2%) and less than the accuracy using the linear function (e.g. 52.3%).
  The plots also show some similarities of the colors between the outcome from the dataset
  and the predicted outcomes (polynomial KSVM) but similar to the linear function, one can see
  the noticeable difference in colors between the two graphs, indicating several misclassifications.

CONFUSION MATRIX
1.Q2_confusion_matrix_polynomial.txt

PLOTS FOR POLYNOMIAL
1. Q2_Scatter_Plots_BMI_vs._Glucose_Poly.pdf
2. Q2_Scatter_Plots_Glucose_vs._Pregnancies_Poly.pdf
3. Q2_Scatter_Plots_Insulin_vs._Age_Poly.pdf

RADIAL BASIS KERNEL FUNCTION
Using the radial basis function, the classification accuracy came out to be approximately 57.2%, 
  which is still less than the accuracy that was calculated in Q1 using
  the KNN method (e.g. 67.2%) but higher than the accuracy using the linear function (e.g. 52.3%)
  and the polynymoial function (46%).
  The plots also show some similarities of the colors between the outcome from the dataset
  and the predicted outcomes (polynomial KSVM) but similar to the linear function and the
  polynomial function, one can see the noticeable difference in colors between the two graphs, 
  indicating several misclassifications.

CONFUSION MATRIX
1.Q2_confusion_matrix_radial.txt

PLOTS FOR RADIAL BASIS
1. Q2_Scatter_Plots_BMI_vs._Glucose_Radial.pdf
2. Q2_Scatter_Plots_Glucose_vs._Pregnancies_Radial.pdf
3. Q2_Scatter_Plots_Insulin_vs._Age_Radial.pdf

From the results, it seems that out of the three different kernel functions, the radial basis
  kernel function produced the higest classification accuracy (e.g. 57.2%). However, it is still
  less than the accuracy seen using the KNN method (e.g. 67.2%), suggesting the simpler
  method, KNN, was better in terms of classification accuracy.


QUESTION 3

I utilized the same dataset as question 1 and 2 (diabetes) and used the neural network
   to calculate the accuracy.  The neuralnet provided a classification accuracy of 63.7%, which
  is more accurate than when using the radial basis KSVM in question 2 (e.g. 57.2%) but still 
  not as accurate as the KNN method (e.g. 67.2%).

CONFUSION MATRIX
1. Q3_confusion_matrix_neuralnet.txt

NEURAL NETWORK
Q3_neuralnet.pdf



QUESTION 4

RANDOM FOREST
I utilized the same dataset diabetes dataset from the previous questions (diabetes) 
  and used the random forest method to classify and determine calculate the accuracy.  
  The confusion matrix provided a classification accuracy of 74.4%, which
  is slightly more accurate than the KNN method (e.g. 69.93%), but significantly more
  accurate than the neural network method (e.g. 63.7%) and the radial basis KSVM method (e.g. 57.23%).

CONFUSION MATRIX
1. Q4_confusion_matrix_randomforest.txt



ADABOOST
I utilized the same dataset diabetes dataset from the previous questions (diabetes) 
  and used the adaboost method to classify and determine calculate the accuracy.  
  The confusion matrix provided a classification accuracy of 71.4%, which
  is slightly less accurate than random forest method (e.g. 74.4%), 
  slightly more accurate than the KNN method (e.g. 67.2%), but significantly more
  accurate than the neural network method (e.g. 63.7%) and the radial basis KSVM method (e.g. 57.2%).

Out of all the methods used, the random forest method and adaboost method seem to produce
  the best classfication accuracy.

CONFUSION MATRIX
1. Q4_confusion_matrix_adaboost.txt


