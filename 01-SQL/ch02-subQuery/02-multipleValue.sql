--02-multipleValue.sql
--multipleValue: là câu select trả ra table nhiều hàng 1 cột
--Thực hành
USE convenienceStoreDB
--1.liệt kê các sản phẩm thuộc nhóm hàng CATE006, CATE005, CATE003
SELECT * FROM Product 
WHERE CategoryID in ('CATE006', 'CATE005', 'CATE003')
--2.liệt kê các sản pẩm thuộc nhóm hàng thịt, ô tô, bag
SELECT * FROM Product
WHERE CategoryID in (SELECT CategoryID FROM Category
					WHERE  CategoryName in ('meat','car','bag'))
--3.in ra anh sách 'id của các nhà cung cấp' những mặt hàng có chủng loại
--là car, meat, bag
SELECT * FROM Supplier 
WHERE SupID in (SELECT SupID FROM InputBill 
				Where ProID in (SELECT ProID FROM Product 
						WHERE CategoryID in (SELECT CategoryID FROM Category
								WHERE CategoryName in ('car', 'meat', 'bag'))))

---

SELECT DISTINCT SupID FROM InputBill 
				Where ProID in (SELECT ProID FROM Product 
						WHERE CategoryID in (SELECT CategoryID FROM Category
								WHERE CategoryName in ('car', 'meat', 'bag')))
--4.đơn hàng nào bán cho khách hàng đến từ việt nam, mĩ, nhật
SELECT * FROM Orders
WHERE CustomerID = (SELECT CusID FROM Customer
					WHERE Country in ('VietNam','Usa','Japan'))

--5.Đơn hàng nào bán cho khách hàng đến từ Việt nam, mĩ, nhật và
--ship đến cùng thành phố với đơn hàng ORD015, tính luôn ORD015
SELECT * FROM Orders
WHERE CustomerID = (SELECT CusID FROM Customer
					WHERE Country in ('VietNam','Usa','Japan'))
AND ShipCity in (SELECT ShipCity FROM Orders 
				WHERE OrdID = 'ORD015')
--6.Đơn hàng nào bán cho khách hàng không đến từ Mĩ, Nhật
SELECT * FROM Orders
WHERE CustomerID in (SELECT CusID FROM Customer
					WHERE Country not in ('Usa','Japan'))
--7.Nhân viên mã số EMP004 đã phụ trách những đơn hàng nào
SELECT * FROM Orders
WHERE EmpID = 'EMP004'
--8.Nhân viên ở Ny phụ trách những đơn hàng nào
SELECT * FROM Orders
WHERE EmpID in (SELECT EmpID FROM Employee 
				Where City = 'NY' )
--9.các đơn hàng đc gữi tới london, bởi các nhà vận chuyển nào
SELECT * FROM Shipper 
WHERE ShipID in (SELECT ShipID FROM Orders
				WHERE ShipCity = 'London')
--10.nhân viên nào phụ trách các đơn hàng gữi đến ny
SELECT EmpID FROM Orders 
WHERE ShipCity = 'NY'
--
SELECT * FROM Employee 
WHERE EmpID in (SELECT EmpID FROM Orders 
				WHERE ShipCity = 'NY')
--11. nhà cung cấp SUP003 và SUP005 đã cung cấp những sản phẩm nào
--in ra thông tin sản phẩm
SELECT * FROM Product
WHERE ProID in (SELECT ProID FROM InputBill
				WHERE SupID in ('SUP003' , 'SUP005'))
--12.nhà cung cấp không đến từ việt nam đã cung cấp
--những sản phẩm thuộc chủng loại nào
--in ra thông tin của các chủng loại đó
SELECT * FROM Category 
WHERE CategoryID in (SELECT CategoryID FROM Product 
					WHERE ProID in (SELECT ProID FROM InputBill 
									WHERE SupID not in (SELECT SupID FROM Supplier
											WHERE Country in ('Viet Nam'))))

--13.nhân viên Enno's đã chăm sóc những đơn hàng nào
SELECT * FROM Orders 
WHERE EmpID in (SELECT EmpID FROM Employee
				WHERE FirstName = 'Enno''s' )
