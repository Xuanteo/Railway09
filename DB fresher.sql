-- Question 1: Tạo table với các ràng buộc và kiểu dữ liệu
DROP DATABASE IF EXISTS fresher;
CREATE DATABASE fresher;
USE fresher;
DROP TABLE IF EXISTS Trainee;
CREATE TABLE Trainee(
TraineeID SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Full_Name VARCHAR(50) NOT NULL,
Birth_Date DATE NOT NULL,
Gender ENUM ('MALE', 'FEMALE','UNKNOWN') NOT NULL,
ET_IQ TINYINT UNSIGNED NOT NULL CHECK (ET_IQ<20),
ET_Gmath TINYINT UNSIGNED NOT NULL CHECK (ET_Gmath<20),
ET_English TINYINT UNSIGNED NOT NULL CHECK (ET_English<50),
Training_Class CHAR(10) NOT NULL,
Evaluation_Notes CHAR (20) NOT NULL
);
-- Question 2: Thêm ít nhất 10 bản ghi vào table
INSERT INTO Trainee (Full_Name,Birth_Date,Gender,ET_IQ,ET_Gmath,ET_English,Training_Class,Evaluation_Notes)
VALUES('Phạm Trường Xuân','1989-04-20','MALE',10,10,20,'VTI001','DHCNHN');
INSERT INTO Trainee (Full_Name,Birth_Date,Gender,ET_IQ,ET_Gmath,ET_English,Training_Class,Evaluation_Notes)
VALUES('Nguyễn xuân thắng','2000-02-9','UNKNOWN',15,15,40,'VTI002','DHBKHN');
INSERT INTO Trainee (Full_Name,Birth_Date,Gender,ET_IQ,ET_Gmath,ET_English,Training_Class,Evaluation_Notes)
VALUES('Phạm Xuân Nguyên','2000-04-18','MALE',17,14,38,'VTI001','DHHN');
INSERT INTO Trainee (Full_Name,Birth_Date,Gender,ET_IQ,ET_Gmath,ET_English,Training_Class,Evaluation_Notes)
VALUES('Đinh Việt Hoàn','2001-08-20','MALE',12,14,40,'VTI003','DHKTQD');
INSERT INTO Trainee (Full_Name,Birth_Date,Gender,ET_IQ,ET_Gmath,ET_English,Training_Class,Evaluation_Notes)
VALUES('Nguyễn Văn Tân','1997-02-01','UNKNOWN',18,19,48,'VTI002','DHCNHN');
INSERT INTO Trainee (Full_Name,Birth_Date,Gender,ET_IQ,ET_Gmath,ET_English,Training_Class,Evaluation_Notes)
VALUES('Tô Văn Vũ','1997-06-25','MALE',8,9,15,'VTI001','DHKHTN');
INSERT INTO Trainee (Full_Name,Birth_Date,Gender,ET_IQ,ET_Gmath,ET_English,Training_Class,Evaluation_Notes)
VALUES('Trịnh Văn Hiếu','2000-08-28','MALE',16,10,35,'VTI001','DHBCVT');
INSERT INTO Trainee (Full_Name,Birth_Date,Gender,ET_IQ,ET_Gmath,ET_English,Training_Class,Evaluation_Notes)
VALUES('Ngô Mạnh Hùng','1995-10-20','MALE',10,10,20,'VTI002','DHQGHN');
INSERT INTO Trainee (Full_Name,Birth_Date,Gender,ET_IQ,ET_Gmath,ET_English,Training_Class,Evaluation_Notes)
VALUES('Ngô Mạnh Hùng','1995-10-20','MALE',10,10,20,'VTI002','DHQGHN');
INSERT INTO Trainee (Full_Name,Birth_Date,Gender,ET_IQ,ET_Gmath,ET_English,Training_Class,Evaluation_Notes)
VALUES('Nguyễn Thị Thảo','1996-03-26','FEMALE',17,18,40,'VTI003','DHNT');
INSERT INTO Trainee (Full_Name,Birth_Date,Gender,ET_IQ,ET_Gmath,ET_English,Training_Class,Evaluation_Notes)
VALUES('Tống Nguyên Quang','1994-03-26','MALE',15,18,30,'VTI001','DHBKHN');
INSERT INTO Trainee (Full_Name,Birth_Date,Gender,ET_IQ,ET_Gmath,ET_English,Training_Class,Evaluation_Notes)
VALUES('Tạ Duy Tùng','1993-08-26','MALE',14,15,25,'VTI001','DHTNMT');

-- Question 3: Insert 1 bản ghi mà có điểm ET_IQ =30. Sau đó xem kết quả
INSERT INTO Trainee (Full_Name,Birth_Date,Gender,ET_IQ,ET_Gmath,ET_English,Training_Class,Evaluation_Notes)
VALUES('Phạm Văn Tý','1992-07-22','MALE',30,15,25,'VTI012','DHHN');

-- Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào,và sắp xếp theo ngày sinh. Điểm ET_IQ >=12, ET_Gmath>=12, ET_English>=20
SELECT *
FROM Trainee
WHERE ET_IQ >=12 AND ET_Gmath>=12 AND ET_English>=20
ORDER BY Birth_Date ASC;

-- Question 5: Viết lệnh để lấy ra thông tin thực tập sinh có tên bắt đầu bằng chữ N và kết thúc bằng chữ C
SELECT *
FROM Trainee
WHERE Full_Name LIKE ('N%D');

-- Question 6: Viết lệnh để lấy ra thông tin thực tập sinh mà tên có ký thự thứ 2 là chữ G
SELECT *
FROM Trainee
WHERE Full_Name LIKE ('_G%');

-- Question 7: Viết lệnh để lấy ra thông tin thực tập sinh mà tên có 10 ký tự và ký tự cuối cùng là C
SELECT *
FROM Trainee
WHERE Full_Name LIKE ('_________C');

-- Question 8: Viết lệnh để lấy ra Fullname của các thực tập sinh trong lớp, lọc bỏ các tên trùng nhau.
SELECT DISTINCT Full_Name
FROM Trainee;

-- Question 9: Viết lệnh để lấy ra Fullname của các thực tập sinh trong lớp, sắp xếp các tên này theo thứ tự từ A-Z
SELECT Full_Name
FROM Trainee
ORDER BY Full_Name ASC;

-- Question 10: Viết lệnh để lấy ra thông tin thực tập sinh có tên dài nhất
SELECT * FROM Trainee
WHERE length(Full_Name)=(SELECT MAX(length(Full_Name)) FROM Trainee);

-- Question 11: Viết lệnh để lấy ra ID, Fullname và Ngày sinh thực tập sinh có tên dài nhất
SELECT TraineeID,Full_Name,Birth_Date
FROM Trainee
WHERE length(Full_Name)=(SELECT MAX(length(Full_Name)) FROM Trainee);

-- Question 12: Viết lệnh để lấy ra Tên, và điểm IQ, Gmath, English thực tập sinh có tên dài nhất
SELECT Full_Name,ET_IQ,ET_Gmath,ET_Gmath
FROM Trainee
WHERE length(Full_Name)=(SELECT MAX(length(Full_Name)) FROM Trainee);

-- Question 13 Lấy ra 5 thực tập sinh có tuổi nhỏ nhất
SELECT *
FROM Trainee
ORDER BY Birth_Date DESC
LIMIT 5;

-- Question 14: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là những người thỏa mãn số điểm như sau:
-- • ET_IQ + ET_Gmath>=20
-- • ET_IQ>=8
-- • ET_Gmath>=8
-- • ET_English>=18

SELECT * FROM Trainee 
WHERE (ET_IQ + ET_Gmath)>=20 AND ET_IQ>=8 AND ET_Gmath>=8 AND ET_English>=18;

-- Question 15: Xóa thực tập sinh có TraineeID = 5
DELETE FROM Trainee WHERE TraineeID = 5;

-- Question 16: Xóa thực tập sinh có tổng điểm ET_IQ, ET_Gmath <=15
DELETE FROM Trainee WHERE (ET_IQ+ET_Gmath) <= 15;

-- Question 17: Xóa thực tập sinh quá 30 tuổi
DELETE FROM Trainee WHERE Year(now())- Year(Birth_Date) < 30;

-- Question 18: Thực tập sinh có TraineeID = 3 được chuyển sang lớp " VTI003". Hãy cập nhật thông tin vào database.
 UPDATE Trainee SET TraineeID = 3 WHERE Training_Class ='VTI003';
 
-- Question 19: Do có sự nhầm lẫn khi nhập liệu nên thông tin của học sinh số 10 đang bị sai,
-- hãy cập nhật lại tên thành “LeVanA”, điểm ET_IQ =10, điểm ET_Gmath =15, điểm ET_English = 30.
UPDATE Trainee SET Full_Name='LeVanA',ET_IQ =10,ET_Gmath =15,ET_English = 30 WHERE TraineeID = 10;

-- Question 20: Đếm xem trong lớp VTI001 có bao nhiêu thực tập sinh
SELECT COUNT(TraineeID) AS TTS, Training_Class
FROM Trainee
WHERE Training_Class ='VTI001';

-- Question 21: Đếm xem trong lớp VTI001 có bao nhiêu thực tập sinh.
SELECT COUNT(TraineeID) AS TTS, Training_Class
FROM Trainee
WHERE Training_Class ='VTI001';

-- Question 22: Đếm tổng số thực tập sinh trong lớp VTI001 và VTI003 có bao nhiêu thực tập sinh.
SELECT COUNT(TraineeID) TTS, Training_Class
FROM Trainee
WHERE Training_Class ='VTI001' OR Training_Class ='VTI003';

-- Question 23: Lấy ra số lượng các thực tập sinh theo giới tính: Male, Female, Unknown.
SELECT COUNT(TraineeID) AS TTS, Gender
FROM Trainee
GROUP BY Gender;

-- Question 24: Lấy ra lớp có lớn hơn 5 thực tập viên
SELECT Training_Class,COUNT(TraineeID) AS TTS
FROM Trainee
GROUP BY Training_Class
HAVING TTS >5;

-- Question 25: Lấy ra lớp có lớn hơn 5 thực tập viên
SELECT COUNT(TraineeID) AS TTS,Training_Class
FROM Trainee
GROUP BY Training_Class
HAVING COUNT(TraineeID)>5;

-- Question 26: Lấy ra trường có ít hơn 4 thực tập viên tham gia khóa học
SELECT COUNT(TraineeID) AS TTS,Evaluation_Notes
FROM Trainee
GROUP BY Evaluation_Notes
HAVING COUNT(TraineeID)<4;

-- Question 27: Bước 1: Lấy ra danh sách thông tin ID, Fullname, lớp thực tập viên có lớp 'VTI001'
-- Bước 2: Lấy ra danh sách thông tin ID, Fullname, lớp thực tập viên có lớp 'VTI002'
-- Bước 3: Sử dụng UNION để nối 2 kết quả ở bước 1 và 2
SELECT TraineeID,Full_Name,Training_Class
FROM Trainee
WHERE Training_Class = 'VTI001'
UNION
SELECT TraineeID,Full_Name,Training_Class
FROM Trainee
WHERE Training_Class = 'VTI002';


