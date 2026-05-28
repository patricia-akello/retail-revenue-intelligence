-- ============================================================
-- Retail Revenue Intelligence & Profitability Optimization
-- Phase 3: PostgreSQL Schema
-- ============================================================

DROP TABLE IF EXISTS retail_orders;

CREATE TABLE retail_orders (
    row_id INTEGER,
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(150),
    segment VARCHAR(50),
    country VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(30),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name TEXT,
    sales NUMERIC(12,2),
    quantity INTEGER,
    discount NUMERIC(5,2),
    profit NUMERIC(12,2),
    shipping_days INTEGER,
    order_year INTEGER,
    order_month INTEGER,
    order_month_name VARCHAR(20),
    order_quarter INTEGER,
    order_year_month VARCHAR(10),
    order_day_of_week VARCHAR(20),
    profit_margin NUMERIC(12,6),
    profit_margin_percentage NUMERIC(12,2),
    loss_making_flag INTEGER,
    profitability_status VARCHAR(50),
    discount_band VARCHAR(50),
    revenue_category VARCHAR(50),
    shipping_speed VARCHAR(50),
    customer_total_sales NUMERIC(12,2),
    customer_total_profit NUMERIC(12,2),
    customer_order_count INTEGER,
    customer_profit_margin NUMERIC(12,6),
    customer_segment_risk VARCHAR(50)
);

-- Recommended indexes for analysis performance
CREATE INDEX idx_order_date ON retail_orders(order_date);
CREATE INDEX idx_region ON retail_orders(region);
CREATE INDEX idx_category ON retail_orders(category);
CREATE INDEX idx_sub_category ON retail_orders(sub_category);
CREATE INDEX idx_customer_id ON retail_orders(customer_id);
CREATE INDEX idx_product_id ON retail_orders(product_id);
CREATE INDEX idx_profitability_status ON retail_orders(profitability_status);