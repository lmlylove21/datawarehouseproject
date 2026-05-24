/*
================================================================
DDL Script Create Gold Views
================================================================
Script Purpose:

This script creates views for the Gold layer in the data warehouse. The Gold layer represents the final dimension and fact tables (Star Schema)

Each view performs transformations and combines data from the Silver layer to produce a clean, enriched, and business-ready dataset.

Usage:
These views can be queried directly for analytics and reporting.
================================================================
*/

--===============================================================
--Create Dimension: gold.dim_customersDROP VIEW [gold].[dim_customers]
--===============================================================
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [gold].[dim_customers] as 
select
Row_number() over (order by c1.cust_id) as customer_key,
c1.cust_id as customer_id,
c1.cst_key as customer_number,
c1.cst_firstname as first_name,
c1.cst_lastname as last_name,
c1.cst_marital_status as marital_status,
case when  c1.cst_gnder!='n/a' then c1.cst_gnder
else coalesce(cu.gen,'n/a')
end as gender,
c1.cst_create_date as create_date,
l1.cntry as country,
cu.BDATE as birth_date
from silver.crm_cust_info as c1
left join silver.erp_LOC_A101 as l1
on C1.cst_key=l1.CID
left join silver.erp_CUST_AZ12 as cu
on c1.cst_key=cu.CID
GO
---------------------------

DROP VIEW [gold].[dim_customers]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [gold].[dim_products] AS
select row_number() over(order by pn.prd_start_dt,pn.prd_key) as product_key,
    pn.prd_id as product_id,
    pn.cat_id as category_id,
    pn.prd_key as product_number ,
    pn.prd_nm product_name,
    px.cat as category,
    px.SUBCAT as subcategory,
    px.MAINTENANCE, 
    pn.prd_cost as cost,
    pn.prd_line as product_line,
    pn.prd_start_dt start_date
from silver.crm_prd_info as pn
left join silver.erp_PX_CAT_G1V2 as px
on pn.cat_id=px.id
where pn.prd_end_dt is null --filter out historical data 
GO
--------------------------------
DROP VIEW [gold].[dim_customers]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [gold].[fact_sales] as
select 
sd.sls_ord_num as order_number,
pr.product_key ,--dimesion key
cu.customer_key,--dimension key
sd.sls_order_dt as order_date,
sd.sls_ship_dt as ship_date,
sd.sls_due_dt as due_date,
sd.sls_sales as sales,
sd.sls_quantity as quantity,
sd.sls_price as price
from silver.crm_sales_details sd
left join gold.dim_products pr
on pr.product_number =sd.sls_prd_key
left join gold.dim_customers cu
on sd.sls_cust_id=cu.customer_id
GO
