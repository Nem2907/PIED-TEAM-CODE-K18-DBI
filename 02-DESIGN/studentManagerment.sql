--studentManagement.sql

CREATE DATABASE DBK19F3_studentManagement 
USE DBK19F3_studentManagement 

CREATE TABLE Major
(
  Major_ID CHAR(2) NOT NULL,
  Major_Name VARCHAR(30) NOT NULL,
  constraint PK_Major_ID PRIMARY KEY (Major_ID),
  constraint UQ_Major_Name UNIQUE (Major_Name)
)

CREATE TABLE Student
(
  Student_ID CHAR(8) NOT NULL,
  Student_Name VARCHAR(30) NOT NULL,
  MID CHAR(2) NOT NULL,
  constraint PK_Student_ID PRIMARY KEY (Student_ID),
  constraint FK_Student_MID_Major_ID 
  FOREIGN KEY (MID) REFERENCES Major(Major_ID)
)

CREATE TABLE Teacher
(
  Teacher_ID CHAR(8) NOT NULL,
  Teacher_Name VARCHAR(30) NOT NULL,
  constraint PK_Teacher_ID PRIMARY KEY (Teacher_ID)
)

CREATE TABLE Room
(
  RoomName CHAR(4) NOT NULL,
  SEQ INT identity(1,1) NOT NULL,
  Stu_ID CHAR(8) NOT NULL,
  Tea_ID CHAR(8) NOT NULL,
  constraint PK_Room_S PRIMARY KEY (SEQ),
  FOREIGN KEY (Stu_ID) REFERENCES Student(Student_ID),
  FOREIGN KEY (Tea_ID) REFERENCES Teacher(Teacher_ID),
)
--nhét giá trị cho Major
Insert Into Major values ('SB', 'Quan tri kinh doanh')
Insert Into Major values ('SE', 'Ky thuat pham mem')
Insert Into Major values ('GD', 'Thiet ke do hoa')
--sinh viên
Insert into Student Values('S1', 'Hung', 'SB')
Insert into Student Values('S2', 'Kiet', 'SB')
Insert into Student Values('S3', 'Tuan', 'SE')
Insert into Student Values('S4', 'Huong', 'SE')
Insert into Student Values('S5', 'Tam', 'SE')
Insert into Student Values('S6', 'Phuoc', 'GD')
Insert into Student Values('S7', 'Phuong', 'GD')
--giáo viên
Insert into Teacher values ('T1', 'Hoang')
Insert into Teacher values ('T2', 'Khanh')
Insert into Teacher values ('T3', 'Hoa')
--thêm thông tin phòng học
insert into Room values ('R001','S1', 'T1')
insert into Room values ('R001','S2', 'T1')
insert into Room values ('R002','S4', 'T1')
insert into Room values ('R002','S3', 'T2')
insert into Room values ('R002','S4', 'T2')
insert into Room values ('R003','S5', 'T3')
insert into Room values ('R003','S6', 'T3')
insert into Room values ('R003','S7', 'T3')

--1.Thầy Hoàng dạy những ai
SELECT Teacher_ID FROM Teacher
WHERE Teacher_Name = 'Hoang'

SELECT Stu_ID
FROM Room
WHERE Tea_ID = (SELECT Teacher_ID FROM Teacher
				WHERE Teacher_Name = 'Hoang')

SELECT * FROM Student
WHERE Student_ID in (SELECT Stu_ID
					 FROM Room
					 WHERE Tea_ID = (SELECT Teacher_ID FROM Teacher
									 WHERE Teacher_Name = 'Hoang'))
--2.Ai học thầy Hoàng nhưng k học ngành SE
SELECT * FROM Student
WHERE Student_ID in (SELECT Stu_ID
					 FROM Room
					 WHERE Tea_ID = (SELECT Teacher_ID FROM Teacher
									 WHERE Teacher_Name = 'Hoang'))
AND MID != 'SE'
--3.đếm xem có bao nhiều học thầy Khánh
SELECT COUNT(Student_ID) as SL FROM Student
WHERE Student_ID in (SELECT Stu_ID
					 FROM Room
					 WHERE Tea_ID = (SELECT Teacher_ID FROM Teacher
									 WHERE Teacher_Name = 'Khanh'))
--4.mỗi giáo viên dạy bao nhiêu học sinh
SELECT t.Teacher_ID , count(Stu_ID) as SL 
FROM Teacher t left join room r on t.Teacher_ID = r.Tea_ID
group by t.Teacher_ID 
--
SELECT * 
FROM (SELECT t.Teacher_ID , count(Stu_ID) as SL 
	  FROM Teacher t left join room r on t.Teacher_ID = r.Tea_ID
	  group by t.Teacher_ID ) as ld left join Teacher t
								on ld.Teacher_ID = t.Teacher_ID
--lấy thêm tên giáo viên

--5.** mỗi giáo viên dạy bao nhiêu học sinh của mỗi chuyên ngành


--6.in ra thông tin của sinh viên kèm thông tin các giáo viên mà sinh viên đó
--theo học
SELECT * 
FROM Student s left join room r on s.Student_ID = r.Stu_ID
				left join Teacher t on r.Tea_ID = t.Teacher_ID
--7.in ra thông tin giáo viên của sinh viên có mã là S4
SELECT * 
FROM Student s left join room r on s.Student_ID = r.Stu_ID
				left join Teacher t on r.Tea_ID = t.Teacher_ID
	WHERE Stu_ID = 'S4'
--8. ai là người có nhiều học sinh nhất
SELECT ld.Teacher_ID, t.Teacher_Name, ld.sl
FROM (SELECT t. Teacher_ID, count(Stu_ID) as sl
	  FROM Teacher t left join Room r on t. Teacher_ID = r. Tea_ID
	  group by t. Teacher_ID) as ld left join Teacher t 
							 on ld.Teacher_ID = t. Teacher_ID
WHERE ld.sl >=ALL(SELECT ld.sl
				  FROM (SELECT t. Teacher_ID, count(Stu_ID) as sl
					    FROM Teacher t left join Room r on t. Teacher_ID = r. Tea_ID
					    group by t. Teacher_ID) as ld left join Teacher t 
							 on ld. Teacher_ID = t. Teacher_ID)
--9. phòng học nào có nhiều học sinh nhất
SELECT RoomName,Count(Stu_ID) as SL 
FROM Student s left join room r on s.Student_ID = r.Stu_ID
group by RoomName
--10. giáo viên nào dạy nhiều sinh viên học ngành SE nhất
SELECT RoomName,Count(Stu_ID) as SL 
FROM Student s left join room r on s.Student_ID = r.Stu_ID
WHERE s.MID = 'SE'
group by RoomName
--lấy tên anh Khánh