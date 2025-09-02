-- This SQL script is part of a sales analytics project.
-- It demonstrates the process of building a star schema from a raw dataset
-- within a PostgreSQL database. The cleaned and modeled data is then
-- connected to a Power BI dashboard for visualization and analysis.

-- Data Source:
-- The analysis is based on the Online Retail Dataset provided by the UCI Machine Learning Repository.
-- Link: https://archive.ics.uci.edu/dataset/352/online+retail

----------------------------------------------------------------------------------------------------
-- STEP 1: CREATE DIMENSION TABLES
-- These tables will contain descriptive attributes of customers, products, and dates.
-- The raw data is assumed to be in a table named `online_retail_raw`.
----------------------------------------------------------------------------------------------------

-- Create dim_customer table
-- This table contains unique customer information, including their country.
-- It uses a `DISTINCT` clause to remove any duplicate customer entries from the raw data.
CREATE TABLE IF NOT EXISTS dim_customer AS
SELECT DISTINCT
    customer_id,
    country
FROM online_retail_raw
WHERE customer_id IS NOT NULL;


-- Create dim_date table
-- This table extracts key date attributes like day, month, year, and weekday.
-- This is essential for time-based analysis in the BI dashboard.
CREATE TABLE IF NOT EXISTS dim_date AS
SELECT DISTINCT
    invoice_date::date AS date_key,
    EXTRACT(DAY FROM invoice_date) AS day,
    EXTRACT(MONTH FROM invoice_date) AS month,
    EXTRACT(YEAR FROM invoice_date) AS year,
    TO_CHAR(invoice_date, 'Day') AS weekday_name,
    EXTRACT(WEEK FROM invoice_date) AS week
FROM online_retail_raw;


-- Create dim_product table
-- This table stores unique product information. It uses `DISTINCT` to handle
-- multiple entries for the same product in the raw data.
CREATE TABLE IF NOT EXISTS dim_product AS
SELECT DISTINCT
    stock_code,
    description
FROM online_retail_raw
WHERE stock_code IS NOT NULL;


----------------------------------------------------------------------------------------------------
-- STEP 2: CREATE THE FACT TABLE
-- This table contains the core transactional data and serves as the central
-- point of the star schema. It includes foreign keys to the dimension tables.
----------------------------------------------------------------------------------------------------

-- Create fact_sales table
-- This table contains all individual sales transactions. It calculates `total_price`
-- and filters out records with null values in critical fields.
CREATE TABLE IF NOT EXISTS fact_sales AS
SELECT
    invoice_no,
    stock_code,
    customer_id,
    invoice_date::date AS date,
    quantity,
    unit_price,
    (quantity * unit_price) AS total_price
FROM online_retail_raw
WHERE customer_id IS NOT NULL
  AND invoice_no IS NOT NULL
  AND stock_code IS NOT NULL
  AND invoice_date IS NOT NULL;

----------------------------------------------------------------------------------------------------
-- STEP 3: DATA CLEANING & PRIMARY KEY DEFINITION
-- This step ensures data integrity by removing duplicates and defining primary keys.
-- Primary keys are essential for creating relationships in Power BI.
----------------------------------------------------------------------------------------------------

-- Clean dim_customer: remove duplicates and define primary key.
-- Note: ctid is a system column that can be used to identify physical rows in PostgreSQL.
DELETE FROM dim_customer a
USING dim_customer b
WHERE a.ctid < b.ctid AND a.customer_id = b.customer_id;

-- Define primary key for dim_customer.
ALTER TABLE dim_customer ADD CONSTRAINT pk_customer PRIMARY KEY (customer_id);


-- Clean dim_product: remove duplicates and define primary key.
DELETE FROM dim_product a
USING dim_product b
WHERE a.ctid < b.ctid AND a.stock_code = b.stock_code;

-- Define primary key for dim_product.
ALTER TABLE dim_product ADD CONSTRAINT pk_product PRIMARY KEY (stock_code);


-- Clean dim_date: remove duplicates and define primary key.
DELETE FROM dim_date a
USING dim_date b
WHERE a.ctid < b.ctid AND a.date_key = b.date_key;

-- Define primary key for dim_date.
ALTER TABLE dim_date ADD CONSTRAINT pk_date PRIMARY KEY (date_key);


-- Clean fact_sales: remove duplicates and define a composite primary key.
-- A composite primary key is used because multiple items can be on a single invoice.
DELETE FROM fact_sales a
USING fact_sales b
WHERE a.ctid < b.ctid
  AND a.invoice_no = b.invoice_no
  AND a.stock_code = b.stock_code;

-- Define composite primary key for fact_sales.
ALTER TABLE fact_sales ADD CONSTRAINT pk_fact_sales PRIMARY KEY (invoice_no, stock_code);


----------------------------------------------------------------------------------------------------
-- END OF SCRIPT
----------------------------------------------------------------------------------------------------
