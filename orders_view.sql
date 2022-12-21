CREATE OR REPLACE VIEW analysis.orders AS
SELECT o.order_id,
	   o.order_ts,
	   o.user_id,
	   o.bonus_payment,
	   o.payment,
	   o.cost,
	   o.bonus_grant,
	   LAST_VALUE(osl.status_id) OVER (PARTITION BY osl.order_id ORDER BY osl.dttm ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS status
FROM production.orders o
JOIN production.OrderStatusLog osl USING(order_id)