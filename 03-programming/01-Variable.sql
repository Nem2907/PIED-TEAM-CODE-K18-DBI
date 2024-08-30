---03-programming
--		01-Variable.sql
--DB engine là một môi trường / tool / appp nhận lệnh sql
--kiểm tra cú pháp --> dịch lệnh
--->compiler and runtime

--DBE cung cấp đủ môi trường lập trình giống như bối cảnh lập trình
--nhưng k thể so sánh SQL với java hay c , c# , jS , nodej

--khai báo biến, có lệnh if else 
--while.... , hàm (procedure ,trigger)
--vì sử dụng data từ các table đã lưu nên không có hàm scanf
--mục tiêu của lập trình trong database là gì ?
--khai khác tinh toán dữ liệu đã có sẵn 1 các nhanh chóng
-- nó ko đủ các lệnh về lập trình

USE DBK19C3_OneManyRelationship
SELECT * FROM PromotionGirl

declare @yob1 int 
declare @yob2 int  = 2005
declare @FirstName nvarchar(40) = (SELECT Name From PromotionGirl
									WHERE ID = 'P11')

--- cách đổi giá trị
set @yob2 = 2007
print @yob2
SELECT @yob2
--Hàm
--produce : hàm thủ tục , hàm bị động
-- khi tạo ra thì nó không tự chạy , có người gọi nó mới chạy
--vd : viết hàm nhận vào 1 leadID, tìm các thành viên của id đó

--- ArrayList<PromotionGirl> getMemberByLIDV1(String leadID){	logic	}
go
CREATE Procedure getMemberByLIDV11(@LeaderID char(4)) as
begin
	SELECT * From PromotionGirl WHERE LID = @LeaderID
end

exec dbo.getMemberByLIDV11 'P21'

---tạo ra một hàm khác getMemberByLIDV2 , muốn hàm nhận vào leaderID
--nhưng nếu leaderID không có thành viên nào thì in ra màn hình : 'nothing to print'
--nếu có thì in ra danh sách các thành viên của leader đó

go
CREATE Procedure getMemberByLIDV2(@LeaderID char(4)) as
IF (SELECT * FROM PromotionGirl WHERE LID = @LeaderID) is null
	begin
	SELECT('nothing to print')
	end
else
	begin
	SELECT * FROM PromotionGirl WHERE LID = @LeaderID
	end

go
CREATE Procedure getMemberByLIDV23(@LeaderID char(4)) as
begin
	Declare @sl int = (SELECT COUNT(ID) FROM PromotionGirl WHERE LID = @LeaderID)
	IF @sl = 0 
		begin
			print 'Nothing to print'
		end
	ELSE
		begin
			SELECT * FROM PromtionGirl WHERE LID = @LeaderID
		end
end

exec dbo.getMemberByLIDV23 'P13'
	

