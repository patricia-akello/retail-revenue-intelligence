-- ============================================================
-- KPI Queries
-- ============================================================

-- 1. Executive KPI Summary
SELECT
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2) AS profit_margin_percentage,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(AVG(discount) * 100, 2) AS average_discount_percentage,
    SUM(loss_making_flag) AS loss_making_transactions
FROM retail_orders;


-- 2. Monthly Revenue, Profit, and Growth Rate
WITH monthly_performance AS (
    SELECT
        DATE_TRUNC('month', order_date)::date AS month,
        ROUND(SUM(sales), 2) AS monthly_revenue,
        ROUND(SUM(profit), 2) AS monthly_profit
    FROM retail_orders
    GROUP BY DATE_TRUNC('month', order_date)
),
growth_calc AS (
    SELECT
        month,
        monthly_revenue,
        monthly_profit,
        LAG(monthly_revenue) OVER (ORDER BY month) AS previous_month_revenue
    FROM monthly_performance
)
SELECT
    month,
    monthly_revenue,
    monthly_profit,
    previous_month_revenue,
    ROUND(
        ((monthly_revenue - previous_month_revenue) / NULLIF(previous_month_revenue, 0)) * 100,
        2
    ) AS monthly_growth_rate_percentage
FROM growth_calc
ORDER BY month;


-- 3. Annual Performance Summary
SELECT
    order_year,
    ROUND(SUM(sales), 2) AS annual_revenue,
    ROUND(SUM(profit), 2) AS annual_profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2) AS annual_profit_margin_percentage,
    COUNT(DISTINCT order_id) AS total_orders
FROM retail_orders
GROUP BY order_year
ORDER BY order_year;


-- 4. Category KPI Summary
SELECT
    category,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2) AS profit_margin_percentage,
    ROUND(AVG(discount) * 100, 2) AS average_discount_percentage,
    COUNT(DISTINCT order_id) AS order_count
FROM retail_orders
GROUP BY category
ORDER BY revenue DESC;