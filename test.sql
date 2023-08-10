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