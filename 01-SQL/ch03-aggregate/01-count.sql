--ch03-aggregate
--- 01-count.sql
--- aggregate là gôm tụ : là hàm có khả năng gom nhiều hang , cột về thành
--- 1 ô duy nhất

-- count : có 2 cơ chế 
-- count(*) : có hàng nào thì đến hàng đó
---count(cột) : đếm ô(value) trong cột , nhung nếu null thì ko đến


Use convenienceStoreDB
--1.Liệt kê danh sách các nhân viên
SELECT * FROM Employee 

--2.Có bao nhiêu nhân viên, đếm số nhân viên đi
SELECT COUNT(EmpID) FROM Employee 
SELECT Count(*) From Employee
--tránh đếm trên cột khác, dễ có null, mà null là k tính

--4.đếm xem có bao nhiêu đơn hàng có ngày yêu cầu RequiredDate
--3 cach
SELECT COUNT(RequiredDate) FROM Orders

SELECT Count(*) FROM Orders
WHERE RequiredDate is not null

SELECT COUNT(RequiredDate) FROM Orders
WHERE RequiredDate is not null

--5.đếm xem có bao nhiêu khác hàng có số điện thoại (5)
SELECT COUNT(CusID) From Customer
Where PhoneNumber is not null

--6.đếm xem có bao nhiêu thành phố đã được xuất hiện trong table
--khách hàng, cứ có là đếm
-->có bao nhiêu khách hàng đã xác định thành phố
SELECT COUNT(City) From Customer
Where City is not null

--6.1 Đếm xem có bao nhiêu thành phố, mỗi thành phố đếm 1 lần (customer) 
--> khách hàng của bạn đến từ bao nhiêu thành phố
SELECT COUNT(DISTINCT City) From Customer
Where City is not null

--7. Đếm xem có bao nhiêu tp trong table NV, mỗi tp đếm 1 lần
--> nhân viên của bạn đến từ bao nhiêu thành phố
SELECT count(distinct city) From Employee

--8. Có bao nhiêu khách hàng chưa xd đc số điện thoại (5)
SELECT count(*) - COUNT(PhoneNumber) From Customer

SELECT count(CusID) FROM Customer where PhoneNumber is null