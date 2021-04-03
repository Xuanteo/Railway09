-- Sử dụng DB mẫu.
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

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên

SELECT d.DepartmentID, d.DepartmentName, COUNT(a.DepartmentID) AS SL
FROM `account`a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
GROUP BY DepartmentID
HAVING COUNT(a.DepartmentID)>3;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT q.QuestionID, q.Content, q.CategoryID, q.TypeID, q.CreatorID, q.CreateDate , COUNT(q.Content) AS SL
FROM question q
INNER JOIN examquestion eq ON q.QuestionID = eq.QuestionID
GROUP BY q.Content
HAVING COUNT(q.Content)=(SELECT MAX(countq)
						FROM 
                                (SELECT COUNT(q.QuestionID) AS countq
								FROM examquestion eq
								INNER JOIN question q ON q.QuestionID = eq.QuestionID
								GROUP BY q.QuestionID) AS MaxContent);

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT cq.CategoryID, cq.CategoryName, COUNT(q.CategoryID) AS SL
FROM categoryquestion cq
LEFT JOIN question q ON q.CategoryID = cq.CategoryID
GROUP BY cq.CategoryID
ORDER BY cq.CategoryID ASC;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT q.Content, COUNT(eq.QuestionID) AS SL
FROM question q
LEFT JOIN examquestion eq ON q.QuestionID = eq.QuestionID
GROUP BY q.QuestionID
ORDER BY eq.ExamID ASC;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT q.QuestionID, q.Content, COUNT(a.Content) AS SL
FROM question q
INNER JOIN answer a ON q.QuestionID =a.QuestionID
GROUP BY a.QuestionID
HAVING COUNT(a.QuestionID) =(SELECT MAX(AnswerA)
							FROM(
									SELECT  COUNT(a.QuestionID) AS AnswerA
									FROM question q
									INNER JOIN answer a ON q.QuestionID =a.QuestionID
									GROUP BY a.QuestionID) AS MaxAnswer);
                                    
-- Question 9: Thống kê số lượng account trong mỗi group
SELECT g.GroupID, g.GroupName, COUNT(AccountID) AS SL
FROM `group` g
LEFT JOIN groupaccount gc ON g.GroupID = gc.GroupID
GROUP BY gc.GroupID
ORDER BY gc.GroupID ASC;

-- Question 10: Tìm chức vụ có ít người nhất
SELECT p.PositionID, p.PositionName, COUNT(a.AccountID) AS SL
FROM  position p
INNER JOIN `account` a ON a.PositionID = p.PositionID	
GROUP BY a.PositionID	
HAVING COUNT(a.PositionID) = (SELECT MIN(positiona)
							  FROM (
									SELECT COUNT(a.PositionID) AS positiona
									FROM `account` a
									INNER JOIN position p ON a.PositionID = p.PositionID
									GROUP BY a.PositionID) AS Minposition);

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT d.DepartmentName, p.PositionName, COUNT(a.DepartmentID) AS SL
FROM `account` a
INNER JOIN position p ON a.PositionID = p.PositionID
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
GROUP BY a.DepartmentID
HAVING COUNT(a.DepartmentID);

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
-- question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …
SELECT q.QuestionID, q.Content AS nộidung, tq.TypeName AS Loạicâuhỏi, q.CreatorID AS Ngườitạo, a.Content AS trảlời, q.CreateDate AS ngàytạo
FROM question q
INNER JOIN answer a ON a.QuestionID = q.QuestionID
INNER JOIN typequestion tq ON q.TypeID = tq.TypeID;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT tq.TypeID, tq.TypeName, COUNT(q.TypeID) AS SL
FROM typequestion tq
INNER JOIN question q ON q.TypeID = tq.TypeID
GROUP BY q.TypeID;

-- Question 14:Lấy ra group không có account nào
SELECT g.GroupID, g.GroupName
FROM `group` g
LEFT JOIN groupaccount ga ON g.GroupID = ga.GroupID
WHERE ga.GroupID IS NULL
ORDER BY ga.GroupID ASC;

-- Question 15: Lấy ra group không có account nào
SELECT g.GroupID, g.GroupName
FROM `group` g
LEFT JOIN groupaccount ga ON g.GroupID = ga.GroupID
WHERE ga.GroupID IS NULL
ORDER BY ga.GroupID ASC;

-- Question 16: Lấy ra question không có answer nào
SELECT q.QuestionID, q.Content
FROM question q
LEFT JOIN answer a ON q.QuestionID=a.QuestionID
WHERE a.QuestionID IS NULL
ORDER BY a.QuestionID ASC;

-- Exercise 2: Union
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
-- b) Lấy các account thuộc nhóm thứ 2
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT a.AccountID, a.FullName
FROM `account` a
INNER JOIN groupaccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID =1
UNION
SELECT a.AccountID, a.FullName
FROM `account` a
INNER JOIN groupaccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID =2;

-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
-- b) Lấy các group có nhỏ hơn 7 thành viên
-- c) Ghép 2 kết quả từ câu a) và câu b)
SELECT g.GroupID,g.GroupName, COUNT(ga.GroupID) AS SL
FROM `group` g
INNER JOIN groupaccount ga ON g.GroupID = ga.GroupID
GROUP BY ga.GroupID
HAVING COUNT(ga.GroupID)>5
UNION
SELECT g.GroupID,g.GroupName, COUNT(ga.GroupID) AS SL
FROM `group` g
INNER JOIN groupaccount ga ON g.GroupID = ga.GroupID
GROUP BY ga.GroupID
HAVING COUNT(ga.GroupID)<7;
