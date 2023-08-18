use test;
create TABLE book(
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8, 2),
    amount INT
    );
 INSERT INTO book(title, author, price, amount)
VALUES('Мастер и Маргарита', 'Булгаков М.А.', 670.99, 3); 
INSERT INTO book(title, author, price, amount)
VALUES('Белая гвардия', 'Булгаков М.А.', 540.50, 5);
INSERT INTO book(title, author, price, amount)
VALUES('Идиот', 'Достоевский Ф.М.', 460.00, 10);
INSERT INTO book(title, author, price, amount)
VALUES('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 2);   

select *
from book;

insert into book(title, author, price, amount)
values('Игрок', 'Достоевский Ф.М.', 480.50, 10);
insert into book(title, author, price, amount)
values('Стихотворения и поэмы', 'Есенин С.А.', 650.00, 15);

SELECT distinct amount
FROM book;

insert into book(title, author, price, amount)
values('Черный человек', 'Есенин С.А.', null, null);

select author, count(author), count(amount), count(*)
from book
group by author;

SELECT author AS Автор, COUNT(author) AS Различных_книг, SUM(amount) AS Количество_экземпляров
FROM book
GROUP BY author;

SELECT author, MIN(price) AS Минимальная_цена, MAX(price) AS Максимальная_цена, round(AVG(price)) AS Средняя_цена
FROM book
GROUP BY author;

SELECT author, sum(price*amount) AS Стоимость, ROUND((sum((price*amount)*0.18)/1.18), 2) AS НДС, round((sum(price*amount)/1.18), 2) AS Стоимость_без_НДС
from book
group by author;

select MIN(price) AS Минимальная_цена, MAX(price) AS Максимальная_цена, ROUND(AVG(price), 2) AS Средняя_цена
from book;

select ROUND(AVG(price), 2) AS Средняя_цена, sum(price*amount) AS Стоимость
from book
GROUP BY amount
HAVING amount between 5 and 14

select author, sum(price*amount) AS Стоимость
from book
where title <> 'Идиот' and title <> 'Белая гвардия'
group by author
having sum(price*amount)>5000
order by Стоимость desc;

select author, price, amount, round((price*1.15), 2) AS new_price
from book

select author, sum(price*1.15*amount) AS planning_price
from book
where amount > 5
group by author
order by planning_price desc;

select author, title, price
from book
where price <=(
    select ROUND(avg(price), 2)
    from book)
order by price desc;

select *
from book

select product_id, type_id, cost_price
from products
order by type_id asc, cost_price desc

select product_id, type_id
from products
where type_id <> 3
order by type_id asc

select author, title, price
from book
where ABS(price - (select min(price)
                from book))> 150
 order by price asc;
 
select client_id, fio, email, length(email) as length
from clients
where length(email) > 15 and length(email) < 20
order by length

select product_id, type_id, selling_price
from products
where (type_id = 1 and selling_price between 50 and 80) 
    or (type_id = 3 and selling_price < 50)
order by selling_price desc

select product_id, info
from products
where info is not null
order by product_id

select client_id, email
from clients
where email like '%b%' and (email like '%@hotmail.com' 
    or email like '%@gmail.com')
order by client_id 

select author, title, amount, count(amount) 
from book
where amount in 

select author, title, amount
FROM book
WHERE amount IN (
    select amount
    from book
    group by amount
    having count(amount) = 1
    );
    
select author, title, price
FROM book
WHERE price < ANY (select min(price)
    from book
    group by author
    );
    
select pt.type_id
from products p
right join product_type pt
on p.type_id = pt.type_id 
where p.type_id is null
order by pt.type_id desc

select pt.type
from product_type pt
left join products p
on pt.type_id = p.type_id
left join orderitems o
on p.product_id = o.product_id
where o.product_id is null
order by pt.type asc

SELECT pt.type  AS type
FROM orderitems o
JOIN products p  ON o.product_id = p.product_id 
RIGHT JOIN product_type pt  ON p.type_id = pt.type_id 
WHERE o.product_id  IS NULL
ORDER BY type

SELECT title, author, amount, ((SELECT MAX(amount) FROM book) - amount) AS Заказ
FROM book
WHERE ABS((SELECT MAX(amount) FROM book) - amount) > 0

select title, author, price, amount, (price * 1.1) AS new_price, ((price * 1.1) * amount) AS new_cost
from book
where amount > (select AVG(amount) from book)
