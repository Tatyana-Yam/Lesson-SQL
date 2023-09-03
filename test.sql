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

select product_id, type_id, 
    ROUND(((selling_price-cost_price)/cost_price*100), 3) AS murkup
from products
WHERE ROUND(((selling_price-cost_price)/cost_price* 100), 3) > 20
union all
select product_id, type_id, 
    ROUND(((selling_price-cost_price)/cost_price* 100), 3) AS murkup
from products
where type_id = 4
order by murkup desc

select max(pt.type) as type
from product_type pt
join products p
on pt.type_id = p.type_id

select pt.type, p.type_id, o.product_id
from product_type pt
full join products p
on pt.type_id = p.type_id
full join orderitems o
on p.product_id = o.product_id
where pt.type = 'Тетради'

SELECT fio
FROM clients cl
JOIN orders ord
ON cl.client_id =ord.client_id 
JOIN orderitems oi
ON ord.order_id =oi.order_id 
JOIN products p 
ON oi.product_id=p.product_id 
JOIN product_type pt 
ON p.type_id =pt.type_id 
WHERE pt.type  = 'Тетради'
ORDER BY fio

CREATE TABLE supply(supply_id INT PRIMARY KEY AUTO_INCREMENT, title VARCHAR(50), author VARCHAR(30), price DECIMAL(8, 2), amount INT);

insert into book (title, author, price, amount)
select title, author, price, amount
from supply
where author <> 'Булгаков М.А.' and author <> 'Достоевский Ф.М.';

select * from book

select employee, sum(sum) AS summ
from transactions
where type = 1
group by employee
order by sum(sum) 

INSERT INTO book (title, author, price, amount)
SELECT title, author, price, amount
FROM supply
WHERE author not in (
    SELECT author
    FROM book
    );
    
SELECT *
FROM book

UPDATE book
SET price = 0.9 * price
WHERE amount BETWEEN 5 and 10;

SELECT *
FROM book

select tr.shop_id, sum(tr.sum)
from transactions tr
full join discounts d
on tr.disc_id = d.discount_id
group by tr.shop_id
order by tr.shop_id 

update book
set price = price * 0.9
where buy = 0;

update book
set buy = amount
where buy > amount;
    
select *
from book

select tr.shop_id, d.value, sum(tr.sum) AS accruals
from transactions tr
join discounts d
on tr.disc_id = d.discount_id
where tr.type = 0
group by tr.shop_id, d.value
order by tr.shop_id asc, accruals desc

SELECT DATE(date) as date, COUNT(DISTINCT doc_id) AS amount
FROM transactions
WHERE DATE(date) BETWEEN '2023-05-17' AND '2023-05-19'
GROUP BY DATE(date)
ORDER BY date

update book, supply
set book.amount = book.amount + supply.amount
where book.title = supply.title and book.author = supply.author;

update book, supply
set book.price = (book.price + supply.price)/2
where book.title = supply.title and book.author = supply.author;

select transaction_id, card_id, date, sum, type, 
    employee, doc_id, cash_id, shop_id, disc_id
from transactions_1
group by transaction_id, card_id, date, sum, type, 
    employee, doc_id, cash_id, shop_id, disc_id
having count(transaction_id) > 1 and count(card_id) > 1 and
    count(date) > 1 and count(sum) > 1 and count(type) > 1 and 
    count(employee) > 1 and count(doc_id) > 1 and count(cash_id) 
    > 1 and count(shop_id) > 1 and count(disc_id) > 1
order by transaction_id asc

