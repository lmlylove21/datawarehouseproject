/*
====================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
====================================================================================

Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the BULK INSERT command to load data from csv files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
====================================================================================
*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create or alter  procedure [bronze].[load_bronze]
AS
BEGIN
Declare @start_time datetime, @end_time datetime,@batch_start_time datetime,@batch_end_time datetime;
set @batch_start_time=Getdate();
begin try

print'======================================'
print'Loading Bronze Layer'
print'======================================'

print'-------------------------------------'
print'Loading CRM Table'
print'-------------------------------------'

set @start_time =GETDATE();
print'>>Truncating Table:bronze.crm_cust_info';
truncate table bronze.crm_cust_info;
print'>>Inserting data into:bronze.crm_cust_info';
BULK INSERT bronze.crm_cust_info
FROM '/var/opt/mssql/data/cust_info.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a', 
    FIRSTROW = 2            
);
set @end_time =GETDATE();
print'>>Load Duration:' + cast(Datediff(SECOND,@start_time,@end_time) as NVARCHAR) +'second';
print'-------------------------------------'

set @start_time =GETDATE();
print'>>Truncating Table:bronze.crm_prd_info';
truncate table bronze.crm_prd_info;
print'>>Inserting data into:bronze.crm_prd_info';
BULK INSERT bronze.crm_prd_info
FROM '/var/opt/mssql/data/prd_info.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a', 
    FIRSTROW = 2  
);
set @end_time =GETDATE();
print'>>Load Duration:' + cast(Datediff(SECOND,@start_time,@end_time) as NVARCHAR) +'second';
print'-------------------------------------'


set @start_time =GETDATE();
print'>>Truncating Table:bronze.crm_sales_details';
truncate table bronze.crm_sales_details;
print'>>Inserting data into:bronze.crm_sales_details';
BULK INSERT bronze.crm_sales_details
FROM '/var/opt/mssql/data/sales_details.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a', 
    FIRSTROW = 2            
);
set @end_time =GETDATE();
print'>>Load Duration:' + cast(Datediff(SECOND,@start_time,@end_time) as NVARCHAR) +'second';
print'-------------------------------------'


print'--------------------------------------'
print'Loading ERP Tables'
print'--------------------------------------'

set @start_time =GETDATE();
print'>>Truncating Table:bronze.erp_CUST_AZ12';
truncate table bronze.erp_CUST_AZ12;
print'>>Inserting data into:bronze.erp_CUST_AZ12';
BULK INSERT bronze.erp_CUST_AZ12
FROM '/var/opt/mssql/data/CUST_AZ12.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a', 
    FIRSTROW = 2            
);
set @end_time =GETDATE();
print'>>Load Duration:' + cast(Datediff(SECOND,@start_time,@end_time) as NVARCHAR) +'second';
print'-------------------------------------'


set @start_time =GETDATE();
print'>>Truncating Table:bronze.erp_PX_CAT_G1V2';
truncate table bronze.erp_PX_CAT_G1V2;
print'>>Inserting data into:bronze.erp_PX_CAT_G1V2';
BULK INSERT bronze.erp_PX_CAT_G1V2
FROM '/var/opt/mssql/data/PX_CAT_G1V2.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a', 
    FIRSTROW = 2            
);
set @end_time =GETDATE();
print'>>Load Duration:' + cast(Datediff(SECOND,@start_time,@end_time) as NVARCHAR) +'second';
print'-------------------------------------'


set @start_time =GETDATE();
print'>>Truncating Table:bronze.erp_LOC_A101 ';
truncate table bronze.erp_LOC_A101;
print'>>Inserting data into:bronze.erp_LOC_A101';
BULK INSERT bronze.erp_LOC_A101
FROM '/var/opt/mssql/data/LOC_A101.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a', 
    FIRSTROW = 2            
);
set @end_time =GETDATE();
print'>>Load Duration:' + cast(Datediff(SECOND,@start_time,@end_time) as NVARCHAR) +'second';
print'-------------------------------------'
end try 
begin CATCH 
print'======================================='
print'Error occured during loading Bronze Layer'
print'======================================='
end catch 
END
set @batch_end_Time=getdate();
print'======================================='
print'Bronze Layer Load Completed'
print'Load Duration:'+ cast (datediff(second,@batch_start_time,@batch_end_time)as nvarchar)+'second'
GO
