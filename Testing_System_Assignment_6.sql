-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các
-- account thuộc phòng ban đó

DROP PROCEDURE IF EXISTS sp_GetAccInforFromDepName;
DELIMITER $$
CREATE PROCEDURE sp_GetAccInforFromDepName(IN in_DepName VARCHAR(30))
BEGIN
	SELECT  a.AccountID, d.DepartmentName,p.PositionName, a.Email, a.FullName, a.CreateDate
	FROM `account` a
	INNER JOIN department d ON a.DepartmentID = d.DepartmentID
    INNER JOIN position p ON p.PositionID= a.PositionID
	WHERE d.DepartmentName = in_DepName;
END$$
DELIMITER 

Call sp_GetAccInforFromDepName('sale');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS sp_GetAccInforFromDepName;
DELIMITER $$
CREATE PROCEDURE sp_GetAccInforFromDepName(IN in_DepName VARCHAR(30))
BEGIN
	SELECT ga.GroupID,g.GroupName, ga.AccountID, ga.JoinDate
	FROM  `group` g  
	INNER JOIN groupaccount ga  ON  g.GroupID = ga.GroupID
	WHERE g.GroupName = in_DepName;
END$$
DELIMITER 

Call sp_GetAccInforFromDepName('Management');

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại
DROP PROCEDURE IF EXISTS sp_GetCountTypeInMonth;
DELIMITER $$
CREATE PROCEDURE sp_GetCountTypeInMonth()
BEGIN
SELECT tq.TypeName, count(q.TypeID) FROM question q
INNER JOIN typequestion tq ON q.TypeID = tq.TypeID
WHERE month(q.CreateDate) = month(now()) AND year(q.CreateDate) = year(now())
GROUP BY q.TypeID;
END$$
DELIMITER ;
Call sp_GetCountTypeInMonth();

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS sp_GetCountQuesFromType;
DELIMITER $$
CREATE PROCEDURE sp_GetCountQuesFromType()
BEGIN
WITH CTE_MaxTypeID AS(
SELECT count(q.TypeID) AS SL FROM question q
GROUP BY q.TypeID)
SELECT tq.TypeName, count(q.TypeID) AS SL FROM question q
INNER JOIN typequestion tq ON tq.TypeID = q.TypeID
GROUP BY q.TypeID
HAVING count(q.TypeID) = (SELECT MAX(SL) FROM CTE_MaxTypeID);
END$$
DELIMITER ;
Call sp_GetCountQuesFromType();

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
DROP PROCEDURE IF EXISTS sp_GetCountQuesFromType;
DELIMITER $$
CREATE PROCEDURE sp_GetCountQuesFromType()
BEGIN
WITH CTE_MaxTypeID AS(
SELECT count(q.TypeID) AS SL FROM question q
GROUP BY q.TypeID
)
SELECT tq.TypeName, count(q.TypeID) AS SL FROM question q
INNER JOIN typequestion tq ON tq.TypeID = q.TypeID
GROUP BY q.TypeID
HAVING count(q.TypeID) = (SELECT MAX(SL) FROM CTE_MaxTypeID);
END$$
DELIMITER ;
Call sp_GetCountQuesFromType();
SET @ID =0;
Call sp_GetCountQuesFromType(@ID);
SELECT * FROM typequestion WHERE TypeID = @ID;













