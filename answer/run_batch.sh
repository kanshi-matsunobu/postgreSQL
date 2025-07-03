#!/bin/bash
# ここに回答を記述してください

# ① バッチ集計処理
docker exec -i sql-batch-practice-db psql -U postgres -d practice_db -c "SELECT aggregate_daily_sales();"

# ② CSV出力
docker exec -i sql-batch-practice-db psql -U postgres -d practice_db -c "\COPY daily_sales_summary TO '/tmp/daily_sales_summary.csv' WITH CSV HEADER;"

# ③ コンテナからホストへコピー
docker cp sql-batch-practice-db:/tmp/daily_sales_summary.csv ./daily_sales_summary.csv

echo "バッチ処理とCSV出力が完了しました"