-- New vs returning customers
WITH first_purchase AS (
  SELECT CustomerID, MIN(InvoiceDate) AS first_date
  FROM retail_final
  GROUP BY CustomerID
)

SELECT 
CASE 
  WHEN strftime('%Y-%m', r.InvoiceDate) = strftime('%Y-%m', f.first_date)
  THEN 'New'
  ELSE 'Returning'
END AS customer_type,
COUNT(DISTINCT r.CustomerID) AS customers,
SUM(r.revenue) AS revenue
FROM retail_final r
JOIN first_purchase f
ON r.CustomerID = f.CustomerID
GROUP BY customer_type;