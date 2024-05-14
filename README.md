# Project_4_Group_2

Project 4 Group 2

Members: Barrett Fudge, Ben Comfort, Cory Lingerfelt, Kelly Carter

Databases: https://apps.who.int/nha/database/Select/Indicators/en
https://www.who.int/data/collections

Repository: https://github.com/lingerfeltcm/Project_4_Group_2.git

Questions to be answered:

What are the effects of different countries’ government healthcare expenditures on their respective mortality rates?
Based on data from 2010-2022, create a predictive model re: the  kinds of changes to health expenditures countries should make to lessen mortality rates via preemptive healthcare.

Tasks:
- Barrett - Pushed ReadMe, Cleaned data
- Ben - Cleaning data
- Cory - Started Repo, Merged data sets, created starter code
- Kelly - Cleaned Data
- ALL - Collaboratively Create a Categorical Machine Learning Model to Streamline Health Expenditure Recommendations

Goals:
- Selecting (a) dataset(s) and formulating a problem 
- Outlining questions to be answered, tasks to be done etc.
- Writing a one pager project proposal.
Methodology:
- Data Extraction: pull data from WHO datasets and merge them (most likely on Countries listed in both). 
- Data Preprocessing: clean data sets by removing missing values, outliers, and inconsistencies. Extract relevant features from data sets. Store data in SQL database and query data based on targeted features.
- Model Development: utilize most effective machine learning models (logistic regression, decision trees, random forests TBD) and the Scikit-learn machine learning library
- Model Evaluation and Statistical Analysis: display the model’s accuracy, precision, and recall
- Interpretation and Visualization: Will use Tableau to present a Dashboard 

### Logistic regression
- This model used the logistic_regression function from the scikitlearn library and aimed to classify each country as above or below the average mortality target.

### Average Mortality Target

```
# use the average and median of this column and use that to catagorize the data and make a new column to predict

print(total_y.mean())
print(total_y.median())


# assign these to variables
total_y_mean = total_y.mean()
total_y_median = total_y.median()

# create empty lists
perc_of_total_avg = []
perc_of_total_med = []

# run a for loop that goes through the total_y array and assigns a 0 (below avg) or 1 (above avg)
for x in total_y:
    if x > total_y_mean:
        perc_of_total_avg.append(1)
    else:
        perc_of_total_avg.append(0)
        
    if x > total_y_median:
        perc_of_total_med.append(1)
        
    else:
        perc_of_total_med.append(0)
```

- The code takes both the median and the mean of every target column. However, we only used the average. 
- We repeated this methodology for each target variable 'Percent_of_Total','Age_Stnd_Per_100k', 'Death_rate_per_100k'
- Both the training and testing predictions showed an overall accuracy below 70% for the logistic regression model

### Using KNeighborsClassifier
- We chose a non-parametric model in order to achieve better accuracy because of our findings in exploratory analysis as well as the failure of the logistic model.

### Interaction with SQL

Run the database code within postgres to create the tables used in the analysis and model. Then import the corresponding csv files into each table. The 'expenditures_model' notebook will take the username and password from postgres. You may update them in the config file.

