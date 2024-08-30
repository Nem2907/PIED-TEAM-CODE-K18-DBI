--chp2-SubQuery
---01: singleValue

--1 :1 câu select cơ bản có những gì ?
-- SELECT ... FROM ... WhERE...ORDER BY
-- SELECT : sàng lọc dữ liệu , lấy những cột mình muốn : liệt kê cột
--- From table, table , table (join(SQL) : những ng học sql | lookup (mongo))
-- Câu Select sẽ luôn trả ra kết quả dưới dang table
USE convenienceStoreDB

SELECT * FROM Employee , Orders
--câu select ở trên trả về kết quả dưới dạng SINGLEValue
--Singl Value : là table 1 hàng 1 cột duy nhất 1 ô| 1 cell

--liệt kê các nhân viên đến từ thành phố mà cùng thành phố 
-- với nhân viên mã số EMP004
--Trong kết quả tính luôn cả EMP004 nha
SELECT City FROM Employee 
WHERE EmpID = 'Emp004'
---
SELECT * From Employee
Where City = (SELECT City FROM Employee 
			 WHERE EmpID = 'Emp004')
			 --SubQuery | Nested Query : câu query nằm trong câu query

-- II- thực hành
-- in ra những nhân viên ở London
SELECT * FROM Employee WHERE City = 'London'
--- in ra những nhân viên cùng quê với angelina
SELECT * FROM Employee 
WHERE Country = (SELECT Country FROM Employee 
				WHERE FirstName = 'Angelina')
AND FirstName != 'Angelina'--optional
-- liệt kê các đơn hàng các ngày yêu cầu giao
SELECT * FROM Orders Where RequiredDate is NOT Null
--liệt kê các đơn hàng có trọng lượng lớn hơn trọng lượng của đơn hàng có mã số ORD021
--- và vận chuyển cùng thành phố của đơn hàng có mã số là ORDER012
SELECT * FROM Orders 
WHERE Freight  > (SELECT Freight FROM Orders 
				   WHERE OrdID = 'ORD021')
AND ShipCity = (SELECT ShipCity FROM Orders 
					WHERE OrdID = 'ORD012')
--Liệt kê các đơn hàng đc ship cùng thành phố với đơn hàng ORD014
--- và có trọng lượng  > 50
SELECT * FROM Orders 
Where ShipCity = (SELECT ShipCity FROM Orders 
				    Where OrdID = 'ORD014')
AND Freight > 50 
--những đơn hàng nào đc vận chuyển bởi công ty vận chuyển có mã số là SHIP003 và được ship đến cùng thành
---phố cùng thành phố của đơn hàn ORDER012
SELECT * FROM Orders 
WHERE ShipID = 'SHIP003' 
AND ShipCity = (SELECT ShipCity FROM Orders 
				 Where OrdID = 'ORDER012')
--- Hãng Giaohangtietkiem đã ship bao nhiêu đơn hàng nào ?
-- Trong đây có liên quan đến 2 table
SELECT * FROM Orders WHERE ShipID = (SELECT ShipID FROM Shipper WHERE CompanyName = 'Giaohangtietkiem' )
SELECT ShipID FROM Shipper
WHERE CompanyName = 'Giaohangtietkiem'
--9. liệt kê danh sách các mặt hàng ,món hàng , product
--full thông tin : mã sp , tên sp
 SELECT * FROM Product
 --10.pork shank (tên sản phẫm) thuộc chủng loại nào ?
 -- output : full thông tin
 SELECT * FROM Category 
 WHERE CategoryID = ( SELECT CategoryID FROM Product 
						Where ProName = 'pork shank')					
-- 11: liệt kê danh sách các mặt hàng có cùng chủng loại với 
-- mặt hàng pork shank

SELECT * FROM Product
WHERE CategoryID = (SELECT CategoryID FROM Product
					Where ProName = 'pork shank')
 --12 : liệt kê các sản phẫn có cùng chủng loại là thịt
SELECT * FROM Product 
WHERE CategoryID = ( SELECT CategoryID FROM Category 
					WHERE CategoryName = 'meat')
 --13 : liệt kee các id  nhà cung câp cung cấp mặt hàn có tên là pork shank
SELECT * FROM Supplier 
WHERE SupID in (SELECT SupID FROM InputBill 
				WHERE ProID =(SELECT ProID FROM Product 
						WHERE ProName = 'pork shank'))

SELECT ProID FROM Product 
WHERE ProName = 'pork shank'

SELECT SupID FROM Supplier
WHERE ProID =(SELECT ProID FROM Product 
						WHERE ProName = 'pork shank')
