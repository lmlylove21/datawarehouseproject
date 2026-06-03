```sql
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
```

