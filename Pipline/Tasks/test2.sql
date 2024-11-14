WITH SalesData AS (
    SELECT 
        p.product_id,
        p.product_name,
        SUM(s.quantity_sold) AS total_quantity_sold
    FROM 
        sales s
    JOIN 
        products p ON s.product_id = p.product_id
    WHERE 
        s.sale_date >= DATEADD(month, -1, GETDATE())
    GROUP BY 
        p.product_id, p.product_name
),
RankedProducts AS (
    SELECT 
        product_id,
        product_name,
        total_quantity_sold,
        RANK() OVER (ORDER BY total_quantity_sold DESC) AS sales_rank
    FROM 
        SalesData
)
SELECT 
    product_id,
    product_name,
    total_quantity_sold
FROM 
    RankedProducts
WHERE 
    sales_rank <= 5;= 5;