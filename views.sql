CREATE OR REPLACE VIEW analysis.orders_view AS
SELECT *
FROM production.orders;

CREATE OR REPLACE VIEW analysis.orderitems_view AS
SELECT *
FROM production.orderitems;

CREATE OR REPLACE VIEW analysis.orderstatuses_view AS
SELECT *
FROM production.orderstatuses;

CREATE OR REPLACE VIEW analysis.products_view AS
SELECT *
FROM production.products;

CREATE OR REPLACE VIEW analysis.users_view AS
SELECT *
FROM production.users;