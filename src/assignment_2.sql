-- Create the 'sales' table to store sales data including sell_date and product_name

CREATE TABLE sales(
-- Define the column to store the date of sale
  sell_date DATE, 
-- Define the column to store the name of the product sold
  product_name VARCHAR(50) 
);

-- Insert sample data into the 'sales' table

INSERT INTO sales VALUES
('2020-05-30', 'Headphones'), 
('2020-06-01','Pencil'), 
('2020-06-02','Mask'), 
('2020-05-30','Basketball'),
('2020-06-01','Book'), 
('2020-06-02', ' Mask '), 
('2020-05-30','T-Shirt'),
('2020-06-03', 'Sunglasses'),
('2020-06-04', 'Water Bottle'),
('2020-06-05', 'Notebook'), 
('2020-06-03', 'Running Shoes'), 
('2020-06-04', 'Backpack'), 
('2020-06-05', 'Umbrella'), 
('2020-06-03', 'Gaming Mouse'), 
('2020-06-04', 'Laptop Sleeve'), 
('2020-06-05', 'Wireless Keyboard'), 
('2020-06-03', 'Desk Lamp'); 

-- Retrieve all data from the 'sales' table

SELECT * FROM sales;

-- Retrieve the sell_date, count of distinct product_name, and a concatenated list of product names sold on each sell_date

SELECT sell_date, COUNT(DISTINCT product_name) AS num_sold,
STRING_AGG(product_name,', ') AS product
FROM sales
GROUP BY sell_date
-- Order the results by the number of distinct product_names sold in ascending order
ORDER BY num_sold;
