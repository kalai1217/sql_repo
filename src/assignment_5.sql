-- Create a new table named 'sales_data' with three columns:
CREATE TABLE sales_data (
    product_id INT,
    sale_date DATE,
    quantity_sold INT
);
-- Insert the given sample data into the 'sales_data' table
INSERT INTO sales_data (product_id, sale_date, quantity_sold) VALUES
    (1, '2022-01-01', 20),
    (2, '2022-01-01', 15),
    (1, '2022-01-02', 10),
    (2, '2022-01-02', 25),
    (1, '2022-01-03', 30),
    (2, '2022-01-03', 18),
    (1, '2022-01-04', 12),
    (2, '2022-01-04', 22);
-- Select the columns: product_id, sale_date, quantity_sold, and a calculated rank
-- Partition the rows by product_id and order them by sale_date in descending order
-- Assign a rank to each row within the partition using the RANK() window function
-- Order the result by product_id and sale_date in descending order
SELECT
    product_id,
    sale_date,
    quantity_sold,
    RANK() OVER (PARTITION BY product_id ORDER BY sale_date DESC) AS rank
FROM
    sales_data
ORDER BY
    product_id, sale_date DESC;
-- Select the columns: product_id, sale_date, quantity_sold
-- Use the LAG() window function to get the previous row's quantity_sold within the partition
-- Calculate the difference between the current and previous quantity_sold
-- Partition the rows by product_id and order them by sale_date in ascending order
-- Order the result by product_id and sale_date in ascending order
SELECT
    product_id,
    sale_date,
    quantity_sold,
    LAG(quantity_sold, 1) OVER (PARTITION BY product_id ORDER BY sale_date) AS prev_qty,
    quantity_sold - LAG(quantity_sold, 1) OVER (PARTITION BY product_id ORDER BY sale_date) AS qty_diff
FROM
    sales_data
ORDER BY
    product_id, sale_date;
-- Select the columns: product_id, sale_date, quantity_sold
-- Use the FIRST_VALUE() window function to get the first sale_date within the partition
-- Use the LAST_VALUE() window function to get the last sale_date within the partition
-- Partition the rows by product_id
-- Order the rows by sale_date in ascending order for FIRST_VALUE()
-- Use RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING for LAST_VALUE() to consider the entire partition
-- Order the result by product_id and sale_date in ascending order
SELECT
    product_id,
    sale_date,
    quantity_sold,
    FIRST_VALUE(sale_date) OVER (PARTITION BY product_id ORDER BY sale_date) AS first_sale_date,
    LAST_VALUE(sale_date) OVER (PARTITION BY product_id ORDER BY sale_date RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_sale_date
FROM
    sales_data
ORDER BY
    product_id, sale_date;