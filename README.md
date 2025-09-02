# Comprehensive Sales Analytics with PostgreSQL & Power BI

## Introduction
This project presents an **end-to-end sales analytics solution** for an online retail dataset.  
It covers the entire process: from **data modeling in PostgreSQL** to building an **interactive Power BI dashboard** that delivers actionable insights for decision-making.

---

## ETL & Data Modeling Process

### 1. Data Extraction & Loading
- Raw data (Excel/CSV) was imported into a PostgreSQL database.  
- This approach ensures efficient handling of large and complex datasets.  

### 2. Data Cleaning & Transformation
- Duplicate and null values were removed.  
- A **Star Schema** was created with Fact and Dimension tables for scalable reporting.  
- All transformations were performed using **SQL scripts**.  

### 3. Data Visualization
- Cleaned and modeled tables were connected to Power BI.  
- Built KPIs, charts, and advanced features such as:  
  - **Drill-through analysis**  
  - **Key Influencers visual**  
  - **Interactive slicers**  

---

## Tools & Technologies
- **Database**: PostgreSQL  
- **Language**: SQL (for ETL and modeling)  
- **Visualization**: Microsoft Power BI Desktop  
- **Management Tool**: pgAdmin  

---

## Data Source
The dataset used for this analysis is publicly available:  
[🔗 Data Source Link](https://archive.ics.uci.edu/dataset/352/online+retail)

---

## Features
- 📊 High-level business overview dashboard  
- 🔎 Drill-through pages for country and customer-level insights  
- 🧹 Automated data cleaning & star schema modeling  
- 📈 Trend analysis with KPIs and seasonal sales patterns  
- 👥 Customer segmentation via Tree Map and detailed tables  

---

## Dashboard Insights
- **Market Dependency**: ~81% of total sales come from the UK → concentration risk.  
- **Seasonality**: Sales peak significantly during the last months of the year.  
- **Top Customers**: A small segment of customers contributes the most to revenue.  
- **Product Concentration**: A few products generate the majority of sales.  
- **Customer Behavior**: Repeat customers account for a large share of total transactions.
---

## Drill-Through Pages
1. **Country Details** → Sales trends & top products by selected country.  
2. **Customer Details** → Purchase history, total spend, and transaction details.  

---

## How to Use
1. Clone this repository.  
2. Import the dataset into **PostgreSQL**.  
3. Run the provided SQL scripts to create and populate Fact & Dimension tables.  
4. Open the Power BI file (`.pbix`) and connect it to your PostgreSQL database.  

---

## Main Dashboard
Here is a preview of the Power BI dashboard:  

![Sales Dashboard Preview](images/Overview online retaile sales analysis.jpg)  



---

## License
This project is released under the MIT License.
