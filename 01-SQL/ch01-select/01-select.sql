--- Lý thuyết
--- Trong database không quan tâm hoa thường , nhưng sẽ
--- ưu tiên viết hoa cho keyword

---ta có thể in ra màn hình = lênh print thay cho printf và sout
PRINT 'Ahahahahaha'
--- SELECT cũng có thể dùng để in
SELECT 'Ahihihihihihiih'
--- SELECT luôn trả kq dưới dạng table

--- các kiểu dữ liệu mà sql có lưu
--- số : integer , decimal , float , double , money
--- chuỗi : char(?) , nchar(?) , varchar(?) , nvarchar(?)

--- char , varchar : ko có lưu tiếng việt
--- nchar , nvarchar : thì có thể lưu được
---		? : độ dài của chuỗi  ; n : lưu dấu unicode
--- char và nchar : lưu chuỗi ở ram ==> truy xuất nhanh ==> nhược : ko co giản
--- xin nhiều xài ít thì bù space  , xin ít xài nhiều thì bug
--- phù hợp để lưu các chuỗi có độ dài cố định : số điện thoại , cmnd , id

--- varchar và nvarchar : lưu ở hdd(ổ cứng) -> truy xuất chậm - > có thể co nhưng ko giãn
--- xin nhiều xài ít thì co lại , xin ít xài nhiều thì bug
---phù hợp cho các trường dữ liệu k biết cụ thể dộ dài : tên

---chuỗi thì phải lưu ở '' 
SELECT 'Điệp Đẹp trai'
SELECT N'Điệp đẹp trai'

---ngày tháng năm : date , datetime
---được biểu hiên bằng '' như chuỗi 
---điều này có nghĩa là : '1999-05-31'

---build-in-function : các hàm có sẵn
---ruound(): làm tròn 
---getdate():lấy ra ngày tháng năm thời gian hiện tại
---year():trích xuất ra năm
---month():trích xuất ra tháng
---day():trích xuất ra ngày
SELECT YEAR('1999-05-31')---1999

---1. in ra một sự thật khó nói 'Anh Điệp Đẹp Trai Quá , em rất iu em <3'
SELECT N'Anh Điệp Đẹp Trai Quá , em rất iu em <3'
---2.in ra ngày tháng năm hiện tại
SELECT GETDATE()
---3. in ra năm hiện tại
SELECT YEAR(GETDATE())
---4. in ra tuổi của e
SELECT YEAR(GETDATE()) - 2004 as AGE
SELECT AGE = YEAR(GETDATE()) - 2004
---5. in ra tổng của 5 + 10 
SELECT 'tổng của 5 + 10'
SELECT '5 + 10'
SELECT '15'
SELECT '5' + 10
SELECT 5 + '10'
SELECT 5 + 10
SELECT '5' - '10'--- ko đc vì ko có lưu đc số 5
---6. in ra tên của em kết hợp với '<3' và tên của ny em
SELECT N'Nam' + '<3' 'Ngân'
SELECT CONCAT(N'Nam' , '<3', 'Ngân')