--ДЗ7 MySQL
/*--Задание 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
вводим заказы
insert into orders_products (order_id, product_id, total) select 1, id, 3 from products where id in (1,6);
insert into orders_products (order_id, product_id, total) select 2, id, 5 from products where id in (1,6);
insert into orders_products (order_id, product_id, total) select 3, id, 4 from products where id in (1,6);
insert into orders_products (order_id, product_id, total) select 4, id, 2 from products where id in (1,6); 
*/


select op.order_id AS 'Номер заказа',u.name AS 'Заказчик', p.name AS "Наименование",p.price AS 'Стоимсоть', op.total AS 'Штук', (p.price*op.total) AS 'итого'
from orders_products as op 
join products as p 
join catalogs as c  
join users as u 
on c.id=p.id and op.order_id=u.id AND op.order_id=p.id WHERE op.order_id>0 ORDER BY op.order_id ;


--Задание 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

select p.name,p.description, c.name as type, p.price from catalogs as c join products as p on c.id=p.id;


/* --апдейтики, так как вначале было много клонов и далее не понимал как привязывать, чтобы заказы не повторялись на всех
insert into orders_products (order_id, product_id, total) select 1, 2, 3 from products WHERE condition;
update orders_products SET product_id=3 from products;

update orders_products SET product_id=3 from products;
update orders_products SET product_id=3 from products;
update orders_products SET product_id=3 from products;
*/

--Задание 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат 
--английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

DROP TABLE IF EXISTS flights;
CREATE TABLE IF NOT EXISTS flights(
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(60)  NOT NULL COMMENT 'город вылета',
  `to` VARCHAR(60)  NOT NULL COMMENT 'город прибытия'
);

CREATE TABLE IF NOT EXISTS cities(
  id SERIAL PRIMARY KEY,
  label VARCHAR(60)  NOT NULL COMMENT 'метка',
  name VARCHAR(60)  NOT NULL COMMENT 'название'
);

insert into flights (`from`, `to`) values
    ('moscow', 'omsk'),
    ('novgorod', 'kazan'),
    ('irkutsk', 'moscow'),
    ('omsk', 'irkutsk'),
    ('moscow', 'kazan');
   
insert into cities (`label`, `name`) values
    ('moscow', 'Москва'),
    ('novgorod', 'Новгород'),
    ('irkutsk', 'Иркутск'),
    ('omsk', 'Омск'),
    ('kazan', 'Казань');
    
--через вложенный запрос   
SELECT id, (SELECT name FROM cities WHERE flights.`from`=label) AS 'From', (SELECT name FROM cities WHERE flights.`to`=label) AS 'To' FROM flights; 

/*
--время потратил не понимая почему так не подставляет:
SELECT flights.id, ct.name AS 'Откуда', ct.name AS 'Куда' 
FROM flights 
JOIN cities AS ct ON flights.`from`=ct.label and flights.`to`=ct.label ORDER BY flights.id; */

SELECT flights.id, cf.name AS 'Откуда', ct.name AS 'Куда' 
FROM flights 
JOIN cities AS cf ON flights.`from`=cf.label 
JOIN cities AS ct ON flights.`to`=ct.label ORDER BY flights.id;


