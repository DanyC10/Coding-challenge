create table products (
    productID int primary key,
    name varchar(30),
    description varchar(30),
    price decimal(10, 2),
    stockQuantity int
)

create table customers (
    customerID int primary key,
    firstName varchar(30),
    lastName varchar(30),
    email varchar(30),
    address varchar(30)
)

CREATE TABLE orders (
    orderID INT PRIMARY KEY,
    customerID INT,
    orderDate DATE,
    totalAmount DECIMAL(10, 2),
    FOREIGN KEY (customerID) REFERENCES customers(customerID)
)

CREATE TABLE orderItems (
    orderItemID INT PRIMARY KEY,
    orderID INT,
    productID INT,
    quantity INT,
    itemAmount DECIMAL(10, 2),
    FOREIGN KEY (orderID) REFERENCES orders(orderID),
    FOREIGN KEY (productID) REFERENCES products(productID)
)

CREATE TABLE cart (
    cartID INT PRIMARY KEY,
    customerID INT,
    productID INT,
    quantity INT,
    FOREIGN KEY (customerID) REFERENCES customers(customerID),
    FOREIGN KEY (productID) REFERENCES products(productID)
)


insert into products values(1 ,'Laptop', 'High-performance laptop', 800.00, 10),
(2 ,'Smartphone', 'Latest smartphone', 600.00, 15),
(3 ,'Tablet', 'Portable tablet' ,300.00, 20),
(4, 'Headphones' ,'Noise-canceling' ,150.00 ,30),
(5, 'TV' ,'4K Smart TV' ,900.00, 5),
(6, 'Coffee Maker',' Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator' ,'Energy-efficient' ,700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave' ,80.00, 15),
(9, 'Blender' ,'High-speed blender' ,70.00 ,20),
(10, 'Vacuum Cleaner' ,'Bagless vacuum cleaner' ,120.00 ,10)


insert into customers values(1, 'John' ,'Doe' ,'johndoe@example.com', '123 Main St, City'),
(2, 'Jane', 'Smith' ,'janesmith@example.com' ,'456 Elm St, Town'),
(3, 'Robert', 'Johnson' ,'robert@example.com' ,'789 Oak St, Village'),
(4, 'Sarah' ,'Brown' ,'sarah@example.com',' 101 Pine St, Suburb'),
(5, 'David', 'Lee', 'david@example.com', '234 Cedar St, District'),
(6, 'Laura' ,'Hall' ,'laura@example.com', '567 Birch St, County'),
(7, 'Michael' ,'Davis', 'michael@example.com' ,'890 Maple St, State'),
(8, 'Emma', 'Wilson', 'emma@example.com', '321 Redwood St, Country'),
(9,' William' ,'Taylor', 'william@example.com', '432 Spruce St, Province'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '765 Fir St, Territory')

insert into orders values(1, 1,'2023-01-05', 1200.00),
(2, 2 ,'2023-02-10', 900.00),
(3, 3 ,'2023-03-15' ,300.00),
(4, 4, '2023-04-20', 150.00),
(5, 5, '2023-05-25 ',1800.00),
(6, 6 ,'2023-06-30' ,400.00),
(7, 7, '2023-07-05' ,700.00),
(8, 8, '2023-08-10 ',160.00),
(9, 9 ,'2023-09-15', 140.00),
(10, 10, '2023-10-20' ,1400.00)

insert into orderItems values(1 ,1, 1, 2, 1600.00),
(2, 1, 3, 1, 300.00),
(3, 2, 2, 3, 1800.00),
(4, 3, 5, 2, 1800.00),
(5, 4, 4, 4, 600.00),
(6, 4, 6, 1, 50.00),
(7, 5, 1, 1, 800.00),
(8, 5, 2 ,2, 1200.00),
(9, 6, 10, 2, 240.00),
(10, 6, 9, 3, 210.00)


insert into cart values(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2)

select * from customers
select * from products
select * from orders
select * from orderItems
select * from cart

--1. Update refrigerator product price to 800.

update products set price=800.00 
where name='refrigerator'

select * from products

--2. Remove all cart items for a specific customer

delete from cart
WHERE customerID = 4 

select * from cart

--3. Retrieve Products Priced Below $100.

select * from products 
where price< 100.00

--4. Find Products with Stock Quantity Greater Than 5.

select name,stockQuantity from products where stockQuantity> 5

--5. Retrieve Orders with Total Amount Between $500 and $1000.

select * from orders where totalAmount between 500 and 1000

--6. Find Products which name end with letter ‘r’.

select name from products where name like '%r'

--7. Retrieve Cart Items for Customer 5.

select * from cart 
where customerID=5

--8. Find Customers Who Placed Orders in 2023.

select c.customerID,c.firstName,o.orderID,o.orderDate from customers c join orders o 
on c.customerID=o.customerID
where year(orderDate)=2023

--9. Determine the Minimum Stock Quantity for Each Product Category.

select name, MIN(stockQuantity) as minstockquantity
FROM products 
GROUP BY name;


--10. Calculate the Total Amount Spent by Each Customer.

select c.customerID,c.firstName,sum(o.totalamount)
from customers c join orders o on c.customerID=o.customerID
group by c.customerID,c.firstName

--11. Find the Average Order Amount for Each Customer.

select c.customerID, c.firstName, avg(o.totalAmount)as average
from orders o
join customers c on o.customerID = c.customerID
group by c.customerID, c.firstName

--12. Count the Number of Orders Placed by Each Customer.

select customerID, count(orderID) as numberOfOrders
from orders
group by customerID

--13. Find the Maximum Order Amount for Each Customer.

select customerID, max(totalAmount) as maximumOrderAmount
from orders
group by customerID

--14. Get Customers Who Placed Orders Totaling Over $1000

select c.customerID, c.firstName, c.lastName
from customers c
join orders o on c.customerID = o.customerID
group by c.customerID, c.firstName, c.lastName
having sum(o.totalAmount) > 1000

--15. Subquery to Find Products Not in the Cart.

select * from products
where productID not in  (select productID from cart)

--16. Subquery to Find Customers Who Haven't Placed Orders.

select * from customers
where customerID not in (select customerID from orders)

--17. Subquery to Calculate the Percentage of Total Revenue for a Product.

select productID, name,price,(price * 100 / (select sum(totalAmount) from orders)) as _percentage_
from products;

--18. Subquery to Find Products with Low Stock.

select * from products
where stockQuantity < (select avg(stockquantity) from products)
--alternate as low stock doesn mean anything specific
select *  from products 
where stockQuantity in (select min(stockQuantity) from products)

--19. Subquery to Find Customers Who Placed High-Value Orders.

select customerID,firstName,email from customers
where customerID IN 
(select customerID from orders 
group by customerID having sum(totalAmount) > 1000)
--taking above 1000 as high valued