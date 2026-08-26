-- =====================================================
-- Retail Sales Data Warehouse — Analytical Queries
-- Demonstrates typical BI / reporting queries run against
-- the star schema (JOINs, aggregation, CTEs, window functions)
-- =====================================================

USE retail_dwh;

-- ---------------------------------------------------------
-- 1. Total sales revenue by region and month
-- ---------------------------------------------------------
SELECT
    r.region_name,
    d.month_name,
    d.year,
    SUM(f.sales_amount) AS total_revenue
FROM fact_sales f
JOIN dim_region r ON f.region_id = r.region_id
JOIN dim_date d   ON f.date_id = d.date_id
GROUP BY r.region_name, d.month_name, d.month, d.year
ORDER BY d.year, d.month, total_revenue DESC;


-- ---------------------------------------------------------
-- 2. Top 5 products by total revenue
-- ---------------------------------------------------------
SELECT
    p.product_name,
    p.category,
    SUM(f.sales_amount) AS total_revenue,
    SUM(f.quantity)     AS units_sold
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 5;


-- ---------------------------------------------------------
-- 3. Quarter-over-quarter revenue growth (window function: LAG)
-- ---------------------------------------------------------
WITH quarterly_revenue AS (
    SELECT
        d.year,
        d.quarter,
        SUM(f.sales_amount) AS revenue
    FROM fact_sales f
    JOIN dim_date d ON f.date_id = d.date_id
    GROUP BY d.year, d.quarter
)
SELECT
    year,
    quarter,
    revenue,
    LAG(revenue) OVER (ORDER BY year, quarter) AS prev_quarter_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY year, quarter))
        / LAG(revenue) OVER (ORDER BY year, quarter) * 100, 2
    ) AS growth_pct
FROM quarterly_revenue
ORDER BY year, quarter;


-- ---------------------------------------------------------
-- 4. Customer segment performance (avg order value, total spend)
-- ---------------------------------------------------------
SELECT
    c.customer_segment,
    COUNT(f.sales_id)              AS total_orders,
    ROUND(AVG(f.sales_amount), 2)  AS avg_order_value,
    SUM(f.sales_amount)            AS total_spend
FROM fact_sales f
JOIN dim_customer c ON f.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY total_spend DESC;


-- ---------------------------------------------------------
-- 5. Running total of daily sales (window function: SUM OVER)
-- ---------------------------------------------------------
SELECT
    d.full_date,
    SUM(f.sales_amount) AS daily_revenue,
    SUM(SUM(f.sales_amount)) OVER (ORDER BY d.full_date) AS running_total
FROM fact_sales f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.full_date
ORDER BY d.full_date;


-- ---------------------------------------------------------
-- 6. Region with the highest profit margin (profit / revenue)
-- ---------------------------------------------------------
SELECT
    r.region_name,
    SUM(f.sales_amount)                              AS total_revenue,
    SUM(f.profit)                                     AS total_profit,
    ROUND(SUM(f.profit) / SUM(f.sales_amount) * 100, 2) AS profit_margin_pct
FROM fact_sales f
JOIN dim_region r ON f.region_id = r.region_id
GROUP BY r.region_name
ORDER BY profit_margin_pct DESC;


-- ---------------------------------------------------------
-- 7. Rank products within each category by revenue (window function: RANK)
-- ---------------------------------------------------------
WITH product_revenue AS (
    SELECT
        p.category,
        p.product_name,
        SUM(f.sales_amount) AS revenue
    FROM fact_sales f
    JOIN dim_product p ON f.product_id = p.product_id
    GROUP BY p.category, p.product_name
)
SELECT
    category,
    product_name,
    revenue,
    RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rank_in_category
FROM product_revenue
ORDER BY category, rank_in_category;
