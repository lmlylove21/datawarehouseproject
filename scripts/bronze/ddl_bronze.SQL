/*
===============================================================================
DDL SCRIPT: CREATE BRONZE TABLES
===============================================================================

Purpose:
This script creates tables in the Bronze Schema and drops existing tables
before recreation.

Usage:
Run this script to redefine the DDL structure of Bronze layer tables.

===============================================================================
*/


/*=============================================================================
  CRM CUSTOMER INFORMATION
=============================================================================*/

IF EXISTS (
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[bronze].[crm_cust_info]')
    AND type IN (N'U')
)
DROP TABLE [bronze].[crm_cust_info];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [bronze].[crm_cust_info] (
    [cust_id]              INT             NULL,
    [cst_key]              VARCHAR(50)     NULL,
    [cst_firstname]        VARCHAR(50)     NULL,
    [cst_lastname]         VARCHAR(50)     NULL,
    [cst_marital_status]   VARCHAR(50)     NULL,
    [cst_gnder]            VARCHAR(50)     NULL,
    [cst_create_date]      DATETIME        NULL
) ON [PRIMARY];
GO


/*=============================================================================
  CRM PRODUCT INFORMATION
=============================================================================*/

IF EXISTS (
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[bronze].[crm_prd_info]')
    AND type IN (N'U')
)
DROP TABLE [bronze].[crm_prd_info];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [bronze].[crm_prd_info] (
    [prd_id]           INT             NULL,
    [prd_key]          VARCHAR(50)     NULL,
    [prd_nm]           VARCHAR(50)     NULL,
    [prd_cost]         INT             NULL,
    [prd_line]         VARCHAR(50)     NULL,
    [prd_start_dt]     DATETIME        NULL,
    [prd_end_dt]       DATETIME        NULL
) ON [PRIMARY];
GO


/*=============================================================================
  CRM SALES DETAILS
=============================================================================*/

IF EXISTS (
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[bronze].[crm_sales_details]')
    AND type IN (N'U')
)
DROP TABLE [bronze].[crm_sales_details];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [bronze].[crm_sales_details] (
    [sls_ord_num]      VARCHAR(50)     NULL,
    [sls_prd_key]      VARCHAR(50)     NULL,
    [sls_cust_id]      VARCHAR(50)     NULL,
    [sls_order_dt]     VARCHAR(50)     NULL,
    [sls_ship_dt]      VARCHAR(50)     NULL,
    [sls_due_dt]       VARCHAR(50)     NULL,
    [sls_sales]        VARCHAR(50)     NULL,
    [sls_quantity]     VARCHAR(50)     NULL,
    [sls_price]        VARCHAR(50)     NULL
) ON [PRIMARY];
GO


/*=============================================================================
  ERP CUSTOMER DATA
=============================================================================*/

IF EXISTS (
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[bronze].[erp_CUST_AZ12]')
    AND type IN (N'U')
)
DROP TABLE [bronze].[erp_CUST_AZ12];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [bronze].[erp_CUST_AZ12] (
    [CID]          VARCHAR(50)     NULL,
    [BDATE]        DATETIME        NULL,
    [GEN]          VARCHAR(50)     NULL
) ON [PRIMARY];
GO


/*=============================================================================
  ERP LOCATION DATA
=============================================================================*/

IF EXISTS (
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[bronze].[erp_LOC_A101]')
    AND type IN (N'U')
)
DROP TABLE [bronze].[erp_LOC_A101];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [bronze].[erp_LOC_A101] (
    [CID]          VARCHAR(50)     NULL,
    [CNTRy]        VARCHAR(50)     NULL
) ON [PRIMARY];
GO


/*=============================================================================
  ERP PRODUCT CATEGORY DATA
=============================================================================*/

IF EXISTS (
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[bronze].[erp_PX_CAT_G1V2]')
    AND type IN (N'U')
)
DROP TABLE [bronze].[erp_PX_CAT_G1V2];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [bronze].[erp_PX_CAT_G1V2] (
    [ID]            VARCHAR(50)     NULL,
    [CAT]           VARCHAR(50)     NULL,
    [SUBCAT]        VARCHAR(50)     NULL,
    [MAINTENANCE]   VARCHAR(50)     NULL
) ON [PRIMARY];
GO

