-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
CREATE OR REPLACE VIEW vw_List_AccountFromSale AS(
SELECT a.AccountID, a.Email, a.FullName, d.DepartmentName, a.PositionID, a.CreateDate
FROM `account` a
INNER JOIN department d ON d.DepartmentID = a.DepartmentID
WHERE d.DepartmentName = 'sale');
SELECT a.AccountID, a.Email, a.FullName, d.DepartmentName, a.PositionID, a.CreateDate FROM vw_List_AccountFromSale;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE OR REPLACE VIEW vw_List_AccountIDMaxgroup AS (
 WITH CTE_getCountAccountID AS (
 SELECT COUNT(ga.AccountID) AS SL FROM groupaccount ga
 GROUP BY ga.AccountID
 )
 SELECT ga.AccountID, a.FullName, a.Email, COUNT(ga.AccountID) AS SL
 FROM groupaccount ga
 INNER JOIN `account` a ON a.AccountID = ga.AccountID
 GROUP BY ga.AccountID
 HAVING COUNT(ga.AccountID) = (SELECT MAX(SL) FROM CTE_getCountAccountID));
 
 SELECT * FROM vw_List_AccountIDMaxgroup;
 
-- Question 8: Lấy ra Question có nhiều câu trả lời nhất- Assignment_4
CREATE OR REPLACE VIEW vw_List_Questionmaxanswer AS (
WITH CTE_GetMaxanswer AS (
SELECT COUNT(a.QuestionID) as SL FROM answer a 
GROUP BY a.QuestionID)
SELECT a.AnswerID,q.QuestionID,q.Content,q.CreateDate, COUNT(a.AnswerID) AS SL
FROM answer a 
INNER JOIN question q ON a.QuestionID = q.QuestionID
GROUP BY a.QuestionID
HAVING COUNT(a.QuestionID)= (SELECT MAX(SL) FROM CTE_GetMaxanswer));
 SELECT * FROM vw_List_Questionmaxanswer;
 
  -- Question 10: Tìm chức vụ có nhiều người nhất Assignment_4
 WITH CTE_ChucVu AS (
 SELECT COUNT(a.PositionID) AS SL FROM `account` a
 GROUP BY a.PositionID) 
 SELECT p.PositionName, COUNT(a.PositionID) AS SL
 FROM `account` a
 INNER JOIN position p ON p.PositionID = a.PositionID
 GROUP BY a.PositionID
 HAVING COUNT(a.PositionID)= (SELECT MAX(SL) FROM CTE_ChucVu);
 
  -- Question 10: Tìm chức vụ có ít người nhất Assignment_4
  
 WITH CTE_ChucVu AS (
 SELECT COUNT(a.PositionID) AS SL FROM `account` a
 GROUP BY a.PositionID)
 SELECT p.PositionName, COUNT(a.PositionID) AS SL
 FROM `account` a
 INNER JOIN position p ON a.PositionID = p.PositionID
 GROUP BY a.PositionID
 HAVING COUNT(a.PositionID)= (SELECT MIN(SL) FROM CTE_ChucVu);
 
-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
-- question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, … Assignment_4

SELECT q.QuestionID,tp.TypeName, cq.CategoryName, q.CreatorID, q.Content, aw.Content, q.CreateDate
FROM question q
INNER JOIN answer aw ON q.QuestionID = aw.QuestionID
INNER JOIN typequestion tp ON tp.TypeID = q.TypeID
INNER JOIN categoryquestion cq ON cq.CategoryID = q.CategoryID;

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
-- được coi là quá dài) và xóa nó đi
CREATE OR REPLACE VIEW vw_delete_Contentlenght AS(
DELETE FROM question WHERE QuestionID = (SELECT QuestionID, length(Content) AS SL
										FROM question
										WHERE length(Content)>300));



-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
CREATE OR REPLACE VIEW vw_List_DepartmentMaxAccount AS (
WITH CTE_CountAccountFromDepartment AS
(SELECT COUNT(a.AccountID) AS SL FROM `account` a
GROUP BY a.DepartmentID)
SELECT d.DepartmentName, COUNT(a.AccountID) AS SL
FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
GROUP BY a.DepartmentID
HAVING COUNT(a.AccountID)= (SELECT MAX(SL) FROM CTE_CountAccountFromDepartment));
SELECT d.DepartmentName, COUNT(a.AccountID) AS SL FROM vw_List_DepartmentMaxAccount;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo

CREATE OR REPLACE VIEW vw_QuestionOfUser AS(
SELECT q.QuestionID, a.FullName
FROM question q
INNER JOIN `account` a ON q.CreatorID = a.AccountID
WHERE SUBSTRING_INDEX(FullName,' ', 1) = 'Catarina'); -- thay nguyễn chỗ catarina để check

SELECT * FROM vw_QuestionOfUser;


-- 




 
 
 
 
 
 
 