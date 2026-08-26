-- =====================================================
-- Retail Sales Data Warehouse — Star Schema
-- Author: Sithmaka Malawige
-- =====================================================

CREATE DATABASE IF NOT EXISTS retail_dwh;
USE retail_dwh;

-- Drop tables if re-running the script during development
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_customer;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_region;

-- ---------- DIMENSION TABLES ----------

CREATE TABLE dim_date (
    date_id       INT PRIMARY KEY,
    full_date     DATE NOT NULL,
    day           INT NOT NULL,
    month         INT NOT NULL,
    month_name    VARCHAR(20) NOT NULL,
    quarter       INT NOT NULL,
    year          INT NOT NULL,
    weekday_name  VARCHAR(15) NOT NULL,
    is_weekend    BOOLEAN NOT NULL
);

CREATE TABLE dim_customer (
    customer_id      INT AUTO_INCREMENT PRIMARY KEY,
    customer_name    VARCHAR(100) NOT NULL,
    gender            VARCHAR(10),
    age_group        VARCHAR(20),
    city              VARCHAR(50),
    country           VARCHAR(50),
    customer_segment VARCHAR(30)
);

CREATE TABLE dim_product (
    product_id     INT AUTO_INCREMENT PRIMARY KEY,
    product_name   VARCHAR(100) NOT NULL,
    category       VARCHAR(50),
    sub_category   VARCHAR(50),
    brand          VARCHAR(50),
    unit_price     DECIMAL(10,2) NOT NULL
);

CREATE TABLE dim_region (
    region_id     INT AUTO_INCREMENT PRIMARY KEY,
    region_name   VARCHAR(50) NOT NULL,
    country       VARCHAR(50),
    state         VARCHAR(50)
);

-- ---------- FACT TABLE ----------
-- Grain: one row per line item in a sales transaction

CREATE TABLE fact_sales (
    sales_id      INT AUTO_INCREMENT PRIMARY KEY,
    date_id       INT NOT NULL,
    customer_id   INT NOT NULL,
    product_id    INT NOT NULL,
    region_id     INT NOT NULL,
    quantity      INT NOT NULL,
    unit_price    DECIMAL(10,2) NOT NULL,
    discount      DECIMAL(5,2) DEFAULT 0.00,
    sales_amount  DECIMAL(12,2) NOT NULL,
    profit        DECIMAL(12,2),

    CONSTRAINT fk_fact_date     FOREIGN KEY (date_id)     REFERENCES dim_date(date_id),
    CONSTRAINT fk_fact_customer FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    CONSTRAINT fk_fact_product  FOREIGN KEY (product_id)  REFERENCES dim_product(product_id),
    CONSTRAINT fk_fact_region   FOREIGN KEY (region_id)   REFERENCES dim_region(region_id)
);

-- ---------- INDEXES for query performance on foreign keys ----------
CREATE INDEX idx_fact_date     ON fact_sales(date_id);
CREATE INDEX idx_fact_customer ON fact_sales(customer_id);
CREATE INDEX idx_fact_product  ON fact_sales(product_id);
CREATE INDEX idx_fact_region   ON fact_sales(region_id);
