-- =====================================================
-- Retail Sales Data Warehouse — Snowflake Schema Variant
-- Demonstrates further normalization of DIM_PRODUCT by
-- splitting category attributes into a separate DIM_CATEGORY table.
-- =====================================================

USE retail_dwh;

DROP TABLE IF EXISTS dim_product_snowflake;
DROP TABLE IF EXISTS dim_category;

-- ---------- Normalized dimension: category is its own table ----------
CREATE TABLE dim_category (
    category_id    INT AUTO_INCREMENT PRIMARY KEY,
    category_name  VARCHAR(50) NOT NULL,
    sub_category   VARCHAR(50)
);

-- ---------- Product table now references category_id instead of ----------
-- ---------- storing category/sub_category as flat text columns   ----------
CREATE TABLE dim_product_snowflake (
    product_id     INT AUTO_INCREMENT PRIMARY KEY,
    product_name   VARCHAR(100) NOT NULL,
    category_id    INT NOT NULL,
    brand          VARCHAR(50),
    unit_price     DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES dim_category(category_id)
);

-- Sample category data
INSERT INTO dim_category (category_name, sub_category) VALUES
('Electronics', 'Accessories'),
('Electronics', 'Audio'),
('Electronics', 'Wearables'),
('Clothing', 'Men''s Wear'),
('Sports', 'Footwear'),
('Sports', 'Fitness'),
('Home & Kitchen', 'Cookware'),
('Home & Kitchen', 'Lighting'),
('Home & Kitchen', 'Dining');

-- Note:
-- In the star schema (01_schema_star.sql), dim_product stores
-- category and sub_category directly as text columns — this is
-- denormalized for faster, simpler read queries (typical OLAP design).
--
-- In this snowflake variant, category is normalized into its own
-- table to eliminate redundancy — closer to an OLTP-style design.
-- This trade-off (query simplicity vs. storage/redundancy) is the
-- core reason most data warehouses favor star schema over snowflake
-- for BI reporting workloads.
