﻿ --ĐỀ TÀI: PHÂN TÍCH THIẾT KẾ HỆ THỐNG QUẢN LÝ PHÒNG KHÁCH SẠN H2O
-- CƠ SỞ DỮ LIỆU

CREATE DATABASE QLKS_H2O
GO

USE QLKS_H2O
GO

CREATE TABLE LOAIPHONG -- CÁC LOẠI PHÒNG TRONG KHÁCH SẠN
(
	MA_LOAIPHONG VARCHAR(10) NOT NULL PRIMARY KEY,
	TEN_LOAIPHONG NVARCHAR(50) NOT NULL,
	KICHTHUOC INT NOT NULL,
	MAMAU VARCHAR(10),
	ANH VARCHAR(100)
)


CREATE TABLE VATTU -- CÁC LOẠI VẬT TƯ
(
	MA_VATTU VARCHAR(5) NOT NULL PRIMARY KEY,
	TEN_VATTU NVARCHAR(50) NOT NULL
)

CREATE TABLE VATTU_LOAIPHONG -- VẬT TƯ TRONG MỖI LOẠI PHÒNG
(
	MA_VATTU VARCHAR(5) NOT NULL FOREIGN KEY REFERENCES VATTU(MA_VATTU) ON DELETE CASCADE,
	MA_LOAIPHONG VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES LOAIPHONG(MA_LOAIPHONG) ON DELETE CASCADE,
	SOLUONG TINYINT NOT NULL,
	PRIMARY KEY (MA_VATTU, MA_LOAIPHONG)
)

CREATE TABLE TRANGTHAI_PHONG -- CÁC TRẠNG THÁI CỦA PHÒNG
(
	MA_TRANGTHAI VARCHAR(2) NOT NULL PRIMARY KEY,
	TEN_TRANGTHAI NVARCHAR(100) NOT NULL,
	MAMAU VARCHAR(10) NOT NULL
)

CREATE TABLE PHONG -- CÁC PHÒNG TRONG KHÁCH SẠN
(
	MA_PHONG VARCHAR(10) NOT NULL PRIMARY KEY,
	MA_LOAIPHONG VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES LOAIPHONG(MA_LOAIPHONG) ON DELETE CASCADE,
	GIAPHONG MONEY NOT NULL, -- Giá phòng hiện tại
	MA_TRANGTHAI VARCHAR(2) NOT NULL FOREIGN KEY REFERENCES TRANGTHAI_PHONG(MA_TRANGTHAI) ON DELETE CASCADE
)

CREATE TABLE KHACH -- KHÁCH THUÊ PHÒNG
(
	MA_KHACH VARCHAR(10) NOT NULL PRIMARY KEY,
	HOTEN_KHACH NVARCHAR(50) NOT NULL,
	CMND VARCHAR(10) UNIQUE NOT NULL,
	DIENTHOAI VARCHAR(15) NOT NULL,
	QUOCTICH NVARCHAR(20) NOT NULL,
	GIOITINH BIT DEFAULT 1 NOT NULL,
	NGAYSINH DATE NOT NULL
)

CREATE TABLE NHANVIEN -- CÁC NHÂN VIÊN TRONG KHÁCH SẠN
(
	MA_NHANVIEN VARCHAR(10) NOT NULL PRIMARY KEY,
	PASSWORD VARCHAR(50) NOT NULL,
	HOTEN_NHANVIEN NVARCHAR(50) NOT NULL,
	NGAYSINH DATE NOT NULL,
	DIENTHOAI VARCHAR(15) NOT NULL,
	DIACHI NVARCHAR(200) NOT NULL,
	BOPHAN NVARCHAR(50) NOT NULL
)

CREATE TABLE DICHVU -- CÁC DỊCH VỤ HIỆN CÓ TRONG KHÁCH SẠN
(
	MA_DICHVU VARCHAR(10)  NOT NULL PRIMARY KEY,
	TEN_DICHVU NVARCHAR(100)  NOT NULL,
	GIA_DICHVU MONEY  NOT NULL -- GIÁ DỊCH VỤ HIỆN TẠI
)

CREATE TABLE PHIEU_THUEPHONG -- ĐANG THUÊ PHÒNG
(
	SO_PHIEU VARCHAR(10) NOT NULL PRIMARY KEY,
	MAKHACH VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES KHACH(MA_KHACH) ON DELETE CASCADE,
	MA_NHANVIEN VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES NHANVIEN(MA_NHANVIEN) ON DELETE CASCADE, -- NHÂN VIÊN ĐÓN KHÁCH
	NGAYLAP_PHIEU DATE NOT NULL,
	NGAYDEN DATE NOT NULL,
	NGAYDI DATE NOT NULL,
	DATRAPHONG BIT DEFAULT 0 -- 0: CHƯA TRẢ PHÒNG, 1: ĐÃ TRẢ PHÒNG
)

CREATE TABLE CHITIET_THUEPHONG -- MỘT KHÁCH CÙNG LÚC CÓ THỂ THUÊ NHIỀU PHÒNG (ĐI ĐOÀN)
(
	SO_PHIEU VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES PHIEU_THUEPHONG(SO_PHIEU) ON DELETE CASCADE,
	MAPHONG VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES PHONG(MA_PHONG) ON DELETE CASCADE,
	SONGUOI TINYINT NOT NULL,
	GIAPHONG MONEY NOT NULL, -- Giá phòng khi tại thời điểm thuê
	PRIMARY KEY(SO_PHIEU, MAPHONG)
)

CREATE TABLE CHITIET_THUEDICHVU -- KHÁCH/ĐOÀN THUÊ THÊM DỊCH VỤ
(
	SO_PHIEU VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES PHIEU_THUEPHONG(SO_PHIEU) ON DELETE CASCADE,
	MA_DICHVU VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES DICHVU(MA_DICHVU) ON DELETE CASCADE,
	SOLUONG INT NOT NULL,
	GIA_DICHVU MONEY NOT NULL, -- GIÁ DỊCH VỤ TẠI THỜI ĐIỂM KHÁCH THUÊ PHÒNG
	PRIMARY KEY (SO_PHIEU, MA_DICHVU)
)

INSERT INTO LOAIPHONG
VALUES ('SGL', N'PHÒNG ĐƠN', 25, '#2060d0','anh7.jpg'),
	   ('TWN', N'PHÒNG HAI GIƯỜNG ĐƠN', 30, '#20d027', 'anh7.jpg'),
	   ('TRPL', N'PHÒNG BA GIƯỜNG ĐƠN', 50, '#d0c420', 'anh7.jpg'),
	   ('DBL', N'PHÒNG GIƯỜNG ĐÔI', 50, '#d04a20', 'anh7.jpg'),
	   ('DLX', N'PHÒNG GIƯỜNG ĐÔI CÓ VIEW', 50, '#13dad2', 'anh7.jpg'),
	   ('FAM', N'PHÒNG GIA ĐÌNH', 70, '#dd23de', 'anh7.jpg')

INSERT INTO VATTU
VALUES ('GD', N'GIƯỜNG ĐƠN'),
	   ('GDB', N'GIƯỜNG ĐÔI'),
	   ('TV', N'TI VI'),
	   ('TM', N'TỦ MÁT'),
	   ('MS', N'MÁY SẤY'),
	   ('DH', N'MÁY ĐIỀU HÒA'),
	   ('KH', N'KHĂN TẮM'),
	   ('DE', N'DÉP'),
	   ('GO', N'GỐI'),
	   ('CH', N'CHĂN'),
	   ('BA', N'BÀN'),
	   ('TU', N'TỦ'),
	   ('NET', N'THIẾT BỊ MẠNG')

INSERT INTO VATTU_LOAIPHONG
VALUES ('GD', 'SGL',1), ('GD', 'TWN', 2), ('GD', 'TRPL', 3), ('GD', 'DBL', 0), ('GD', 'DLX', 0), ('GD', 'FAM', 2),
	   ('GDB', 'SGL',0), ('GDB', 'TWN', 0), ('GDB', 'TRPL', 0), ('GDB', 'DBL', 1), ('GDB', 'DLX', 1), ('GDB', 'FAM', 2),
	   ('TV', 'SGL',1), ('TV', 'TWN', 1), ('TV', 'TRPL', 1), ('TV', 'DBL', 1), ('TV', 'DLX', 1), ('TV', 'FAM', 1),
	   ('TM', 'SGL',1), ('TM', 'TWN', 1), ('TM', 'TRPL', 1), ('TM', 'DBL', 1), ('TM', 'DLX', 1), ('TM', 'FAM', 1),
	   ('MS', 'SGL',1), ('MS', 'TWN', 1), ('MS', 'TRPL', 1), ('MS', 'DBL', 1), ('MS', 'DLX', 1), ('MS', 'FAM', 1),
	   ('DH', 'SGL',1), ('DH', 'TWN', 1), ('DH', 'TRPL', 1), ('DH', 'DBL', 1), ('DH', 'DLX', 1), ('DH', 'FAM', 1),
	   ('KH', 'SGL',2), ('KH', 'TWN', 4), ('KH', 'TRPL', 6), ('KH', 'DBL', 4), ('KH', 'DLX', 4), ('KH', 'FAM', 12),
	   ('DE', 'SGL',1), ('DE', 'TWN', 2), ('DE', 'TRPL', 3), ('DE', 'DBL', 2), ('DE', 'DLX', 2), ('DE', 'FAM', 6),
	   ('GO', 'SGL',1), ('GO', 'TWN', 2), ('GO', 'TRPL', 3), ('GO', 'DBL', 2), ('GO', 'DLX', 2), ('GO', 'FAM', 6),
	   ('CH', 'SGL',1), ('CH', 'TWN', 2), ('CH', 'TRPL', 3), ('CH', 'DBL', 1), ('CH', 'DLX', 1), ('CH', 'FAM', 4),
	   ('BA', 'SGL',0), ('BA', 'TWN', 0), ('BA', 'TRPL', 1), ('BA', 'DBL', 1), ('BA', 'DLX', 1), ('BA', 'FAM', 2),
	   ('TU', 'SGL',0), ('TU', 'TWN', 0), ('TU', 'TRPL', 1), ('TU', 'DBL', 1), ('TU', 'DLX', 1), ('TU', 'FAM', 1),
	   ('NET', 'SGL',1), ('NET', 'TWN', 1), ('NET', 'TRPL', 1), ('NET', 'DBL', 1), ('NET', 'DLX', 1), ('NET', 'FAM', 1)

INSERT INTO TRANGTHAI_PHONG
VALUES ('VD', N'PHÒNG TRỐNG BẨN', '#3c1717'),
	   ('AE', N'PHÒNG ĐÃ ĐƯỢC ĐẶT', '#1900ec'),
	   ('OO', N'PHÒNG HƯ HỎNG', '#ec0000'),
	   ('HU', N'PHÒNG NỘI BỘ', '#00cbec'),
	   ('OC', N'PHÒNG KHÁCH ĐANG Ở', '#06ec0d'),
	   ('VC', N'PHÒNG TRỐNG SẠCH', '#ffffff')

INSERT INTO PHONG
VALUES ('101', 'TWN', 0, 'HU'),

	   ('201', 'TWN', 300000, 'VC'),
	   ('202', 'SGL', 250000, 'OC'),
	   ('203', 'TRPL', 400000, 'VC'),
	   ('204', 'FAM', 720000, 'OC'),

	   ('301', 'TWN', 300000, 'VC'),
	   ('302', 'SGL', 250000, 'OC'),
	   ('303', 'TRPL', 400000, 'VC'),
	   ('304', 'FAM', 720000, 'OC'),

	   ('401', 'DBL', 350000, 'OC'),
	   ('402', 'SGL', 250000, 'OC'),
	   ('403', 'TRPL', 400000, 'VC'),
	   ('404', 'DLX', 540000, 'VC'),
	   ('405', 'DLX', 540000, 'VC'),

	   ('501', 'DBL', 350000, 'OC'),
	   ('502', 'SGL', 250000, 'VC'),
	   ('503', 'TRPL', 400000, 'OC'),
	   ('504', 'DLX', 540000, 'VC'),
	   ('505', 'DLX', 540000, 'OC')

INSERT INTO DICHVU
VALUES ('XE', N'THUÊ XE MÁY', 130000),
	   ('AN', N'ĂN SÁNG', 40000),
	   ('DL', N'DU LỊCH', 500000),
	   ('TX1', N'ĐẶT TAXI TỚI SÂN BAY', 100000),
	   ('TX2', N'ĐẶT TAXI TỚI BẾN XE', 100000),
	   ('NU', N'NƯỚC SUỐI', 10000),
	   ('CL', N'COCACOLA LON', 200000),
	   ('BI', N'BIA', 40000),
	   ('TT', N'TRANG TRÍ PHÒNG', 200000),
	   ('GU', N'GẶT ỦI', 50000)

INSERT INTO NHANVIEN
VALUES ('NV001', '1234', N'ĐOÀN QUỐC NHÂN', '1999/1/1', '0376060699', N'CAM RANH - KHÁNH HÒA', N'QUẢN LÝ'),
	   ('NV002', '1234', N'TRẦN NHÂN SINH', '1999/10/29', '0378879849', N'CĐÔNG HÒA - PHÚ YÊN', N'LỄ TÂN'),
	   ('NV003', '1234', N'NGUYỄN ANH HẢI', '1999/11/29', '0336745880', N'SÔNG CẦU - PHÚ YÊN', N'KẾ TOÁN'),
	   ('NV004', '1234', N'NGUYỄN BÙI MINH HIẾU', '1999/10/29', '0123456789', N'CAM RANH - KHÁNH HÒA', N'VẬT TƯ')

INSERT INTO KHACH
VALUES ('094857463', N'NGUYỄN VĂN ANH KHOA', '221321326', '0123424340', N'VIỆT NAM', 1, '1999-10-1'),
	   ('201232341', N'Shane Filbert', 'BF3484SDF', '0912871627', N'ANH', 1, '1999-7-7'),
	   ('123412324', N'Steven William', 'BF3AS75SDF', '0982712218', N'ANH', 1, '1998-1-13'),
	   ('454523134', N'Lilly Collins', 'HG3ASUES5', '0122391281', N'NGA', 1, '1999-8-8'),
	   ('456734734', N'Louis Howard', 'PO75FJFU', '0129412135', N'MỸ', 1, '1999-9-9'),
	   ('689564656', N'Nicole Norwood', 'HN4635HDS', '0132318271', N'ANH', 1, '1999-10-10'),
	   ('123462543', N'NGUYỄN ANH DŨNG', '228674844', '0921827441', N'VIỆT NAM', 1, '1999-11-11'),
	   ('595478456', N'Josep William', 'QO85RI4D', '0812731231', N'MỸ', 1, '1999-12-12'),
	   ('056856735', N'Frederick Nicholas', 'JGH74QWHD', '0981231321', N'ANH', 1, '1999-6-14'),
	   ('124545733', N'TRẦN PHONG VŨ', '22736454', '0982127182', N'VIỆT NAM', 1, '1999-11-21'),
	   ('172347356', N'Rachel Filbert', 'UTN75FH4', '0128129318', N'NGA', 1, '1998-3-3'),
	   ('546823634', N'Daniel Bruce', 'Y56YRY4YR', '0912381238', N'MỸ', 1, '1999-1-1'),
	   ('245925634', N'Michael Collins', 'JFU574HGF', '0989891231', N'ANH', 1, '1999-4-1'),
	   ('957835465', N'James Howard', 'HTY464HDD', '0129381231', N'NGA', 1, '1999-1-1'),
	   ('472576472', N'TRƯƠNG THỊ THU THỦY', '2253443443', '0123912312', N'VIỆT NAM', 1, '1999-5-1'),
	   ('134265348', N'TRẦN QUỲNH ANH', '2291879879', '0909128371', N'VIỆT NAM', 1, '1999-1-4'),
	   ('569824442', N'TRƯƠNG THU HẢO', '2987687546', '0913138291', N'VIỆT NAM', 0, '1999-7-1'),
	   ('245346814', N'TOM HIDDLESTON', 'HIO987UYNJ', '0129381726', N'PHÁP', 1, '1999-12-15'),
	   ('423443587', N'Acacia Elain', 'FUNK8762HT', '01293889123', N'ÚC', 1, '1999-1-17'),
	   ('789678123', N'LÊ THỊ THANH HUYỀN', '2891765413', '0912931223', N'VIỆT NAM', 0, '1999-1-18'),
	   ('234509284', N'LÊ TRUNG KIÊN', '2987876511', '0903127881', N'VIỆT NAM', 1, '1999-1-19'),
	   ('232468443', N'Euphemia Halcyon', 'KKOP98908J', '0977865213', N'ITALIA', 1, '1999-10-20'),
	   ('076855244', N'Joyce Kaylin', 'UHG27847TM', '0977898123', N'ÁO', 1, '1999-1-31'),
	   ('136356246', N'NGUYỄN QUỲNH MY', '2298976671', '0989887866', N'VIỆT NAM', 1, '1999-11-14'),
	   ('058456741', N'TRẦN THỊ THU THẢO', '2214776532', '0988712231', N'VIỆT NAM', 0, '1999-6-7'),
	   ('125736144', N'Ladonna Eira', 'PHN2819UY7', '0122312889', N'ÚC', 1, '1999-1-17'),
	   ('976584542', N'TRẦN TIỂU MANH', '279KHU126H', '0212331299', N'TRUNG QUỐC', 1, '1999-1-11'),
	   ('583442347', N'THIỀU MINH Ý', '7HUHY2918H', '0129812931', N'TRUNG QUỐC', 0, '1999-1-12'),
	   ('946258455', N'Kane Hary', 'HN2817HNGR', '0921312381', N'PHÁP', 1, '1999-1-13'),
	   ('245835534', N'Randolph Otis', '28HTAS786Y', '0998981231', N'PHÁP', 1, '1999-1-13'),
	   ('247354925', N'Zodiac Alien', '89HJTY127H', '0123912831', N'PHÁP', 1, '1999-1-14')

INSERT INTO PHIEU_THUEPHONG   
VALUES  ( '094857463' , '094857463' , 'NV002' ,'2019-02-01' , '2019-02-01' ,'2019-02-03' ,1),
		( '201232341' , '201232341' , 'NV002' ,'2019-02-01' , '2019-02-01' ,'2019-02-05' ,1),
		( '123412324' , '123412324' , 'NV002' ,'2019-02-02' , '2019-02-02' ,'2019-02-10' ,1),
		( '454523134' , '454523134' , 'NV002' ,'2019-02-02' , '2019-02-02' ,'2019-02-05' ,1),
		( '456734734' , '456734734' , 'NV002' ,'2019-02-04' , '2019-02-04' ,'2019-02-09' ,1),
		( '689564656' , '689564656' , 'NV002' ,'2019-02-04' , '2019-02-04' ,'2019-02-10' ,1),
		( '123462543' , '123462543' , 'NV002' ,'2019-02-04' , '2019-02-04' ,'2019-02-08' ,1),
		( '595478456' , '595478456' , 'NV002' ,'2019-02-10' , '2019-02-10' ,'2019-02-13' ,1),
		( '056856735' , '056856735' , 'NV002' ,'2019-02-15' , '2019-02-15' ,'2019-02-20' ,1),
		( '124545733' , '124545733' , 'NV002' ,'2019-02-20' , '2019-02-20' ,'2019-02-25' ,1),
		( '172347356' , '172347356' , 'NV002' ,'2019-03-01' , '2019-03-01' ,'2019-03-05' ,1),
		( '546823634' , '546823634' , 'NV002' ,'2019-03-01' , '2019-03-01' ,'2019-03-03' ,1),
		( '245925634' , '245925634' , 'NV002' ,'2019-03-10' , '2019-03-10' ,'2019-03-15' ,1),
		( '957835465' , '957835465' , 'NV002' ,'2019-04-01' , '2019-04-01' ,'2019-04-04' ,1),
		( '472576472' , '472576472' , 'NV002' ,'2019-04-07' , '2019-04-07' ,'2019-04-10' ,1),
		( '134265348' , '134265348' , 'NV002' ,'2019-04-10' , '2019-04-10' ,'2019-04-15' ,1),
		( '569824442' , '569824442' , 'NV002' ,'2019-04-20' , '2019-04-20' ,'2019-04-25' ,1),
		( '245346814' , '245346814' , 'NV002' ,'2019-05-01' , '2019-05-01' ,'2019-05-05' ,1),
		( '423443587' , '423443587' , 'NV002' ,'2019-05-02' , '2019-05-02' ,'2019-05-10' ,1),
		( '789678123' , '789678123' , 'NV002' ,'2019-05-05' , '2019-05-05' ,'2019-05-10' ,1),
		( '234509284' , '234509284' , 'NV002' ,'2019-05-15' , '2019-05-15' ,'2019-05-20' ,1),
		( '232468443' , '232468443' , 'NV002' ,'2019-06-01' , '2019-06-01' ,'2019-06-05' ,1),
		( '076855244' , '076855244' , 'NV002' ,'2019-06-05' , '2019-06-05' ,'2019-06-10' ,1),
		( '136356246' , '136356246' , 'NV002' ,'2019-07-01' , '2019-07-01' ,'2019-07-05' ,1),
		( '058456741' , '058456741' , 'NV002' ,'2019-07-05' , '2019-07-05' ,'2019-07-10' ,1),
		( '125736144' , '125736144' , 'NV002' ,'2019-07-10' , '2019-07-10' ,'2019-07-15' ,1),
		( '976584542' , '976584542' , 'NV002' ,'2019-07-15' , '2019-07-15' ,'2019-07-20' ,1),
		( '583442347' , '583442347' , 'NV002' ,'2019-08-01' , '2019-08-01' ,'2019-02-03' ,1),
		( '946258455' , '946258455' , 'NV002' ,'2019-08-06' , '2019-08-06' ,'2019-08-10' ,1),
		( '245835534' , '245835534' , 'NV002' ,'2019-08-10' , '2019-08-10' ,'2019-08-15' ,1),
		( '247354925' , '247354925' , 'NV002' ,'2019-10-01' , '2019-10-01' ,'2019-10-05' ,1)
INSERT INTO dbo.CHITIET_THUEDICHVU
        ( SO_PHIEU ,
          MA_DICHVU ,
          SOLUONG ,
          GIA_DICHVU
        )
VALUES  ( '094857463' , 'XE' , 1 ,130000),
		( '201232341' , 'TX1' , 1 ,100000),
		( '123412324' , 'NU' , 1 ,10000),
		( '454523134' , 'AN' , 1 ,40000),
		( '456734734' , 'TX1' , 1 ,100000),
		( '689564656' , 'BI' , 2 ,40000),
		( '123462543' , 'XE' , 1 ,130000),
		( '595478456' , 'XE' , 1 ,130000),
		( '056856735' , 'AN' , 1 ,40000),
		( '124545733' , 'TT' , 1 ,200000),
		( '172347356' , 'GU' , 1 ,50000),
		( '546823634' , 'TX1' , 1 ,100000),
		( '245925634' , 'AN' , 1 ,40000),
		( '957835465' , 'XE' , 1 ,130000),
		( '472576472' , 'BI' , 5 ,40000),
		( '134265348' , 'AN' , 1 ,40000),
		( '569824442' , 'DL' , 1 ,500000),
		( '134265348' , 'XE' , 1 ,130000),
		( '569824442' , 'TX2' , 1 ,100000),
		( '245346814' , 'GU' , 1 ,50000),
		( '232468443' , 'TT' , 1 ,200000),
		( '232468443' , 'DL' , 1 ,500000),
		( '076855244' , 'XE' , 1 ,130000),
		( '136356246' , 'AN' , 1 ,40000),
		( '058456741' , 'NU' , 1 ,10000),
		( '125736144' , 'AN' , 1 ,40000),
		( '976584542' , 'XE' , 1 ,130000),
		( '583442347' , 'AN' , 2 ,40000),
		( '946258455' , 'TX1' , 1 ,100000),
		( '245835534' , 'TT' , 1 ,200000),
		( '247354925' , 'DL' , 1 ,500000)

		
INSERT INTO dbo.CHITIET_THUEPHONG
        ( SO_PHIEU ,
          MAPHONG ,
          SONGUOI ,
          GIAPHONG
        )
VALUES  ( '094857463' , '404' , 2 , 540000 ),
		( '201232341' , '203' , 3 , 400000 ),
		( '123412324' , '202' , 1 , 250000 ),
		( '454523134' , '303' , 3 , 400000 ),
		( '456734734' , '302' , 1 , 250000 ),
		( '689564656' , '505' , 2 , 540000 ),
		( '123462543' , '403' , 3 , 400000 ),
		( '595478456' , '502' , 1 , 250000 ),
		( '056856735' , '304' , 4 , 720000 ),
		( '124545733' , '503' , 3 , 400000 ),
		( '172347356' , '505' , 2 , 540000 ),
		( '546823634' , '204' , 5 , 720000 ),
		( '245925634' , '502' , 1 , 250000 ),
		( '957835465' , '404' , 2 , 540000 ),
		( '472576472' , '405' , 2 , 540000 ),
		( '134265348' , '202' , 1 , 250000 ),
		( '569824442' , '303' , 3 , 400000 ),
		( '134265348' , '402' , 1 , 250000 ),
		( '569824442' , '504' , 2 , 540000 ),
		( '245346814' , '403' , 3 , 400000 ),
		( '232468443' , '304' , 5 , 720000 ),
		( '232468443' , '204' , 6 , 720000 ),
		( '076855244' , '202' , 1 , 250000 ),
		( '136356246' , '503' , 3 , 400000 ),
		( '058456741' , '505' , 2 , 540000 ),
		( '125736144' , '405' , 2 , 540000 ),
		( '976584542' , '504' , 2 , 540000 ),
		( '583442347' , '402' , 1 , 250000 ),
		( '946258455' , '302' , 1 , 250000 ),
		( '245835534' , '204' , 6 , 720000 ),
		( '247354925' , '403' , 3 , 400000 )







create proc THONGKE_PHONG
as
begin
	select p.MA_PHONG, ISNULL(soLan, 0) as soLan from PHONG p left join 
	(select MAPHONG, count(*) as soLan
	from CHITIET_THUEPHONG
	group by MAPHONG) tk on p.MA_PHONG = tk.MAPHONG
end
GO

create proc THONGKE_DICHVU
as
begin
	select dv.MA_DICHVU, dv.TEN_DICHVU, ISNULL(soLuong, 0) as soLuong from DICHVU dv left join 
	(select MA_DICHVU, sum(SOLUONG) as soLuong
	from CHITIET_THUEDICHVU
	group by MA_DICHVU) tk on dv.MA_DICHVU = tk.MA_DICHVU
end
GO