--tạo môi trường demo
CREATE DATABASE K19C1_Ch03_Aggregate
USE K19C1_Ch03_Aggregate
--tạo table lưu thông tin sinh viên
CREATE TABLE GPA(
	name nvarchar(10),
	points float,
	major char(2)
)
insert into GPA values(N'An', 9, 'IS')
insert into GPA values(N'Bình', 7, 'IS')
insert into GPA values(N'Cường', 5, 'IS')

insert into GPA values(N'Dũng', 8, 'JS')
insert into GPA values(N'Em', 7, 'JS')
insert into GPA values(N'Giang', 4, 'JS')
insert into GPA values(N'Hương', 8, 'JS')

insert into GPA values(N'Khanh', 7, 'ES')
insert into GPA values(N'Minh', 6, 'ES')
insert into GPA values(N'Nam', 5, 'ES')
insert into GPA values(N'Oanh', 5, 'ES')

--Max, min, avg, sum
--3 thằng này đều là aggregate như count
--*Lưu ý
--aggregate không lồng vào nhau!!
--max(count(cột)) -> sai
---> dùng multipleColumn

--1.có tất cả bao nhiêu sinh viên
SELECT COUNT(*) FROM GPA
--2.Chuyên ngành nhúng có bao nhiêu sinh viên(IS)--3
SELECT COUNT(name) FROM GPA
WHERE major = 'IS'
--2.1 Chuyên ngành nhúng và cầu nối có tổng cộng bao nhiêu sinh
--viên('JS','IS')--7
SELECT COUNT(name) FROM GPA
WHERE major in ('IS','JS')
--2.2 Con điểm bao nhiêu là cao nhất trong danh sách sinh viên
SELECT MAX(Points) From GPA
--2.3 ai là người cao điểm nhất trong đám sinh viên
SELECT * FROM GPA 
WHERE points = (SELECT MAX(points) FROM GPA )
--All()
SELECT * FROM GPA
WHERE points >= ALL(SELECT points FROM GPA)

--2.4 tính tổng điểm của tất cả sinh viên
SELECT SUM(points) From GPA
--2.5 điểm trung bình của tất cả sinh viên là bao nhiêu
SELECT AVG(points) From GPA

--**---
--22/6
--3 mỗi chuyên ngành có bao nhiêu sinh viên
--> dựa vào chữ mỗi :
--> khi trong câu có chữ "mỗi" -- each thì có nghĩa là phải dùng group by
-- tbl1_Student(name,points,yob,city)
--đếm xem mỗi thành phố có bao nhiêu sinh viên đang theo học
--HCM : 10
--HM : 15
--ĐN : 7

--đếm số lượng sinh viên của mỗi năm sinh :
-- 1995 : 5
-- 2000 : 17
-- 2001 : 15

--Syntax : SELECT .... FROM .... WHERE ... GROUP BY .... ORDER BY....
--*Thần chú :
--- Khi dùng Group by thì mệnh đề SELECT chỉ được chỉ dung cột có trong group by mà thôi, nếu k thì phải dùng
--- aggregate

---3. Đếm xem mỗi chuyên ngành có bao nhiêu sinh viên

SELECT major, COUNT(major) FROM GPA GROUP BY major


---4 điểm cao nhất mỗi chuyên ngành là bao nhiêu
SELECT major, MAX(points) FROM GPA GROUP BY major
---5 điểm trung binh mỗi chuyên ngành
SELECT major , AVG(points) FROM GPA GROUP BY major

---6 Thêm vào 2 data nữa : 
---Phượng học ngành JP
INSERT INTO GPA VALUES (N'Phượng',8,'JP')
---Trường mới bổ sung ngành HT , nhưng chưa có sinh viên theo học
INSERT INTO GPA VALUES (null,null,'HT')

---3. Đếm xem mỗi chuyên ngành có bao nhiêu sinh viên
SELECT * From GPA
SELECT major, COUNT(name) FROM GPA GROUP BY major

--**---
---Syntax
--  SELECT .... FROM .... WHERE ... GROUP BY .... HAVING ......ORDER BY....
--- Having : lọc dữ liệu sau khi đã gôm nhóm 
--- Having là where thứ 2 của câu select
---*** mệnh đề having sẽ giống mệnh đề select trong câu group by
--chỉ đc dùng các cột ở Group Ny hoặc aggregate

---5 : Chuyên ngành có từ 4 sinh viên trở lên 
SELECT major, COUNT(name) FROM GPA 
GROUP BY major 

---B1 : tìm xem mỗi chuyên ngành có bao nhiêu sinh viên trước
SELECT major, COUNT(name) FROM GPA 
GROUP BY major 
HAVING COUNT(name) >= 4

 ---5.1 ngành IS, JS , ES , mỗi chuyên ngành có bao nhiêu sinh viên
SELECT major, COUNT(name) FROM GPA 
WHERE major in ('IS','JS','ES')
GROUP BY major 
 ---6.Chuyên ngành có ít sinh viên nhất
 ---ALL()
SELECT major , count(name) FROM GPA 
GROUP BY major 
HAVING count(name) <= ALL(SELECT count(name) FROM GPA 
						GROUP BY major)
 ---MIN()
 SELECT major , count(name) as sl FROM GPA 
GROUP BY major 
--multiple
--tìm số bé nhất
SELECT min(sl) FROM (SELECT major , count(name) as sl 
					FROM GPA 
					GROUP BY major ) as ld 

SELECT major , count(name) as sl
FROM GPA 
GROUP BY major 
HAVING count(name) = (SELECT min(sl) FROM (SELECT major , count(name) as sl 
					FROM GPA 
					GROUP BY major ) as ld )

--7 : điểm lớn nhất của ngành IS là mấy điểm
--ALL()
SELECT MAX(Points) FROM GPA WHERE major = 'IS' 
--MAX()
SELECT points FROM GPA 
WHERE major = 'IS' AND
points >= ALL(SELECT points FROM GPA WHERE major = 'IS') 

--7.1 : tìm sinh viên có điểm cao nhất của ngành IS
--ALL()
SELECT * FROM GPA 
WHERE points >= ALL(SELECT points FROM GPA 
					WHERE major = 'IS' )
AND major = 'IS'
--MAX()
SELECT * FROM GPA Where points = (SELECT MAX(Points) FROM GPA WHERE major = 'IS')

--11.Điểm lớn nhất mỗi chuyên ngành (cẩn thận với HT)
SELECT MAX(points) FROM GPA
---** hàm iiif()
SELECT major, MAX(ld) FROM (SELECT points as ld , major FROM GPA) as nh
WHERE ld is not null
GROUP BY major 


SELECT major ,iif(max(points) is null , 0 , max(points)) FROM GPA
GROUP BY major
 
---MAX()

--12: Chuyên ngành nào có thủ khoa điểm trên 8 --- dùng max
--- ngành nào điểm cao nhất trên 8
SELECT major , MAX(points) FROM GPA
WHERE points is not null
GROUP BY major
HAVING MAX(points) >= 8
--13****: liệt kê những sinh viên đạt thủ khoa của mỗi chuyên ngành(Chưa làm đc đâu) (đệ quy - join1)


------------------
USE convenienceStoreDB
--************Đề******************
--14.1. Trọng lượng nào là con số lớn nhất, tức là trong các đơn "hàng đã vận chuyển",
-- trọng lượng nào là lớn nhất, trọng lượng lớn nhất 
--là bao nhiêu???
--> lấy giá trị lớn nhất trong 1 tập hợp
---Dùng All:
SELECT Freight FROM Orders
WHERE Freight >= ALL(SELECT Freight FROM Orders )

---Dùng MAX Thử:
SELECT MAX(Freight) FROM Orders

--14. Đơn hàng nào có trọng lượng lớn nhất
--Output: mã đơn, mã kh, trọng lượng
--dùng All thử:
SELECT OrdID , CustomerID ,Freight FROM Orders
WHERE Freight >= ALL(SELECT Freight FROM Orders )

--dùng MAX thử: 
SELECT OrdID , CustomerID ,Freight FROM Orders
WHERE Freight >= ALL(SELECT MAX(Freight) FROM Orders)

SELECT OrdID , CustomerID , Freight FROM Orders
WHERE Freight = (SELECT MAX(Freight) From Orders )
--15.Đếm số đơn hàng của mỗi quốc gia 
--Output: quốc gia, số đơn hàng
--nghe chữ mỗi: chia nhóm theo .... => dùng Group By ngay 
SELECT ShipCountry , COUNT(OrdID) as dh FROM Orders
GROUP BY ShipCountry
--15.1-Hỏi rằng quốc gia nào có từ 8 đơn hàng trở lên
--việc đầu tiên là phải đếm số đơn hàng của mỗi quốc gia
--đếm xong, lọc lại coi thằng nào >= 8 đơn thì in 
--lọc lại sau khi group by, chính là HAVING
SELECT ShipCountry , COUNT(OrdID) as dh FROM Orders
GROUP BY ShipCountry
HAVING COUNT(OrdID) >= 8

--16.Quốc gia nào có nhiều đơn hàng nhất??
--Output: quốc gia, số đơn hàng
--đếm xem mỗi quốc gia có bao nhiêu đơn hàng
--sau đó lọc lại
--Dùng ALL Thử: 
SELECT ShipCountry, COUNT(OrdID) as dh FROM Orders
GROUP BY ShipCountry
HAVING COUNT(OrdID) >= ALL(SELECT COUNT(OrdID) as dh 
							FROM Orders
							GROUP BY ShipCountry)


--Dùng Max thử: 
--Nếu ko đc dùng >= ALL
--tim max sau khi đếm, mà ko đc dùng max(count) do SQL ko cho phép
--ta sẽ count, coi kết quả count là 1 table, tìm max của table này để
--ra đc 12
--Thử dùng Max() xem sao
SELECT ShipCountry , COUNT(OrdID)as sl From Orders
GROUP BY ShipCountry

----mul
SELECT MAX(sl) FROM (SELECT ShipCountry , COUNT(OrdID)as sl From Orders
				GROUP BY ShipCountry) as ld
----KQ
SELECT ShipCountry , COUNT(OrdID) 
From Orders
GROUP BY ShipCountry
HAVING COUNT(OrdID) = (SELECT MAX(sl) FROM (SELECT ShipCountry , COUNT(OrdID)as sl From Orders
					GROUP BY ShipCountry) as ld)

--17.Mỗi cty đã vận chuyển bao nhiêu đơn hàng
--Output1: Mã cty, số lượng đơn hàng - hint: group by ShipId(ShipVia)
--*khó*Output2: mã cty, tên cty, sl (để in ra được câu này thì phải học nhiều hơn)
SELECT ShipID, count(OrdID) as sl
FROM Orders
GROUP BY ShipID
--18.Cty nào vận chuyển ít đơn hàng nhất
--Output1: Mã cty, số lượng đơn
---Dùng All Thử: 
SELECT ShipID, count(OrdID) as sl
FROM Orders
GROUP BY ShipID
HAVING COUNT(OrdID) <= ALL(SELECT count(OrdID) as sl
							FROM Orders
							GROUP BY ShipID)
---dùng Min() thử xem: 
SELECT MIN(sl) FROM(SELECT ShipID, count(OrdID) as sl
				FROM Orders
				GROUP BY ShipID) as ld
---
SELECT ShipID, count(OrdID) as sl
FROM Orders
GROUP BY ShipID
HAVING COUNT(OrdID) = (SELECT MIN(sl) FROM(SELECT ShipID, count(OrdID) as sl
						FROM Orders
						GROUP BY ShipID) as ld)

----mul

----KQ


--*Khó*Output2: mã cty, tên cty, sl (để in ra được câu này thì phải học nhiều hơn)

--19.in ra danh sách id các khánh hàng kèm tổng
-- cân nặng của tất cả đơn hàng họ đã mua
---->câu này hỏi khác đi: số lượng cân nặng mà khách hàng đã mua
--hint: Sum + Group by:
SELECT CustomerID , sum(Freight)
FROM Orders
GROUP By CustomerID
--20.khách hàng nào có tổng cân nặng của 
--tất cả đơn hàng họ đã mua là lớn nhất
--dùng ALL():
SELECT CustomerID , sum(Freight)
FROM Orders
GROUP By CustomerID
HAVING sum(Freight) >= ALL(SELECT CustomerID , sum(Freight)
							FROM Orders
							GROUP By CustomerID)

--Dùng Max thử: 
SELECT MAX(sl) FROM (SELECT CustomerID , sum(Freight) as sl
				FROM Orders
				GROUP By CustomerID ) as ld
----MultipleColumn

----KQ
SELECT CustomerID , sum(Freight)
FROM Orders
GROUP By CustomerID
HAVING sum(Freight) = (SELECT MAX(sl) FROM (SELECT CustomerID , sum(Freight as sl)
						FROM Orders
						GROUP By CustomerID ) as ld)


--21.NY, London có tổng bao nhiêu đơn hàng
-- dùng count bth xem sao
SELECT COUNT(OrdID) FROM Orders WHERE ShipCity in ('London','NY')
--group by having, sum cho nghệ thuật: 
---
SELECT sum(sl) FROM (SELECT ShipCity , count(OrdID) as sl From Orders)
--22.công ty vận chuyển nào vận chuyển nhiều đơn hàng nhất
--dùng thử All(): 

--Dùng MAX() thử xem:
--------------------------------------làm thêm ---------------------------------
use convenienceStoreDB
--1. in ra danh sách các khách hàng
SELECT * FROM Customer
 
--2. Đếm xem mỗi thành phố có bao nhiêu khách hàng
--mỗi khu vực: chia nhóm theo khu vực 
--TỪ MỖI -> GOM NHÓM 
SELECT iif(City is null,N'Chưa xác định',City) as City, COUNT(CusID) as Amount FROM Customer
GROUP BY City

--nếu bạn đếm count(city) bạn sẽ mất các khách hàng chưa xác định thành phố
--vì null nên sẽ không đếm được số lượng của null bằng cách này, vì null nó sẽ
--không đếm, dùng iif để chỉnh city Null thành 'Chưa xác định'

--5. Liệt kê danh sách các thành phố của các đơn hàng,
-- mỗi thanh pho xuat hien
-- 1 lần thoy 
SELECT DISTINCT ShipCity FROM Orders 


--thử dùng group by cho câu này xem sao ?
SELECT ShipCity  FROM Orders
GROUP BY ShipCity

--3. Đếm xem có bao nhiêu quốc gia đã giao dịch
-- trong đơn hàng(cứ có là đếm)
SELECT COUNT(ShipCountry) FROM Orders


--4. Đếm xem có bao nhiêu quốc gia đã giao dịch trong đơn hàng,
-- mỗi quốc gia đếm 1 lần thoy(distinct)
SELECT COUNT(distinct ShipCountry) FROM Orders


--4.1 làm nghệ thuật, group by + count + multipleColumn
--mul
SELECT ShipCountry,COUNT(OrdID) as sl FROM Orders GROUP BY ShipCountry
--thử count(ShipCountry) trong group by sẽ thấy nó đếm kiểu khác
SELECT COUNT(ShipCountry) FROM (SELECT ShipCountry,COUNT(OrdID) as sl FROM Orders GROUP BY ShipCountry) as ld

--5. Mỗi quốc gia có bao nhiêu đơn hàng
SELECT COUNT(OrdID) FROM Orders
GROUP BY ShipCity

--6. mỗi khác hàng đã mua bao nhiêu đơn hàng
SELECT COUNT(OrdID) FROM Orders
GROUP BY CustomerID

--7.khách hàng CUS004 đã mua bao nhiêu đơn hàng(làm 2 cách)
	--c1-hãy dùng group by xem sao ?
	SELECT COUNT(OrdID) FROM Orders
	WHERE CustomerID = 'CUS004'
	GROUP BY CustomerID
	
	--c2-thử làm cách không dùng group by, 
	--chỉ dùng aggregate và where hoi xem sao ?
	SELECT COUNT(OrdID) FROM Orders
	WHERE CustomerID = 'CUS004'

--8. CUS004 CUS001 CUS005 có tổng cộng bao nhiêu đơn hàng
--dùng aggregate + Where hoi xem sao ?
SELECT COUNT(OrdID) FROM Orders
WHERE CustomerID in ('CUS004','CUS001','CUS005')
--dùng count + where + group by + multipleColumn + Sum xem sao ?
SELECT CustomerID,Count(OrdID) FROM Orders
WHERE CustomerID in ('CUS004','CUS001','CUS005')
GROUP BY CustomerID
--mul
SELECT sum(sl) FROM (SELECT CustomerID,Count(OrdID) as sl FROM Orders
				WHERE CustomerID in ('CUS004','CUS001','CUS005')
				GROUP BY CustomerID) as ld

--9. Đếm số đơn hàng của mỗi quốc gia --21 rows
SELECT  ShipCity,COUNT(OrdID) FROM Orders
GROUP BY ShipCity
--10. Đếm số đơn hàng của nước Mĩ
--c1.Dùng Count + Where
SELECT COUNT(OrdID) FROM Orders
WHERE ShipCountry = 'USA'

--c2.dùng Where + Group By
SELECT  ShipCountry,COUNT(OrdID) FROM Orders
WHERE ShipCountry = 'USA'
GROUP BY ShipCountry

--c3.dùng having, lọc sau group
SELECT  ShipCountry,COUNT(OrdID) FROM Orders
GROUP BY ShipCountry
HAVING ShipCountry ='USA'

--11.liệt kê id của các khách hàng nào đã mua trên 2 đơn hàng
SELECT CustomerID , COUNT(OrdID) FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrdID) > 2
--12. Quốc gia nào có số lượng đơn hàng nhiều nhất?????
--phân tích:
-- - đếm số đơn hàng của mỗi quốc gia, count(*), mỗi - group by
-- - đếm xong có quá trời quốc gia, kèm số lượng đơn hàng
-- - ta cần số lớn nhất
-- - ta having cột số lượng vừa đếm >= ALL (??????)
--dùng All()
SELECT ShipCountry ,COUNT(OrdID) FROM Orders 
GROUP BY ShipCountry

SELECT ShipCountry , COUNT(OrdID) FROM Orders
GROUP BY ShipCountry
HAVING COUNT(OrdID) >= ALL(SELECT COUNT(OrdID) 
							FROM Orders 
							GROUP BY ShipCountry)

--thử thách dùng max() đi đại ca :
SELECT ShipCountry , COUNT(OrdID) as ld FROM Orders 
GROUP BY ShipCountry

SELECT ShipCountry , COUNT(OrdID) FROM Orders
GROUP BY ShipCountry
HAVING COUNT(OrdID) = ALL(SELECT MAX(sl) 
							FROM(SELECT ShipCountry , COUNT(OrdID) as sl FROM Orders 
							GROUP BY ShipCountry) as ld)
`
--13. Mỗi công ty đã vận chuyển bao nhiêu đơn hàng
SELECT ShipID ,COUNT(OrdID) FROM Orders
GROUP BY ShipID

--14. Mỗi nhân viên phụ trách bao nhiêu đơn hàng
--output 1: mã nv, số đơn hàng
SELECT EmpID ,COUNT(OrdID) FROM Orders
GROUP BY EmpID
--output2:(khó) mã nv, tên nv, số đơn hàng(phải học nhiều hơn mới làm được, để từ từ làm)-em chưa làm đc