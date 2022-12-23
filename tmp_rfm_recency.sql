TRUNCATE analysis.tmp_rfm_recency;
INSERT INTO analysis.tmp_rfm_recency
SELECT uv.id AS user_id, NTILE(5) OVER(ORDER BY CASE WHEN c.order_last IS NULL THEN '2022-01-01 00:00:00' ELSE c.order_last END) AS recency
FROM (SELECT user_id, MAX(order_ts) AS order_last, SUM(COST) AS order_sum, COUNT(order_id) AS order_count
	  FROM analysis.orders_view
	  WHERE order_ts >= '2022-01-01 00:00:00' AND status = 4
	  GROUP BY user_id) c
RIGHT JOIN analysis.users_view uv ON c.user_id=uv.id;