---07-null.sql
--trong c có void , ko có khái niệm về null
--void :không có gì hết, không thể chứa trong biến , ko có giá trị, ko có để  hứng giá trị
--trong java có cả 2
--undefined(js) : có thể chứa được nhưng ko biết kiểu, không biết giá trị

-- null biết kiểu nhma ko biết giá trị, mặt khác : có thể chứa đc, biết kiểu dữ liệu , nhma ko có giá trị cụ thể


--- định nghĩa bith : trong thực tế , dữ liệu đôi khi không có giá trị tại 1 thời điểm nào đó
---vd : đi thi thì ko điền thông tin vào ô điểm , ô điểm tại thời điểm đó là null
--- cập nhật sau
---> null không phải là một giá trị(mà là trạng thái) của dữ liệu 
--- lưu ý;
-- null ko phải giá trị
---null ko phải là toán tử so sánh
----> name = null : sai
----> name is null,  name is not null ; not(name is null)

---Thực hành
--- xài database covenienceStore
use convenienceStoreDB
--- liệt kê danh sách khách hàng
SELECT * FROM Customer
---Liệt kê khách hàng chưa có sdt
SELECT*
FROM Customer
WHERE PhoneNumber is null
---liệt kê danh sách khách hàng đã cập nhật sdt: 3 cách
SELECT*
FROM Customer
WHERE PhoneNumber is not null

SELECT*
FROM Customer
WHERE not PhoneNumber is  null

SELECT*
FROM Customer
WHERE not(not PhoneNumber is not null)
--- =)))))))))))))))))))))))))))))))))))))))))

---Liệt kê đơn hàng chưa có ngày yêu cầu , gửi đến london và california(2 cách)
SELECT *
FROM Orders
WHERE ShipCity in ('London','California') and  RequiredDate is null

SELECT *
FROM Orders
WHERE (ShipCity = 'London' or ShipCity = 'California') and  RequiredDate is null
---Liệt kê đơn hàng có ngày yêu cầu
SELECT *
FROM Orders
WHERE RequiredDate is not null
--- liệt kê đơn hàng có ngày yêu cầu và được gửi bởi ct vận chuyển có mã số là SHIP001 và SHIP004

SELECT *
FROM Orders
Where ShipID in ('SHIP001','SHIP004') and RequiredDate is not null
---Đơn hàng nào ở London có ngày yêu cầu khác null
SELECT *
FROM Orders
Where RequiredDate is not null and ShipCity = 'London'