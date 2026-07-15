select * from store limit 10;
select count(distinct order_ID) from store;

-- Sales by category

-- which category has more sales
select category, round(sum(sales),2) as total_sales
from store
group by category order by total_sales desc
limit 10;
 
 -- which subcategory has more sales
 select `sub-category` ,round(sum(sales),2) as total_sales
 from store
 group by `sub-category` order by total_sales desc;
 
 -- Total Sales by Sub-Category Ranked Within Each Category
 select t.category,t.`sub-category` ,t.total_sales
 from ( select 
 category,`sub-category` ,round(sum(sales),2) as total_sales , 
 rank()over(partition by category order by sum(sales) desc) as ranking from store
 group by category,`sub-category`
 )t;

-- which country has more sales
select country ,round(sum(sales),2) as total_sales
from store 
group by country
order by total_sales desc;

-- which region has more sales
select region ,round(sum(sales),2) as total_sales
from store
group by region
order by total_sales desc;

-- which state has more sales
select state , round(sum(sales),2) as total_sales
from store
group by state
order by total_sales desc;

-- Total Sales by state Ranked Within Each region
select t.region,t.state,t.total_sales 
from (select
region,state, round(sum(sales),2) as total_Sales, 
rank() over(partition by region order by sum(sales) desc) as ranking
from store 
group by region,state)t;

-- top customers
select customer_name ,round(sum(sales),2) as total_sales
from store
group by customer_name
order by total_sales desc
limit 10;

-- shipment analysis
select ship_mode , 
round(avg(datediff(ship_date, order_date)),2) as delivery_days,
round(sum(sales),2) as total_Sales
from store
group by ship_mode
order by total_sales desc;

-- yearly analysis
select year(order_date) as years, round(sum(sales),2) as total_sales
from store
group by years
order by total_sales desc;

-- monthly analysis
select month(order_date) as months ,round(sum(sales),2) as total_sales
from store
group by months
order by total_sales desc;

-- seasonal peak
select year(order_date) as years,
quarter(order_date) as quarters,
round(sum(sales),2) as total_sales
from store
group by years, quarters
order by years, quarters;

-- Average order value
select order_id, round(avg(sales),2) as AOV
from store
group by order_id
order by AOV desc;

-- Repeated Customers
select customer_id, count(distinct order_id) as total_orders
from store
group by customer_id
order by total_orders desc;

-- which category peforms best in each region
select region,category ,round(sum(sales),2) as total_sales
from store
group by region,category
order by region,total_sales desc;

-- sales contribution by each category
select category,
round(sum(sales),2) as total_sales,
round(sum(sales)*100 / (select sum(sales) from store),2) as Percentage
from store
group by category;

-- Top 5 sellig products
select Product_Name , round(sum(sales),2) as total_sales
from store 
group by Product_Name
order by total_sales desc
limit 5;

-- Which Products Generate High Sales but Low Order Frequency?
select Product_Name , count(distinct order_id) as order_count,
 round(sum(sales),2) as total_sales
from store
group by Product_Name 
having order_count < 10
order by total_sales desc;

-- which day of week generate more sales
select dayname(order_date) as days, round(sum(sales),2) as total_sales 
from store
group by days
order by total_sales desc;

--  which category had highest  customers count and orders count 
select category, count(distinct customer_id) as customer_count,
count(order_id) as total_orders
from store
group by category;