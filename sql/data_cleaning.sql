-- cleaning
CREATE table retail_clean as 
SELECT *
from online_retail 
where customerid is not NULL
and quantity > 0 
and unitprice > 0


--create revenue column
CREATE table retail_final as 
select *,
quantity * unitprice as revenue
from retail_clean

