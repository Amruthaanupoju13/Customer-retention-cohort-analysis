--Monthly revenue
select 
strftime('%Y-%m' , invoicedate) as month,
sum(revenue) as total_revenue
from retail_final
group by month
order by month