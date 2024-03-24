# sql_repo
## _This repo contains assignments on sql._
## Project_Structure

 - **src**
 
     - `assignment.sql` contains the respective assignment for each question.


 - **README.md**

    - *Overview of the project*

## assignment_1

**_Summary_**

### Step 1. Create Database:
Created a database named `ecommerce`.

### Step 2. Create Tables:
   - Created four tables named `gold_member_users`, `users`, `sales`, and `product` under the `ecommerce` database.

### Step 3. Insert Values:
Inserted provided values into respective tables with appropriate data types.

### Step 4. Show Tables:
Displayed all tables within the `ecommerce` database.

### Step 5. Count Records:
Counted all records across the four tables using a single query.

### Step 6. Total Amount Spent:
Calculated the total amount each customer spent on the e-commerce company.

### Step 7. Distinct Visit Dates:
Retrieved distinct visit dates of each customer.

### Step 8. First Product Purchased:
Found the first product purchased by each customer using a join between `users`, `sales`, and `product` tables.

### Step 9. Most Purchased Item:
Determined the most purchased item of each customer and how many times it was purchased.

### Step 10. Non-Gold Member Customers:
Identified customers who are not gold members.

### Step 11. Amount Spent by Gold Members:
Calculated the amount spent by each customer when they were gold members.

### Step 12. Customers Name Starting with M:
Retrieved customer names whose names start with 'M'.

### Step 13. Distinct Customer IDs:
Found distinct customer IDs of each customer.

### Step 14. Column Name Change:
Changed the column name from `price` to `price_value` in the `product` table.

### Step 15. Product Name Change:
Changed the product name from 'Ipad' to 'Iphone' in the `product` table.

### Step 16. Table Name Change:
Renamed the `gold_member_users` table to `gold_membership_users`.

### Step 17. Add Status Column:
Added a new column named `Status` to the `gold_membership_users` table, with values 'Yes' or 'No' based on whether the user is a gold member.

### Step 18. Delete Records and Rollback:
Deleted user IDs 1 and 2 from the `users` table and rolled back the changes once both rows were deleted, preserving data integrity.

### Step 19. Insert Duplicate Record:
Inserted one more record with the same values into the `product` table.

### Step 20. Find Duplicates:
Wrote a query to identify duplicates in the `product` table.

## assignment_2
**_summary_**
### Step 1. Create Table:
Created a table named `product_details` with columns `sell_date` and `product`.

### Step 2. Insert Data:
Inserted provided data into the `product_details` table.

### Step 3. Query for Output:
Wrote a query to group the data by `sell_date`, count the number of different products sold on each date, and concatenate the names of those products into a single string.

```sql
SELECT 
    sell_date,
    COUNT(DISTINCT product) AS num_sold,
    GROUP_CONCAT(DISTINCT product ORDER BY product ASC SEPARATOR ', ') AS product_list
FROM 
    product_details
GROUP BY 
    sell_date;
```
## assignment_3
**_summary_**
### Step 1. Create Table:
Created a table named `dept_tbl` with columns `id_deptname`, `emp_name`, and `salary`.

### Step 2. Insert Data:
Inserted provided data into the `dept_tbl` table.

### Step 3. Query for Output:
Wrote a query to group the data by department name (`id_deptname`), calculate the total salary for each department.

## assignment_4
**_summary_**
### Step 1. Create Table:
Created a table named `email_signup` with columns `id`, `email_id`, and `signup_date`.

### Step 2. Insert Data:
Inserted provided data into the `email_signup` table.

### Step 3. Query for Output:
1. Wrote a query to find Gmail accounts with the latest and first signup dates, along with the difference between both dates.
2. Wrote a query to replace null values in the `signup_date` column with '1970-01-01'.

## assignment_5
**_sum### Step 1. Create Table:
Created a table named `sales_data` with columns `product_id`, `sale_date`, and `quantity_sold`.

### Step 2. Insert Sample Data:
Inserted provided sample data into the `sales_data` table.

### Question 1: Assign Rank by Partition:
Assigned rank by partitioning based on `product_id` to find the latest `product_id` sold.

### Question 2: Compare Quantity Sold:
Retrieved the `quantity_sold` value from the previous row and compared it with the current `quantity_sold`.

### Question 3: First and Last Values in Ordered Set:
Partitioned based on `product_id` and returned the first and last values in the ordered set.

## assignment_6
### Entities and Attributes:
- **Student:** 
  - Attributes: student_id (Primary Key), name, date_of_birth, email_address, major_id (Foreign Key).

- **Course:** 
  - Attributes: course_code (Primary Key), title, credit_hours, department_id (Foreign Key).

- **Instructor:** 
  - Attributes: instructor_id (Primary Key), name, office_location.

### Relationships:
- **Enrollment:**
  - Many-to-Many relationship between Student and Course.
  - Attributes: None.

- **Teaching:**
  - One-to-Many relationship between Instructor and Course.
  - Attributes: None.

- **Major:**
  - One-to-Many relationship between Student and Major.
  - Attributes: None.

- **Department:**
  - One-to-Many relationship between Course and Department.
  - Attributes: None.

This ER diagram captures the entities, attributes, and relationships between students, courses, instructors, majors, and departments in the university database system.
