-- 1. Tạo table với các ràng buộc và kiểu dữ liệu Thêm ít nhất 3 bản ghi vào table
DROP DATABASE IF EXISTS ThucTap;
CREATE DATABASE ThucTap;
USE ThucTap;

DROP TABLE IF EXISTS GiangVien;
CREATE TABLE GiangVien(
magv TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
hoten VARCHAR(50) NOT NULL,
luong INT UNSIGNED NOT NULL 
);

DROP TABLE IF EXISTS SinhVien;
CREATE TABLE SinhVien(
masv MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
hoten VARCHAR(50) NOT NULL,
namsinh DATE NOT NULL,
quequan VARCHAR(200) NOT NULL
);

DROP TABLE IF EXISTS DeTai;
CREATE TABLE DeTai(
madt SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
tendt VARCHAR(100),
kinhphi INT UNSIGNED NOT NULL,
NoiThucTap VARCHAR(200) NOT NULL
);

DROP TABLE IF EXISTS HuongDan;
CREATE TABLE HuongDan(
id MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
masv MEDIUMINT UNSIGNED NOT NULL,
madt SMALLINT UNSIGNED NOT NULL,
magv TINYINT UNSIGNED NOT NULL,
ketqua ENUM('dat','khongdat') NOT NULL,
CONSTRAINT fk_HuongDan_GiangVien FOREIGN KEY (magv) REFERENCES GiangVien(magv),
CONSTRAINT fk_HuongDan_SinhVien FOREIGN KEY (masv) REFERENCES SinhVien(masv),
CONSTRAINT fk_HuongDan_DeTai FOREIGN KEY (madt) REFERENCES DeTai(madt)
);


INSERT INTO `thuctap`.`giangvien` (`hoten`, `luong`) 
VALUES ('giangvien1', '10000000'),
		('giangvien2', '12000000'),
		('giangvien3', '10000000'),
		('giangvien4', '14000000'),
		('giangvien5', '15000000'),
		('giangvien6', '12000000'),
		('giangvien7', '10000000'),
		('giangvien8', '15000000'),
		('giangvien9', '14000000'),
		('giangvien10', '10000000');

INSERT INTO `thuctap`.`sinhvien` (`hoten`, `namsinh`, `quequan`) 
VALUES ('sinhvien1', '1998-04-20', 'Thanhhoa'),
		('sinhvien2', '1999-05-20', 'Hanoi'),
		('sinhvien3', '1997-06-20', 'Thaibinh'),
		('sinhvien4', '1998-04-21', 'Namdinh'),
		('sinhvien5', '1997-05-22', 'Thanhhoa'),
		('sinhvien6', '1996-01-01', 'Thanhhoa'),
		('sinhvien7', '1998-08-20', 'Hanoi'),
		('sinhvien8', '1999-09-20', 'Namdinh'),
		('sinhvien9', '1998-10-10', 'Thaibinh'),
		('sinhvien10', '1999-08-26', 'Thaibinh');

INSERT INTO `thuctap`.`detai` (`tendt`, `kinhphi`, `NoiThucTap`) 
VALUES ('CONG NGHE SINH HOC', '3000000', 'Hanoi'),
		('Detai9', '3000000', 'Hanoi'),
		('Detai10', '3000000', 'Hanoi'),
		('Detai2', '3000000', 'Hanoi'),
		('Detai3', '3000000', 'Hanoi'),
		('Detai4', '3000000', 'Hanoi'),
		('Detai5', '3000000', 'Hanoi'),
		('Detai6', '3000000', 'Hanoi'),
		('Detai7', '3000000', 'Hanoi'),
		('Detai8', '3000000', 'Hanoi');

INSERT INTO `thuctap`.`huongdan` (`masv`, `madt`, `magv`, `ketqua`) 
VALUES ('1', '1', '1', 'dat'),
		('2', '1', '1', 'dat'),
		('3', '1', '1', 'dat'),
		('4', '2', '2', 'dat'),
		('5', '2', '2', 'dat'),
		('6', '3', '2', 'khongdat'),
		('7', '3', '3', 'dat'),
		('8', '3', '3', 'dat'),
		('9', '4', '4', 'dat'),
		('10', '4', '4', 'dat');

-- 2. Viết lệnh để
-- a) Lấy tất cả các sinh viên chưa có đề tài hướng dẫn
SELECT * 
FROM `sinhvien` s
LEFT JOIN `huongdan` h ON s.masv = h.masv
WHERE h.masv IS NULL;

-- b) Lấy ra số sinh viên làm đề tài ‘CONG NGHE SINH HOC’

SELECT h.madt, d.tendt,COUNT(s.masv) AS SL
FROM  `huongdan` h
INNER JOIN `sinhvien` s ON s.masv = h.masv
INNER JOIN detai d ON d.madt = h.madt
WHERE tendt = 'CONG NGHE SINH HOC';

-- 3. Tạo view có tên là "SinhVienInfo" lấy các thông tin về học sinh bao gồm:
-- mã số, họ tên và tên đề tài
-- (Nếu sinh viên chưa có đề tài thì column tên đề tài sẽ in ra "Chưa có")

CREATE OR REPLACE VIEW vw_List_SV AS(
SELECT s.masv, s.hoten, d.tendt
FROM `sinhvien` s
INNER JOIN `huongdan` h ON s.masv = h.masv
INNER JOIN detai d ON d.madt = h.madt
UNION
SELECT s.masv, s.hoten, 'chưa có' As DeTai FROM sinhvien s
LEFT JOIN `huongdan` h ON s.masv = h.masv
WHERE h.masv IS NULL);

SELECT * FROM vw_List_SV;

-- 4. Tạo trigger cho table SinhVien khi insert sinh viên có năm sinh <= 1900
-- thì hiện ra thông báo "năm sinh phải > 1900"

DROP TRIGGER IF EXISTS Trg_Insertsinhvien;
DELIMITER $$
	CREATE TRIGGER Trg_Insertsinhvien
    BEFORE INSERT ON sinhvien
    FOR EACH ROW
    BEGIN		
			IF (year(NEW.namsinh)<=1900) THEN 
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = 'năm sinh phải > 1900';
		END IF;        
    END$$
DELIMITER ;

INSERT INTO `thuctap`.`sinhvien` (`hoten`, `namsinh`, `quequan`) 
VALUES ('sinhvien1', '1889-04-20', 'Thanhhoa');


-- 5. Hãy cấu hình table sao cho khi xóa 1 sinh viên nào đó thì sẽ tất cả thông
-- tin trong table HuongDan liên quan tới sinh viên đó sẽ bị xóa đi

ALTER TABLE huongdan DROP FOREIGN KEY fk_HuongDan_SinhVien;
ALTER TABLE huongdan ADD CONSTRAINT fk_HuongDan_SinhVien FOREIGN KEY (masv) REFERENCES SinhVien(masv) ON DELETE CASCADE;







