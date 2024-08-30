--01-join.sql
--vì join rất khó để hiểu nên mình tạo database để demo cho dễ hiểu		
CREATE DATABASE DBK19C3_Ch04_join
USE DBK19C3_Ch04_join

---Tạo table Master lưu số nguyên , kèm với cách viết tiếng việt
CREATE TABLE Master(
	MNO int ,
	ViDesc nvarchar(10),
)
INSERT INTO Master VALUES(1,N'Một')
INSERT INTO Master VALUES(2,N'Hai')
INSERT INTO Master VALUES(3,N'Ba')
INSERT INTO Master VALUES(4,N'Bốn')
INSERT INTO Master VALUES(5,N'Năm')



CREATE TABLE Detailed(
	DNO int ,
	EnDesc nvarchar(10),
)
INSERT INTO Detailed VALUES(1,N'One')
INSERT INTO Detailed VALUES(3,N'Three')
INSERT INTO Detailed VALUES(5,N'Five')
INSERT INTO Detailed VALUES(7,N'Seven')

SELECT * FROM Detailed
SELECT * FROM MASTER
--inner join : môn đăng hộ đối : 
	--descartes join : tích đề cát
	SELECT * FROM Master , Detailed
	WHERE MNO = DNO
	--inner join
	SELECT * FROM Master
	inner join Detailed on MNO = DNO

	SELECT * FROM Master
	join Detailed on MNO = DNO

	--inner join là ta giữ đc những điểm chung và ta bỏ đi hết những cái riêng
	--master(mất 2,4) ,Detalied(mất 7)
--outter join : nối lệch
	--left join:
	SELECT * FROM Master
	left join Detailed on MNO = DNO
	-- vì là left join nên là master là gốc
	---từ master nhìn sang Detalied , tìm cái nào mình có thì lắp vô, ko có thì null
	-- phần còn lại của Detalied bỏ hết
	-- Master k mất gì hết , Detailed sẽ mất những gì ko có trong master
	-- Master còn nguyên , detalied mất 7
--right join:
	SELECT * FROM Master
	right join Detailed on MNO = DNO
	-- vì là right join nên là master là gốc

--full join
	SELECT * FROM Master
	right join Detailed on MNO = DNO	


	--tạo table lưu thông tin của chuyên ngành
CREATE TABLE Major(
	ID char(2) Primary key,
	Name nvarchar(30),
	Room char(4),
	Hotline char(11)
)

Insert Into Major Values ('IS', 'Information System', 'R101', '091x...')
Insert Into Major Values ('JS', 'Japanese Software Eng', 'R101', '091x...')
Insert Into Major Values ('ES', 'Embedded System', 'R102', '091x...')
Insert Into Major Values ('JP', 'Japanese Language', 'R103', '091x...')
Insert Into Major Values ('EN', 'English', 'R102', null)
Insert Into Major Values ('HT', 'Hotel Management', 'R103', null)

CREATE TABLE Student(
	ID char(8) primary key,
	Name nvarchar(30),
	MID char(2) null, 
	Foreign key(MID) references Major(ID)
)


insert into Student values ('SE123458', N'Cường Võ', 'IS')
insert into Student values ('SE123459', N'Dũng Phạm', 'IS')

insert into Student values ('SE123460', N'Em Trần', 'JS')
insert into Student values ('SE123461', N'Giang Lê', 'JS')
insert into Student values ('SE123462', N'Hương Võ', 'JS') 
insert into Student values ('SE123463', N'Khanh Lê', 'JS') 

insert into Student values ('SE123464', N'Lan Trần', 'ES')
insert into Student values ('SE123465', N'Minh Lê', 'ES')
insert into Student values ('SE123466', N'Ninh Phạm', 'ES') 

insert into Student values ('SE123467', N'Oanh Phạm', 'JP')
insert into Student values ('SE123468', N'Phương Nguyễn', 'JP')

--IS: 4, JS: 4, ES: 3, JP: 2
--HT: 0, EN: 0
--3 sv đang học dự bị, tức là mã CN là null
insert into Student values ('SE123469', N'Quang Trần', null)
insert into Student values ('SE123470', N'Rừng Lê', null)
insert into Student values ('SE123471', N'Sơn Phạm', null)

SELECT * FROM Student
--liệt kê danh sách các chuyên ngành kèm theo danh sách sinh viên theo học
--output : mã chuyên ngành , mã sv , tên sinh viên
SELECT m.* , s.ID ,s.Name FROM Major m
left join Student s on m.ID = s.MID
--vif left join nên major đầy đủ , còn nguyên
---còn Student thì mất 3 sinh viên ko có chuyên ngành

--Làm bài cực khó
USE convenienceStoreDB
--1.Mỗi khách hàng đã mua bao nhiêu đơn hàng
--output 1: mã customer, số đơn hàng
	--th1: em group by và count bth
	SELECT CustomerID , COUNT(OrdID) 
	FROM Orders 
	GROUP BY CustomerID
	--th2: join trước rồi group by
	SELECT CustomerID , COUNT(OrdID) FROM Customer
	Left Join Orders on CustomerID = CusID
	GROUP BY CustomerID

--output2: mã customer, tên customer, số đơn hàng
SELECT c.CusID , c.FirstName ,LD.sl
FROM (SELECT c.CusID , c.FirstName , COUNT(o.OrdID) as sl
		FROM Customer c left join Orders o on c.CusID = o. CustomerID
		GROUP BY CusID , FirstName) as LD LEFT JOIN Customer c on LD.CusID = c.CusID
--2.khách hàng nào mua nhiều đơn hàng nhất
--output: mã kh, tên kh, số lượng đơn hàng
SELECT c.CusID , COUNT(o.OrdID) as sl  
FROM Customer c left join Orders o on c.CusID = o.CustomerID
GROUP BY c.CusID
HAVING COUNT(o.OrdID) >= ALL(SELECT COUNT(o.OrdID) as sl  
								FROM Customer c left join Orders o on c.CusID = o.CustomerID
								GROUP BY c.CusID) 
--join để lấy tên khách
SELECT * FROM (SELECT c.CusID , COUNT(o.OrdID) as sl  
				FROM Customer c left join Orders o on c.CusID = o.CustomerID
				GROUP BY c.CusID
				HAVING COUNT(o.OrdID) >= ALL(SELECT COUNT(o.OrdID) as sl  
											FROM Customer c left join Orders o on c.CusID = o.CustomerID
											GROUP BY c.CusID)) as LD left join Customer c 
											on LD.CusID = c.CusID
--3. mỗi nhân viên đã chăm sóc bao nhiêu đơn hàng
--output 1: mã nhân viên, số lượng đơn hàng
	SELECT e.EmpID , count(o.OrdID) as SL FROM Employee e
	LEFT JOIN Orders o on e.EmpID = o.EmpID
	GROUP BY e.EmpID
--output 2 : mã nhân viên , tên nhân ciên , số lượng đơn hàng
SELECT *
FROM(SELECT e.EmpID, COUNT(o.OrdID) as SL 
		FROM Employee e LEFT JOIN Orders o on e.EmpID = o.EmpID
		GROUP BY e.EmpID) as LD LEFT JOIN Employee e
								ON LD.EmpID = e.EmpID
--4***. show ra ai(những ai) là khách hàng mua ít đơn hàng nhất
SELECT * FROM (SELECT c.CusID , COUNT(o.OrdID) as sl  
				FROM Customer c left join Orders o on c.CusID = o.CustomerID
				GROUP BY c.CusID
				HAVING COUNT(o.OrdID) <= ALL(SELECT COUNT(o.OrdID) as sl  
											FROM Customer c left join Orders o on c.CusID = o.CustomerID
											GROUP BY c.CusID)) as LD left join Customer c 
											on LD.CusID = c.CusID
--thêm mới data
Use DBK19C3_Ch04_join
insert into Major values('IA','Information Asurance','R103',null)
insert into Student values ('SE123472', N'Anh Lê', 'IA')

--**Đề**--
--1. Có bao nhiêu chuyên ngành  --6rows
SELECT COUNT(ID) FROM Major
--2. Có bao nhiêu sinh viên
SELECT COUNT(ID) FROM Student
--3. Có bao nhiêu sv học chuyên ngành IS
SELECT COUNT(ID) as SL FROM Student 
WHERE MID = 'IS'
--4. Đếm xem mỗi CN có bao nhiêu SV
SELECT iif(MID is null , N'Chưa xác định ' , MID ) as MID ,COUNT(ID) as SL
FROM Student
GROUP BY MID

SELECT m.ID, COUNT(s.ID) as SL FROM Major m
LEFT JOIN Student s on m.ID = s.MID
GROUP BY m.ID
--5. Chuyên ngành nào có nhiều SV nhất
--xử lý 2 cn không có sinh viên bằng iff trước khi tìm max min
SELECT m.ID, COUNT(s.ID) as SL FROM Major m
LEFT JOIN Student s on m.ID = s.MID
GROUP BY m.ID
HAVING COUNT(s.ID) >= (SELECT COUNT(s.ID) as SL FROM Major m
						LEFT JOIN Student s on m.ID = s.MID
						GROUP BY m.ID)
--6. Chuyên ngành nào có ít sv nhất
--<= ALL:
SELECT m.ID, COUNT(s.ID) as SL FROM Major m
LEFT JOIN Student s on m.ID = s.MID
GROUP BY m.ID
HAVING COUNT(s.ID) <= (SELECT COUNT(s.ID) as SL FROM Major m
						LEFT JOIN Student s on m.ID = s.MID
						GROUP BY m.ID)
--dùng min:
SELECT COUNT(s.ID) as SL FROM Major m
	LEFT JOIN Student s on m.ID = s.MID
	GROUP BY m.ID
--MUL : số sv của chuyên ngành có it sinh viên nhất
	SELECT min(SL) as Mini FROM (SELECT COUNT(s.ID) as SL FROM Major m
				  LEFT JOIN Student s on m.ID = s.MID
				  GROUP BY m.ID) as ld

	SELECT m.ID , COUNT(s.ID) as SV
	FROM Major m left join  Student s on m.ID = s.MID
	GROUP BY m.ID
	HAVING COUNT(s.ID) = (SELECT min(SL) as Mini FROM (SELECT COUNT(s.ID) as SL FROM Major m
						LEFT JOIN Student s on m.ID = s.MID
						GROUP BY m.ID) as ld)
	
	
--7. Đếm số sv của cả 2 chuyên ngành ES và JS 
--dùng Where + aggregate: 
SELECT COUNT(ID) as SL FROM Student
WHERE MID in ('ES','JS')
--dùng Group by + MultipleColum + sum : 
SELECT m.ID , COUNT(s.MID) as SL FROM Major m
LEFT JOIN Student s on m.ID = s.MID
WHERE M.ID in ('ES','JS')
GROUP BY m.ID

SELECT SUM(SL) as Total FROM (SELECT m.ID , COUNT(s.MID) as SL FROM Major m
			LEFT JOIN Student s on m.ID = s.MID
			WHERE M.ID in ('ES','JS')
			GROUP BY m.ID) as ld

--8. Mỗi chuyên ngành ES và JS có bao nhiêu sv
SELECT m.ID , COUNT(s.MID) as SL FROM Major m
LEFT JOIN Student s on m.ID = s.MID
WHERE M.ID in ('ES','JS')
GROUP BY m.ID

--9. Chuyên ngành nào có từ 3 sv trở lên
SELECT m.ID , COUNT(s.MID) as SL FROM Major m
LEFT JOIN Student s on m.ID = s.MID
GROUP BY m.ID
HAVING COUNT(s.MID) > 3

--10. Chuyên ngành nào có từ 2 sv trở xuống
SELECT m.ID , COUNT(s.MID) as SL FROM Major m
LEFT JOIN Student s on m.ID = s.MID
GROUP BY m.ID
HAVING COUNT(s.MID) < 2
--11. Liệt kê danh sách sv của mỗi CN
--output: mã cn, tên cn, mã sv, tên sv
SELECT  s.MID , m.Name , s.ID , s.Name FROM Major m
Left join Student s on m.ID = s.MID

--12. Liệt kê thông tin chuyên ngành của mỗi sv
--output: mã sv, tên sv, mã cn, tên cn, room
SELECT  s.MID , m.Name , s.ID , s.Name , m.Room FROM Major m
RIGHT join Student s on m.ID = s.MID
--thử thách làm lại câu 13 siêu khó của bài MaxMinSumAll
USE K19C1_Ch03_Aggregate
SELECT * FROM GPA
--13****: liệt kê những sinh viên cao diem nhat của mỗi chuyên ngành(Chưa làm đc đâu) (đệ quy - join1)
-- hint : tim max diem cua moi cn , join
SELECT major , MAX(points) as maxpoints FROM GPA
GROUP BY major

SELECT * FROM GPA,(SELECT major , MAX(points) as maxpoints FROM GPA
					GROUP BY major) as LD
		WHERE GPA.major = LD.major AND GPA.points = LD.maxpoints


Use convenienceStoreDB
--1. đếm xem mỗi nhà vận chuyển đã vận chuyển bao nhiêu đơn hàng ?
--output: mã nhà vận chuyển, tên nhà vận chuyển, số lượng đơn hàng
SELECT o.ShipID , COUNT(OrdID)  as SL
FROM Orders o RIGHT JOIN Shipper s on o.ShipID = s.ShipID
GROUP BY o.ShipID

SELECT s.ShipID , s.CompanyName , LD.SL FROM (SELECT o.ShipID , COUNT(OrdID)  as SL
				FROM Orders o RIGHT JOIN Shipper s on o.ShipID = s.ShipID
				GROUP BY o.ShipID) as LD LEFT JOIN Shipper s on LD.ShipID = s.ShipID

--2. đếm xem mỗi nhà vận chuyển đã vận chuyển bao nhiêu đơn hàng đến USA?
--output: mã nhà vận chuyển, tên nhà vận chuyển, số lượng đơn hàng
SELECT s.ShipID , s.CompanyName , LD.SL FROM (SELECT o.ShipID , COUNT(OrdID)  as SL
				FROM Orders o RIGHT JOIN Shipper s on o.ShipID = s.ShipID
				WHERE o.ShipCountry = 'USA'
				GROUP BY o.ShipID) as LD LEFT JOIN Shipper s on LD.ShipID = s.ShipID
--3. Khách hàng CUS001 , CUS005, CUS007 dã mua bao nhiêu đơn hàng
--output: mã khách hàng, tên khách hàng, số lượng khách hàng

SELECT c.CusID , COUNT(o.OrdID) FROM Customer c 
LEFT JOIN Orders o on c.CusID = o.CustomerID
WHERE c.CusID in ('CUS001','CUS005','CUS007')
GROUP BY c.CusID

SELECT LD.CusID,c.FirstName ,LD.SL FROM (SELECT c.CusID , COUNT(o.OrdID) as SL
				FROM Customer c LEFT JOIN Orders o on c.CusID = o.CustomerID
				WHERE c.CusID in ('CUS001','CUS005','CUS007')
				GROUP BY c.CusID) AS LD LEFT JOIN Customer c 
								  ON LD.CusID = c.CusID



--4. Khách hàng CUS001 , CUS005, CUS007 dã mua bao nhiêu đơn hàng vận chuyển tới đúng quê của họ
--output: mã khách hàng, tên khách hàng, số lượng khách hàng

SELECT c.CusID , COUNT(o.OrdID) FROM Customer c 
LEFT JOIN Orders o on c.CusID = o.CustomerID
WHERE c.CusID in ('CUS001','CUS005','CUS007')
GROUP BY c.CusID

SELECT LD.CusID,c.FirstName ,LD.SL FROM (SELECT c.CusID , COUNT(o.OrdID) as SL
				FROM Customer c LEFT JOIN Orders o on c.CusID = o.CustomerID
				WHERE c.CusID in ('CUS001','CUS005','CUS007')
				AND c.Country = o.ShipCountry
				GROUP BY c.CusID) AS LD LEFT JOIN Customer c 
								  ON LD.CusID = c.CusID


