TRUNCATE analysis.tmp_rfm_monetary_value;
INSERT INTO analysis.tmp_rfm_monetary_value
SELECT user_id, NTILE(5) OVER(ORDER BY SUM(cost)) AS monetary_value
FROM analysis.orders_view
GROUP BY user_id;