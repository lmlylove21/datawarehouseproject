# Data Warehouse & Analytics Project 

Welcome to the **Data Warehouse and Analytics Project** repository!
This project demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as a portfolio project highlights industry best practices in data engineering and analytics.

-----


## Data Architecture
<img width="811" height="691" alt="image" src="https://github.com/user-attachments/assets/a4f912cc-3853-43cd-b337-5eb033726410" />

 1.**Bronze Layer:** Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.
 
 2.**Silver Layer:** This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.     
 3.**Gold Layer:** Houses business-ready data modeled into a star schema required for reporting and analytics.

----
# Project Overview 
This project involves:

 1.**Data Architecture**: Designing a Modern Data Warehouse Using Medallion Architecture Bronze, Silver, and Gold layers. 
 2.**ETL Pipelines:** Extracting, transforming, and loading data from source systems into the warehouse.   
 3.**Data Modeling:** Developing fact and dimension tables optimized for analytical queries.   
 4.**Analytics & Reporting:** Creating SQL-based reports and dashboards for actionable insights.    

🎯 This repository is an excellent resource for professionals and students looking to showcase expertise in:

    SQL Development
    Data Architect
    Data Engineering
    ETL Pipeline Developer
    Data Modeling
    Data Analytics
    🛠️ Important Links & Tools:
    Everything is for Free!

----
### 🛠️ Important Links & Tools:

 **[Datasets](https://github.com/DataWithBaraa/sql-data-warehouse-project/tree/main/datasets):** Access to the project dataset (csv files).                 
 **Docker:** Container tool used to run the Microsoft SQL Server database engine on macOS.               
 **Visual Studio Code:** The primary IDE used for writing SQL scripts and managing the repository.                      
 **SQL Server (mssql) Extension:** Extension used inside VS Code to connect to the Docker container and execute T-SQL queries.           
 **DrawIO:** Tool used to design data architecture maps, flowcharts, and relational models.        
 **[Notion Project Steps](https://www.notion.so/Data-Warehouse-Project-35f3c479a2aa880aa8f2d8742ffc4e95?source=copy_link):** Access to all project phases and tasks tracker.          

---
## Project Requirements 


### Building the Data Warehouse (Data Engineering)

#### Objective
Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

#### Specifications
- **Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation The data model to support both business stakeholders and analytics teams.



### BI: Analytics & Reporting (Data Analytics)

#### Objective
Develop SQL-based analytics to deliver detailed insights into:

**Customer Behavior**
**Product Performance**
**Sales Trends**

These insights empower stakeholders with key business metrics, enabling strategic decision-making.

## 📁 Repository Structure

```text
data-warehouse-project/
├── datasets/                    # Raw datasets used for the project
├── docs/                        # Project documentation and architecture maps
│   ├── etl.drawio               # Draw.io file showing ETL logic flow
│   ├── data_architecture.drawio # Draw.io file showing the Medallion layers
│   ├── data_catalog.md          # Catalog of datasets, definitions, and types
│   ├── data_flow.drawio         # Draw.io file for the table-to-table flow
│   ├── data_models.drawio       # Draw.io file for final production star schema
│   └── naming-conventions.md    # Consistent naming guidelines and formatting rules
├── scripts/                     # SQL scripts for ETL and data transformations
│   ├── bronze/                  # Scripts for extracting and loading raw data
│   ├── silver/                  # Scripts for cleaning and transforming data
│   └── gold/                    # Scripts for creating analytical models
├── tests/                       # Test scripts and data quality filters
├── README.md                    # Project overview and documentation main page
├── LICENSE                      # License information for the code repository
├── .gitignore                   # Files and directories to be ignored by Git
└── requirements.txt             # Dependencies and requirement tools list
## License
This project is licensed under the [MIT License) (LICENSE). You are free to use, modify, and share this project with proper attribution.

## About Me
Hi there! I'm **Somya Pal**, a BCom graduate building hands-on projects in SQL, data warehousing, and analytics to strengthen my skills in working with real-world data

