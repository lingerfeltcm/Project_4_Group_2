# Healthcare Expenditure & Infectious Disease Mortality: A Global Analysis (2010–2022)

> Predicting infectious disease mortality outcomes from WHO health expenditure data using machine learning classification models.

## Team

Barrett Fudge, Ben Comfort, Cory Lingerfelt, Kelly Carter

## Overview

This project investigates the relationship between national healthcare spending and infectious disease mortality across countries worldwide. Using data from the World Health Organization (WHO) spanning 2010–2022, we tested the hypothesis that higher healthcare expenditure as a percentage of GDP would correlate linearly with lower infectious disease death rates.

Our exploratory analysis revealed that the relationship is statistically significant (p < 0.0001) but decidedly non-linear, prompting a pivot from regression to classification. A K-Nearest Neighbors classifier trained on health expenditure features achieved 89–92% accuracy in predicting whether a country's mortality rate falls above or below the global average — substantially outperforming logistic regression (63–67% accuracy).

## Research Questions

1. What are the effects of different countries' government healthcare expenditures on their respective infectious disease mortality rates?
2. What nuanced trends in country-level and regional data (economic and epidemiological) stand out in a global context?
3. Which countries would most benefit from increased healthcare spending, and how should that investment be structured?

## Hypothesis

We hypothesized a negative, statistically significant linear correlation between health expenditures (as % of GDP) and infectious disease mortality rates — that is, as a country allocates more GDP to healthcare, mortality decreases in a roughly linear fashion. We also expected Current Health Expenditure (CHE) to be more predictive than Capital Health Expenditure (HK), given CHE's direct connection to goods and services delivery.

**Outcome:** The linear hypothesis was rejected. While the correlation is statistically significant (p < 0.0001, Pearson r = -0.42), the relationship is non-linear, requiring non-parametric models for effective prediction.

## Project Structure

```
Project_4_Group_2/
├── data/
│   ├── raw/                  # Original WHO datasets (not tracked in git)
│   │   ├── GHED_data.csv
│   │   ├── WHOMortalityDatabase_Deaths_*.csv (5 files)
│   │   └── agestandardized.csv
│   └── cleaned/              # Processed datasets ready for analysis
│       ├── expenditures.csv          (1,254 rows × 11 cols)
│       ├── clean_infectious_disease.csv  (841 rows × 12 cols)
│       ├── all_infectious_disease.csv
│       ├── expmortjoin.csv           (356 rows × 16 cols)
│       └── expmortjoin.xlsx
├── notebooks/
│   ├── 01_health_expenditures_cleaning.ipynb   # GHED data cleaning
│   ├── 02_infect_cleaning.ipynb                # Mortality data cleaning
│   ├── 03_expenditures_model.ipynb             # ML modeling & evaluation
│   ├── 04_analysis.ipynb                       # Comprehensive analysis
│   ├── starter_code_mortality.ipynb            # Exploratory starter code
│   └── machine_model_mortality.ipynb           # Mortality model scaffold
├── sql/
│   └── exp_mort.sql          # PostgreSQL schema & data (project_4 database)
├── reports/
│   └── Project 4 Group 2 Presentation.pdf
├── images/                   # Visualization outputs
├── config.py                 # PostgreSQL credentials (not tracked in git)
├── .gitignore
└── README.md
```

## Data Sources

All data was sourced from the World Health Organization:

- **WHO Global Health Expenditure Database (GHED):** Country-level healthcare spending metrics including Current Health Expenditure (CHE) and Capital Health Expenditure (HK) as percentages of GDP, per capita USD, and total USD.
  - Download: [apps.who.int/nha/database](http://apps.who.int/nha/database)

- **WHO Mortality Database:** Infectious disease mortality rates by country, including age-standardized rates per 100,000, crude death rates, and percentage of total deaths attributable to infectious diseases.
  - Download: [platform.who.int/mortality](https://platform.who.int/mortality/themes/theme-details/MDB/communicable-maternal-perinatal-and-nutritional-conditions)

> **Note:** Raw data files exceed GitHub's 100MB limit and are excluded from this repository via `.gitignore`. Download them from the links above and place them in `data/raw/`.

## Methodology

### 1. Data Extraction & Cleaning

**Health Expenditure Data** (`health_expenditures_cleaning.ipynb`): The GHED dataset was filtered to 2010–2022, retaining 11 key columns covering expenditure metrics across income levels. Rows with null values in critical financial columns were dropped, yielding 1,254 clean records.

**Infectious Disease Mortality** (`infect_cleaning.ipynb`): WHO mortality data was filtered to all-age aggregates (excluding age-group breakdowns that would skew toward infant/elder mortality). Countries with fewer than 10 years of data were excluded, producing 841 records. Column names were standardized for SQL compatibility.

### 2. Data Integration

Both cleaned datasets were loaded into a PostgreSQL database (`project_4`) and joined on country code and year via inner join, producing a merged dataset of 356 records — countries with complete data in both expenditure and mortality databases.

### 3. Feature Engineering & Target Variables

Nine features were selected for modeling: `che_gdp(%)`, `hk_gdp(%)`, `che_pc_usd`, `che`, `gdp_pc_usd`, `che_usd`, and three income-level dummy variables (High, Lower-middle, Upper-middle).

Three binary target variables were created by splitting each mortality metric at its mean:

| Target Variable | Mean | Median | Description |
|---|---|---|---|
| Percent_of_Total | 3.74% | 3.06% | Infectious disease deaths as % of all deaths |
| Age_Stnd_Per_100k | 21.04 | 16.51 | Age-standardized mortality rate per 100,000 |
| Death_rate_per_100k | 20.88 | 15.97 | Crude death rate per 100,000 |

### 4. Modeling

**Logistic Regression** (baseline): Trained on unscaled features, achieving 63–67% accuracy with severely imbalanced recall (0.09–0.10 on the positive class), indicating the model defaulted to predicting the majority class.

**K-Nearest Neighbors (k=3)** (final model): Trained on StandardScaler-normalized features, achieving balanced precision and recall across all three target variables:

| Target | Accuracy | Precision (0/1) | Recall (0/1) |
|---|---|---|---|
| Percent_of_Total | **89%** | 0.96 / 0.78 | 0.86 / 0.93 |
| Age_Stnd_Per_100k | **91%** | 0.96 / 0.82 | 0.90 / 0.93 |
| Death_rate_per_100k | **92%** | 0.96 / 0.86 | 0.91 / 0.94 |

## Key Findings

1. **Statistical significance without linearity.** Current Health Expenditure as % of GDP shows a statistically significant relationship with infectious disease mortality (p < 0.0001), but the relationship is non-linear (Pearson r = -0.42).

2. **CHE outperforms HK as a predictor.** Current Health Expenditure (direct spending on healthcare goods and services) is more predictive of mortality outcomes than Capital Health Expenditure (long-term infrastructure investment).

3. **Non-parametric models excel.** KNN's ability to capture non-linear decision boundaries produced 89–92% accuracy versus logistic regression's 63–67%, validating the non-linear nature of the expenditure-mortality relationship.

4. **Income level matters.** The inclusion of income-level dummy variables as features improved model performance, reflecting that a country's economic development mediates the expenditure-mortality relationship.

## Setup & Reproduction

### Prerequisites

Python 3.10+, PostgreSQL 16+, and the following packages:

```bash
pip install pandas scikit-learn sqlalchemy psycopg2-binary matplotlib
```

### Database Setup

1. Create a PostgreSQL database named `project_4`
2. Run the SQL schema in `sql/exp_mort.sql` or import CSVs into the tables defined there
3. Update `config.py` with your PostgreSQL credentials:
   ```python
   username = 'your_username'
   password = 'your_password'
   ```

### Running the Analysis

Execute notebooks in order:
1. `notebooks/01_health_expenditures_cleaning.ipynb` — cleans GHED data
2. `notebooks/02_infect_cleaning.ipynb` — cleans mortality data
3. `notebooks/03_expenditures_model.ipynb` — runs ML models
4. `notebooks/04_analysis.ipynb` — comprehensive analysis with visualizations

## Limitations & Future Work

The merged dataset contains only 356 records (countries with complete data in both sources), limiting model generalizability. Binary classification using the mean as threshold reduces nuance — future work could explore regression models or multi-class approaches. Only two model types were tested; ensemble methods (Random Forest, Gradient Boosting) and hyperparameter tuning (varying k in KNN) could improve results. Incorporating regional, climatic, and socioeconomic features beyond income level would enable more nuanced policy recommendations.

## License

This project was developed for educational purposes as part of a data analytics bootcamp.

## Contributions

- **Barrett Fudge** — Data cleaning, statistical coding, logistic and chart visualizations, project report
- **Ben Comfort** — Dataset merging and cleaning, SQL database creation, logistic regression and KNN modeling
- **Cory Lingerfelt** — Repository setup, dataset merging, expenditures starter code, linear visualizations
- **Kelly Carter** — Data cleaning
- **All** — Collaborative development of the categorical machine learning model
