
QUESTION 4

ANOVA
For tooth length and supplement, p-value is 0.06 and is greater than 0.05, 
  meaning there is no significant difference between the supplement on the 
  tooth growth on the guinea pigs and the null hypothesis is true.
  For tooth length and dose, p-value is 2.812E-13 and is less than 0.05, 
  meaning there is significant difference between the dosage amount on the 
  tooth growth on the guinea pigs and the null hypothesis is rejected.

BONFERRONI PAIRWISE T-TEST
Results show that the p-value is greater than 0.05 for the following comparisons: 
  VC 1 and OJ 0.5; OJ 2 and OJ 1; VC2 and OJ 1; and VC 2 and OJ 2, 
  meaning that these comparisons are not stasticially significant to each other 
  and therefore the null hypothesis is true.
  The remaining p-values are less than 0.05, indicating that for these 
  comparisions they are stastically significant so the null hypothesis is rejected.

BENJAMINI_HOCHBERG PAIRWISE T-TEST
Results show that the p-value is greater than 0.05 for the following comparisons: 
  VC 1 and OJ 0.5; OJ 2 and OJ 1; VC2 and OJ 1; and VC 2 and OJ 2, 
  meaning that these comparisons are not stasticially significant to each other 
  and therefore the null hypothesis is true.
  The remaining p-values are less than 0.05, indicating that for these 
  comparisions they are stastically significant so the null hypothesis is rejected.

The results between the two pairwise t-tests ares similar but it can be seen that
  Benjamini-Hochberg test shows smaller p-values in general.


QUESTION 5

KRUSKALL WALLIS
Without assuming normality, using ANOVA input data, 
  the p-value between tooth length and the type of supplement is 0.06343, 
  which is still greater than 0.05, so there is no significant difference 
  between the supplement on the tooth growth on the guinea pigs and the null hypothesis is true.
  Without assuming normality, using ANOVA input data, the p-value between tooth length
  and dose amount is 1.475E-09, which is signficantly smaller than 0.05,
  so there is significant different between the dose on the tooth growth on the guinea pig and the null hypothesis is rejected.

PEARSON AND SPEARMAN
The pearson correlation coefficient between the tooth growth and dose is 0.8026913, indicating a positive correlation.
  The spearman rank coefficient between the tooth growth and the dosage is 0.8283415, indicating a positive monotonic association.
  The p-value for both correlations are significantly small, indicating the correlation between the two
  variables are signficant.

KS TEST
The p-value from the ks test is 0.6237, which is greater than 0.05.  Therefore,
  the null hypothesis is not rejected and suggests that the data is a good fit to
  the normal distribution so my assumptions of normality holds for this data.

COMPARE PARAMETRIC AND NONPARAMETRIC TESTS
When comparing the p-values between the parametric (ANOVA) and nonparametric tests
  (kruskal wallis), there is minor difference between the p-values when comparing
  tooth length with supplement and dose.  For tooth length and supplement, 
  the p-value is still significantly greater than 0.05 and for tooth length and dose,
  the p-evalue is still significantly smaller than 0.05. 
  Therefore, the outcomes of the two tests seem pretty consistent.


QUESTION 6

LINEAR REGRESSION AND COMPARISON TO CORRELATIONS
The r-squared value between tooth length and dose is approximately 0.64, 
  meaning that approximately 64% of the variance for the dependent variable (tooth length),
  is due to the independent variable (dose).  The p-value is 1.23E-14 which is signiciantly
  small, meaning that the effect that dose has on tooth growth is stastically significant.
  Therefore, there is a strong and positive relationship between tooth length and dose
The correlations in Question 5 and the linear regression here both show that the
  two variables have a strong and positive correlation with one another.  However, the
  biggest difference is that correlation does not indicate that one variable is caused by
  another while regression indicates that one variable is caused or dependent by another.
  Therefore, regression is more appropriate if you want to know or test how well the
  dependent variable is caused by the independnet variable.
