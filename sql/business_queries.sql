-- ============================================================
-- Business Analysis Queries
-- ============================================================

-- 1. Monthly Revenue Trend
SELECT
    order_year_month,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2) AS profit_margin_percentage
FROM retail_orders
GROUP BY order_year_month
ORDER BY order_year_month;


-- 2. Peak Revenue Months
SELECT
    order_year_month,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(AVG(discount) * 100, 2) AS average_discount_percentage,
    COUNT(DISTINCT order_id) AS order_count
FROM retail_orders
GROUP BY order_year_month
ORDER BY revenue DESC
LIMIT 10;


-- 3. Top Performing Products
SELECT
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2) AS profit_margin_percentage,
    COUNT(DISTINCT order_id) AS order_count
FROM retail_orders
GROUP BY product_name, category, sub_category
ORDER BY profit DESC
LIMIT 10;


-- 4. High Revenue but Low Profit Products
SELECT
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2) AS profit_margin_percentage,
    ROUND(AVG(discount) * 100, 2) AS average_discount_percentage
FROM retail_orders
GROUP BY product_name, category, sub_category
HAVING SUM(sales) > (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY product_revenue)
    FROM (
        SELECT SUM(sales) AS product_revenue
        FROM retail_orders
        GROUP BY product_name
    ) product_sales
)
AND SUM(profit) <= 0
ORDER BY revenue DESC;


-- 5. Worst Profit Products
SELECT
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(AVG(discount) * 100, 2) AS average_discount_percentage
FROM retail_orders
GROUP BY product_name, category, sub_category
ORDER BY profit ASC
LIMIT 10;


-- 6. Regional Performance
SELECT
    region,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2) AS profit_margin_percentage,
    ROUND(AVG(discount) * 100, 2) AS average_discount_percentage,
    COUNT(DISTINCT order_id) AS order_count
FROM retail_orders
GROUP BY region
ORDER BY profit ASC;


-- 7. State-Level Underperformance
SELECT
    state,
    region,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2) AS profit_margin_percentage,
    ROUND(AVG(discount) * 100, 2) AS average_discount_percentage
FROM retail_orders
GROUP BY state, region
HAVING SUM(profit) < 0
ORDER BY profit ASC;


-- 8. Discount Impact on Profitability
SELECT
    discount_band,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2) AS profit_margin_percentage,
    COUNT(*) AS transaction_count
FROM retail_orders
GROUP BY discount_band
ORDER BY profit_margin_percentage ASC;


-- 9. Category and Sub-Category Profitability
SELECT
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2) AS profit_margin_percentage,
    ROUND(AVG(discount) * 100, 2) AS average_discount_percentage
FROM retail_orders
GROUP BY category, sub_category
ORDER BY profit ASC;


-- 10. Customer Segment Profitability
SELECT
    segment,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2) AS profit_margin_percentage,
    COUNT(DISTINCT customer_id) AS customer_count
FROM retail_orders
GROUP BY segment
ORDER BY profit DESC;


-- 11. Customer Risk Segmentation
SELECT
    customer_segment_risk,
    COUNT(DISTINCT customer_id) AS customer_count,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2) AS profit_margin_percentage
FROM retail_orders
GROUP BY customer_segment_risk
ORDER BY profit ASC;


-- 12. Shipping Performance
SELECT
    shipping_speed,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(AVG(shipping_days), 2) AS average_shipping_days
FROM retail_orders
GROUP BY shipping_speed
ORDER BY average_shipping_days DESC;