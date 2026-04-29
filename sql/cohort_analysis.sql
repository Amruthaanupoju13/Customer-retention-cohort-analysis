--get cohort month
WITH cohort AS (
    SELECT 
    CustomerID,
    MIN(strftime('%Y-%m', InvoiceDate)) AS cohort_month
    FROM retail_final
    GROUP BY CustomerID
),

activity AS (
    SELECT 
    CustomerID,
    strftime('%Y-%m', InvoiceDate) AS activity_month
    FROM retail_final
),

cohort_data AS (
    SELECT 
    c.cohort_month,
    a.activity_month,
    COUNT(DISTINCT a.CustomerID) AS customers
    FROM cohort c
    JOIN activity a
    ON c.CustomerID = a.CustomerID
    GROUP BY c.cohort_month, a.activity_month
),

cohort_size AS (
    SELECT 
    cohort_month,
    COUNT(DISTINCT CustomerID) AS total_customers
    FROM cohort
    GROUP BY cohort_month
)

SELECT 
cd.cohort_month,
cd.activity_month,
cd.customers,
cs.total_customers,
ROUND(cd.customers * 100.0 / cs.total_customers, 2) AS retention_percent
FROM cohort_data cd
JOIN cohort_size cs
ON cd.cohort_month = cs.cohort_month
ORDER BY cd.cohort_month, cd.activity_month;
