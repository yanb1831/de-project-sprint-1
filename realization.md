# Витрина RFM

## 1.1. Выясните требования к целевой витрине.

Постановка задачи выглядит достаточно абстрактно - постройте витрину. Первым делом вам необходимо выяснить у заказчика детали. Запросите недостающую информацию у заказчика в чате.

Зафиксируйте выясненные требования. Составьте документацию готовящейся витрины на основе заданных вами вопросов, добавив все необходимые детали.

-----------
**Ответ:**

Витрина располагается в схеме **analysis**.

Поля витрины:
* user_id
* recency (число от 1 до 5)
* frequency (число от 1 до 5)
* monetary_value (число от 1 до 5)

Данные в витрине с начала 2022 года.

Название витрины **dm_rfm_segments**

Витрина без обновлений.

Успешный заказ имеет статус **Closed**.

## 1.2. Изучите структуру исходных данных.

Полключитесь к базе данных и изучите структуру таблиц.

Если появились вопросы по устройству источника, задайте их в чате.

Зафиксируйте, какие поля вы будете использовать для расчета витрины.

-----------

**Ответ:**  
БД состоит из:  
Таблица `orders`
* order_id - уникальный номер заказа
* order_ts - дата и время заказа
* user_id - уникальный номер клиента
* bonus_payment - надбавка/чаевые
* payment - плата
* cost - стоимость
* bonus_grant - бонусы к программе лояльности
* status - статус заказа
  
Таблица `orderitems`
* id - уникальный номер
* product_id - уникальный номер продукта
* order_id - уникальный номер заказа
* name - наименование продукта
* price - цена
* discount - скидка
* quanitity- количество

Таблица `orderstatuses`
* id - уникальный номер
* key - статус заказа
    * Open
    * Cooking
    * Delivering
    * Closed
    * Cancelled

Таблица `orderstatuslog`
* id - уникальный номер
* order_id - уникальный номер заказа
* status_id - уникальный номер статуса
* dttm - дата и время

Таблица `products`
* id - уникальный номер
* name - наименование продукта
* price - цена

Таблица `users`
* id - уникальный номер
* name - наименование клиента
* login - логин клиента


Для расчета будут использованы следующие поля:
**order_ts**,**order_id**, **user_id**, **cost**

## 1.3. Проанализируйте качество данных

Изучите качество входных данных. Опишите, насколько качественные данные хранятся в источнике. Так же укажите, какие инструменты обеспечения качества данных были использованы в таблицах в схеме production.

-----------

**Ответ:**

В таблице `users` неверно записаны данные в столбцах **login** и **name**.
В таблицах нет пустых значений.
Валюта имеет числовой тип данных с ограничением (19, 5), а не decimal (есть определенные различия).

В итоговом документе **data_quality.md** описаны, насколько качественные данные хранятся в источнике.

## 1.4. Подготовьте витрину данных

Теперь, когда требования понятны, а исходные данные изучены, можно приступить к реализации.

### 1.4.1. Сделайте VIEW для таблиц из базы production.**

Вас просят при расчете витрины обращаться только к объектам из схемы analysis. Чтобы не дублировать данные (данные находятся в этой же базе), вы решаете сделать view. Таким образом, View будут находиться в схеме analysis и вычитывать данные из схемы production. 

Напишите SQL-запросы для создания пяти VIEW (по одному на каждую таблицу) и выполните их. Для проверки предоставьте код создания VIEW.

```SQL
CREATE OR REPLACE VIEW analysis.orders_view AS
SELECT *
FROM production.orders;

CREATE OR REPLACE VIEW analysis.orderitems_view AS
SELECT *
FROM production.orderitems;

CREATE OR REPLACE VIEW analysis.orderstatuses_view AS
SELECT *
FROM production.orderstatuses;

CREATE OR REPLACE VIEW analysis.orderstatuslog_view AS
SELECT *
FROM production.orderstatuslog;

CREATE OR REPLACE VIEW analysis.products_view AS
SELECT *
FROM production.products;

CREATE OR REPLACE VIEW analysis.users_view AS
SELECT *
FROM production.users;
```

### 1.4.2. Напишите DDL-запрос для создания витрины.**

Далее вам необходимо создать витрину. Напишите CREATE TABLE запрос и выполните его на предоставленной базе данных в схеме analysis.

```SQL
CREATE TABLE analysis.dm_rfm_segments (
    user_id int NOT NULL PRIMARY KEY,
    recency int NOT NULL CHECK(recency >= 1 AND recency <= 5),
    frequency int NOT NULL CHECK(recency >= 1 AND recency <= 5),
    monetary_value int NOT NULL CHECK(recency >= 1 AND recency <= 5)
);
```

### 1.4.3. Напишите SQL запрос для заполнения витрины

Наконец, реализуйте расчет витрины на языке SQL и заполните таблицу, созданную в предыдущем пункте.

Для решения предоставьте код запроса.

```SQL
INSERT INTO analysis.dm_rfm_segments
SELECT user_id, recency, frequency, monetary_value
FROM analysis.tmp_rfm_recency
JOIN analysis.tmp_rfm_frequency USING(user_id)
JOIN analysis.tmp_rfm_monetary_value USING(user_id);
```



