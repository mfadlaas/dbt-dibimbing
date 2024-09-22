{{ config(materialized='table') }}

WITH t_data AS (
  SELECT DISTINCT
    `Sales Channel ` AS sales_channel
  FROM `dbt-dibimbing.dibimbing.amazon_sale_report`
)

-- If multiple promotion IDs are comma-separated, you can split them
SELECT 
  {{ dbt_utils.generate_surrogate_key(['sales_channel']) }} AS sales_channel_id, 
  sales_channel 
FROM t_data