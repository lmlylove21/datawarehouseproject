/*
=========================================================================================
DDL Script: Create Bronze Tables
=========================================================================================
Script Purpose:
    This script creates tables in 'bronze schema' , dropping exisisting tables if they already exist.
    Run this script to  redfine the DDl Structure of 'bronze' tables
=========================================================================================
/*
-----------------------/
  IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[bronze].[crm_cust_info]') AND type in (N'U'))
    DROP TABLE [bronze].[crm_cust_info];
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [bronze].[crm_cust_info](
    [cust_id]            [int] NULL,
    [cst_key]            [varchar](50) NULL,
    [cst_firstname]      [varchar](50) NULL,
    [cst_lastname]       [varchar](50) NULL,
    [cst_marital_status] [varchar](50) NULL,
    [cst_gnder]          [varchar](50) NULL,
    [cst_create_date]    [varchar](50) NULL
) ON [PRIMARY];
GO
-----------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[bronze].[crm_prd_info]') AND type in (N'U'))
    DROP TABLE [bronze].[crm_prd_info];
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bronze].[crm_prd_info](
	[prd_id] [int] NULL,
	[prd_key] [varchar](50) NULL,
	[prd_nm] [varchar](50) NULL,
	[prd_cost] [int] NULL,
	[prd_line] [varchar](50) NULL,
	[prd_start_dt] [datetime] NULL,
	[prd_end_dt] [datetime] NULL
) ON [PRIMARY]
GO
GO
-----------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[bronze].[crm_sales_details]') AND type in (N'U'))
    DROP TABLE [bronze].[crm_sales_details];
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [bronze].[crm_sales_details](
    [sls_ord_num]  [varchar](50) NULL,
    [sls_prd_key]  [varchar](50) NULL,
    [sls_cust_id]  [int] NULL,
    [sls_order_dt] [int] NULL,
    [sls_ship_dt]  [int] NULL,
    [sls_due_dt]   [int] NULL,
    [sls_sales]    [int] NULL,
    [sls_quantity] [int] NULL,
    [sls_price]    [int] NULL
) ON [PRIMARY];
GO
-----------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[bronze].[erp_CUST_AZ12]') AND type in (N'U'))
    DROP TABLE [bronze].[erp_CUST_AZ12];
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [bronze].[erp_CUST_AZ12](
    [CID]   [varchar](50) NULL,
    [BDATE] [varchar](50) NULL,
    [GEN]   [varchar](50) NULL
) ON [PRIMARY];
GO
-----------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[bronze].[erp_LOC_A101]') AND type in (N'U'))
    DROP TABLE [bronze].[erp_LOC_A101];
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [bronze].[erp_LOC_A101](
    [CID]   [varchar](50) NULL,
    [CNTRY] [varchar](50) NULL
) ON [PRIMARY];
GO
-----------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[bronze].[erp_PX_CAT_G1V2]') AND type in (N'U'))
    DROP TABLE [bronze].[erp_PX_CAT_G1V2];
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [bronze].[erp_PX_CAT_G1V2](
    [ID]          [varchar](50) NULL,
    [CAT]         [varchar](50) NULL,
    [SUBCAT]      [varchar](50) NULL,
    [MAINTENANCE] [varchar](50) NULL
) ON [PRIMARY];
GO
