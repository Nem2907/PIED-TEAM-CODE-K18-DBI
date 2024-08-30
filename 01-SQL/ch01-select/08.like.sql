---08.like.sql
--về vấn đề so sánh , thì ta có thể dùng dấu "=" để so sánh chính xác , cell(1 ô) chuẩn 100%
--name = 'name'

--dbEngine cung cấp cho chúng ta toán tử 'like'
--- like là toán tử giúp so sánh tương đối(so sánh so khớp)
-- toán tử like giống với regex
-- _ (shift gạch) :đại diện cho MỘT ký tự bất ky(tính cả dấu space)
-- % : đại diện cho từ 0 --> n bất kỳ : miễn có là được

-- lấy ra sinh viên có tên là ânm
-- name = 'nam'

--lấy ra sinh viên tên có chứa 'nam'
-- name like '%nam%'

-- lấy ra sinh viên có chữ 'nam' ở cuối
--name like '%nam'

--lấy ra sinh viên mà tên có chứa 3 ký tự
-- name like '___'

---II.Thực hành
--1. Dùng database
USE convenienceStoreDB
--2. in ra danh sách nhân viên
SELECT * FROM Employee
--3 : in ra nhân viên có tên là Scarlett
SELECT * FROM Employee WHERE FirstName LIKE 'Scarlett'
--4 : in ra những nhân viên có tên là hanna
SELECT * FROM Employee WHERE FirstName LIKE 'Hanna'
--5: in ra những nhân viên có chữ A đứng đầu
SELECT * FROM Employee WHERE FirstName LIKE 'A%'
--6 : in ra những nhân viên mà họ có chữ A đứng cuối cùng
SELECT * FROM Employee WHERE LastName LIKE '%A'
--7 :in ra những nhân viên mà tên có chữ A
SELECT * FROM Employee WHERE FirstName LIKE '%A%'
--8 :Những nhân viên nào có tên gồm đúng 3 ký tự
SELECT * FROM Employee WHERE FirstName LIKE '___'
--9 :Những nhân viên nào có tên gồm đúng 2 ký tự
SELECT * FROM Employee WHERE FirstName LIKE '__'
--10 : những nhân viên nào có ký tự cuối cùng là e
SELECT * FROM Employee WHERE FirstName LIKE '%e'
--11 Những nhân viên nào mà tên có 4 ký tự và ký tự cuối cùng là e
SELECT * FROM Employee WHERE FirstName LIKE '____e'
--- đủ trình thì làm 2 cách
SELECT * FROM Employee WHERE FirstName LIKE '_____' AND FirstName LIKE '%e'
--12 : những nhân viên nào mà tên có 6 ký tự và có chữ A trong tên
SELECT * FROM Employee WHERE FirstName LIKE '______%A%'
--13 :khách hàng nào mà địa chỉ có chữ i đứng 2 tính từ trái sang phải
SELECT * FROM Orders WHERE ShipAddress LIKE '_i%'
--14:tìm các sản phẫm và tên sản phẫm có 5 ký tự 
SELECT * FROM Product WHERE ProName LIKE '_____'
--15: tìm các sản phẫm và từ cuối cùng của sản phẫm đó có 5 ký tự
SELECT * FROM Product 
WHERE (ProName LIKE '% ____') OR (ProName LIKE '_____') AND (RIGHT(ProName,5) not Like '% %' )
--16 : Liệt kê những nhân viên mà địa chỉ có chứa _
SELECT *
FROM Employee
WHERE Address LIKE '%_%' Escape '~'
--những ký tự để làm dấu Escape : ~ $ ^
--WHERE Address = '%[_]}%' vẫn đc 
--WHERE Address = '%_%' ko đc
---17 :Tìm những trong tên có nháy đơn '
SELECT *
FROM Employee
WHERE FirstName LIKE '%''%'
---đây là kĩ thuật xss