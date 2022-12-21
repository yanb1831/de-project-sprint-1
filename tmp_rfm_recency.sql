TRUNCATE analysis.tmp_rfm_recency;
INSERT INTO analysis.tmp_rfm_recency
SELECT user_id, NTILE(5) OVER(ORDER BY status DESC, order_ts) AS recency
FROM (SELECT user_id, status, order_ts
      FROM analysis.orders_view
	  WHERE order_ts IN (SELECT MAX(order_ts)
                         FROM analysis.orders_view
                         GROUP BY user_id)) t