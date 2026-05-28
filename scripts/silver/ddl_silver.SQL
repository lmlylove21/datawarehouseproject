/*
=========================================================================================
DDL Script: Create Silver Tables
=========================================================================================
Script Purpose:
    This script creates tables in 'silver schema' , dropping exisisting tables if they already exist.
    Run this script to  redfine the DDl Structure of 'bronze' tables
========================================================================================
*/


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[silver].[crm_cust_info]') AND type in (N'U'))
DROP TABLE [silver].[crm_cust_info]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [silver].[crm_cust_info](
	[cust_id] [int] NULL,
	[cst_key] [varchar](50) NULL,
	[cst_firstname] [varchar](50) NULL,
	[cst_lastname] [varchar](50) NULL,
	[cst_marital_status] [varchar](50) NULL,
	[cst_gnder] [varchar](50) NULL,
	[cst_create_date] [varchar](50) NULL,
	[dwh_create_date] [datetime2](7) NULL
) ON [PRIMARY]
GO
ALTER TABLE [silver].[crm_cust_info] ADD  DEFAULT (getdate()) FOR [dwh_create_date]
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[silver].[crm_prd_info]') AND type in (N'U'))
DROP TABLE [silver].[crm_prd_info]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [silver].[crm_prd_info](
	[prd_id] [int] NULL,
	[prd_key] [varchar](50) NULL,
	[cat_id] [varchar](50) NULL,
	[prd_nm] [varchar](50) NULL,
	[prd_cost] [int] NULL,
	[prd_line] [varchar](50) NULL,
	[prd_start_dt] [date] NULL,
	[prd_end_dt] [date] NULL
) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[silver].[crm_sales_details]') AND type in (N'U'))
DROP TABLE [silver].[crm_sales_details]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [silver].[crm_sales_details](
	[sls_ord_num] [varchar](50) NULL,
	[sls_prd_key] [varchar](50) NULL,
	[sls_cust_id] [int] NULL,
	[sls_order_dt] [date] NULL,
	[sls_ship_dt] [date] NULL,
	[sls_due_dt] [date] NULL,
	[sls_sales] [int] NULL,
	[sls_quantity] [int] NULL,
	[sls_price] [int] NULL,
	[dwh_create_date] [datetime2](7) NULL
) ON [PRIMARY]
GO
ALTER TABLE [silver].[crm_sales_details] ADD  DEFAULT (getdate()) FOR [dwh_create_date]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[silver].[erp_CUST_AZ12]') AND type in (N'U'))
DROP TABLE [silver].[erp_CUST_AZ12]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [silver].[erp_CUST_AZ12](
	[CID] [varchar](50) NULL,
	[BDATE] [varchar](50) NULL,
	[GEN] [varchar](50) NULL,
	[dwh_create_date] [datetime2](7) NULL
) ON [PRIMARY]
GO
ALTER TABLE [silver].[erp_CUST_AZ12] ADD  DEFAULT (getdate()) FOR [dwh_create_date]
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[silver].[erp_LOC_A101]') AND type in (N'U'))
DROP TABLE [silver].[erp_LOC_A101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [silver].[erp_LOC_A101](
	[CID] [varchar](50) NULL,
	[CNTRY] [varchar](50) NULL,
	[dwh_create_date] [datetime2](7) NULL
) ON [PRIMARY]
GO
ALTER TABLE [silver].[erp_LOC_A101] ADD  DEFAULT (getdate()) FOR [dwh_create_date]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[silver].[erp_PX_CAT_G1V2]') AND type in (N'U'))
DROP TABLE [silver].[erp_PX_CAT_G1V2]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [silver].[erp_PX_CAT_G1V2](
	[ID] [varchar](50) NULL,
	[CAT] [varchar](50) NULL,
	[SUBCAT] [varchar](50) NULL,
	[MAINTENANCE] [varchar](50) NULL,
	[dwh_create_date] [datetime2](7) NULL
) ON [PRIMARY]
GO
ALTER TABLE [silver].[erp_PX_CAT_G1V2] ADD  DEFAULT (getdate()) FOR [dwh_create_date]
GO
