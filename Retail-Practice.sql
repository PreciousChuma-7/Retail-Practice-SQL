--Level 1
--Q1

SELECT*
FROM retail1.sales.DATASET
WHERE `Product Category`='Electronics';

--Q2

SELECT`Customer ID`, Age, `Total Amount`
FROM retail1.sales.DATASET
WHERE Gender= 'Female'
ORDER BY `Total Amount` DESC;

--Q3

SELECT*
FROM retail1.sales.DATASET
ORDER BY `Total Amount` DESC
LIMIT 10;

--Q4

SELECT*
FROM retail1.sales.DATASET
WHERE Quantity = 4
AND `Price per Unit`= 500;

--Q5

SELECT DISTINCT `Product Category`
FROM retail1.sales.DATASET;

--Level 2

--Q6

SELECT COUNT(*) AS transaction_count
FROM retail1.sales.DATASET;

--Q7

SELECT SUM(`Total Amount`) AS total_revenue
FROM retail1.sales.DATASET;

--Q8

SELECT ROUND (AVG(Age), 1) AS avg_age
FROM retail1.sales.DATASET;

--Q9

SELECT ROUND(AVG(`Total Amount`), 2) AS avg_spend
FROM retail1.sales.DATASET;

--Q10

SELECT MIN(`Total Amount`) AS min_amount,
MAX(`Total Amount`) AS max_amount
FROM retail1.sales.DATASET;

--Level 3
--Q11

SELECT `Product Category`,
SUM(`Total Amount`) AS revenue
FROM retail1.sales.DATASET
GROUP BY `Product Category`
ORDER BY revenue DESC;

--Q12

SELECT Gender,
COUNT(*) AS transactional_count,
ROUND(AVG(`Total Amount`), 2) AS avg_spend
FROM retail1.sales.DATASET
GROUP BY Gender;

--Q13

SELECT `Product Category`,
ROUND(AVG(Age), 1) AS avg_age
FROM retail1.sales.DATASET
GROUP BY `Product Category`
ORDER BY avg_age DESC;

--Q14

SELECT`Product Category`,
SUM(Quantity) AS units_sold
FROM retail1.sales.DATASET
GROUP BY `Product Category`
ORDER BY units_sold DESC;

--Q15

SELECT `Product Category`,
SUM(`Total Amount`) AS revenue
FROM retail1.sales.DATASET
GROUP BY `Product Category`
HAVING SUM(`Total Amount`) >150000
ORDER BY revenue DESC;

--Q16

SELECT date_format(Date, 'yyyy-MM') AS year_month,
COUNT(*) AS transaction_count
FROM retail1.sales.DATASET
GROUP BY date_format(Date, 'yyyy-MM')
ORDER BY year_month;

--LEVEL 5

--Q17

SELECT CASE
WHEN Age < 30 THEN '18-29'
WHEN Age < 45 THEN '30-44'
ELSE '45+'
END AS age_group,
COUNT(*) AS transaction_count
FROM retail1.sales.DATASET
GROUP BY CASE
WHEN Age < 30 THEN '18-29'
WHEN Age < 45 THEN '30-44'
ELSE '45+'
END
ORDER BY age_group;

--Q18

SELECT CASE
WHEN `Total Amount` >=  500 THEN 'High'
WHEN `Total Amount` >= 100 THEN 'Medium'
ELSE 'Low'
END AS spend_band,
COUNT(*) AS transaction_count
FROM retail1.sales.DATASET
GROUP BY CASE
WHEN `Total Amount` >= 500 THEN 'High'
WHEN `Total Amount` >= 100 THEN 'Medium'
ELSE 'Low'
END
ORDER BY transaction_count DESC;

--Q19

SELECT quarter(Date) AS quarter,
SUM(`Total Amount`) AS revenue
FROM retail1.sales.DATASET
WHERE year(Date) = 2023
GROUP BY quarter(Date)
ORDER BY quarter;

--Q20

SELECT CASE WHEN Age > 40 THEN 'Over 40'  ELSE '40 and under' END AS age_segment,
ROUND(AVG(`Total Amount`), 2) AS avg_spend,
COUNT(*) AS transaction_count
FROM retail1.sales.DATASET
GROUP BY CASE WHEN Age > 40 THEN 'Over 40' ELSE '40 and under'END;

--LEVEL 5

--Q21

SELECT `Transaction ID`,
`Product Category`,
`Total Amount`,
RANK() OVER (PARTITION BY `Product Category` ORDER BY `Total Amount` DESC) AS category_rank
FROM retail1.sales.DATASET;

--Q22

SELECT `Transaction ID`,
`Product Category`,
`Total Amount`,
ROUND (AVG(`Total Amount`) OVER (PARTITION BY `Product Category`), 2) AS category_avg,
ROUND(`Total Amount` -AVG(`Total Amount`) OVER (PARTITION BY `Product Category`), 2) AS 
diff_from_avg
FROM retail1.sales.DATASET;

--Q23

SELECT Date,
`Total Amount`,
SUM(`Total Amount`) OVER (ORDER BY Date
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_revenue
FROM retail1.sales.DATASET;

--Q24

SELECT `Transaction ID`, Gender, `Total Amount`
FROM retail1.sales.DATASET
QUALIFY ROW_NUMBER() OVER (PARTITION BY Gender
ORDER BY `Total Amount` DESC) <= 3;

--Q25

SELECT `Product Category`,
SUM(`Total Amount`) AS revenue,
ROUND(SUM(`Total Amount`) * 100.0 / SUM(SUM(`Total Amount`)) OVER (), 2) AS
pct_of_total
FROM retail1.sales.DATASET
GROUP BY `Product Category`
ORDER BY pct_of_total DESC;
