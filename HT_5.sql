
#Задание 1
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `first_name` varchar(100)  NOT NULL COMMENT 'Имя пользователя',
  `last_name` varchar(100)NOT NULL COMMENT 'Фамилия пользователя',
  `email` varchar(100)  NOT NULL COMMENT 'Почта',
  `phone` varchar(100)  NOT NULL COMMENT 'Телефон',
  `created_at` datetime COMMENT 'Время создания строки',
  `updated_at` datetime  COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`)
  );

  #решение1
UPDATE users SET created_at = now() ; 
UPDATE users SET updated_at = now() ; 
 

#Задание 2
DROP TABLE IF EXISTS users1;
 CREATE TABLE users1 (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `first_name` varchar(100) NOT NULL COMMENT 'Имя пользователя',
  `last_name` varchar(100) NOT NULL COMMENT 'Фамилия пользователя',
  `created_at` varchar(100) COMMENT 'Время создания строки',
  `updated_at` varchar(100)  COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`)
  );

INSERT INTO users1 (first_name , last_name, created_at, updated_at) VALUES ('Kate', 'Kashina', '20.10.2017 8:10', '20.11.2017 8:10'), ('Nikita', 'Podin', '20.11.2017 8:10', '20.12.2017 8:10');

#решение2
#сначала меняем формат стр на дату
UPDATE users1
	SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i')
;
#модификация формата varchare На datetime
ALTER TABLE users1
	MODIFY COLUMN created_at DATETIME,
	MODIFY COLUMN updated_at DATETIME
;


#Задание 3
CREATE TABLE users2 (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO
  users2 (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('Наталья', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
  ('Александр', '1985-05-20', '14.08.2016 20:10', '14.08.2016 20:10'),
  ('Сергей', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
  ('Иван', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
  ('Мария', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56');


DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO
  storehouses_products (storehouse_id, product_id, value)
VALUES
  (1, 543, 0),
  (1, 789, 2500),
  (1, 3432, 0),
  (1, 826, 30),
  (1, 719, 500),
  (1, 638, 1);

 #решение3
SELECT * FROM storehouses_products ORDER BY CASE WHEN value = 0 THEN 9999 ELSE value END;

-- Тема Операции, задание 4
-- (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в
-- августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')
-- Используйте таблицу профилей БД ВК

 #решение4
SELECT * FROM users2 WHERE birthday_at RLIKE '^[0-9]{4}-(05|08)-[0-9]{2}';
#долго не получалось, однако потом понял, что ставил месяца нужные без "0", т.е. (5 'or' 8) ))


-- Тема Операции, задание 5
-- (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2);
-- Отсортируйте записи в порядке, заданном в списке IN.

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

 #решение5
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY CASE WHEN id = 5 THEN 0 WHEN id = 1 THEN 1  ELSE 2 END;


#Практическое задание теме «Агрегация данных»
1.Подсчитайте средний возраст пользователей в таблице users.
SELECT id, round(avg(floor(datediff(curdate(),birthday_at))) / 365.25) AS 'средний возраст' FROM users2;

2.Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT  DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday_at, 6, 10))) AS day_of_birthday,
COUNT(*) AS birthday_count  FROM  users2  GROUP BY  day_of_birthday  ORDER BY  birthday_count DESC;

3.(по желанию) Подсчитайте произведение чисел в столбце таблицы.
select round(exp(sum(log(id-1)))) from users2; #у нас было 6 id, поэтому пришлось убавлять и округлять



