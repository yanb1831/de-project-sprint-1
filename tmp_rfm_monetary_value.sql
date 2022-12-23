TRUNCATE analysis.tmp_rfm_monetary_value;
INSERT INTO analysis.tmp_rfm_monetary_value
SELECT uv.id AS user_id, NTILE(5) OVER(ORDER BY CASE WHEN c.order_sum IS NULL THEN 0 ELSE c.order_sum END) AS monetary_value
FROM (SELECT user_id, MAX(order_ts) AS order_last, SUM(COST) AS order_sum, COUNT(order_id) AS order_count
	  FROM analysis.orders_view
	  WHERE order_ts >= '2022-01-01 00:00:00' AND status = 4
	  GROUP BY user_id) c
RIGHT JOIN analysis.users_view uv ON c.user_id=uv.id;