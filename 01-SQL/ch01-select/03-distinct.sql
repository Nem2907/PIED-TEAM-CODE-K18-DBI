---Distents
-------------------
--I - lý thuyết
---------------------
--1 table thường luôn có 1 cột mà các giá trị của cột đó không trùng trên toàn bộ
--table, cột đó là PK

--1 câu lệnh select luôn cho ra kết quả dưới dạng table
--		khi ta select * thì ta sẽ lấy tất cả các cột(bao gồm cột PK)
--			điều đó sẽ làm cho không cột nào trong 1 hàng có thể trùng nhau 100%
--			2 học sinh có thể cùng tên, cùng điểm , cùng tuổi
--			nhưng sẽ khác id của nhau

--		nhưng nếu ta chỉ select 1 vài cột, không phải tất cả, và không gọi cột pk
--			thì khi đó, table ta nhận được là 1 table không có pk để tạo sự khác biệt
--		lúc này ta sẽ thu về rất nhiều data trùng nhau(tuple/bộ trùng nhau), 
--		ta có thể loại bỏ những data trùng nhau(những dòng trùng nhau) 
--		bằng keyword Distinct

--distinct luôn nằm sát bên select
--distinct vô dụng với * vì nó lấy cả PK (làm cho 
--không dòng nào trùng 100%)
-----------------------------
--Thực hành
----------------------------
USE convenienceStoreDB
SELECT DISTINCT * FROM Orders
--1 IN RA THÔNG TIN KHÁCH HÀNG
SELECT * FROM Customer
--2.in ra danh sách các thành phố mà khách hàng của bạn sinh sống
SELECT DISTINCT City FROM Customer
--3.in ra thông tin các đơn hàng đã nhập vào kho
SELECT DISTINCT * FROM InputBill
--4.liệt kê danh sách các sản phẫm đã nhập
SELECT DISTINCT ProID FROM InputBill