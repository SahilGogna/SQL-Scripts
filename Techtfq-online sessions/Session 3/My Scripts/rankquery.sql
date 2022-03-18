/*
Find the best selling item for each month (no need to separate months by year)
where the biggest total invoice was paid.
The best selling item is calculated using the formula (unitprice * quantity).
Output the description of the item along with the amount paid.
*/
select month:: int as month, description, total_paid
from (
    select to_char(invoicedate,'MM') as month
        , description
        , sum(quantity*unitprice) as total_paid
        , rank() over (partition by to_char(invoicedate,'MM') order by sum(quantity*unitprice) desc) as rnk
    from online_retail
    group by to_char(invoicedate,'MM'), description) x
where rnk = 1;