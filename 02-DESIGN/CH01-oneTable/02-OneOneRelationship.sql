--02-OneOneRelationship
-- mối quan hệ 1-1
-- thực thể là thực thể đc tạo ra bởi 2 thực thể khác để tạo thành nhiêu - nhiểu
-- trên thực tế thì thực thể yếu ko co tồn tại

CREATE DATABASE DBK19C3_OneOneRelationship
USE DBK19C3_OneOneRelationship

--- anh tạo table lưu thông tin của các cư dân
CREATE TABLE Citizen(
	CID char(9) not null ,
	LastName varchar(30) not null,
	FirstName varchar(30) not null,

)
Alter Table Citizen
	add constraint PK_Citizen_CID primary key(CID)

INSERT INTO Citizen Values('C1',N'Nguyễn',N'An')
INSERT INTO Citizen Values('C2',N'Lê',N'Bình')
INSERT INTO Citizen Values('C3',N'Võ',N'Cường')
INSERT INTO Citizen Values('C4',N'Phạm',N'Dũng')

SELECT * FROM Citizen

--Tạo table passport để lưu trữ xem ai đang dùng passport
--1 công nhân được sở hữu 1 passport
--1 cmnd có thể tạo đc 1 passport mà thôi
-- và 1 passport chỉ được tạo từ 1 cmmnd mà thôi
DROP TABLE Passport
CREATE TABLE Passport(
	PNO char(9) not null , --primary key
	IssuedDate date, --ngày cấp
	ExpiredDate  Date, -- ngày hết hạn
	CMND char(9) not null, -- cần unique để 1 công dân chỉ đc xuất hiện 1 lần
)
--primary key cho PNO  k có 2 cái passport giống nhau
Alter Table Passport
	add constraint PK_Passport_PNO primary key(PNO)
--foreign key : khóa ngoại : rằng buộc tham chiếu , chỉ đc lấy giá trị , tham chiếu ở table khác
-- rằng buộc tham chiếu cho cmnd , ép rằng giá trị của cmnd phải tồn tại trước đó trong cột CID
Alter Table Passport
	add constraint FK_Passport_CMND_CITIZEN_CID 
		Foreign key (CMND) references CITIZEN(CID)
--unique : cấm trùng --> cấm cho cmnd đc dùng nhiều lần để tạo passport , mỗi cmnd chỉ đc xuất hiện 1 lần

Alter Table Passport
	add constraint Uq_Passport_CMND UNIQUE(CMND)

INSERT INTO Passport VALUES ('P1','2024-7-9','2034-7-9','C1')
INSERT INTO Passport VALUES ('P1','2024-7-9','2034-7-9','C2')
INSERT INTO Passport VALUES ('P2','2024-7-9','2034-7-9','C1')
INSERT INTO Passport VALUES ('P3','2024-7-9','2034-7-9',null)
INSERT INTO Passport VALUES ('P1','2024-7-9','2034-7-9','C7')
INSERT INTO Passport VALUES ('P2','2024-7-9','2034-7-9','C2')

-- kết : 1-1 (FK,UQ)
--- mối quan hệ 1 - N (FK)

---xem thử passport p2 là của ai ? 
--1 : subquerry
SELECT * FROM Citizen 
WHERE CID = (SELECT CMND FROM Passport
			WHERE PNO = 'P2')

SELECT * FROM Pas
--2 : join
SELECT * FROM Passport p
left JOIN Citizen c on p.CMND = c.CID
WHERE p.PNO = 'P2'
