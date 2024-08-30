--02-selectTable.sql

---I--Lý thuyết
---Thực tế trên thế giới có rất nhiều dạng database
---Dạng 1\RDBMS : Relationship database managerment system
-- (oracl, mySQL ,MS Sever, PostgreSQL ,graphQL)
-- Dạng 2: CSDL Dạng khóa - giá trị (Redis) , menacahced
--Dạng 3: doccument store - NoSQ ( mongaDB, CouchBase)

---Tại sao cần học RDBMS ?
	---Vì nó đáp ứng cái tính chất của ACID
	--Atomicity : tính nguyên tử : trong 1 chu trình có nhều tác vụ chi trình đc xem là hoàn thành khi toàn
	--bộ các tác vũ hoàn thành nếu có 1 tác vụ false thì xem như chu trình thất bại

	--Consistency:tính nhất quán : 1 tác vụ nếu hoàn thành sẽ tạo ra trạng thái hợp lệ cho dữ liệu
	--							nếu tác vụ thất bại thì dữ liệu sẽ quay về trạng thái hợp lệ gần nhất

	--Isolation : tính độc lập : 1 tác vụ đang thực thi và chưa xác thực sẽ được tách ra khỏi các tác vụ khác

	--Durability : tính bền vững : các dữ liệu đã đc xác thực sẽ đc đc hệ thống lưu lại để khi có trường hợp
	--				hỏng hóc hoặc lỗi thì sẽ backup trở về trang thái gần nhất

---SQL có cấu trúc truy xuất đa dụng giúp dễ dàng query dữ liệu , để dành mở rộng và phát triển dữ liệu (đọc)
---cung cấp phân quyền truy xuất dữ liệu: admin , user , guest, bla bla
---nhược diểm : 
---+ xử lý dữ liệu phi cấu trúc yếu(đánh đổi việc linh hoạt lấy tính bảo mật ACID)
--- tốc độ xử lý dữ liệu khá chậm
--- nên dùng khi nào ? 
--- ==> các trường hợp cần đảm bảo tính toàn vẹn của dữ liệu
--- Không cho phép chỉnh sửa dễ dàng
--- Ví dụ : ứng dụng tài chính , ứng dụng quốc phong, an ninh ,
---			Lĩnh vực sức khỏe cá nhân
--- các lĩnh vực tự động hóa
--- thông tin nội bộ

--Trong database có rát nhiêu table 
--- table là gì ? là dánh sách các đối tượng nào đó
---ví dụ : table Sinh viên(id,name,yob,address)
---			table customer(id,name,phone,address)
--- table : cột//column/field/attribute/property


--- table thì 1 hàng/ row : là một object
---	table là danh sách/ mảng/Array các object giống nhau

--- Trong table luôn có ít nhất 1 cột , mà giá trị của cột không trùng trên toàn bộ table 
--- Trên toàn bộ table , cột này có tên là khóa chính(primary key - PK)

---mục đích : xác định 1 object duy nhất giúp ko có dòng nào trùng 100%

---2.Database là gì ?
---là tập hợp nhiều table có cùng chủ đề , giúp giải quyết 1 bài toàn lưu trữ
---vd : db Bán Hang (tb1 suplier , db1 customer , tb1 employee )
---relationship : 11 , 1n và nn

---3.để có thể xem , thêm , sửa ,xóa dữ liệu thì ta có thể dùng DML của SQL
---Insert ,SELECT , UPDATE , DELETE

-----------------------------------

---II. Thực hành
---Đầu tiên ta chọn database cần truy xuất để sử dụng
USE convenienceStoreDB
--để có thể lấy dữ liệu ra xem thì ta dùng lênh SELECT....FROM...
---1.Liệt kê danh sách nhân viêc có đầy đủ thông tin
SELECT * FROM Employee e
---2.Liệt kê danh sách nhân viêc và ta chỉ xem 1 vài cuộc thôi
---output : id , name , birthday
SELECT e.EmpID , e.FirstName ,e.LastName, e.Birthday FROM Employee e
---3.In ra danh sách fullname của các nhân viên
SELECT  e.EmpID , e.FirstName + ' ' +e.LastName AS FullName FROM Employee e
---4.In ra nhân viên kèm năm sinh của họ
SELECT e.EmpID ,
		e.FirstName + ' ' +e.LastName AS FullName , 
		YEAR(e.Birthday)AS Yob  
		FROM Employee e
---5.Tính tuổi các nhân viên trong công ty
SELECT e.EmpID ,
		e.FirstName + ' ' +e.LastName AS FullName
		, YEAR(GETDATE()) - YEAR(e.Birthday) AS Birth  
		FROM Employee e
---6.In ra thông tin của các nhà cung cấp
SELECT * FROM Supplier
---7.In ra thông tin các nhà vận chuyển
SELECT * FROM Shipper	
---8.In ra xem công ty bán những chủng loại sản phẩm nào
SELECT * FROM Category
---9.Kiểm tra công ty bán những sản phẫm gì
SELECT * FROM Product
---10. kiểm tra xem trong kho có những gì
SELECT * FROM Barn
---11.In ra thông tin các đơn hàng đã bán
SELECT * FROM Orders
---12. In ra thông tin các đơn hàng , trọng lượng của đơn hàn
--output : ordID, customerId,EmpID,Freight
SELECT o.OrdID , o.CustomerID , o.EmpID , o.Freight FROM Orders o
--13.In ra thông tin chi tiết đơn hàng(mua món nào , số lượng bao nhiêu)
SELECT * FROM OrdersDetail
SELECT * FROM Orders








)