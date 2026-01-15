# 📊 SQL Data Cleaning Project — using Global Tech Layoffs Dataset

## 📌 Project Overview

This project focuses on cleaning and preparing a real-world layoffs dataset using **MySQL**.  
The raw dataset contained duplicate records, inconsistent text formatting, missing values, and improperly typed date fields.  
The objective was to transform raw data into an **analysis-ready structured dataset** using industry-standard SQL data cleaning techniques.

This project demonstrates practical skills required for **Data Analyst and Business Intelligence roles**, including staging tables, deduplication, standardization, and ethical handling of missing data.

---

## 🗂 Dataset Description

- **Source:** Public layoffs dataset (CSV format)
- **Records:** Company-wise layoff events
- **Fields include:**
  - Company
  - Location
  - Industry
  - Total laid off
  - Percentage laid off
  - Date
  - Funding stage
  - Country
  - Funds raised (millions)

### Files in This Repository

| File | Description |
|--------|------------|
| `layoffs.csv` | Raw dataset before cleaning |
| `sql_data_cleaning.sql` | Full MySQL data cleaning script |
| `layoffs_final2.csv` | Final cleaned dataset (analysis-ready) |

---

## 🛠 Tools & Technologies

- **Database:** MySQL 8.0
- **SQL Client:** MySQL Workbench
- **Techniques Used:**
  - Window functions (`ROW_NUMBER()`)
  - Staging tables
  - String standardization
  - Date conversion
  - NULL handling
  - Data validation queries

---

## 🔍 Data Cleaning Workflow

### 1. Data Staging
- Created working copies of the raw table to preserve original data.
- Used multiple staging layers for safe transformations.

### 2. Duplicate Removal
- Identified duplicates using `ROW_NUMBER()` with partitioning across business-relevant columns.
- Retained only the first occurrence of duplicate records.

### 3. Standardization
- Trimmed company names and fixed formatting inconsistencies.
- Standardized industry labels (e.g., Crypto variants → "Crypto").
- Cleaned country names by removing trailing punctuation.
- Converted date strings into proper SQL `DATE` datatype.

### 4. Handling Missing Values
- Filled missing industry values using company-level matching.
- Removed records where both `total_laid_off` and `percentage_laid_off` were missing.
- Remaining NULL values were retained when no reliable data source existed (ethical data practice).

### 5. Final Validation
- Performed null audits and row counts.
- Verified schema correctness and consistency.

---

## ✅ Final Output

The cleaned dataset:
- Contains no duplicate records
- Uses standardized categorical values
- Has correctly typed date fields
- Is suitable for analytics, dashboards, and further modeling

The final dataset is available as:  
📁 **`layoffs_final2.csv`**

---

## 📈 Potential Extensions

This dataset can be used for:

- Power BI / Tableau dashboards
- Exploratory Data Analysis (EDA)
- Trend analysis of layoffs by year, industry, or country
- Predictive modeling use cases

Future improvements may include:
- Automated ETL pipelines
- Cloud database deployment
- Scheduled refresh workflows

---

## 👤 Author

**Devanuj Rijal**  
B.Tech Student, National Institute of Technology Silchar  
Interested in Data Analytics, Business Intelligence, and Software Engineering  

🔗 GitHub: *(add your profile link here)*  
🔗 LinkedIn: *(optional)*

---

## 📌 How to Reproduce This Project

1. Import `layoffs.csv` into MySQL as table `layoffs`
2. Run `sql_data_cleaning.sql` from top to bottom
3. Final table `layoffs_final` will be created
4. Export final table as CSV if needed


## 📊 Exploratory Data Analysis (EDA)

After cleaning the dataset, exploratory analysis was performed using SQL to identify:

- Year-wise and monthly layoff trends
- Most impacted companies
- Industry-level and country-level distributions

All EDA queries are available in:

📄 `EDA_Script_Queries.sql`

