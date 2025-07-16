-- このファイルに回答を記述してください
CREATE OR REPLACE FUNCTION aggregate_daily_sales()
RETURNS void AS $$
BEGIN
    DELETE FROM daily_sales_summary;

    INSERT INTO daily_sales_summary (summary_date, product_id, total_quantity_sold, total_sales_amount)
    SELECT
        DATE(o.order_datetime) AS summary_date,
        p.product_id,
        SUM(od.quantity) AS total_quantity_sold,
        SUM(p.price * od.quantity) AS total_sales_amount
    FROM
        orders o
        JOIN order_details od ON o.order_id = od.order_id
        JOIN products p ON od.product_id = p.product_id
    GROUP BY
        DATE(o.order_datetime),
        p.product_id
    ORDER BY
        summary_date,
        p.product_id;
END;
$$ LANGUAGE plpgsql;