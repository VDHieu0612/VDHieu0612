/*BUOI 1*/
CREATE DATABASE QLYKHACHHANG

USE QLYKHACHHANG

CREATE TABLE KHACHHANG(
MAKH char(4) NOT NULL CONSTRAINT PK_KH PRIMARY KEY,
HOTEN varchar(40),
DCHI varchar(50),
SODT varchar(20),
NGSINH smalldatetime,
NGDK smalldatetime,
DOANHSO money,
)

CREATE TABLE NHANVIEN(
MANV char(4) NOT NULL CONSTRAINT PK_NV PRIMARY KEY,
HOTEN varchar(40),
SODT varchar(20),
NGVL smalldatetime,
)

CREATE TABLE SANPHAM(
MASP char(4) NOT NULL CONSTRAINT PK_SP PRIMARY KEY,
TENSP varchar(40),
DVT varchar(20),
NUOCSX varchar(40),
GIA money,
)

CREATE TABLE HOADON(
SOHD int NOT NULL CONSTRAINT PK_HD PRIMARY KEY,
NGHD smalldatetime,
MAKH char(4) CONSTRAINT FK_HD_KH FOREIGN KEY REFERENCES KHACHHANG(MAKH),
MANV char(4) CONSTRAINT FK_HD_NV FOREIGN KEY REFERENCES NHANVIEN(MANV),
TRIGIA money,
)

CREATE TABLE CTHD(
SOHD int CONSTRAINT FK_CTHD_HD FOREIGN KEY REFERENCES HOADON(SOHD),
MASP char(4) CONSTRAINT FK_CTHD_SP FOREIGN KEY REFERENCES SANPHAM(MASP),
SL int,
CONSTRAINT PK_CTHD PRIMARY KEY (SOHD,MASP)
)

/*2. Them vao tt GHICHU co kieu du lieu varchar(20) cho quan ha SANPHAM.*/
ALTER TABLE SANPHAM
ADD GHICHU varchar(20)

/*3. Them vao thuoc tinh LOAIKH co kieu du lieu la tinyint cho quan he KHACHHANG.*/
ALTER TABLE KHACHHANG
ADD LOAIKH tinyint

/*4. Sua kieu du lieu cua thuoc tinh GHICHU trong quan he SANPHAM thanh varchar(100).*/
ALTER TABLE SANPHAM
ALTER COLUMN GHICHU varchar(100)

/*5. Xoa thuoc tinh GHICHU trong quan he SANPHAM.*/
ALTER TABLE SANPHAM
DROP COLUMN GHICHU

/*6. Lam sao de thuoc tinh LOAIKH trong quan he KHACHHANG co the luu cac gia tri la: �Vang lai�, �Thuong xuyen�, �Vip��*/
ALTER TABLE KHACHHANG
ALTER COLUMN LOAIKH varchar(20)
ALTER TABLE KHACHHANG
ADD CONSTRAINT LOAI_KH CHECK (LOAIKH in ('Vang lai','Thuong xuyen','Vip')) 

/*7. Don vi tinh cua san pham chi co the la (�cay�,�hop�,�cai�,�quyen�,�chuc�)*/
ALTER TABLE SANPHAM
ADD CONSTRAINT LOAI_DVT CHECK (DVT in ('cay','hop','cai','quyen','chuc'))

/*8. Gia ban cua san pham tu 500 dong tro len.*/
ALTER TABLE SANPHAM
ADD CONSTRAINT GIA_SP CHECK (GIA >= 500)

/*9. Moi lan mua hang, khach hang phai mua it nhat 1 san pham*/
ALTER TABLE CTHD
ADD CONSTRAINT SL_MUA CHECK (SL >= 1)

/*10. Ngay khach hang dang ky la khach hang thanh vien phai lon hon ngay sinh cua nguoi do.*/
ALTER TABLE KHACHHANG
ADD CONSTRAINT NGSINH_NGDK CHECK (NGDK > NGSINH)

----------------------------------------------------------------------------------------------------------------
/*BUOI 2*/
set dateformat dmy

INSERT INTO NHANVIEN(MANV, HOTEN, SODT, NGVL)
VALUES 
    ('NV01', N'Nguyen Nhu Nhut', '0927345678', '13-04-2006'),
    ('NV02', N'Le Thi Phi Yen', '0987567390', '21-04-2006'),
    ('NV03', N'Nguyen Van B', '0997047382', '27-04-2006'),
    ('NV04', N'Ngo Thanh Tuan', '0913758498', '24-06-2006'),
    ('NV05', N'Nguyen Thi Truc Thanh', '0918590387', '20-07-2006');

INSERT INTO KHACHHANG(MAKH, HOTEN, DCHI, SODT, NGSINH, DOANHSO, NGDK)
VALUES 
    ('KH01', N'Nguyen Van A', N'731 Tran Hung Dao, Q5, TpHCM', '08823451', '22-10-1960', 13060000, '22-07-2006'),
    ('KH02', N'Tran Ngoc Han', N'23/5 Nguyen Trai, Q5, TpHCM', '0908256478', '03-04-1974', 280000, '30-07-2006'),
    ('KH03', N'Tran Ngoc Linh', N'45 Nguyen Canh Chan, Q1, TpHCM', '0938776266', '12-06-1980', 3860000, '05-08-2006'),
    ('KH04', N'Tran Minh Long', N'50/34 Le Dai Hanh, Q10, TpHCM', '0917325476', '09-03-1965', 250000, '02-10-2006'),
    ('KH05', N'Le Nhat Minh', N'34 Truong Dinh, Q3, TpHCM', '08246108', '10-03-1950', 21000, '28-10-2006'),
    ('KH06', N'Le Hoai Thuong', N'227 Nguyen Van Cu, Q5, TpHCM', '08631738', '31-12-1981', 915000, '24-11-2006'),
    ('KH07', N'Nguyen Van Tam', N'32/3 Tran Binh Trong, Q5, TpHCM', '0916783565', '06-04-1971', 12500, '01-12-2006'),
    ('KH08', N'Phan Thi Thanh', N'45/2 An Duong Vuong, Q5, TpHCM', '0938435756', '10-01-1971', 365000, '13-12-2006'),
    ('KH09', N'Le Ha Vinh', N'873 Le Hong Phong, Q5, TpHCM', '08654763', '03-09-1979', 70000, '14-01-2007'),
    ('KH10', N'Ha Duy Lap', N'34/34B Nguyen Trai, Q1, TpHCM', '08768904', '02-05-1983', 67500, '16-01-2007');

INSERT INTO SANPHAM(MASP, TENSP, DVT, NUOCSX, GIA)
VALUES 
    ('BC01', N'But chi', N'cay', N'Singapore', 3000),
    ('BC02', N'But chi', N'cay', N'Singapore', 5000),
    ('BC03', N'But chi', N'cay', N'Viet Nam', 3500),
    ('BC04', N'But hop', N'cay', N'Viet Nam', 30000),
    ('BB01', N'But bi', N'cay', N'Viet Nam', 5000),
    ('BB02', N'But bi', N'cay', N'Trung Quoc', 7000),
    ('BB03', N'But bi', N'hop', N'Thai Lan', 100000),
    ('TV01', N'Tap 100 giay mong', N'quyen', N'Trung Quoc', 2500),
    ('TV02', N'Tap 200 giay mong', N'quyen', N'Trung Quoc', 4500),
    ('TV03', N'Tap 100 giay tot', N'quyen', N'Viet Nam', 3000),
    ('TV04', N'Tap 200 giay tot', N'quyen', N'Viet Nam', 5500),
    ('TV05', N'Tap 100 trang', N'chuc', N'Viet Nam', 23000),
    ('TV06', N'Tap 200 trang', N'chuc', N'Viet Nam', 53000),
    ('TV07', N'Tap 100 trang', N'chuc', N'Trung Quoc', 34000),
    ('ST01', N'So tay 500 trang', N'quyen', N'Trung Quoc', 40000),
    ('ST02', N'So tay loai 1', N'quyen', N'Viet Nam', 55000),
    ('ST03', N'So tay loai 2', N'quyen', N'Viet Nam', 51000),
    ('ST04', N'So tay', N'quyen', N'Thai Lan', 55000),
    ('ST05', N'So tay mong', N'quyen', N'Thai Lan', 20000),
    ('ST06', N'Phan viet bang', N'hop', N'Viet Nam', 5000),
    ('ST07', N'Phan khong bui', N'hop', N'Viet Nam', 7000),
    ('ST08', N'Bong bang', N'cai', N'Viet Nam', 1000),
    ('ST09', N'But long', N'cay', N'Viet Nam', 5000),
    ('ST10', N'But long', N'cay', N'Trung Quoc', 7000);

SET DATEFORMAT dmy;

INSERT INTO HOADON (SOHD, NGHD, MAKH, MANV, TRIGIA)
VALUES 
    (1001, '23-07-2006', 'KH01', 'NV01', 320000),
    (1002, '12-08-2006', 'KH01', 'NV02', 840000),
    (1003, '23-08-2006', 'KH02', 'NV01', 100000),
    (1004, '01-09-2006', 'KH02', 'NV01', 180000),
    (1005, '20-10-2006', 'KH01', 'NV02', 3800000),
    (1006, '16-10-2006', 'KH01', 'NV03', 2430000),
    (1007, '28-10-2006', 'KH03', 'NV03', 510000),
    (1008, '28-10-2006', 'KH01', 'NV03', 440000),
    (1009, '28-10-2006', 'KH03', 'NV04', 200000),
    (1010, '01-11-2006', 'KH01', 'NV01', 5200000),
    (1011, '04-11-2006', 'KH04', 'NV03', 250000),
    (1012, '30-11-2006', 'KH05', 'NV03', 21000),
    (1013, '12-12-2006', 'KH06', 'NV01', 5000),
    (1014, '31-12-2006', 'KH03', 'NV02', 3150000),
    (1015, '01-01-2007', 'KH06', 'NV01', 910000),
    (1016, '01-01-2007', 'KH07', 'NV02', 12500),
    (1017, '02-01-2007', 'KH08', 'NV03', 35000),
    (1018, '13-01-2007', 'KH08', 'NV03', 330000),
    (1019, '13-01-2007', 'KH01', 'NV03', 30000),
    (1020, '14-01-2007', 'KH09', 'NV04', 70000),
    (1021, '16-01-2007', 'KH10', 'NV03', 67500),
    (1022, '16-01-2007', NULL, 'NV03', 7000),
    (1023, '17-01-2007', NULL, 'NV01', 330000);

INSERT INTO CTHD (SOHD, MASP, SL)
VALUES 
    (1001, 'TV02', 10),
    (1001, 'ST01', 5),
    (1001, 'BC01', 5),
    (1001, 'BC02', 10),
    (1001, 'ST08', 10),
    (1002, 'BC04', 20),
    (1002, 'BB01', 20),
    (1002, 'BB02', 20),
    (1003, 'BB03', 10),
    (1004, 'TV01', 20),
    (1004, 'TV02', 10),
    (1004, 'TV03', 10),
    (1004, 'TV04', 10),
    (1005, 'TV05', 50),
    (1005, 'TV06', 50),
    (1006, 'TV07', 20),
    (1006, 'ST01', 30),
    (1006, 'ST02', 10),
    (1007, 'ST03', 10),
    (1008, 'ST04', 8),
    (1009, 'ST05', 10),
    (1010, 'TV07', 50),
    (1010, 'ST07', 50),
    (1010, 'ST08', 100),
    (1010, 'ST04', 50),
    (1010, 'TV03', 100),
    (1011, 'ST06', 50),
    (1012, 'ST07', 3),
    (1013, 'ST08', 5),
    (1014, 'BC02', 80),
    (1014, 'BB02', 100),
    (1014, 'BC04', 60),
    (1014, 'BB01', 50),
    (1015, 'BB02', 30),
    (1015, 'BB03', 7),
    (1016, 'TV01', 5),
    (1017, 'TV02', 1),
    (1017, 'TV03', 1),
    (1017, 'TV04', 5),
    (1018, 'ST04', 6),
    (1019, 'ST05', 1),
    (1019, 'ST06', 2),
    (1020, 'ST07', 10),
    (1021, 'ST08', 5),
    (1021, 'TV01', 7),
    (1021, 'TV02', 10),
    (1022, 'ST07', 1),
    (1023, 'ST04', 6);

/*2. Tao quan he SANPHAM1 chua toan bo du lieu cua quan he SANPHAM. Tao quan he KHACHHANG1 chua toan bo du lieu cua quan he KHACHHANG.*/
SELECT * INTO SANPHAM1 FROM SANPHAM
SELECT * INTO KHACHHANG1 FROM KHACHHANG

/*3. Cap nhat gia tang 5% doi voi nhung san pham do "Thai Lan" san xuat (cho quan he SANPHAM1)*/
UPDATE SANPHAM1
SET GIA = GIA * 1.05
WHERE NUOCSX = 'Thai Lan'

/*4. Cap nhat gia giam 5% doi voi nhung san pham do "Trung Quoc" san xuat co gia tu 10.000 tro xuong (cho quan he SANPHAM1).*/
UPDATE SANPHAM1
SET GIA	= GIA * 0.95
WHERE NUOCSX = 'Trung Quoc' AND GIA <= 10000
/*5. Cap nhat gia tri LOAIKH la "Vip" doi voi nhung khach hang dang ky thanh vien truoc ngay 1/1/2007 co doanh so tu 10.000.000 tro len hoac khach hang dang ky thanh vien tu 1/1/2007 tro ve sau co doanh so tu 2.000.000 tro len (cho quan he KHACHHANG1).*/
UPDATE KHACHHANG1
SET LOAIKH = 'Vip'
WHERE (NGDK < '1/1/2007' AND DOANHSO >= 10000000) OR (NGDK >= '1/1/2007' AND DOANHSO >= 2000000)

/*1. In ra danh sach cac san pham (MASP, TENSP) do "Trung Quoc" san xuat.*/
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'

/*2. In ra danh sach cac san pham (MASP, TENSP) co don vi tinh la "cay", "quyen".*/
SELECT MASP, TENSP
FROM SANPHAM
WHERE DVT = 'cay' OR DVT = 'quyen'

/*3. In ra danh sach cac san pham (MASP, TENSP) co ma san pham bat dau la "B" va ket thuc la "01".*/
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP LIKE 'B%' AND MASP LIKE '%01'

/*4. In ra danh sach cac san pham (MASP, TENSP) do "Trung Quoc" san xuat co gia tu 30.000 den 40.000.*/
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc' AND (GIA BETWEEN 30000 AND 40000)

/*5. In ra danh sach cac san pham (MASP, TENSP) do "Trung Quoc" hoac "Thai Lan" san xuat co gia tu 30.000 den 40.000.*/
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX IN ('Trung Quoc', 'Thai Lan') AND (GIA BETWEEN 30000 AND 40000)

/*6. In ra cac so hoa don, tri gia hoa don ban ra trong ngay 1/1/2007 va ngay 2/1/2007.*/
SELECT SOHD, TRIGIA
FROM HOADON
WHERE NGHD = '1/1/2007'
UNION
SELECT SOHD, TRIGIA
FROM HOADON
WHERE NGHD = '2/1/2007'

/*7. In ra cac so hoa don, tri gia hoa don trong thang 1/2007, sap xep theo ngay (tang dan) va tri gia cua hoa don (giam dan).*/
SELECT SOHD, TRIGIA
FROM HOADON
WHERE MONTH(NGHD) = 1 AND YEAR(NGHD) = 2007
ORDER BY NGHD ASC, TRIGIA DESC

/*8. In ra danh sach cac khach hang (MAKH, HOTEN) da mua hang trong ngay 1/1/2007.*/
SELECT KHACHHANG.MAKH, HOTEN
FROM KHACHHANG INNER JOIN HOADON ON KHACHHANG.MAKH = HOADON.MAKH
WHERE NGHD = '1/1/2007'

/*9. In ra so hoa don, tri gia cac hoa don do nhan vien co ten "Nguyen Van B" lap trong ngay 28/10/2006.*/
SELECT SOHD, TRIGIA
FROM NHANVIEN INNER JOIN HOADON ON NHANVIEN.MANV = HOADON.MANV
WHERE NHANVIEN.HOTEN = 'Nguyen Van B' AND NGHD = '28/10/2006'

/*10. In ra danh sach cac san pham (MASP, TENSP) duoc khach hang co ten "Nguyen Van A" mua trong thang 10/2006.*/
SELECT SANPHAM.MASP, TENSP
FROM KHACHHANG
	INNER JOIN HOADON ON KHACHHANG.MAKH = HOADON.MAKH
	INNER JOIN CTHD ON HOADON.SOHD = CTHD.SOHD
	INNER JOIN SANPHAM ON CTHD.MASP = SANPHAM.MASP
WHERE HOTEN = 'Nguyen Van A' AND MONTH(NGHD) = 10 AND YEAR(NGHD) = 2006

/*11. Tim cac so hoa don da mua san pham co ma so "BB01" hoac "BB02".*/
SELECT SOHD
FROM CTHD
WHERE MASP = 'BB01' OR MASP = 'BB02'








