# 1.3. Качество данных

## Оцените, насколько качественные данные хранятся в источнике.
Опишите, как вы проверяли исходные данные и какие выводы сделали.

## Укажите, какие инструменты обеспечивают качество данных в источнике.
Ответ запишите в формате таблицы со следующими столбцами:
- `Наименование таблицы` - наименование таблицы, объект которой рассматриваете.
- `Объект` - Здесь укажите название объекта в таблице, на который применён инструмент. Например, здесь стоит перечислить поля таблицы, индексы и т.д.
- `Инструмент` - тип инструмента: первичный ключ, ограничение или что-то ещё.
- `Для чего используется` - здесь в свободной форме опишите, что инструмент делает.


Ответ: 

| Таблицы             | Объект                      | Инструмент      | Для чего используется |
| ------------------- | --------------------------- | --------------- | --------------------- |
| production.Products | id int NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей о пользователях |
| production.Products | numeric(19, 5) NOT NULL DEFAULT 0 CHECK(price >= 0)| Ограничения  |значения равные или больше нуля, значение по умолчанию 0, в столбце могут находится 19 числовых значений, где 5 значений после запятой|
| production.OrderStatuses | id int NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей о пользователях |
| production.Users | id int NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей о пользователях |
| production.Orders | order_id int NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей о пользователях |
| production.bonus_payment | numeric(19, 5) NOT NULL DEFAULT 0 | Ограничения | без пустых значений, по умолчанию 0|
| production.payment | numeric(19, 5) NOT NULL DEFAULT 0 | Ограничения | без пустых значений, по умолчанию 0|
| production.cost | numeric(19, 5) NOT NULL DEFAULT 0 CHECK (cost = payment + bonus_payment)| Ограничения | без пустых значений, по умолчанию 0, проверка что итоговое значение сумма payment и bonus_payment|
| production.bonus_grant | numeric(19, 5) NOT NULL DEFAULT 0 | Ограничения | без пустых значений, по умолчанию 0|
| production.OrderItems | int NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY| Первичный ключ  | Обеспечивает уникальность записей о пользователях, автоматическая генерация последовательностей, без возможности внести значения |
| production.OrderItems | int NOT NULL REFERENCES production.Products(id)| Внешний ключ  | ссылается на таблицу Products столбец id |
| production.OrderItems | int NOT NULL REFERENCES production.Orders(order_id), name varchar(2048) NOT NULL | Внешний ключ  | ссылается на таблицу Products столбец order_id |
| production.OrderItems | price numeric(19, 5) NOT NULL DEFAULT 0 CHECK(price >= 0) | Ограничения  |значения равные или больше нуля, значение по умолчанию 0, в столбце могут находится 19 числовых значений, где 5 значений после запятой |
| production.OrderItems | discount numeric(19, 5) NOT NULL DEFAULT 0 CHECK(discount >= 0 AND discount <= price) | Ограничения  |значения равные или больше нуля, значение по умолчанию 0, в столбце могут находится 19 числовых значений, где 5 значений после запятой, ограничение значений больше или равно 0, но меньше или равное значениям price|
| production.OrderItems | quantity int NOT NULL CHECK(quantity > 0) | Ограничения  |значения равные или больше нуля |
| production.OrderItems | UNIQUE(order_id, product_id) | Ограничения  | уникальность значений |
| production.OrderStatusLog | id int NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY | Первичный ключ  | Обеспечивает уникальность записей о пользователях, автоматическая генерация последовательностей, без возможности внести значения |
| production.OrderStatusLog | order_id int NOT NULL REFERENCES production.Orders(order_id) | Внешний ключ  | ссылается на таблицу Orders столбец order_id |
| production.OrderStatusLog | int NOT NULL REFERENCES production.OrderStatuses(id) | Внешний ключ  | ссылается на таблицу OrderStatuses столбец id |
| production.OrderStatusLog | UNIQUE(order_id, status_id) | Ограничения  | уникальность значений |