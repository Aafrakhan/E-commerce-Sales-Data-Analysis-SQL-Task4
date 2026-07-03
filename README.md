# SQL for Data Analysis — UrbanCart E-Commerce Database

## 📌 Objective
Use SQL queries to extract and analyze data from a relational e-commerce database, covering filtering, joins, subqueries, aggregation, views, and indexing.

## 🛠 Tools Used
- MySQL Workbench 8.0
- Dataset: SQL Practice Dataset (Kaggle) 🔗 https://www.kaggle.com/datasets/nudratabbas
- imported into a custom database named `urbancart_db`

## 🗂 Database Schema
The database `urbancart_db` contains three related tables:

**customers**
| Column | Type |
|---|---|
| customer_id | text |
| gender | text |
| age | int |
| city | text |
| signup_date | text |
| loyalty_member | text |

**orders**
| Column | Type |
|---|---|
| order_id | text |
| customer_id | text |
| product_id | text |
| order_date | text |
| quantity | int |
| payment_method | text |

**products**
| Column | Type |
|---|---|
| product_id | text |
| product_name | text |
| category | text |
| price | double |

## 📝 What I Did
1. Created the `urbancart_db` database and imported customers, orders, and products tables from a Kaggle SQL practice dataset.
2. Wrote and executed SQL queries covering:
   - **Filtering & sorting**: `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`
   - **Joins**: INNER JOIN, LEFT JOIN, RIGHT JOIN across the three tables
   - **Subqueries**: finding customers with no orders, products priced above average, top customer by order count
   - **Aggregate functions**: total revenue, average order value, revenue by category
   - **Views**: created `customer_order_summary` and `top_selling_products` for reusable analysis
   - **Indexing**: added an index on `orders.customer_id` and used `EXPLAIN` to confirm the query optimizer now uses the index (`type: ref`) instead of a full table scan
3. Took screenshots of each query's output as proof of execution.

## 📊 Key Queries & Insights
- Identified the top-selling products by total quantity sold.
- Calculated total and average revenue across all orders.
- Segmented revenue by product category.
- Built a `customer_order_summary` view combining customer info with their total orders and spend, useful for future dashboarding.


## ✅ Outcome
Gained hands-on experience manipulating and querying structured relational data using SQL — 
from basic filtering to joins, subqueries, aggregation, views, and query optimization with indexes.
