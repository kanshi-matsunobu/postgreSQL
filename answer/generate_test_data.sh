#!/bin/bash
# このファイルに回答を記述してください

# ① 注文データを生成
docker exec -i sql-batch-practice-db psql -U postgres -d practice_db -c "SELECT insert_random_orders(100);"

# ② 注文明細データを生成
docker exec -i sql-batch-practice-db psql -U postgres -d practice_db -c "SELECT insert_random_order_details();"

echo "テストデータ生成が完了しました"