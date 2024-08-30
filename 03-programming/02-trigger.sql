--02-trigger.sql
--lấy mô phỏng là anh đang quản lý một tiệm tạp hóa
--có 2 hướng
-- 1:quản lý kho
-- 2:đơn đặt hàng
USE DBK19C3_OneManyRelationship
DROP TABLE tb1_DatHang
DROP TABLE tb1_KhoHang
CREATE TABLE tb1_KhoHang(
	MaHang int primary key ,
	TenHang nvarchar(30),
	SoLuongTon int
)

INSERT INTO tb1_KhoHang values(1,'String',20)
INSERT INTO tb1_KhoHang values(2,'numberOne',10)
INSERT INTO tb1_KhoHang values(3,'C2',40)

--tạo table lưu các đơn đặt hàng
CREATE TABLE tb1_DatHang(
	id int primary key ,
	MaHangTrongDatHang int ,
	SoLuongDat int ,
	Foreign key (MaHangTrongDatHang) references tb1_KhoHang(MaHang)
)
go
CREATE Trigger Trg_khiDatHang on Tb1_DatHang after insert as
begin
	update tb1_KhoHang
	set SoLuongTon = SoLuongTon - (SELECT SUM(SoLuongDat) as SL FROM inserted
									WHERE MaHangTrongDatHang = tb1_KhoHang.MaHang
									Group BY MaHangTrongDatHang)
	FROM tb1_KhoHang join inserted on tb1_KhoHang.MaHang = inserted.MaHangTrongDatHang
end
INSERT INTO tb1_DatHang values(4,2,3)
INSERT INTO tb1_DatHang values(5,1,7)
INSERT INTO tb1_DatHang values(6,1,6)

SELECT * FROM tb1_KhoHang

--co che xoa

go
CREATE Trigger Trg_khiHuyDonHang on Tb1_DatHang for delete as
begin
	update tb1_KhoHang
	set SoLuongTon = SoLuongTon + (SELECT SUM(SoLuongDat) as SL FROM deleted
									WHERE MaHangTrongDatHang = tb1_KhoHang.MaHang
									Group BY MaHangTrongDatHang)
	FROM tb1_KhoHang join deleted on tb1_KhoHang.MaHang = deleted.MaHangTrongDatHang
end

DELETE tb1_DatHang WHERE ID in ('4','5','6')

SELECT * FROM tb1_KhoHang

--- co che cap nhat don hang
go
CREATE Trigger Trg_CapNhatDatHang on Tb1_DatHang after update as
begin
	update tb1_KhoHang
	set SoLuongTon = SoLuongTon + (SELECT SUM(SoLuongDat) as SL FROM deleted
									WHERE MaHangTrongDatHang = tb1_KhoHang.MaHang
									Group BY MaHangTrongDatHang) 
								- (SELECT SUM(SoLuongDat) as SL FROM inserted
									WHERE MaHangTrongDatHang = tb1_KhoHang.MaHang
									Group BY MaHangTrongDatHang)
	FROM tb1_KhoHang join deleted on tb1_KhoHang.MaHang = deleted.MaHangTrongDatHang
end

INSERT INTO tb1_DatHang values (5,2,5)

UPDATE tb1_DatHang set SoLuongDat = 2 WHERE id = '4'

SELECT * FROM tb1_KhoHang

-- hiệu năng , trigger tốn nhiều tài nguyên duy trì
--nhưng nó đem lại khả năng tự động hóa
-- về mặt bảo mật thì kém

--procedure phục vụ những chức nagnw mà mình muốn gọi nó