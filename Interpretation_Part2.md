

QUESTION 8

MANOVA
Since the p value is 2.2E-16 and is significantly smaller than 0.05, 
  there is significant impact of the independent variable, region, 
  to the dependent variables.  Therefore, the null hypothesis can be rejected.
  Also, at least one of the group means is significantly different from the 
  others, possible northeast based on the plots?


QUESTION 9

MLR
For household_size, the p-value is 0.779 and significantly larger than 0.05.  
  There is a positive relationship between household_size and total_energy_use,
  in that when one unit of household_size is increased, the total_energy_use increased by approximately 96.6 units.
  Therefore, the relationship between household_size and total_energy_use is significant and positive.
  For electricity_use, the p-value is < 2E-16 and is significantly smaller than 0.05.
  There is a positive relationship between electricity_use and total_energy_use, in that
  when one unit of electricity_use is increased, the total_energy_use is increased by approximately 1 unit.
  Therefore, the relationship between electricity_use and total_energy_use is significant and positive.
  For electricity_cost, the p-value is < 2E-16 and is significantly smaller than 0.05.
  There is a negative relationship between electricity_cost and total_energy_use, in that
  when one unit of electricity_cost is increased, the total_energy_use is decreased by approximately 51 units.
  Therfore, the relationship between electricity_cost and total_energy_use is significant and negative.
  For ng_use, the p-value is < 2E-16 and is significantly smaller than 0.05.
  There is a positive relationship between ng_use and total_energy_use, in that
  when one unit of ng_use is increased, the total_energy_use is increased by approximately 92 units.
  Therefore, the relationship between ng_use and total_energy_use is significant and positive.
  For ng_cost, the p-value is < 2E-16 and is significantly smaller than 0.05.
  There is a negative relationship between ng_cost and total_energy_use, in that
  when one unit of ng_cost is increased, the total_energy_use is decreased by approximately 45 units.
  Therfore, the relationship between ng_cost and total_energy_use is significant and negative.
  For total_energy_cost, the p-value is < 2E-16 and is significantly smaller than 0.05.
  There is a positive relationship between total_energy_cost and total_energy_use, in that
  when one unit of total_energy_cost is increased, the total_energy_use is increased by approximately 51 units.
  Therfore, the relationship between total_energy_cost and total_energy_use is significant and positive.
  
  Given that if you increase one unit of electricity_use you increase one unit of total_energy_use,
  electricity_use seems to be the best or most significant predictor.

MLR for NE
When doing the regression focussing on the NORTHEAST (NE) region, for the most part,
  the relationships between the dependent variable (NE) and the other variables are the same
  as when the dependent variable covered all the regions.  However, the p-value for ng_use
  and ng_cost here is 0.01 and 0.05, which are higher than the previous analysis, <2E-16 and <2E-16, respectively.
  This may indicate that the relationship between total_energy_cost and ng_cost and ng_use may not be that significant.
  
  Electricity_use is still the best predictor or most significant predictor as 
  it has a low p-value and value of approximately 1.


QUESTION 11

When comparing the original iris dataset to the corrupted datset, in this case
  missing data, there is no significant difference in the ANOVA results. The p-values
  in the corrupt dataset is still significant smaller than 0.05.  Therfore, it can be said
  that the method I chose, one-way ANOVA, is not that sensitive to the modifications.


QUESTION 12

The high p-values from the kruskal wallis tests show that there is no significant influence
  of the categorical variables (species, color, sold) on the ordinal variables 
  (attract, likelytobuy, review).  The only one that shows some significance is
  species and attractiveness.


QUESTION 13

The reduction of the data was succsessful as shown in the scree plot, where
  the bend or elbow of the curve occurs at component 3, which indicates
  the first three components are enough to explain the data and the rest can be
  ignored or ommitted.
Based on the loadings, and only focusing on the first three components (principle
  components or PCs), PC 1 best describes the overall size variation because it has
  all positive loadings.
It seems that the PC 3 is strongly driven by electricity_use given it is positive
  and has a large loading (0.711). 
