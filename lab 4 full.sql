DROP DATABASE IF EXISTS company;

CREATE DATABASE company;
USE company;

CREATE TABLE IF NOT EXISTS `department` (
    `department_id` INT NOT NULL,
    `department_name` VARCHAR(30) NOT NULL,
    `city` VARCHAR(30) NOT NULL DEFAULT 'Lviv',
    `street` VARCHAR(50) NOT NULL,
    `building_no` INT(4),
    PRIMARY KEY (`department_id`)
);

CREATE TABLE IF NOT EXISTS `employee` (
    `employee_id` INT AUTO_INCREMENT NOT NULL,
    `user_name` VARCHAR(30) NOT NULL UNIQUE,
    `first_name` VARCHAR(30) NOT NULL,
    `last_name` VARCHAR(30) NOT NULL,
    `position` VARCHAR(30) NOT NULL,
    `employment_date` DATE NOT NULL,
    `department_id` INT,
    `manager_id` INT,
    `rate` FLOAT NOT NULL,
    `bonus` FLOAT,
    PRIMARY KEY (`employee_id`)
);

CREATE TABLE IF NOT EXISTS `product` (
    `product_id` INT NOT NULL,
    `product_name` VARCHAR(40) NOT NULL,
    `product_description` VARCHAR(150) NOT NULL,
    `category` VARCHAR(15) NOT NULL,
    `manufacture` VARCHAR(30) NOT NULL,
    `product_type` VARCHAR(15) NOT NULL,
    `amount` INT NOT NULL,
    `price` FLOAT NOT NULL,
    PRIMARY KEY (`product_id`)
);

CREATE TABLE IF NOT EXISTS `customer` (
    `customer_id` INT AUTO_INCREMENT NOT NULL,
    `first_name` VARCHAR(30) NOT NULL,
    `last_name` VARCHAR(30) NOT NULL,
    `gender` VARCHAR(1) NOT NULL,
    `birth_date` DATE NOT NULL,
    `phone_number` BIGINT(15) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `discount` INT NOT NULL,
    PRIMARY KEY (`customer_id`)
);

CREATE TABLE IF NOT EXISTS `invoice` (
    `invoice_id` BIGINT(15) NOT NULL,
    `employee_id` INT NOT NULL,
    `customer_id` INT,
    `payment_method` INT NOT NULL,
    `transaction_moment` DATETIME NOT NULL,
    `status` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`invoice_id`)
);

CREATE TABLE IF NOT EXISTS `orders` (
    `orders_id` INT AUTO_INCREMENT NOT NULL,
    `employee_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `invoice_id` BIGINT(15) NOT NULL,
    `invoice_datatime` DATETIME NOT NULL,
    `quantity` INT NOT NULL,
    PRIMARY KEY (`orders_id`)
);

ALTER TABLE `employee`
    ADD CONSTRAINT `employee_fk_department`
    FOREIGN KEY (`department_id`) REFERENCES `department`(`department_id`);

ALTER TABLE `employee`
    ADD CONSTRAINT `employee_fk_manager`
    FOREIGN KEY (`manager_id`) REFERENCES `employee`(`employee_id`);

ALTER TABLE `invoice`
    ADD CONSTRAINT `invoice_fk_employee`
    FOREIGN KEY (`employee_id`) REFERENCES `employee`(`employee_id`);

ALTER TABLE `orders`
    ADD CONSTRAINT `orders_fk_employee`
    FOREIGN KEY (`employee_id`) REFERENCES `employee`(`employee_id`);

ALTER TABLE `orders`
    ADD CONSTRAINT `orders_fk_product`
    FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`);

ALTER TABLE `orders`
    ADD CONSTRAINT `orders_fk_customer`
    FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`);

ALTER TABLE `orders`
    ADD CONSTRAINT `orders_fk_invoice`
    FOREIGN KEY (`invoice_id`) REFERENCES `invoice`(`invoice_id`);
    
    
    
    
    USE company;


ALTER TABLE `orders`
    DROP FOREIGN KEY `orders_fk_employee`;

ALTER TABLE `orders`
    DROP FOREIGN KEY `orders_fk_customer`;



ALTER TABLE `orders`
    DROP COLUMN `employee_id`,
    DROP COLUMN `customer_id`;



ALTER TABLE `invoice`
    ADD CONSTRAINT `invoice_fk_customer`
    FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`);
    
    
    
    SELECT * FROM department;
    SELECT * FROM employee;
    SELECT * FROM customer;
    SELECT * FROM product;
    SELECT * FROM invoice;
    SELECT * FROM orders;
    
    USE company;
    SELECT *
    FROM employee;
    
    SELECT employee_id, first_name , last_name, position 
    FROM employee
    LIMIT 7;
    
    SELECT DISTINCT position 
    FROM employee
    ORDER by position DESC;
    
    SELECT employee_id, last_name, first_name, position, employment_date
    FROM employee 
    WHERE ( position = 'Seller'
    OR 
    
    position = 'Consultant'
    )
    AND  employment_date > '2013-01-01'
    ORDER by employment_date DESC;
    
    -- Solution 1 
    SELECT last_name, first_name, position, employment_date 
    FROM employee
    WHERE (
    position like 'Seller'
    OR 
    position in ('Senior Consultant', 'Consultant')
)
AND employment_date > '2013-01-01'
Order by employment_date DESC;

-- Solution 2 
    SELECT last_name, first_name, position, employment_date 
    FROM employee
    Where ( position like 'S______'
    OR
    ( position like   '%Consultant'
    AND 
    position NOT LIKE 'A%'
    )) 
    AND employment_date > '2013-01-01'
    Order by employment_date DESC;
    
    SELECT employee_id, last_name, first_name, position, manager_id,department_id
    FROM employee
    WHERE manager_id IS NULL
    OR department_id IS NOT NULL 
	Order by manager_id ASC;
    
    -- Solution 1 
    SELECT last_name, first_name, position, employment_date, bonus 
    FROM employee
    WHERE  bonus IS NOT NULL 
    AND ( 
    employment_date > '2015-12-31'
    and 
    employment_date < '2020-12-31'
    )
    Order by last_name ASC;
    
    -- Solution 2 
    SELECT last_name, first_name, position, employment_date, bonus
    FROM employee 
    WHERE bonus IS NOT NULL
    AND 
    employment_date
    BETWEEN '2015-12-31'
    AND '2016-12-31'
    Order by last_name ASC;
    
    SELECT -- employee_id, 
    last_name, first_name, position,
    CASE
    WHEN position = 'Senior Consultant' THEN 'Can Seles, Consulting and Lead'
    WHEN position IN ('Senior Consultant', 'Consultant') THEN 'Can Seles and Consulting'
    WHEN position like 	'Assistant Consultant' THEN 'Can only Consulting'
    WHEN position LIKE 'Seller' THEN 'Can only Sale'
    ELSE 'Service Roles'
    END AS 'Relation to Customer'
    FROM employee 
    Order by last_name;
    
    SELECT 
    -- employee_id,
    last_name "Last Name",
    first_name 'First Name',
    position Title,
    employment_date AS 'Hire Date'
    From employee;
    
    -- домашка
    -- Дізнайтеся, які клієнти були зареєстровані в нашій компанії (показати всі доступні поля). Відсортуйте 
-- список за Прізвищем.
    USE company;
    SELECT *
    FROM customer 
    Order by last_name ASC;
    
    -- Вивести унікальні назви виробників (manufacture ) з таблиці продуктів в одному запиті, впорядкованому
-- за алфавітом

SELECT DISTINCT manufacture
FROM product
ORDER BY manufacture ASC;
	
-- Отримати коротку інформацію про продукти (назва_продукту, виробник, категорія, тип_продукту, ціна),
-- ироблені компанією 'DELL', з таблиці продуктів в одному запиті, впорядкованому за назвою продукту в	
-- алфавітному порядку. 

SELECT product_name, manufacture, category, product_type, price
FROM product
WHERE manufacture = 'DELL'
ORDER BY product_name ASC;

-- Отримати інформацію про клієнтів-жінок 1990-2000 років народження (ім'я, прізвище, стать, дата
-- народження, номер телефону) з таблиці customer в одному запиті, відсортовану за прізвищем в
-- алфавітному порядку.
SELECT first_name, last_name, gender, birth_date, phone_number
FROM customer
WHERE gender = 'F'
AND birth_date BETWEEN '1990-01-01' AND '2000-12-31'
ORDER BY last_name ASC;

-- Отримати інформацію з таблиці товарів про наявні на складі ноутбуки, які оснащені дисковими
-- накопичувачами об'ємом 512 ГБ.

SELECT *
FROM product
WHERE category = 'NOTEBOOK'
AND product_description LIKE '%512GB%'
AND amount > 0;

-- Отримати інформацію з таблиці товарів про наявні на складі ноутбуки або настільні комп'ютери, які
-- оснащені дисковими накопичувачами 512 ГБ або 1 ТБ.

SELECT *
FROM product
WHERE category IN ('NOTEBOOK', 'Desktops')
AND (product_description LIKE '%512GB%' OR product_description LIKE '%1TB%')
AND amount > 0;

-- Отримати інформацію з таблиці рахунків-фактур (invoice ) про всі покупки, зроблені неавторизованими
-- покупцями (customer_id NULL).
SELECT *
FROM invoice
WHERE customer_id IS NULL;

-- zavdanya
SELECT * 
FROM product
WHERE category IN ('Desktops')
AND (product_description LIKE '%DELL%' AND  product_description LIKE '%I3%')
OR (
 category IN ('Desktops')
AND (product_description LIKE '%I7%')
AND amount > 20
)
ORDER BY price ASC
LIMIT 50;

SELECT * 
FROM product
WHERE category IN ('Desktops');




-- lab 5 

USE company;
SELECT
employee_id "Manager ID",
last_name "Manager Last Name",
first_name "Manager First Name",
position 'Manager Title',
employment_date AS 'Manager Hire Date'
FROM 
employee AS Managers 
WHERE 
position IN ('CEO', 'Manager');

SELECT 
e.employee_id "Employee ID",
e.last_name "Employee Last Name",
e.first_name 'Employee First Name',
e.position 'Employee Title',
e.employment_date AS 'Employee Hire Date',
e.manager_id "Employee Manager ID",
m.employee_id "Manager ID",
m.last_name "Manager Last Name",
m.first_name 'Manager First Name',
m.position 'Manager Title',
m.employment_date AS 'Manager Hire Date'
FROM 
employee AS e,
employee AS m
WHERE 
e.manager_id = m.employee_id;


SELECT 
e.employee_id "Employee ID",
e.last_name "Employee Last Name",
e.first_name 'Employee First Name',
e.position 'Employee Title',
e.department_id "Employee Department ID",
d.department_id "Department ID",
d.department_name "Department name"
FROM 
employee AS e,
department AS d
WHERE 
e.department_id = d.department_id;


SELECT 
e.employee_id "Employee ID",
e.last_name "Employee Last Name",
e.first_name 'Employee First Name',
e.position 'Employee Title',
i.employee_id "Invoice Employee ID",
i.invoice_id 'Invoice',
i.transaction_moment 'Transaction moment'
FROM 
employee AS e 
JOIN 
invoice AS i
ON 
e.employee_id = i.employee_id
ORDER By
i.transaction_moment;


SELECT 
e.employee_id "Employee ID",
e.last_name "Employee Last Name",
e.first_name 'Employee First Name',
e.position 'Employee Title',
i.employee_id "Invoice Employee ID",
i.invoice_id 'Invoice',
i.customer_id 'Invoice Customer ID',
i.transaction_moment 'Transaction moment',
c.customer_id 'Customer ID',
c.last_name 'Customer Last Name',
c.first_name 'Customer First Name'
FROM 
employee AS e
NATURAL JOIN 
invoice AS i
JOIN 
customer AS c
USING (customer_id)
ORDER BY
i.transaction_moment;

SELECT 
e.employee_id "Employee ID",
e.last_name "Employee Last Name",
e.first_name 'Employee First Name',
e.position 'Employee Title',
i.employee_id "Invoice Employee ID",
i.invoice_id 'Invoice',
i.customer_id 'Invoice Customer ID',
i.transaction_moment 'Transaction moment',
c.customer_id 'Customer ID',
c.last_name 'Customer Last Name',
c.first_name 'Customer First Name'
FROM 
employee AS e 
NATURAL JOIN 
invoice AS i
LEFT JOIN 
customer AS c 
USING (customer_id)
WHERE customer_id IS NULL
ORDER BY 
i.transaction_moment;

SELECT
-- Employee as e 
e.employee_id 'Employee id',
e.last_name 'Employee Last Name',
e.first_name 'Employee First Name',
e.position 'Employee position',
e.manager_id 'Employee Manager Id',
e.department_id 'Employee department_id',
-- Manager as m 
m.employee_id 'Manager ID',
m.last_name ' Manager Last Name',
m.first_name ' Manager First Name',
m.position 'Manager position',
m.department_id 'Manager Department Id',
-- department as d 
d.department_id ' Department ID',
d.department_name 'Department Name',
d.city ' Department City'
FROM 
department as d 
Right join  
employee as e 
ON 
e.department_id = d.department_id
Left join 
employee as m 
ON e.manager_id = m.employee_id;

SELECT 
employee_id,
first_name,
last_name,
position,
'Consulting' as Responsibility 
FROM 
employee 
WHERE 
position like '%Consultant%'
UNION 
SELECT 
employee_id,
first_name,
last_name,
position, 'Not Consulting'
FROM 
employee
WHERE 
position NOT LIKE '%Consultant%'
Order BY last_name;
-- LAB 5 DZ 


-- zavd 1 
SELECT
  o.orders_id AS 'Orders ID',
  p.product_name AS 'Product name',
  p.category AS 'Product category',
  i.invoice_id AS 'Invoice ID',
  i.transaction_moment AS 'Transaction moment',
  c.last_name AS 'Customer last name',
  c.first_name AS 'Customer first name'
FROM orders o 
JOIN
  product p ON o.product_id = p.product_id
JOIN
  invoice i ON o.invoice_id = i.invoice_id
 JOIN 
  customer c ON i.customer_id = c.customer_id   
ORDER BY o.orders_id;

-- zavd 2 
SELECT
    o.orders_id AS 'Orders ID',
    p.product_name AS 'Product name',
    p.category AS 'Product category',
    i.invoice_id AS 'Invoice ID',
    i.transaction_moment AS 'Transaction moment',
    c.last_name AS 'Customer last name',
    c.first_name AS 'Customer first name'
FROM orders o
JOIN product p ON o.product_id = p.product_id         
JOIN invoice i ON o.invoice_id = i.invoice_id         
JOIN customer c ON i.customer_id = c.customer_id     
JOIN employee e ON i.employee_id = e.employee_id     
JOIN department d ON e.department_id = d.department_id 
WHERE d.department_name = 'Mercury'                   
  AND o.order_datetime BETWEEN '2023-07-01' AND '2023-10-01'
ORDER BY o.orders_id;

-- zavd 3 
SELECT
    c.customer_id AS 'Customer ID',
    c.last_name AS 'Last Name',
    c.first_name AS 'First Name',
    i.invoice_id AS 'Invoice ID',
    i.transaction_moment AS 'Transaction Moment'
FROM customer c
LEFT JOIN invoice i ON c.customer_id = i.customer_id

UNION

SELECT
    c.customer_id AS 'Customer ID',
    c.last_name AS 'Last Name',
    c.first_name AS 'First Name',
    i.invoice_id AS 'Invoice ID',
    i.transaction_moment AS 'Transaction Moment'
FROM customer c
RIGHT JOIN invoice i ON c.customer_id = i.customer_id

ORDER BY `Invoice ID`;







    
    