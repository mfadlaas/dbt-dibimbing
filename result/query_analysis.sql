--Top Revenue per Style and Category
SELECT 
  p.style,
  p.category,
  SUM(f.qty) AS total_quantity_sold,
  SUM(f.amount) AS total_revenue
FROM `dbt-dibimbing.dibimbing.fact_salesorder` f
JOIN `dbt-dibimbing.dibimbing.dim_product` p
  ON f.product_id = p.product_id
WHERE f.status LIKE '%Shipped%' -- Filter to only shipped orders
GROUP BY p.style, p.category
ORDER BY total_revenue DESC
LIMIT 10;



--Top Revenue per Sales Channel
SELECT 
  sc.sales_channel,
  SUM(f.qty) AS total_quantity_sold,
  SUM(f.amount) AS total_revenue
FROM `dbt-dibimbing.dibimbing.fact_salesorder` f
JOIN `dbt-dibimbing.dibimbing.dim_sales_channel` sc
  ON f.sales_channel_id = sc.sales_channel_id
WHERE f.status LIKE '%Shipped%'
GROUP BY sc.sales_channel
ORDER BY total_revenue DESC;


--Top City Shipment
SELECT 
  ss.ship_city,
  SUM(f.qty) AS total_quantity_sold,
  SUM(f.amount) AS total_revenue
FROM `dbt-dibimbing.dibimbing.fact_salesorder` f
JOIN `dbt-dibimbing.dibimbing.dim_sales_shipment` ss
  ON f.sales_shipment_id = ss.sales_shipment_id
WHERE f.status LIKE '%Shipped%'
GROUP BY ss.ship_city
ORDER BY total_revenue DESC;
