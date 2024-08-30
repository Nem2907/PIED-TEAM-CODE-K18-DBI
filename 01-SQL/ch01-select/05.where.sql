---05-where.sql
--I-Lý thuyết
--Một câu SELECT  sẽ có cấu trúc có cấu trúc đầu đủ :
--SELECT ...FROM ... WHERE ... GROUP BY ... HAVING .... ORDER BY ....
-- 1 :SELECT : là mệnh đề giúp ta filter  (sàng lọc ) dữ liệu theo cột(cột dọc)
---SELECT * FROM table_x
---						: lấy ra tất cả các cột và các hàng từ table_x
---2 : SELECT id , name , name from table_x
---				lấy ra cột í , name , và tất cả các dòng từ table_x
-- From : dùng để liệt kê table 
--Where là mệnh đề dùng để filter dữ liệu theo dòng(trục ngang)
--- SELECT * GROM table_x WHERE <conditional clause>
---			lấy ra tất cả các cột và các dòng thỏa điều kiện từ table_x

--- toán tử  : > < >= <= = !=(khác) <>(khác)
--- logic : AND OR NOT
--Lưu ý : nên dùng () để group các điều kiện lại

---II- thực hành
--1 : Liệt kê các nhân viên
SELECT * FROM Employee
--2 : liệt kê danh sách các nhân viên ở california
SELECT * FROM Employee WHERE (City = 'California')
--3 : liệt kê danh sách các nhân viên ở 'London'
---output : id , name , title , address
SELECT EmpID , FirstName + ' ' + LastName as fullName, Address FROM Employee
Where City = 'London'

--4. Liệt kê tất cả các nhân viên ở thành phố London và California 
SELECT * FROM Employee WHERE (City = 'London' OR City = 'California' )
 --5. Liệt kê tất cả các nhân viên ở thành phố London hoặc NY 
 SELECT * FROM Employee WHERE (City = 'London' OR City = 'NY' )
 --6. liệt kê các đơn hàng
 select * from orders
 --7. liệt kê các đơn hàng không giao tới 'Hàng Mã'
SELECT * from Orders where  ShipCity != N'Hàng Mã'
--8. liệt kê các đơn hàng không giao tới 'Hàng Mã' và London
SELECT * from Orders where ShipCity != N'Hàng Mã' AND ShipCity != 'London'
--9. liệt kê các đơn hàng không giao tới 'Hàng Mã' hoặc London
SELECT * from Orders where not(ShipCity != 'Hàng Mã' OR ShipCity != 'London')

--10. Liệt kê các nhân viên có chức danh là Promotion
SELECT * From Employee Where Title = 'Promotion'
--11. Liệt kê các nhân viên có chức danh không là Promotion
--làm bằng 3 cách	!= 
					SELECT * From Employee Where Title != 'Promotion'
--					<>
					SELECT * From Employee Where Title <> 'Promotion'
--					not
					SELECT * From Employee Where not Title = 'Promotion'
--12. Liệt kê các nhân viên có chức danh là Promotion hoặc TeleSale
SELECT * From Employee Where Title = 'Promotion' or Title = 'TeleSale'
--13. Liệt kê các nhân viên có chức danh là Promotion và Mentor
SELECT * From Employee Where Title = 'Promotion' OR Title = 'Mentor'
--14. Liệt kê các nhân viên có chức danh không là Promotion và Telesale
SELECT * From Employee Where not(Title = 'Promotion' OR Title ='TeleSale')
--15. Liệt kê các nhân viên có chức danh không là Promotion và có thể là Telesale

--16. Những nhân viên nào có năm sinh trước 1972
SELECT * FROM Employee Where YEAR(Birthday) < 1972
--17. Những nhân viên nào tuổi lớn hơn 40, in ra thêm cột tuổi, và sắp xếp 
SELECT * ,YEAR(GETDATE()) - YEAR(Birthday) AS AGE FROM Employee 
Where  YEAR(GETDATE()) - YEAR(Birthday) > 40 ORDER BY AGE
---note : nhớ rằng ở phần where ko thể dùng age vì nó đang tính toán , xào trộn
--- lại trong đó nên ta ko sài đc ==> ko gọi AGE ra được
--18. Đơn hàng nào nặng hơn 100 và được gữi đến thành phố london
SELECT * FROM Orders WHERE Freight > 100 AND ShipCity = 'London'
--19.khác hàng nào có tuổi trong khoản 29 - 21 và đang ở london không ? hãy in ra
SELECT * , YEAR(GETDATE()) - YEAR(Birthday) as OLD FROM Customer
Where YEAR(GETDATE()) - YEAR(Birthday) > 21 
AND YEAR(GETDATE()) - YEAR(Birthday) < 29 
AND Country = 'London'
--20. Liệt kê các khách hàng đến từ Anh Quốc hoặc Vietnam
	--custom	
	SELECT * 
	FROM Customer 
	Where Country = 'UK' OR Country = 'Vietnam'

--21. Liệt kê các các đơn hàng đc gửi tới Vietnam hoặc Nhật bản
SELECT *
FROM Orders 
WHERE ShipCountry = 'Vietnam' or ShipCountry = 'Japan'
--22. Liệt kê các đơn hàng nặng từ 500.0 đến 100.0 pound (nằm trong đoạn, khoảng)
SELECT *
FROM Orders
Where Freight >= 100 AND Freight <= 500
--23. ktra lại cho chắc, sắp giảm dần kết quả theo cân nặng đơn hàng 
SELECT *
FROM Orders
Where Freight >= 100 AND Freight <= 500
ORDER BY Freight DESC
--24. Liệt các đơn hàng gửi tới Anh, 
SELECT *
FROM Orders
WHERE ShipCountry = 'USA' OR ShipCountry = 'UK' OR ShipCountry = 'VietNam'
ORDER BY Freight
--Mĩ, Việt sắp xếp tăng dần theo trọng lượng


--25. Liệt các đơn hàng KHÔNG gửi tới Anh, Pháp Mĩ, và có cân nặng trong khoản 50-100
-- sắp xếp tăng dần theo trọng lượng 
SELECT *
FROM Orders
WHERE not(ShipCountry = 'USA' 
OR ShipCountry = 'UK' 
OR ShipCountry = 'FRANCE')
AND Freight > 50 AND Freight < 100

ORDER BY Freight

--26. Liệt kê các nhân viên sinh ra trong khoảng năm 1970-1999
SELECT * ,YEAR(Birthday) AS dob FROM Employee 
Where  YEAR(Birthday) > 1970 AND YEAR(Birthday) < 1999
--- Trong khoảng ==> ko có dấu = 
--- Trong đoạn ==> có dấu bằng =