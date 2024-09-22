{{ config(materialized='table') }}

WITH t_data AS (
  SELECT `index`, 
  `Order ID` AS order_id, 
  Date AS date,
  Status AS status,
  Qty AS qty,
  Amount AS amount,
  {{ dbt_utils.generate_surrogate_key([
				'SKU'
			]) }} as product_id,
  {{ dbt_utils.generate_surrogate_key([
				'Fulfilment', 
				'`fulfilled-by`'
			])}} AS fulfilment_id,
  {{ dbt_utils.generate_surrogate_key([
    '`promotion-ids`'
      ]) }} AS promotion_id,
  {{ dbt_utils.generate_surrogate_key([
    '`Sales Channel `'
      ]) }} AS sales_channel_id,
  {{ dbt_utils.generate_surrogate_key([
    '`Courier Status`', 
    '`ship-service-level`', 
    '`ship-postal-code`', 
    '`ship-city`', 
    '`ship-state`', 
    '`ship-country`'
  ]) }} AS sales_shipment_id
FROM `dbt-dibimbing.dibimbing.amazon_sale_report`        
)

SELECT 
  {{ dbt_utils.generate_surrogate_key(['`index`']) }} AS fact_salesorder_id, *
FROM t_data -- sesuaikan dengan table kalian