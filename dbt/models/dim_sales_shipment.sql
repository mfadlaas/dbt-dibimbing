{{ config(materialized='table') }}


WITH t_data AS (
  SELECT DISTINCT
    `Courier Status` AS courier_status,
    `ship-service-level` AS ship_service_level,
    `ship-postal-code` AS ship_postal_code,
    `ship-city` AS ship_city,
    `ship-state` AS ship_state,
    `ship-country` AS ship_country
  FROM `dbt-dibimbing.dibimbing.amazon_sale_report`
)

-- If multiple promotion IDs are comma-separated, you can split them
SELECT 
  {{ dbt_utils.generate_surrogate_key([
    'courier_status', 
    'ship_service_level', 
    'ship_postal_code', 
    'ship_city', 
    'ship_state', 
    'ship_country'
  ]) }} AS sales_shipment_id, *
FROM t_data