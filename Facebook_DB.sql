-- Tạo DB facebook với các rằng buộc và kiểu dữ liệu.
DROP DATABASE IF EXISTS Facebook_DB;
CREATE DATABASE Facebook_DB;
USE Facebook_DB;

DROP TABLES IF EXISTS `National`;
CREATE TABLE `National`(
National_id		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
National_Name   VARCHAR (50) NOT NULL,
Language_Main VARCHAR (50) NOT NULL
);

DROP TABLES IF EXISTS Office;
CREATE TABLE Office ( 
Office_id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Street_Address VARCHAR (50) NOT NULL,
National_id TINYINT UNSIGNED NOT NULL,
FOREIGN KEY (National_id) REFERENCES `National`(National_id)
);

DROP TABLES IF EXISTS Staff;
CREATE TABLE Staff(
Staff_id MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
First_Name VARCHAR (50) NOT NULL,
Last_Name VARCHAR (50) NOT NULL,
Email VARCHAR (50) NOT NULL UNIQUE KEY,
Office_id SMALLINT UNSIGNED NOT NULL,
FOREIGN KEY (Office_id) REFERENCES Office(Office_id)
);

-- Ques2: Thêm 10 bản ghi vào các table
INSERT INTO `national` (`National_Name`, `Language_Main`) 
VALUES ('National_VN', 'Language_VN'),
		('National_US', 'Language_UK'),
		('National_UK', 'Language_UK'),
		('National_Japan', 'Language_Japanese'),
		('National_Korean', 'Language_Koreanese'),
		('National_China', 'Language_Chinese'),
		('National_Singapore', 'Language_UK'),
		('National_Gemany', 'Language_Gemany'),
		('National_Spain', 'Language_Spain'),
		('National_Thailan', 'Language_Thailan');

INSERT INTO `office` (`Street_Address`, `National_id`) 
VALUES ('Street_Vietnam', '1'),
		('Street_Vietnam', '2'),
		('Street_UK', '3'),
		('Street_China', '4'),
		('Street_Singapo', '5'),
		('Street_China', '6'),
		('Street_Vietnam', '7'),
		('Street_Us', '8'),
		('Street_Vietnam', '9'),
		('Street_Spain', '10');

INSERT INTO `staff` (`First_Name`, `Last_Name`, `Email`, `Office_id`) 
VALUES ('fistname1', 'lastname1', 'fullname1@gmail.com', '1'),
		('fistname2', 'lastname2', 'fullname2@gmail.com', '1'),
        ('fistname3', 'lastname3', 'fullname3@gmail.com', '1'),
        ('fistname4', 'lastname4', 'fullname4@gmail.com', '2'),
        ('fistname5', 'lastname5', 'fullname5@gmail.com', '2'),
        ('fistname6', 'lastname6', 'fullname6@gmail.com', '2'),
        ('fistname7', 'lastname7', 'fullname7@gmail.com', '3'),
        ('fistname8', 'lastname8', 'fullname8@gmail.com', '3'),
        ('fistname9', 'lastname9', 'fullname9@gmail.com', '3'),
        ('fistname10', 'lastname10', 'fullname10@gmail.com', '3'),
        ('fistname11', 'lastname11', 'fullname11@gmail.com', '3'),
        ('fistname12', 'lastname12', 'daonq@viettel.com.vn', '2');

-- Ques3: Bạn hãy lấy dữ liệu của tất cả nhân viên đang làm việc tại Vietnam.
SELECT s.*, o.Street_Address
FROM `staff` s
INNER JOIN `office` o ON s.Office_id = o.Office_id
WHERE o.Street_Address = 'Street_Vietnam';

-- Ques4: Lấy ra ID, FullName, Email, National của mỗi nhân viên.
SELECT s.Staff_id, concat(First_Name,First_Name),s.Email,n.National_Name
FROM `office` o
INNER JOIN `national` n ON n.National_id = o.National_id
INNER JOIN staff s ON o.Office_id = s.Office_id;

-- Ques5: Lấy ra tên nước mà nhân viên có Email: "daonq@viettel.com.vn" đang làm việc.
SELECT s.Staff_id, concat(First_Name,First_Name),s.Email,n.National_Name
FROM `office` o
INNER JOIN `national` n ON n.National_id = o.National_id
INNER JOIN staff s ON o.Office_id = s.Office_id
WHERE s.Email= 'daonq@viettel.com.vn';

-- Ques6: Bạn hãy tìm xem trên hệ thống có quốc gia nào có thông tin trên hệ thống nhưng
-- không có nhân viên nào đang làm việc.
SELECT n.*
FROM `national` n
LEFT JOIN `office` o ON n.National_id = o.National_id
INNER JOIN staff s ON o.Office_id = s.Office_id
WHERE n.National_id IS NULL;



-- Ques7: Thống kê xem trên thế giới có bao nhiêu quốc gia mà FB đang hoạt động sử dụng
-- tiếng Anh làm ngôn ngữ chính.
SELECT n.*
FROM `national` n
WHERE Language_Main LIKE 'Language_UK';

-- Ques8: Viết lệnh để lấy ra thông tin nhân viên có tên (First_Name) có 10 ký tự, bắt đầu bằng
-- chữ N và kết thúc bằng chữ C.
 SELECT *
 FROM staff
 WHERE First_Name LIKE'N________C';
 
-- Ques9: Bạn hãy tìm trên hệ thống xem có nhân viên nào đang làm việc nhưng do nhập khi
-- nhập liệu bị lỗi mà nhân viên đó vẫn chưa cho thông tin về trụ sở làm việc(Office).
SELECT s.*
FROM  staff s
LEFT JOIN office o ON s.Office_id = o.Office_id
WHERE s.Office_id IS NULL;

-- Ques10: Nhân viên có mã ID =9 hiện tại đã nghỉ việc, bạn hãy xóa thông tin của nhân viên
-- này trên hệ thống.
DELETE FROM staff WHERE Staff_id = 9;

-- Ques11: FB vì 1 lý do nào đó không còn muốn hoạt động tại Australia nữa, và Mark
-- Zuckerberg muốn bạn xóa tất cả các thông tin trên hệ thống liên quan đến quốc gia này. Hãy
-- tạo 1 Procedure có đầu vào là tên quốc gia cần xóa thông tin để làm việc này và gửi lại cho
-- anh ấy.
DROP PROCEDURE IF EXISTS sp_XoaQuocGia;
DELIMITER $$
CREATE PROCEDURE sp_XoaQuocGia(IN in_NalName VARCHAR(50))
BEGIN
	DECLARE National_id TINYINT;
    SELECT n.National_id INTO National_id FROM `national` n WHERE n.National_Name = in_NalName;
    DELETE FROM staff s WHERE s.Office_id IN (SELECT o.Office_id FROM office o WHERE o.National_id = National_id);
    DELETE FROM office o WHERE o.National_id = National_id;
    DELETE FROM `national` n WHERE n.National_id = National_id;
END$$
DELIMITER 

Call sp_XoaQuocGia('National_Korean');


-- Ques12: Mark muốn biết xem hiện tại đang có bao nhiêu nhân viên trên toàn thế giới đang
-- làm việc cho anh ấy, hãy viết cho anh ấy 1 Function để a ấy có thể lấy dữ liệu này 1 cách
-- nhanh chóng.
SET GLOBAL log_bin_trust_function_creators = 1;
DROP FUNCTION IF EXISTS fc_GetallStaff
DELIMITER $$
CREATE FUNCTION fc_GetallStaff() RETURNS MEDIUMINT
BEGIN
DECLARE allStaff MEDIUMINT;
SELECT COUNT(1) INTO allStaff FROM staff;
RETURN allStaff;
END $$
SELECT fc_GetallStaff() AS allStaff;

-- Ques13: Để thuận tiện cho việc quản trị Mark muốn số lượng nhân viên tại mỗi quốc gia chỉ
-- tối đa 10.000 người. Bạn hãy tạo trigger cho table Staff chỉ cho phép insert mỗi quốc gia có
-- tối đa 10.000 nhân viên giúp anh ấy (có thể cấu hình số lượng nhân viên nhỏ hơn vd 11 nhân
-- viên để Test).
DROP TRIGGER IF EXISTS Trg_StaffMax;
DELIMITER $$
	CREATE TRIGGER Trg_StaffMax
    BEFORE INSERT ON staff 
    FOR EACH ROW
    BEGIN		
		DECLARE National_id TINYINT ; 
		DECLARE Count_Staff TINYINT ; 
        SELECT o.National_id INTO National_id FROM office o WHERE o.Office_id = NEW.Office_id ;
		SELECT COUNT(1) INTO Count_Staff FROM staff s 
        INNER JOIN office o ON o.Office_id = s.Office_id
        INNER JOIN `national` n ON o.National_id = n.National_id
        WHERE n.National_id = National_id;
		IF (Count_Staff > 1) THEN 
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = 'Khong the them nhan vien';
		END IF;        
    END$$
DELIMITER ;

INSERT INTO `facebook_db`.`staff` (`First_Name`, `Last_Name`, `Email`, `Office_id`) 
VALUES ('FirstName14', 'LastName14', 'fullname14@gmail.com', '1');

-- Ques14: Bạn hãy viết 1 Procedure để lấy ra tên trụ sở mà có số lượng nhân viên đang làm việc nhiều nhất.
DROP PROCEDURE IF EXISTS SP_GetOfficemaxstaff;
DELIMITER $$
CREATE PROCEDURE SP_GetOfficemaxstaff()
BEGIN
WITH CTE_Officemaxstaff AS (
SELECT o.Street_Address, count(s.Staff_id) AS SL FROM `Staff` s
INNER JOIN `office` o ON s.Office_id = o.Office_id
GROUP BY s.Office_id)
SELECT * FROM CTE_Officemaxstaff WHERE SL = (SELECT MAX(SL) FROM CTE_Officemaxstaff);
END $$
CALL SP_GetOfficemaxstaff();

-- Ques15: Bạn hãy viết 1 Function để khi nhập vào thông tin Email của nhân viên thì sẽ trả ra thông tin đầy đủ của nhân viên đó.



-- Ques16: Bạn hãy viết 1 Trigger để khi thực hiện cập nhật thông tin về trụ sở làm việc của
-- nhân viên đó thì hệ thống sẽ tự động lưu lại trụ sở cũ của nhân viên vào 1 bảng khác có tên
-- Log_Office để Mark có thể xem lại khi cần thiết.



-- Ques17: FB đang vướng vào 1 đạo luật hạn chế hoạt động, FB chỉ có thể hoạt động tối đa
-- trên 100 quốc gia trên thế giới, hãy tạo Trigger để ngăn người nhập liệu nhập vào quốc gia
-- thứ 101 (bạn có thể sử dụng số nước nhỏ hơn để Test VD 11 nước).
DROP TRIGGER IF EXISTS Trg_NalMax100;
DELIMITER $$
	CREATE TRIGGER Trg_NalMax100
    BEFORE INSERT ON `national` 
    FOR EACH ROW
    BEGIN		
		DECLARE Count_national TINYINT ; 
        SELECT COUNT(n.National_id) INTO Count_national FROM `national` n ;
		IF (Count_national > 100) THEN 
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = 'Khong the them nuoc nay';
		END IF;        
    END$$
DELIMITER ;

INSERT INTO `national` (`National_Name`, `Language_Main`) 
VALUES ('Bi', 'Language_Bi');

-- Ques18: Thống kê mỗi xem mỗi nước(National) đang có bao nhiêu nhân viên đang làm việc.
SELECT n.National_Name,COUNT(s.Office_id) AS SNV
FROM office o
INNER JOIN staff s ON s.Office_id = o.Office_id
INNER JOIN `national` n ON o.National_id = n.National_id
GROUP BY s.Office_id;

-- Ques19: Viết Procedure để thống kê mỗi xem mỗi nước(National) đang có bao nhiêu nhân viên đang làm việc, với đầu vào là tên nước.
DROP PROCEDURE IF EXISTS sp_GetAccfromNational;
DELIMITER $$
CREATE PROCEDURE sp_GetAccfromNational(IN in_NationalName VARCHAR(50))
BEGIN
	SELECT n.National_Name,COUNT(s.Office_id) AS SNV
	FROM office o
	INNER JOIN staff s ON s.Office_id = o.Office_id
	INNER JOIN `national` n ON o.National_id = n.National_id
	WHERE n.National_Name = in_NationalName;
END$$
DELIMITER 

Call sp_GetAccfromNational('National_VN');


-- Ques20: Thống kê mỗi xem trong cùng 1 trụ sở (Office) đang có bao nhiêu employee đang làm việc.
SELECT o.Street_Address, COUNT( s.Staff_id)
FROM office o
INNER JOIN staff s ON o.Office_id = s.Office_id
GROUP BY  o.Office_id;

-- Ques22: Viết Procedure để lấy ra tên quốc gia đang có nhiều nhân viên nhất.
DROP PROCEDURE IF EXISTS SP_GetNationmaxstaff;
DELIMITER $$
CREATE PROCEDURE SP_GetNationmaxstaff()
BEGIN
WITH CTE_Nationalmaxstaff AS (
SELECT n.National_Name, count(s.Staff_id) AS SL FROM `Staff` s
INNER JOIN `office` o ON s.Office_id = o.Office_id
INNER JOIN `national` n ON n.National_id = o.National_id
GROUP BY n.National_Name)
SELECT * FROM CTE_Nationalmaxstaff WHERE SL = (SELECT MAX(SL) FROM CTE_Nationalmaxstaff);
END $$
CALL SP_GetNationmaxstaff();

-- Ques23: Thống kê mỗi country có bao nhiêu employee đang làm việc.
SELECT n.National_Name,COUNT(s.Office_id) AS SNV
FROM office o
INNER JOIN staff s ON s.Office_id = o.Office_id
INNER JOIN `national` n ON o.National_id = n.National_id
GROUP BY s.Office_id;

-- Ques24: Bạn hãy cấu hình lại các bảng và ràng buộc giữ liệu sao cho khi xóa 1 trụ sở làm
-- việc (Office) thì tất cả dữ liệu liên quan đến trụ sở này sẽ chuyển về Null



-- Ques25: Bạn hãy cấu hình lại các bảng và ràng buộc giữ liệu sao cho khi xóa 1 trụ sở làm
-- việc (Office) thì tất cả dữ liệu liên quan đến trụ sở này sẽ bị xóa hết.


