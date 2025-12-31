## 📂 Dataset

Due to GitHub file size limits, the complete AdventureWorks Excel dataset
is provided via GitHub Releases.

👉 Dataset Location: Releases → v1.0
👉 [Download Dataset from Releases](https://github.com/ashish260901/AdventureWorks/releases/tag/v1.0)

📊 AdventureWorks Sales Analytics Project

Tools Used: Excel | SQL (PostgreSQL) | Power BI | Tableau

This project is a comprehensive sales analytics case study built using the AdventureWorks dataset. The goal of the project was to analyze sales performance, profitability, customer behavior, and product trends, and to present actionable business insights using multiple analytics tools.

🔹 Data Preparation & Modeling

The project uses a star schema–based data model consisting of dimension tables such as Customers, Products, Product Category, Product Subcategory, Date, and Sales Territory, along with a FactInternetSales table.
Raw Excel files were cleaned and standardized by handling missing values, fixing date formats, and ensuring consistent keys for joins across tables.

🔹 Excel Analysis

In Excel, I performed initial data exploration and validation. I created calculated fields such as Sales Amount, Gross Amount, Production Cost, Unit Discount, and Profit using formulas.
Pivot Tables were used to analyze:

Month-wise, quarter-wise, and year-wise sales

Product and customer performance

Regional sales distribution

Interactive slicers and charts (bar, line, and pie charts) were added to make the analysis user-friendly and business-ready.

🔹 SQL (PostgreSQL) Analysis

Using PostgreSQL, I created all dimension and fact tables and loaded the data into the database. I wrote SQL queries to:

Perform joins between fact and dimension tables

Calculate total sales, total profit, production cost, and gross amount

Analyze sales by year, month, and quarter

Count distinct products and customers

Validate calculations done in Excel and Power BI

SQL was mainly used for data validation, transformation, and time-based analysis.

🔹 Power BI Dashboard

In Power BI, I built an interactive dashboard with KPIs such as Total Sales, Total Profit, Total Products, and Total Customers.
DAX measures were created for:

Gross Amount

Production Cost

Unit Discount

Profit

Visuals included:

Year-wise and month-wise sales trends

Quarter-wise performance

Product-wise and customer-wise analysis

Sales by territory

Slicers were added to allow dynamic filtering by year, product, and region.

🔹 Tableau Visualization

In Tableau, I recreated key dashboards with a strong focus on visual storytelling. Clean layouts and intuitive charts were designed to highlight sales trends, profitability, and product performance for business users.

🔹 Key Outcome

This project demonstrates practical skills in:

Data cleaning and modeling

SQL querying and calculations

Business KPI creation

Dashboard design and storytelling

It reflects a real-world business analytics workflow from raw data to insights and decision-ready dashboards.
