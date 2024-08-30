--04-orderBy.sql

--dùng databasse
use convenienceStoreDB
--I- Lý thuyết
--câu SELECT luôn trả ra kết quả dưới dạng table
-- ta có thể sắp xếp các dòng trong table theo  1 cột nào đó
-- nhưng chắc chắn rằng hành động sắp xếp này KHÔNG ảnh hưởng đến 
-- thứ tự của các table gốc

--Quy tắc sắp xếp 
--số : só sánh bình thường 
--ngày tháng năm : so sánh bth
--- 1999-05-31 và 1999-06-1 
--chuỗi : không so sánh theo độ dài ,
--- só sánh theo cặp đối xứng , bằng = next , lệch thì return 
--- mọi thứ sẽ phức tạp hơn nếu mình phải so sánh 2 cột trở lên
--- thứ tự liệt kê không quan trong , quan trọng là thứ tự trong table
--- so sánh cột đầu tiên , nếu trùng thì so sánh cột tiếp theo của nội bộ nhóm trùng
--- nội dung bộ nhóm trùng
--- SELECT ... FROM ... Order By cột asc/desc ,cột asc/desc , cột....


--II- thực hành

--1.In ra thông tin các đơn hàng
SELECT * FROM Orders
--2. In ra danh sách các đơn hàng được sắp xếp theo trọng lượng
--giảm dần
SELECT * FROM Orders 
ORDER BY Freight DESC
--3. in ra danh sách nhân viên đc sắp xếp theo tên(first name)
--giảm dần
SELECT * FROM Employee e 
ORDER BY e.FirstName DESC 
--4.In ra danh sách các đơn hang sắp xếp theo mã nhân viên phụ trách và
--giảm dần theo trọng lượng
SELECT * FROM Orders o ORDER BY o.EmpID, o.Freight DESC