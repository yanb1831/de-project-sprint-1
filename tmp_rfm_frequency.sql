TRUNCATE analysis.tmp_rfm_frequency;
INSERT INTO analysis.tmp_rfm_frequency
SELECT user_id, NTILE(5) OVER(ORDER BY COUNT(order_id)) AS frequency
FROM analysis.orders_view
GROUP BY user_id;