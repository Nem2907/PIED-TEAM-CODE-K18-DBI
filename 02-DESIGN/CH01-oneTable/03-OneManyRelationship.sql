---03-oneManyRelationship.sql
--mối quan hệ 1 - N
CREATE DATABASE DBK19C3_OneManyRelationship
USE DBK19C3_OneManyRelationship
DROP Table City 
DROP Table Candidate
--- muốn tạo ra 1 rable lưu thông tin  các thành phố
CREATE TABLE City(
	ID INT not null ,
	Name nvarchar(40),
)
Alter table City 
	add constraint PK_City_ID primary key(ID)

Alter table City
	add constraint UQ_City_Name Unique(Name)

INSERT INTO City Values (1, N'TP.HCM')
INSERT INTO City Values (2, N'TP.Hà Nội')
INSERT INTO City Values (3, N'TP.Bình Dương')
INSERT INTO City Values (4, N'Tây Ninh')
INSERT INTO City Values (5, N'Đắk Lắk')
INSERT INTO City Values (6, N'Bắc Kạn')

-- tạo table lưu trữ thông tin Candidate : ứng cử viên đi thi
CREATE TABLE Candidate(
	ID char(5) not null ,
	LastName nvarchar(30) not null ,
	FirstName nvarchar(30) not null,
	CitiID Int ,
)
-- cài primary key để kh ứng vbieen nào cùng mã sinh viên
Alter Table Candidate
	add constraint PK_Candidate_ID primary key(ID)
-- trong table Candidate ta sẽ cho CityID tham chiếu giá trị từ City(ID		)
Alter Table Candidate
	add constraint FK_Candidate_CitiID_CITY_ID Foreign Key (CitiID) references City(ID)
	on delete set null
	on update cascade

	INSERT INTO Candidate Values('C1',N'Nguyễn',N'An',1)
	INSERT INTO Candidate Values('C2',N'Lê',N'Bình',1)
	INSERT INTO Candidate Values('C3',N'Võ',N'Cường',2)
	INSERT INTO Candidate Values('C4',N'Phạm',N'Dũng',3)
	INSERT INTO Candidate Values('C5',N'Trần',N'Em',4)

	--Ôn Tập sql
	--1 : Liệt kê danh sách sinh viên 
	SELECT * FROM Candidate
	--2 : Liệt kê danh sách sinh viên kèm thông tin thành phố
	SELECT * FROM Candidate c
	Left join City ci on c.CitiID = ci.ID
	--mất gì ? 
	--2.1 Liệt kê danh sách các tỉnh thành kèm thông tin sinh viên
	SELECT * FROM Candidate c
	Left join City ci on c.CitiID = ci.ID
	ORDER BY c.CitiID

	--3 in ra các sinh viên ở tp hcm
	--3.1: subquerry
	SELECT * FROM Candidate
	WHERE CitiID in (SELECT ID FROM City
					WHERE Name = N'Tp.HCM')
	--3.2: join
	SELECT * FROM Candidate c
	Left join City ci on c.CitiID = ci.ID
	WHERE ci.Name = N'Tp.HCM'
	---4. đếm xem có bao nhiêu sinh viên
	SELECT COUNT(ID) FROM Candidate
	
	--4.1 đếm xem tỉnh thành có bao nhiêu sinh viên
	---trước khi học join
	SELECT CitiID , COUNT(ID) FROM Candidate
	GROUP BY CitiID
	-- và sau khi học join
	SELECT ci.ID ,COUNT(c.ID) as SL FROM Candidate c
	Right Join City ci on c.CitiID = ci.ID
	GROUP BY  ci.ID
	---4.2 đếm xem thành phố hcm có bao nhiêu sinh viên
	SELECT ci.Name , COUNT(c.ID) as SL FROM Candidate c
	Left Join City ci on c.CitiID = ci.ID
	WHERE ci.Name = N'Tp.HCM'
	GROUP BY ci.Name

	SELECT ci.* , ld.SL
	FROM(SELECT ci.ID , COUNT(ca.ID) as SL
				FROM City ci left join Candidate ca on ci.ID = ca.CitiID
				GROUP BY ci.ID) as ld left join City ci on ld.ID = ci.ID
	--4.3 tỉnh nào có nhiều sinh viên nhất
	SELECT MAX(SL)  FROM (SELECT ci.Name , COUNT(c.ID) as SL FROM Candidate c
				  Left Join City ci on c.CitiID = ci.ID
				  GROUP BY ci.Name) as NH

	SELECT ci.* , ld.SL
	FROM(SELECT ci.ID , COUNT(ca.ID) as SL
				FROM City ci left join Candidate ca on ci.ID = ca.CitiID
				GROUP BY ci.ID) as ld left join City ci on ld.ID = ci.ID
				WHERE ld.SL >= ALL(SELECT ci.* , ld.SL
								   FROM(SELECT ci.ID , COUNT(ca.ID) as SL
								   FROM City ci left join Candidate ca on ci.ID = ca.CitiID
								   GROUP BY ci.ID) as ld left join City ci on ld.ID = ci.ID)
	--4.4 tỉnh nào không có sinh viên
	SELECT * FROM City

	SELECT * FROM City 
	WHERE Name not in (SELECT NH.Name FROM (SELECT ci.Name , COUNT(c.ID) as SL FROM Candidate c
				  Left Join City ci on c.CitiID = ci.ID
				  GROUP BY ci.Name) as NH)

	SELECT * FROM City
	WHERE City in (SELECT * FROM (SELECT ci.ID ,COUNT(c.ID) as SL FROM Candidate c
	Right Join City ci on c.CitiID = ci.ID
	GROUP BY  ci.ID
	HAVING COUNT(c.ID) <= ALL(SELECT COUNT(c.ID) as SL FROM Candidate c
							  Right Join City ci on c.CitiID = ci.ID
						      GROUP BY  ci.ID)) as NH )

	SELECT ci.* , ld.SL
	FROM(SELECT ci.ID , COUNT(ca.ID) as SL
				FROM City ci left join Candidate ca on ci.ID = ca.CitiID
				GROUP BY ci.ID) as ld left join City ci on ld.ID = ci.ID
				WHERE ld.SL <= ALL(SELECT ci.* , ld.SL
								   FROM(SELECT ci.ID , COUNT(ca.ID) as SL
								   FROM City ci left join Candidate ca on ci.ID = ca.CitiID
								   GROUP BY ci.ID) as ld left join City ci on ld.ID = ci.ID)

-- đỗ domino
--- điều gì xảy ra nếu như ta xóa bên 1 , bên N có bị ảnh hưởng hay không ?
-- và ngược lại
DELETE City WHERE ID = '1'
DELETE City WHERE ID = '4'
-- Thp Hcm đang có sinh viên , mọc rễ rồi , ko xóa gốc đc nữa
-- nhưng Bắc Kạn và Đắk Lawsk thì xóa đc , vì chưa có sinh viên nào cả

update City set ID = '333' WHERE ID = '3'
-- bài tập về nhà :
--05-SuperMarket : siêu thị
--  thiết kế cho anh một table customer lưu thông tin các hàng gồm các hàng sau :
--(id,name,dob,sex,numberOfInhabitants,phone,email,typeOfCustomer)
CREATE DATABASE SuperMarket(
	ID char(5) not null,
	name nvarchar(30)not null ,
	dob Date ,
	numberOfInhabitants int not null ,
	phone int(11) not null ,
	email char(30) not null ,
	typeOfCustomer bit(3) not null

)
 
--06-PromotionGirl
--(kỹ thuật đệ quy khóa ngoại)
-- tạo talbe lưu trữ thông tin các em promotionGirl
-- trong nhóm các em promotionGirl , sẽ có vài em được chọn ra làm leader
--- các em leader này sẽ quản lý một vài promotionGirl khác
--- chỉ đc dùng 1 table duy nhất để lưu trữ và table đó có thể querry các câu hỏi :
-- 1 : Leader này lead những ai
-- 2: cô này được lead bởi ai ?
CREATE TABLE PromotionGirl(
	Id char(8) primary key not null,
	Name nvarchar(40) not null,
	LID char(8) not null,
	Constraint FK_PromotionGirl_ID_LID
	Foreign key(ID) references PromotionGirl(ID)
)

INSERT INTO PromotionGirl VALUES('P11' , N'Cúc', 'P11')
INSERT INTO PromotionGirl VALUES('P12' , N'Huệ', 'P11')
INSERT INTO PromotionGirl VALUES('P13' , N'Trà', 'P11')

INSERT INTO PromotionGirl VALUES('P21' , N'Lan', 'P21')
INSERT INTO PromotionGirl VALUES('P22' , N'Hồng', 'P21')
INSERT INTO PromotionGirl VALUES('P23' , N'Phượng', 'P21')

--dánh sách leader
SELECT * FROM PromotionGirl
WHERE id = LID
--mỗi nhóm quản lý bao nhiều người
SELECT LID, count(ID) as sl
FROM PromotionGirl
WHERE ID != LID
GROUP BY LID
--ai là quản lý cô hồng
SELECT * FROM PromotionGirl

SELECT LID FROM PromotionGirl
WHERE name in (N'Hồng')

SELECT * FROM PromotionGirl
WHERE ID in (SELECT LID FROM PromotionGirl
				WHERE name in (N'Hồng'))
