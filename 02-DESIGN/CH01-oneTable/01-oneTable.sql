---02-Design
----ch01-oneTable
-----01.oneTable.sql

---học thiết kế và tìm hiểu các thành phần trong 1 table đơn giản
CREATE DATABASE DBK19F3_OneTable
Use DBK19F3_OneTable
-- tạo table lưu thông tin sinh viên
	CREATE TABLE StudentV1(
		ID char(8) primary key,
		firstName nvarchar(30) not null,
		lastName nvarchar(30) not null,
		DOB date null, --- YYYY-MM-DD
		Sex char(1) null, ---M F L G B T U
		Email varchar(50) null,
	)

INSERT INTO StudentV1
		Values('SE123456',N'An',N'Nguyễn','1999-1-1','F','An@')
INSERT INTO StudentV1
		Values('SE123456',N'An',N'Nguyễn','1999-1-1','F','An@')

--Đề xuất : mỗi một table thì nên có ít nhật một cột cấm trùng
-- các cột cấm trùng đều gọi là key hoặc là candidate key
---Student(id,name,dob,phone,email,hộ khẩu, cmnd , bằng lái xe)
---id,email,cmnd,bằng lái xe
---tất cả những tk trên đều là key 
-- và cụ thể là candidate key (key ứng viên)
-- key ứng tuyển vị trí primary key(khóa chính-pk)

--tiêu chí tuyển chọn khóa chính là gì ?
--phải đạt 2 yêu cầu :
--1/ phù hợp với bài toán lưu trữ của table 
--2/ không khả dụng khi ở table khác
--primary key là cấm trung và cấm null
--khóa chính (primary key) là một dạng rằng buộc(constraint)
--rằng buộc là gì?
--Là cách ta ép người dùng nhập đúng data theo một tiêu chuẩn nào đó
-- vd : sex thì phải thuộc 1 trong các M F LG B T U
--vd : tên thì ko đc bỏ trống
---vs : sinh viên ko đc đắng ký quá 5 môn
--- nói riêng về các rằng buộc của các table , ta sẽ có :
---primary key (khóa chính), cấm trung + cấm null
--Unique :  cấm trùng | candidate key (ko cấm null)
-- not null
-- foreign key : khóa ngoại tham chiếu
-- composite key : key kết hợp 
-----Primary key(block,room
--- block | room |owner
-- inno 101 Điệp
-- Anna 101 Hường
-- inno 201 Lan
-- Anna 102 Trà

--super key : siêu khóa vô dụng
--primary(PK,cột)

--weak entry : thực thể yếu

CREATE TABLE StudentV2(
		ID char(8) not null,
		firstName nvarchar(30) not null,
		lastName nvarchar(30) not null,
		DOB date null, --- YYYY-MM-DD
		Sex char(1) null, ---M F L G B T U
		Email varchar(50) null,
	)
ALTER TABLE StudentV2
	Add CONSTRAINT Pk_StudentV2_ID primary key(id)
ALTER TABLE StudentV2
	Add CONSTRAINT Uq_StudentV2_Email Unique(email)
INSERT INTO StudentV2
		Values('SE123456',N'An',N'Nguyễn','1999-1-1','F','An@')
INSERT INTO StudentV2
		Values('SE123457',N'An',N'Nguyễn','1999-1-1','F','An1@')
