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
    WHEN position IN ('Senior Conultant', 'Consultant') THEN 'Can Seles and Consulting'
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

    
    
    
    
    