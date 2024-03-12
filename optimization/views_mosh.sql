#views helps us so that we do not have to type the queries always

use sql_invoicing;

create view sales_by_clients as
select c.client_id,c.name,sum(invoice_total) as total_sales from clients as c join invoices as i on c.client_id = i.client_id
group by client_id,name;

select * from sales_by_clients
join clients using (client_id)




