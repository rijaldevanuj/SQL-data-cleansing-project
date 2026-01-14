
#---1 Remove Duplicates
#---2 Standardize the data
#---3 Null values or blank values
#---4 Remove any Columns

select*
from layoffs;

DROP TABLE IF EXISTS layoff_staging;
CREATE TABLE layoff_staging
LIKE layoffs;

insert into layoff_staging
select*
from layoffs;

select*
from layoff_staging;

#---Lets chaeck duplicate
select*,
ROW_NUMBER() OVER
(partition by total_laid_off,percentage_laid_off, `date`) AS row_num
from layoff_staging;

with duplicate_cte AS 
(
select*,
ROW_NUMBER() OVER
(partition by company,location, industry ,total_laid_off,percentage_laid_off, `date`,stage,country,funds_raised) AS row_num
from layoff_staging
)
select*
from duplicate_cte
where row_num >1 ;

select*
from layoff_staging
where company = "Casper";




CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select*
from layoff_staging2
where row_num > 1;

insert into layoff_staging2
select*,
ROW_NUMBER() OVER
(partition by company,location, industry ,total_laid_off,percentage_laid_off, `date`,stage,country,funds_raised_millions) AS row_num
from layoff_staging;

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select*
from layoff_staging2
where row_num > 1;

insert into layoff_staging2
select*,
ROW_NUMBER() OVER
(partition by company,location, industry ,total_laid_off,percentage_laid_off, `date`,stage,country,funds_raised_millions) AS row_num
from layoff_staging;

delete
from layoff_staging2
where row_num >1;


select*
from layoff_staging2;

#----Standardising Data

select company, trim(company)
from layoff_staging2;

update layoff_staging2
SET company = trim(company);

select distinct industry
from layoff_staging2
order by 1;


select*
from layoff_staging2
where industry like "Crypto%";

UPDATE layoff_staging2
SET industry = "Crypto"
where industry like "Crypto%";


select*
from layoff_staging2;

select distinct location
from layoff_staging2
order by 1;

select distinct country
from layoff_staging2
where country like "United States%";


select distinct country, trim(trailing '.' from country)
from layoff_staging2
order by 1;

update layoff_staging2
SET country =  trim(trailing '.' from country)
where country like "United States%";

select*
from layoff_staging2;

select `date`,
STR_TO_DATE(`date`,'m%/%d/%Y')
from layoff_staging2;

ALTER TABLE layoff_staging2
MODIFY COLUMN `date` DATE;
select*
from layoff_staging2;

SELECT*
from layoff_staging2
where industry IS NULL
OR industry = '';

update layoff_staging2 t1
JOIN layoff_staging2 t2
	ON t1.company = t2.company
	SET t1.industry = t2.industry
    WHERE t1.industry is NULL
    AND t2.industry is NOT NULL;
SELECT *
FROM layoff_staging2
WHERE industry IS NULL;

select*
from layoff_staging2
where total_laid_off is NULL
and precentage_laid_off is NULL ;

delete
from layoff_staging2
where total_laid_off is NULL
	and precentage_laid_off is NULL ;

alter table layoff_staging2
drop column row_num;

#-- Check total rows
SELECT COUNT(*) FROM layoff_staging2;

#-- Check nulls
SELECT
  SUM(industry IS NULL) AS industry_nulls,
  SUM(total_laid_off IS NULL) AS total_nulls
FROM layoff_staging2;

#-- Quick preview
SELECT *
FROM layoff_staging2;

DROP TABLE IF EXISTS layoffs_final;

CREATE TABLE layoffs_final AS
SELECT *
FROM layoff_staging2;


