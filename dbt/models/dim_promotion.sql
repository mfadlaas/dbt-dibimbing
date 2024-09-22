{{ config(materialized='table') }}

WITH t_data AS (
  SELECT DISTINCT
    `promotion-ids` AS promotion_description
  FROM `dbt-dibimbing.dibimbing.amazon_sale_report`
  WHERE `promotion-ids` IS NOT NULL
)

-- If multiple promotion IDs are comma-separated, you can split them
SELECT 
  {{ dbt_utils.generate_surrogate_key(['promotion_description']) }} AS promotion_id, 
  promotion_description 
FROM t_data
