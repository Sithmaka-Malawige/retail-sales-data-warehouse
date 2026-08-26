-- =====================================================
-- Retail Sales Data Warehouse — Sample Data
-- =====================================================

USE retail_dwh;

-- ---------- DIM_DATE ----------
INSERT INTO dim_date (date_id, full_date, day, month, month_name, quarter, year, weekday_name, is_weekend) VALUES
(1, '2025-01-05', 5, 1, 'January', 1, 2025, 'Sunday', TRUE),
(2, '2025-01-14', 14, 1, 'January', 1, 2025, 'Tuesday', FALSE),
(3, '2025-01-23', 23, 1, 'January', 1, 2025, 'Thursday', FALSE),
(4, '2025-02-01', 1, 2, 'February', 1, 2025, 'Saturday', TRUE),
(5, '2025-02-10', 10, 2, 'February', 1, 2025, 'Monday', FALSE),
(6, '2025-02-19', 19, 2, 'February', 1, 2025, 'Wednesday', FALSE),
(7, '2025-02-28', 28, 2, 'February', 1, 2025, 'Friday', FALSE),
(8, '2025-03-09', 9, 3, 'March', 1, 2025, 'Sunday', TRUE),
(9, '2025-03-18', 18, 3, 'March', 1, 2025, 'Tuesday', FALSE),
(10, '2025-03-27', 27, 3, 'March', 1, 2025, 'Thursday', FALSE),
(11, '2025-04-05', 5, 4, 'April', 2, 2025, 'Saturday', TRUE),
(12, '2025-04-14', 14, 4, 'April', 2, 2025, 'Monday', FALSE),
(13, '2025-04-23', 23, 4, 'April', 2, 2025, 'Wednesday', FALSE),
(14, '2025-05-02', 2, 5, 'May', 2, 2025, 'Friday', FALSE),
(15, '2025-05-11', 11, 5, 'May', 2, 2025, 'Sunday', TRUE),
(16, '2025-05-20', 20, 5, 'May', 2, 2025, 'Tuesday', FALSE),
(17, '2025-05-29', 29, 5, 'May', 2, 2025, 'Thursday', FALSE),
(18, '2025-06-07', 7, 6, 'June', 2, 2025, 'Saturday', TRUE),
(19, '2025-06-16', 16, 6, 'June', 2, 2025, 'Monday', FALSE),
(20, '2025-06-25', 25, 6, 'June', 2, 2025, 'Wednesday', FALSE);

-- ---------- DIM_CUSTOMER ----------
INSERT INTO dim_customer (customer_name, gender, age_group, city, country, customer_segment) VALUES
('Nimal Perera', 'Male', '25-34', 'Colombo', 'Sri Lanka', 'Regular'),
('Kasuni Fernando', 'Female', '18-24', 'Kandy', 'Sri Lanka', 'Premium'),
('Ruwan Silva', 'Male', '35-44', 'Galle', 'Sri Lanka', 'Regular'),
('Ishara Jayasinghe', 'Female', '25-34', 'Negombo', 'Sri Lanka', 'Premium'),
('Chamara Wickramasinghe', 'Male', '45-54', 'Jaffna', 'Sri Lanka', 'Regular'),
('Nadeesha Gunawardena', 'Female', '18-24', 'Matara', 'Sri Lanka', 'New'),
('Tharindu Rathnayake', 'Male', '25-34', 'Kurunegala', 'Sri Lanka', 'Regular'),
('Sanduni Weerasinghe', 'Female', '35-44', 'Anuradhapura', 'Sri Lanka', 'Premium'),
('Dilshan Bandara', 'Male', '18-24', 'Ratnapura', 'Sri Lanka', 'New'),
('Piumi Karunaratne', 'Female', '25-34', 'Batticaloa', 'Sri Lanka', 'Regular');

-- ---------- DIM_PRODUCT ----------
INSERT INTO dim_product (product_name, category, sub_category, brand, unit_price) VALUES
('Wireless Mouse', 'Electronics', 'Accessories', 'TechPro', 8.50),
('Bluetooth Headphones', 'Electronics', 'Audio', 'SoundMax', 25.00),
('Cotton T-Shirt', 'Clothing', 'Men''s Wear', 'UrbanFit', 6.00),
('Running Shoes', 'Sports', 'Footwear', 'SprintX', 32.00),
('Non-stick Frying Pan', 'Home & Kitchen', 'Cookware', 'HomeChef', 14.00),
('LED Desk Lamp', 'Home & Kitchen', 'Lighting', 'BrightLite', 11.50),
('Yoga Mat', 'Sports', 'Fitness', 'FlexFit', 9.00),
('Denim Jeans', 'Clothing', 'Men''s Wear', 'UrbanFit', 18.00),
('Smart Watch', 'Electronics', 'Wearables', 'TechPro', 45.00),
('Ceramic Coffee Mug Set', 'Home & Kitchen', 'Dining', 'HomeChef', 7.50);

-- ---------- DIM_REGION ----------
INSERT INTO dim_region (region_name, country, state) VALUES
('Western', 'Sri Lanka', 'Western Province'),
('Southern', 'Sri Lanka', 'Southern Province'),
('Central', 'Sri Lanka', 'Central Province'),
('Northern', 'Sri Lanka', 'Northern Province'),
('Eastern', 'Sri Lanka', 'Eastern Province');

-- ---------- FACT_SALES ----------
INSERT INTO fact_sales (date_id, customer_id, product_id, region_id, quantity, unit_price, discount, sales_amount, profit) VALUES
(4, 1, 5, 2, 4, 14.00, 0.05, 53.20, 13.86),
(18, 2, 10, 4, 1, 7.50, 0.00, 7.50, 1.23),
(8, 9, 10, 1, 4, 7.50, 0.15, 25.50, 4.67),
(19, 5, 1, 2, 7, 8.50, 0.10, 53.55, 10.26),
(7, 6, 2, 1, 7, 25.00, 0.00, 175.00, 35.67),
(12, 10, 5, 1, 8, 14.00, 0.00, 112.00, 33.15),
(13, 2, 9, 3, 6, 45.00, 0.05, 256.50, 65.58),
(2, 4, 5, 1, 4, 14.00, 0.00, 56.00, 11.59),
(15, 6, 3, 3, 6, 6.00, 0.05, 34.20, 8.57),
(3, 10, 3, 5, 4, 6.00, 0.05, 22.80, 5.00),
(9, 9, 4, 3, 1, 32.00, 0.05, 30.40, 8.31),
(11, 7, 5, 1, 4, 14.00, 0.10, 50.40, 9.17),
(16, 7, 8, 2, 5, 18.00, 0.05, 85.50, 15.99),
(18, 9, 5, 5, 7, 14.00, 0.15, 83.30, 17.02),
(5, 9, 8, 1, 1, 18.00, 0.00, 18.00, 3.11),
(6, 7, 10, 1, 7, 7.50, 0.15, 44.62, 10.68),
(15, 9, 5, 5, 1, 14.00, 0.00, 14.00, 3.53),
(18, 5, 6, 1, 5, 11.50, 0.15, 48.88, 8.49),
(1, 5, 9, 2, 2, 45.00, 0.10, 81.00, 22.38),
(17, 10, 4, 2, 6, 32.00, 0.05, 182.40, 42.12),
(17, 1, 10, 3, 8, 7.50, 0.00, 60.00, 10.01),
(12, 5, 4, 1, 4, 32.00, 0.00, 128.00, 20.84),
(16, 2, 9, 2, 3, 45.00, 0.15, 114.75, 33.51),
(6, 5, 9, 5, 7, 45.00, 0.05, 299.25, 86.58),
(7, 5, 7, 3, 8, 9.00, 0.15, 61.20, 10.29),
(8, 2, 6, 1, 4, 11.50, 0.05, 43.70, 6.60),
(2, 4, 2, 1, 6, 25.00, 0.00, 150.00, 34.07),
(9, 8, 4, 5, 3, 32.00, 0.15, 81.60, 15.21),
(16, 7, 4, 1, 2, 32.00, 0.15, 54.40, 11.05),
(14, 8, 1, 1, 1, 8.50, 0.15, 7.22, 1.87),
(4, 4, 4, 2, 8, 32.00, 0.05, 243.20, 51.87),
(9, 8, 4, 1, 8, 32.00, 0.00, 256.00, 40.34),
(18, 1, 2, 2, 3, 25.00, 0.15, 63.75, 14.21),
(7, 7, 1, 2, 7, 8.50, 0.00, 59.50, 17.72),
(9, 8, 5, 4, 8, 14.00, 0.05, 106.40, 18.99),
(7, 1, 10, 5, 1, 7.50, 0.10, 6.75, 1.07),
(19, 8, 9, 5, 3, 45.00, 0.00, 135.00, 39.71),
(3, 3, 2, 5, 2, 25.00, 0.05, 47.50, 10.00),
(19, 4, 10, 5, 1, 7.50, 0.00, 7.50, 1.60),
(19, 10, 9, 3, 5, 45.00, 0.05, 213.75, 53.54),
(11, 4, 5, 4, 3, 14.00, 0.10, 37.80, 8.26),
(3, 1, 8, 5, 2, 18.00, 0.00, 36.00, 8.30),
(17, 5, 3, 3, 2, 6.00, 0.05, 11.40, 2.34),
(6, 8, 9, 3, 1, 45.00, 0.10, 40.50, 11.74),
(4, 3, 5, 1, 2, 14.00, 0.05, 26.60, 5.08);
