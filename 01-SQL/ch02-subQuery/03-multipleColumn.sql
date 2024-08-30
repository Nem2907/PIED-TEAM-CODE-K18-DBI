--03.MultipleColumn.sql 
--Kết quả của câu select luôn trả về dưới dạng table
--SELECT ...FROM <table-select>
--1 câu select mà dùng dùng như table thì gọi là multiple column
Use convenienceStoreDB

--lấy ra những khách hàng đến từ usa và xác định số điện thoại

SELECT * FROM Customer 
Where PhoneNumber is not null 
and Country = 'USA'
---biểu diễn : làm code khó đọc hơn
SELECT * FROM (SELECT * FROM Customer
				Where Country = 'USA') as [tab1_cusFromUSA])
Where PhoneNumber is not null

-- biểu diễn cách 2 
SELECT * FROM (SELECT * FROM Customer
				Where PhoneNumber is not null) as [tab1_avaiablePhone])
Where Country = 'USA'

--3 : liệt kê các đơn hàng gửi đến London , Califonia , hàng mã và được nhân viên mã số
--- EMP001 chịu trách nhiệm
---1
SELECT * FROM Orders 
Where ShipCity in ('London','California',N'Hàng mã') And 
		EmpID in ('EMP001')

--2
SELECT * FROM (SELECT * FROM Orders
				WHERE ShipCity in ('London','California',N'Hàng mã')) as nh
		WHERE EmpID in ('EMP001')
--3 
SELECT * FROM (SELECT * FROM Orders
					WHERE EmpID in ('EMP001')) as nh
		WHERE ShipCity in ('London','California',N'Hàng mã')

-- 4 : liệt kê các đơn hàng gửi đến London , Califonia , hàng mã và được mua bởi các khách hàng
-- có tên là Roney, Hồng
SELECT * FROM Orders 
Where ShipCity in ('condon','california',N'hàng mã')  
AND		CustomerID in (SELECT CusID FROM Customer 
						WHERE FirstName in('Roney',N'Hồng'))
		
SELECT * FROM (SELECT * FROM Orders 
				WHERE ShipCity in ('London','California',N'Hàng mã')) as nh
	WHERE CustomerID in (SELECT CusID FROM Customer 
						WHERE FirstName in('Roney',N'Hồng'))

SELECT * FROM (SELECT * FROM Orders
				WHERE  CustomerID in (SELECT CusID FROM Customer 
						WHERE FirstName in('Roney',N'Hồng'))) as nh
		WHERE  ShipCity in ('London','California',N'Hàng mã'))
--5:liệt kê các đơn nhập của nhà cung cấp mã số SUP006 và có số lượng nhập < 1000
SELECT * FROM InputBill 
		WHERE SupID in ('SUP006') 
		  AND Amount < 1000

SELECT * FROM (SELECT * FROM InputBill 
						WHERE SupID in ('SUP006')) as nh
		WHERE Amount < 1000

SELECT * FROM (SELECT * FROM InputBill
						Where Amount < 1000) as nh
		WHERE SupID in ('SUP006')

---6 (trực tiếp) : liệt kê các đơn nhập của nhà cung cấp vingroup và có số lượng
--- nhập < 10000

SELECT * FROM InputBill
		WHERE SupID in (SELECT SupID FROM Supplier
						Where SupName = 'Vingroup')
		AND Amount < 10000

SELECT * FROM (SELECT * FROM InputBill
						WHERE SupID in (SELECT SupID FROM Supplier
												Where SupName = 'Vingroup')) as nh
			WHERE Amount < 10000

SELECT * FROM (SELECT * FROM InputBill
						WHERE Amount < 10000) as nh
			WHERE SupID in (SELECT SupID FROM Supplier
										Where SupName = 'Vingroup')