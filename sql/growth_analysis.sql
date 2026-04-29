--GROWTH RATE
SELECT 
month,
total_revenue,
prev_revenue,
ROUND(
(total_revenue - prev_revenue) * 100.0 / prev_revenue, 2
) AS growth_percent
FROM (
    SELECT 
    month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY month) AS prev_revenue
    FROM (
        SELECT 
        strftime('%Y-%m', InvoiceDate) AS month,
        SUM(revenue) AS total_revenue
        FROM retail_final
        GROUP BY month
    )
);