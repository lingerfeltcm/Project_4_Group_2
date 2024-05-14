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
- Ben - Cleaning data, ran logistic and KNearest Neighbors
- Cory - Started Repo, Merged data sets, created starter code, created linear visualizations
- Kelly - Cleaned Data
- ALL - Collaboratively Create a Categorical Machine Learning Model to Streamline Health Expenditure Recommendations

## Goals:
- Selecting (a) dataset(s) and formulating a problem 
- Outlining questions to be answered, tasks to be done etc.
- Writing a one pager project proposal.
## Methodology:
- Data Extraction: pull data from WHO datasets and merge them (most likely on Countries listed in both). 
- Data Preprocessing: clean data sets by removing missing values, outliers, and inconsistencies. Extract relevant features from data sets. Store data in SQL database and ## query data based on targeted features.
- Model Development: utilize most effective machine learning models (logistic regression, decision trees, random forests TBD) and the Scikit-learn machine learning library
- Model Evaluation and Statistical Analysis: display the model’s accuracy, precision, and recall
- Interpretation and Visualization: Will use Tableau to present a Dashboard 
## PURPOSE IN SUMMARY
This project focuses on the use of World Health Organization infectious disease data in predicting and making policy recommendations for decreasing future mortality rates across countries and global regions.

## INITIAL HYPOTHESIS
We initially hypothesized that there exists a negative and statistically significant linear correlation between health expenditures as a percentage of GDP and infectious disease mortality rates. In other words, as a country’s percentage of GDP allocated to healthcare increases, whether through actual spending or capital investments, infectious disease mortality rates decrease in a fairly direct (linear) way.

## DATASET SOURCES
We used the World Health Organization Mortality Database, World Global Health Expenditure Database 2010 - 2022 and Current Health Expenditure (CHE) and Capital Health Expenditure (HK) Database.

https://platform.who.int/mortality/themes/theme-details/MDB/communicable-maternal-perinatal-and-nutritional-conditions

http://apps.who.int/nha/database



## CTE DATA
We focused on the infectious disease mortality data (not including respiratory infections) provided by these  Presumably infectious diseases have the potential to be more treatable and thus preventable than other causes of death, a country’s expenditures would have a greater correlation. Infectious diseases also accounted for 14% of the world-wide mortality rate in 2019 per Our World in Data (Source: https://ourworldindata.org/causes-of-death). The primary focus of our analysis was on the Age Standardized Mortality Rate per 100,000, which standardized our mortality data based on the life expectancy of a given country.

In cleaning this data, brackets were removed for readability, data was limited to all age groups instead of also including age group breakdowns since we were more concerned with the country-wide mortality rate than rates for individual age groups. Data was further limited to only include countries with 10 or more years worth of mortality rate data.

WHO global expenditure data was filtered down to only show country statistics from 2010 to 2022. We centered on the columns that involved a country’s current health expenditure and capital health expenditure. These values contained per capita breakdowns of spending as well as a total percentage. The data was cleaned to only focus on mortality rates. We Filtered the dataset to only show countries with 10 or more years of data.

These datasets were joined and are currently stored in postgresSQL where we pulled the joined data frame to construct visuals and formulate a predictive model

## INITIAL EXPLORATORY ANALYSIS (working off merged and cleaned dataset)
The initial exploratory analysis was working off our original assumption that the relationship between government expenditures on healthcare and mortality rates would be somewhat linear. To test this we used Tableau’s visualizations and trend lines to evaluate the R, R-squared, and P-value scores.

It became apparent very quickly that there was not a strong linear correlation between these data variables; however, the P-Value scores for Current Health Expenditure (a government’s expenditures on the goods and services side of healthcare) as a percent of GDP showed a pretty strong sign of significance with P-values being < 0.0001.

However, no truly linear model was going to be able to predict mortality rates accurately.

### Logistic regression
- This model used the logistic_regression function from the scikitlearn library and aimed to classify each country as above or below the average mortality target.

## Average Mortality Target

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


## Using KNeighborsClassifier
- We chose a non-parametric model in order to achieve better accuracy because of our findings in exploratory analysis as well as the failure of the logistic model.

## Interaction with SQL

Run the database code within postgres to create the tables used in the analysis and model. Then import the corresponding csv files into each table. The 'expenditures_model' notebook will take the username and password from postgres. You may update them in the config file.

## RESULTS

The analysis reveals that country-specific Health Expenditures play a significant role in predicting mortality rates associated with infectious diseases. Notably, the Current Health Expenditure (CHE) demonstrates a higher degree of statistical significance compared to Capital Health Expenditure (HK). Our findings suggest that Logistic regression, implemented through a KKNeighbors Classifier, offers the most accurate predictive capabilities, effectively navigating the complexity inherent in our dataset.

PREDICTIONS
We would need to explore the WHO data more in depth and find other data sources to explore more non-linear predictive models. 
