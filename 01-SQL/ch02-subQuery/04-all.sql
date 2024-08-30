--04-all.sql
---tạo 1 môi trường data base để demo khái niệm all
CREATE DATABASE DBK19C3_SubQuerry_All

USE DBK19C3_SubQuerry_All

---tạo table để lưu các số lẻ
CREATE Table Odds(
	Number int -- tạo cột tên number lưu số nguyên
)
INSERT INTO Odds VALUES (1)
INSERT INTO Odds VALUES (3)
INSERT INTO Odds VALUES (5)
INSERT INTO Odds VALUES (7)
INSERT INTO Odds VALUES (9)


CREATE Table Evens(
	Number int -- tạo cột tên number lưu số nguyên
)
INSERT INTO Evens VALUES (0)
INSERT INTO Evens VALUES (2)
INSERT INTO Evens VALUES (4)
INSERT INTO Evens VALUES (6)
INSERT INTO Evens VALUES (8)


CREATE Table Intergers(
	Number int -- tạo cột tên number lưu số nguyên
)
INSERT INTO Intergers VALUES (0)
INSERT INTO Intergers VALUES (1)
INSERT INTO Intergers VALUES (2)
INSERT INTO Intergers VALUES (3)
INSERT INTO Intergers VALUES (4)
INSERT INTO Intergers VALUES (5)
INSERT INTO Intergers VALUES (6)
INSERT INTO Intergers VALUES (7)
INSERT INTO Intergers VALUES (8)
INSERT INTO Intergers VALUES (9)
INSERT INTO Intergers VALUES (10)

--1 . SQL cung cấp toán tử so sánh all , giúp so sánh vơi tập hợp
--cú pháp : WHERE CỘT <Toán Tử> All (SubQuerry-MultipleValue)
--vd : An có phải là người  "cao điểm" hơn tất cả những bạn sinh viên đến từ HCM ko?

--trong nhóm A , có ai thấp điểm hơn tất cả những bạn bên nhóm B ko?

--2.ý nghĩa :
--Where cột A so sánh tất cả (tập hợp)
--so sánh value trong cột A xem thử có ai thỏa với tất cả các giá trị bên tập 
--hợp hay ko ? 
--nếu có thì bỏ vào kết quả
-------------
--1 .Tìm trong evens những number nào  > tất cả number bên odds
SELECT * FROM Evens 
		WHERE Number > ALL(SELECT number from Odds) 

--2.Tìm trong odds những number nào  > tất cả number bên evens
SELECT * FROM Odds 
		WHERE Number > ALL(SELECT number from Evens) 
--2.Tìm trong odds những number nào  > tất cả number bên odd
SELECT * FROM Odds 
		WHERE Number > ALL(SELECT number from Odds)
--2.Tìm trong odds những number nào  > hoặ bằng tất cả number bên odds
SELECT * FROM Odds 
		WHERE Number >= ALL(SELECT number from Evens) 
--2.Tìm trong Integers những number nào  số lớn nhất là bao nhiêu
SELECT * FROM Intergers 
		WHERE Number >= ALL(SELECT Number FROM Intergers ) 
---
Use convenienceStoreDB
---1 : in ra thông tin các nhân viên kèm tuổi của họ
SELECT * , YEAR(GETDATE()) - YEAR(Birthday) as AGE FROM Employee 
---2 : in ra thông tin các nhân viên có tuổi lớn nhất
SELECT * , YEAR(GETDATE()) - YEAR(Birthday) as AGE FROM Employee 
	WHERE  YEAR(GETDATE()) - YEAR(Birthday) >= ALL(SELECT YEAR(GETDATE()) - YEAR(Birthday) as AGE FROM Employee)


---3 : trong các nhân viên ở usa , nhân viên nào có tuổi lớn nhất
SELECT *,YEAR(GETDATE()) - YEAR(Birthday) as nh FROM Employee
WHERE Country = 'USA' 
AND YEAR(GETDATE()) - YEAR(Birthday) >= ALL(SELECT YEAR(GETDATE()) - YEAR(Birthday) FROM Employee 
											WHERE Country = 'USA' )
--4 : in ra thông tin của các sản phẫm thuộc chủng loại quần áo , túi , moto
SELECT * FROM Product 
WHERE CategoryID in (SELECT CategoryID FROM Category 
							WHERE CategoryName in ('clothes','bag','moto'))
---5 : đơn nào có trọng lượng lớn nhất
SELECT * FROM Orders
WHERE Freight >= ALL(SELECT Freight FROM Orders)
-- 5.1 : trong các đơn hàng , trong lượng lớn nhất là bao nhiêu
SELECT Freight FROM Orders
WHERE Freight >= ALL(SELECT Freight FROM Orders)
---6  : trong các đang hàng gửi tơi hàng mã , tokyo 
-- đơn hàng nào có trọng lượng lớn nhất
SELECT * FROM Orders 
WHERE Freight >= All(SELECT Freight From Orders WHERE ShipCity in (N'Hàng Mã','Tokyo'))
AND ShipCity in (N'Hàng Mã','Tokyo')
--7 : trong các đơn hàng gửi đến hàng mã , tokyo thì đơn hàng nào có 
---trọng lượng nhỏ nhất
SELECT * FROM Orders 
WHERE Freight <= All(SELECT Freight From Orders WHERE ShipCity in (N'Hàng Mã','Tokyo'))
AND ShipCity in (N'Hàng Mã','Tokyo')
--8 sản phẫm nào giá bán cao nhất
SELECT * FROM Product 
WHERE PRICE >= ALL(SELECT Price FROM Product )
--9: sản phẫm nào có giá bán coa nhất thuộc chủng loại nào
SELECT * FROM Product
WHERE PRICE >= ALL(SELECT Price FROM Product )

SELECT * FROM Category
WHERE CategoryID in (SELECT * FROM Product
					WHERE PRICE >= ALL(SELECT Price FROM Product ))