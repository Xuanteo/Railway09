-- sử dụng DB mẫu
-- Question 2: lấy ra tất cả các phòng ban

SELECT * FROM department;

-- Question 3: lấy ra id của phòng ban "Sale"

SELECT DepartmentID,DepartmentName FROM department WHERE DepartmentName='Sales';

-- Question 4: lấy ra thông tin account có full name dài nhất

SELECT * FROM `account` WHERE length(FullName) = (SELECT MAX(length(FullName)) FROM `account`) 
ORDER BY  FullName DESC;

-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3

WITH id3 AS (SELECT * FROM `account` WHERE DepartmentID=3)
SELECT * FROM `id3` WHERE length(FullName) = (SELECT MAX(length(FullName)) FROM `id3`) 
ORDER BY  FullName DESC;

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019

SELECT GroupName, CreateDate FROM `group` WHERE CreateDate <'2021-03-30';

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời

SELECT QuestionID, COUNT(QuestionID) FROM answer
GROUP BY QuestionID
HAVING COUNT(QuestionID)>=4;

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 2019-12-20

SELECT `Code`,Duration,CreateDate FROM exam
WHERE Duration>=60 AND CreateDate<'2019-12-20';

-- Question 9: Lấy ra 5 group được tạo gần đây nhất

SELECT * FROM `group` ORDER BY CreateDate DESC
LIMIT 5;

-- Question 10: Đếm số nhân viên thuộc department có id = 2

SELECT DepartmentID, COUNT(AccountID) AS SLnhanvien FROM `account`
WHERE DepartmentID=2;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"

SELECT * FROM `account` WHERE FullName LIKE 'D%o'; 

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019

DELETE FROM exam WHERE CreateDate < '2019-12-20';

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"

DELETE FROM question WHERE Content = 'câu hỏi';

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn

UPDATE `account` SET FullName='Nguyễn Bá Lộc',Email='loc.nguyenba@vti.com.vn' WHERE AccountID=5;

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4

UPDATE groupaccount SET AccountID=5 WHERE GroupID=4;

-- Exercise 1: Join
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ

SELECT a.FullName, a.DepartmentID, d.DepartmentName
FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010

SELECT * FROM `account` WHERE CreateDate >'2020-12-20';

-- Question 3: Viết lệnh để lấy ra tất cả các developer

SELECT *
FROM `account` a
INNER JOIN position p ON a.PositionID = p.PositionID
WHERE PositionName ='Dev';









