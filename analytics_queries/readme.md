# Analytics Queries

This folder contains analytical SQL queries written on the Gold Layer of the data warehouse to generate business insights related to customers, products, revenue trends, profitability, and regional sales performance.

These queries were created to strengthen analytical SQL skills and demonstrate how warehouse data can be used for business reporting and decision-making.

---

## 1. Top Customers by Revenue

```sql
SELECT TOP 10
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    SUM(s.sales) AS total_revenue
FROM gold.fact_sales AS s
INNER JOIN gold.dim_customers AS c
    ON c.customer_key = s.customer_key
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC;
```

---

## 2. Revenue & Profit by Category

```sql
SELECT 
    p.category,
    SUM(s.sales) AS total_revenue,
    SUM(s.sales - (s.quantity * p.cost)) AS profit,
    ROUND(
        SUM(s.sales - (s.quantity * p.cost)) * 100.0 / SUM(s.sales),
        2
    ) AS profit_margin_percentage
FROM gold.fact_sales AS s
JOIN gold.dim_products AS p 
    ON p.product_key = s.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;
```

---

## 3. Monthly Sales Revenue Analysis

```sql
SELECT 
    FORMAT(order_date, 'yyyy-MM') AS order_month,
    SUM(sales) AS total_revenue
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY total_revenue DESC;
```

---

## 4. Most Profitable Products

```sql
SELECT 
    p.product_name,
    SUM(s.sales) AS total_revenue,
    SUM(s.sales - (s.quantity * p.cost)) AS profit,
    ROUND(
        SUM(s.sales - (s.quantity * p.cost)) * 100.0 / SUM(s.sales),
        2
    ) AS profit_margin_percentage
FROM gold.fact_sales AS s
JOIN gold.dim_products AS p 
    ON p.product_key = s.product_key
GROUP BY p.product_name
ORDER BY profit DESC;
```

---

## 5. Repeat Customers Analysis

```sql
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    COUNT(DISTINCT s.order_number) AS total_orders,
    SUM(s.sales) AS total_revenue
FROM gold.fact_sales AS s
JOIN gold.dim_customers AS c
    ON c.customer_key = s.customer_key
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
HAVING COUNT(DISTINCT s.order_number) > 1
ORDER BY total_orders DESC;
```

---

## 6. Regional Sales Performance

```sql
SELECT 
    c.country,
    SUM(s.sales) AS total_revenue,
    SUM(s.sales - (s.quantity * p.cost)) AS total_profit,
    COUNT(DISTINCT s.order_number) AS total_orders
FROM gold.fact_sales AS s
JOIN gold.dim_customers AS c
    ON c.customer_key = s.customer_key
JOIN gold.dim_products AS p
    ON p.product_key = s.product_key
GROUP BY c.country
ORDER BY total_revenue DESC;
```

---

## 7. Yearly Sales Growth

```sql
SELECT 
    YEAR(order_date) AS sales_year,
    SUM(sales) AS total_revenue,
    COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY sales_year;
```
