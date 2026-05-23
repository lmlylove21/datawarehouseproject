/*
====================================================================================
Stored Procedure: Load Bronze Layer (Source -> silver)
====================================================================================

Script Purpose:
    This stored procedure loads data into the 'silver' schema from external CSV files.
    It performs the following actions:
    - Truncates the silver tables before loading data.
    - Uses the BULK INSERT command to load data from csv files to silver tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC silver.load_silver;
====================================================================================
*/


create or alter procedure silver.load_silver as
Begin
Declare @start_time datetime,@end_time datetime,@batch_start_time datetime,@batch_end_time datetime;
set @batch_start_time=getdate();
print'======================================'
print'Loading Silver Layer'
print'======================================'

print'-------------------------------------'
print'Loading CRM Table'
print'-------------------------------------'

Begin Try

    set @start_time=getdate();
    print'>>Truncating Table Info: Silver.crm_cust_info' ;
    TRUNCATE TABLE silver.crm_cust_info;
    print'>>Inserting Data Into: Silver.crm_cust_info' ;
    INSERT INTO silver.crm_cust_info (
    cust_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_marital_status,
    cst_gnder,
    cst_create_date
    )
    SELECT
    cust_id,
    cst_key,
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname,
    CASE
    WHEN UPPER (TRIM(cst_marital_status)) = 'S' THEN 'Single'
    WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
    ELSE 'n/a'
    END AS cst_marital_status,
    CASE
    WHEN UPPER(TRIM(cst_gnder)) = 'F' THEN 'Female'
    WHEN UPPER(TRIM(cst_gnder)) = 'M' THEN 'Male'
    ELSE 'n/a'
    END AS cst_gnder,
    cst_create_date
    FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY cust_id ORDER BY cst_create_date DESC ) as flag_last
    FROM bronze.crm_cust_info
    WHERE cust_id IS NOT NULL
    )a
    WHERE flag_last=1;
    set @end_time=getdate();
    print'>> Load Duration' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'second'
print'-------------------------------------'


    set @start_time =getdate();
    print'>>Truncating Table Info: Silver.crm_prd_info' ;
    TRUNCATE TABLE silver.crm_cust_info;
    print'>>Inserting Data Into: Silver.crm_prd_info' ;
    insert into silver.crm_prd_info (
    prd_id,
    cat_id,
    prd_Key,
    prd_nm,
    prd_line,
    prd_cost,
    prd_start_dt,
    prd_end_dt
    )
    select prd_id,
    replace(substring(prd_key,1,5),'-','_') as cat_id,
    substring(prd_key,7,len(prd_key)) as prd_Key,
    prd_nm,
    case when trim(Upper(prd_line))='M' then 'Mountain'
        when trim(Upper(prd_line))='S' then 'Other Sales'
        when trim(Upper(prd_line))='R' then 'Road'
        when trim(Upper(prd_line))='T' then 'Touring'
        else 'n/a'
        end as prd_line,
    isnull(prd_cost,0) as prd_cost,
    cast(prd_start_dt as date ) as prd_start_dt,
    dateadd(day,-1,lead(prd_start_dt) over (partition by prd_key order by prd_start_dt)) as prd_end_dt
    from bronze.crm_prd_info
    set @end_time=getdate()
    print'>>Load Duration' + cast(datediff(second,@start_time,@end_time)as nvarchar) +'second'
print'-------------------------------------'

    set @start_time =getdate();
    print'>>Truncating Table Info: Silver.crm_sales_details' ;
    TRUNCATE TABLE silver.crm_sales_details;
    print'>>Inserting Data Into: Silver.crm_csales_details' ;
    INSERT INTO silver.crm_sales_details (
        sls_ord_num,
        sls_prd_key,
        sls_cust_id,
        sls_order_dt,
        sls_ship_dt,
        sls_due_dt,
        sls_sales,
        sls_quantity,
        sls_price
    )
    SELECT 
        sls_ord_num,
        sls_prd_key,
        sls_cust_id,
        CASE 
            WHEN sls_order_dt = 0 OR LEN(CAST(sls_order_dt AS VARCHAR)) != 8 THEN NULL
            ELSE CONVERT(DATE, CAST(sls_order_dt AS VARCHAR), 112)
        END AS sls_order_dt,
        CASE 
            WHEN sls_ship_dt = 0 OR LEN(CAST(sls_ship_dt AS VARCHAR)) != 8 THEN NULL
            ELSE CONVERT(DATE, CAST(sls_ship_dt AS VARCHAR), 112)
        END AS sls_ship_dt,
        CASE 
            WHEN sls_due_dt = 0 OR LEN(CAST(sls_due_dt AS VARCHAR)) != 8 THEN NULL
            ELSE CONVERT(DATE, CAST(sls_due_dt AS VARCHAR), 112)
        END AS sls_due_dt,
        CASE 
            WHEN TRY_CAST(sls_sales AS DECIMAL(18,2)) IS NULL OR TRY_CAST(sls_sales AS DECIMAL(18,2)) <= 0 
                THEN TRY_CAST(sls_quantity AS DECIMAL(18,2)) * ABS(TRY_CAST(sls_price AS DECIMAL(18,2)))
            ELSE TRY_CAST(sls_sales AS DECIMAL(18,2))
        END AS sls_sales,
        TRY_CAST(sls_quantity AS DECIMAL(18,2)) AS sls_quantity,
        CASE 
            WHEN TRY_CAST(sls_price AS DECIMAL(18,2)) IS NULL OR TRY_CAST(sls_price AS DECIMAL(18,2)) <= 0
                THEN TRY_CAST(sls_sales AS DECIMAL(18,2)) / NULLIF(TRY_CAST(sls_quantity AS DECIMAL(18,2)), 0)
            ELSE TRY_CAST(sls_price AS DECIMAL(18,2))
        END AS sls_price
    FROM bronze.crm_sales_details;
    set @end_time=getdate()
    print'>>Load Duration' + cast(datediff(second,@start_time,@end_time)as nvarchar) +'second'
print'--------------------------------------'


print'======================================'
print'Loading Silver Layer'
print'======================================'

print'-------------------------------------'
print'Loading ERP Table'
print'-------------------------------------'

    set @start_time =getdate();
    print'>>Truncating Table Info: Silver.erp_cust_AZ12';
    TRUNCATE TABLE silver.erp_cust_AZ12;
    print'>>Inserting Data Into: Silver.erp_cust_AZ12';
    INSERT into silver.erp_CUST_AZ12(
        CID,
        BDATE,
        Gen
    )
    select 
        CID,
        case when BDATE_1 > getdate() then null else BDATE_1 end as BDAY,
        Gen
    from (
        SELECT 
            case when CID like 'NAS%' then substring(CID,4,len(CID)) else CID end as CID,
            cast(BDATE as date) as BDATE_1,
            CASE 
                WHEN UPPER(TRIM(REPLACE(REPLACE(Gen, CHAR(13), ''), CHAR(10), ''))) IN ('F', 'FEMALE') THEN 'Female'
                WHEN UPPER(TRIM(REPLACE(REPLACE(Gen, CHAR(13), ''), CHAR(10), ''))) IN ('M', 'MALE') THEN 'Male'
                ELSE 'N/A'
            END AS Gen
        from bronze.erp_CUST_AZ12
        where case when CID like 'NAS%' then substring(CID,4,len(CID)) else CID end in (select cst_key from silver.crm_cust_info )
    ) as a
    set @end_time=getdate()
    print'Load Duration' + cast(datediff(second,@start_time,@end_time)as nvarchar ) +'second'
print'-------------------------------------'

    set @start_time=getdate();
    print'>>Truncating Table Info: Silver.erp_PX_CAT_G1V2';
    TRUNCATE TABLE silver.erp_PX_CAT_G1V2;
    print'>>Inserting Data Into: Silver.erp_PX_CAT_G1V2';
    Insert into silver.erp_PX_CAT_G1V2 (
        id,
        cat,
        subcat,
        maintenance
    )
    select id,
    cat,
    subcat,
    maintenance
    from bronze.erp_PX_CAT_G1V2
    set @end_time=getdate()
    print'>>Load Duration' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'second'
print'-------------------------------------'
    
    set @start_time=getdate();
    print'>>Truncating Table Info: Silver.erp_LOC_A101';
    TRUNCATE TABLE silver.erp_LOC_A101 ;
    print'>>Inserting Data Into: Silver.erp_LOC_A101';
    INSERT INTO silver.erp_LOC_A101 (
        CID,
        CNTRY
    )
    SELECT
        REPLACE(CID, '-', '') AS CID,
        CASE 
            WHEN TRIM(REPLACE(REPLACE(cntry, CHAR(13), ''), CHAR(10), '')) IN ('US', 'USA') THEN 'United States'
            WHEN TRIM(REPLACE(REPLACE(cntry, CHAR(13), ''), CHAR(10), '')) = 'DE' THEN 'Germany'
            WHEN TRIM(REPLACE(REPLACE(cntry, CHAR(13), ''), CHAR(10), '')) = '' OR cntry IS NULL THEN 'n/a'
            ELSE TRIM(REPLACE(REPLACE(cntry, CHAR(13), ''), CHAR(10), ''))
        END AS CNTRY
    FROM bronze.erp_LOC_A101
    set @end_time=getdate()
    print'>>Load Duration' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'second'
print'-------------------------------------'
end TRY
begin catch 
print'error occured in loading silver layer '
print'Error Message'+Error_Message();
print'Error Message'+ cast(Error_number() as nvarchar);
print'Error Message'+ cast(Error_state() as nvarchar);
end catch
end
set @batch_end_Time=getdate();
print'======================================='
print'Silver Layer Load Completed'
print'Load Duration:'+ cast (datediff(second,@batch_start_time,@batch_end_time)as nvarchar)+'second'
GO
