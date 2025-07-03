-- このファイルに回答を記述してください
--ランダムな日付を持つ100件のデータを挿入する
CREATE OR REPLACE FUNCTION insert_random_orders(num_orders INT)
RETURNS void AS $$
DECLARE
    i INT := 0;
BEGIN
    WHILE i < num_orders LOOP
        INSERT INTO orders (order_datetime)
        VALUES (
            NOW() - (TRUNC(RANDOM() * 30) || ' days')::interval
        );
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

--注文明細データを各注文につき1-3件登録
CREATE OR REPLACE FUNCTION insert_random_order_details()
RETURNS void AS $$
DECLARE
    o RECORD;
    p_count INT;
    p_id INT;
BEGIN
    FOR o IN SELECT order_id FROM orders LOOP
        p_count := (TRUNC(RANDOM() * 3) + 1)::int;

        FOR i IN 1..p_count LOOP
            SELECT product_id INTO p_id
            FROM products
            ORDER BY RANDOM()
            LIMIT 1;

            INSERT INTO order_details (order_id, product_id, quantity)
            VALUES (o.order_id, p_id, (TRUNC(RANDOM() * 10) + 1)::int);
        END LOOP;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
