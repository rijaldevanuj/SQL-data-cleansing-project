#---Exploratory Data Analysis------
#The typical structure of an EDA project like this is:
#Overview metrics
#Trends over time
#Group/aggregate insights
#Filtering and comparisons
#Advanced aggregations
#Percentage and ranking calculations 


SHOW TABLES;

#1, Query: Total Records and Basic Summary
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT company) AS unique_companies,
  COUNT(DISTINCT country) AS unique_countries
FROM layoffs_final;

#2, LAYOFF TRENDS OVER TIME


-- convert text to date again
UPDATE layoffs_final
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- change column type
ALTER TABLE layoffs_final
MODIFY COLUMN `date` DATE;
SELECT* 
FROM layoffs_final;
 #year_wise_analysis
SELECT
  YEAR(`date`) AS year,
  SUM(total_laid_off) AS total_laid_off
FROM layoffs_final
GROUP BY YEAR(`date`)
ORDER BY year;


### 3, Layoffs per Category 

#--Companies by layoffs
SELECT
  company,
  SUM(total_laid_off) AS total_laid_off
FROM layoffs_final
GROUP BY company
ORDER BY total_laid_off DESC;


#--Layoffs by Country
SELECT
  country,
  SUM(total_laid_off) AS total_laid_off
FROM layoffs_final
GROUP BY country
ORDER BY total_laid_off DESC;

#--Layoffs by Industry
SELECT
  industry,
  SUM(total_laid_off) AS total_laid_off
FROM layoffs_final
GROUP BY industry
ORDER BY total_laid_off DESC;


##---Average Layoff Percentage by Industry
SELECT
  industry,
  AVG(CAST(REPLACE(percentage_laid_off, '%', '') AS DECIMAL(5,2))) AS avg_pct_laid_off
FROM layoffs_final
WHERE percentage_laid_off IS NOT NULL
GROUP BY industry
ORDER BY avg_pct_laid_off DESC;


###-- Top 5 countries by Layoffs
SELECT
  country,
  SUM(total_laid_off) AS total_laid_off,
  DENSE_RANK() OVER (ORDER BY SUM(total_laid_off) DESC) AS renk
FROM layoffs_final
GROUP BY country
ORDER BY renk
LIMIT 5;


#### -- Layoffs in a Specific Year
SELECT
  company,
  total_laid_off,
  percentage_laid_off,
  country
FROM layoffs_final
WHERE YEAR(`date`) = 2023
ORDER BY total_laid_off DESC
;

####----Monthly Layoffs
SELECT
  DATE_FORMAT(`date`, '%Y-%m') AS year_monthly,
  COUNT(*) AS layoffs_events
FROM layoffs_final
GROUP BY year_monthly
ORDER BY year_monthly;


#### 3-Month Rolling Average of Layoff Count
SELECT
  year_monthly,
  layoffs_events,
  AVG(layoffs_events) OVER (
    ORDER BY year_monthly
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
  ) AS moving_avg_3mo
FROM (
  SELECT
    DATE_FORMAT(`date`, '%Y-%m') AS year_monthly,
    COUNT(*) AS layoffs_events
  FROM layoffs_final
  GROUP BY year_monthly
) AS monthly;

####---Frequency of NULLs After Cleaning
SELECT
  SUM(industry IS NULL) AS industry_nulls,
  SUM(total_laid_off IS NULL) AS total_laid_off_nulls,
  SUM(percentage_laid_off IS NULL) AS pct_nulls
FROM layoffs_final;
 
