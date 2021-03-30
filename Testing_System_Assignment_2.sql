DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;		
USE TestingSystem;
DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
DepartmentID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
DepartmentName 	VARCHAR(50) NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS 	Position;
CREATE TABLE Position (
PositionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
PositionName  ENUM ('Dev','Test','Scrum Mater','PM') NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
AccountID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Email VARCHAR(50) NOT NULL UNIQUE KEY,
Username VARCHAR(50) NOT NULL UNIQUE KEY,
FullName NVARCHAR(50) NOT NULL,
DepartmentID TINYINT UNSIGNED NOT NULL,
PositionID TINYINT UNSIGNED NOT NULL,
CreateDate DATETIME DEFAULT NOW(),
FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);
 DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
GroupID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
GroupName NVARCHAR(50) NOT NULL UNIQUE KEY,
CreatorID TINYINT UNSIGNED NOT NULL,
CreateDate DATETIME DEFAULT NOW(),
FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount (
GroupID TINYINT UNSIGNED NOT NULL,
AccountID TINYINT UNSIGNED NOT NULL,
JoinDate DATETIME DEFAULT NOW(),
PRIMARY KEY (GroupID,AccountID),
FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
);
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
TypeID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
TypeName ENUM ('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion (
CategoryID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
CategoryName NVARCHAR(50) NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS Question;
CREATE TABLE Question (
QuestionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Content NVARCHAR(50) NOT NULL,
CategoryID TINYINT UNSIGNED NOT NULL ,
TypeID TINYINT UNSIGNED NOT NULL,
CreatorID TINYINT UNSIGNED NOT NULL,
CreateDate DATETIME DEFAULT NOW(),
FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID),
FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer (
AnswerID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Content NVARCHAR(100) NOT NULL,
QuestionID TINYINT UNSIGNED NOT NULL,
isCorrect BIT DEFAULT (1),
FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
); 
DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam (
ExamID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
`Code` CHAR(10) NOT NULL,
Title NVARCHAR(30) NOT NULL,
CategoryID TINYINT UNSIGNED NOT NULL,
Duration TINYINT UNSIGNED NOT NULL,
CreatorID TINYINT UNSIGNED NOT NULL,
CreateDate DATETIME DEFAULT NOW(),
FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);
DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion (
ExamID TINYINT UNSIGNED NOT NULL,
QuestionID TINYINT UNSIGNED NOT NULL,
PRIMARY KEY (ExamID,QuestionID),
FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

INSERT INTO department (DepartmentName) VALUES	('Sales');
INSERT INTO department (DepartmentName) VALUES	('maketing');
INSERT INTO department (DepartmentName) VALUES	('accountant');
INSERT INTO department (DepartmentName) VALUES	('admin');
INSERT INTO department (DepartmentName) VALUES	('Engineering');

INSERT INTO `Position` (PositionName)
VALUES					('Dev'),
						('Test'),
                        ('Scrum Mater'),
                        ('PM');

INSERT INTO `account` (Email, Username, FullName, DepartmentID, PositionID, CreateDate) 
VALUES ('Thangbita1403@gmail.com', 'thang', 'Nguyễn xuân thắng', 1, 1, '2021-03-28');
INSERT INTO `account` (Email, Username, FullName, DepartmentID, PositionID, CreateDate) 
VALUES ('Trinhhieu2k000@gmail.com', 'hieu', 'Trịnh Văn Hiếu', 2, 2, '2021-03-28');
INSERT INTO `account` (Email, Username, FullName, DepartmentID, PositionID, CreateDate) 
VALUES ('hqkhnk2209@gmail.com', 'hung', 'Ngô Mạnh Hùng', 3, 3, '2021-03-28');
INSERT INTO `account` (Email, Username, FullName, DepartmentID, PositionID, CreateDate) 
VALUES ('phungthetai686@gmail.com', 'tai', 'Phùng Thế Tài', 4, 4, '2021-03-28');
INSERT INTO `account` (Email, Username, FullName, DepartmentID, PositionID, CreateDate) 
VALUES ('hiendon99@gmail.com', 'hien', 'Nguyễn Văn Hiển', 5, 1, '2021-03-28');

INSERT INTO `Group` ( GroupName , CreatorID , CreateDate)
VALUES ( 'L10 Sale 01', 1 , '2021-03-28'),
		( 'L10 Sale 02', 2 , '2021-03-28'),
        ( 'L10 Sale 03', 3 , '2021-03-28'),
        ( 'L10 engineering 01', 4 , '2021-03-28'),
		('L10 engineering 02', 5 , '2021-03-28');
        
INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (1, 1 , '2021-03-28');
INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (2, 1 , '2021-03-29');
INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (2, 5 , '2021-03-29');        
INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (4, 3 , '2021-03-29'); 
INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (3, 2 , '2021-03-29'); 

INSERT INTO TypeQuestion (TypeName )
VALUES ('Essay' ),('Multiple-Choice' );

INSERT INTO CategoryQuestion (CategoryName )
VALUES ('Java' ),
		('.NET' ),
        ('SQL' ),
        ('Postman' ),
		('Ruby' );
        
INSERT INTO Question (Content, CategoryID, TypeID, CreatorID, CreateDate) 
VALUES ( 'cau hoi 1' , 1 , 1 , 2 , '2021-03-29' );
INSERT INTO Question (Content, CategoryID, TypeID, CreatorID, CreateDate) 
VALUES ('cau hoi 2' , 2 , 2 , 1 , '2021-03-29' );
INSERT INTO Question (Content, CategoryID, TypeID, CreatorID, CreateDate) 
VALUES ('cau hoi 3' , 3 , 2 , 3 , '2021-03-29' );
INSERT INTO Question (Content, CategoryID, TypeID, CreatorID, CreateDate) 
VALUES ('cau hoi 4' , 4 , 1 , 4 , '2021-03-29' );
INSERT INTO Question (Content, CategoryID, TypeID, CreatorID, CreateDate) 
VALUES ('cau hoi 5' , 5 , 1 , 5 , '2021-03-29' );

INSERT INTO Answer (Content, QuestionID, isCorrect) VALUES ('tra loi 1', 1, 1);
INSERT INTO Answer (Content, QuestionID, isCorrect) VALUES ('tra loi 2', 2, 0);
INSERT INTO Answer (Content, QuestionID, isCorrect) VALUES ('tra loi 3', 3, 0);
INSERT INTO Answer (Content, QuestionID, isCorrect) VALUES ('tra loi 4', 4, 1);
INSERT INTO Answer (Content, QuestionID, isCorrect) VALUES ('tra loi 5', 5, 1);

INSERT INTO Exam (`Code` , Title , CategoryID , Duration , CreatorID , CreateDate )
VALUES ('RW1', 'chu de Java' , 1 , 90 , 3 , '2021-03-29');
INSERT INTO Exam (`Code` , Title , CategoryID , Duration , CreatorID , CreateDate )
VALUES ('RW2', 'chu de .NET' , 2 , 90 , 1 , '2021-03-29');
INSERT INTO Exam (`Code` , Title , CategoryID , Duration , CreatorID , CreateDate )
VALUES ('RW3', 'chu de SQL' , 3 , 90 , 2 , '2021-03-29');
INSERT INTO Exam (`Code` , Title , CategoryID , Duration , CreatorID , CreateDate )
VALUES ('RW4', 'chu de Postman' , 4 , 90 , 5 , '2021-03-29');
INSERT INTO Exam (`Code` , Title , CategoryID , Duration , CreatorID , CreateDate )
VALUES ('RW5', 'chu de Ruby' , 5 , 90 , 4 , '2021-03-29');

INSERT INTO ExamQuestion (ExamID, QuestionID) VALUES (1, 3);
INSERT INTO ExamQuestion (ExamID, QuestionID) VALUES (2, 1);
INSERT INTO ExamQuestion (ExamID, QuestionID) VALUES (3, 2);
INSERT INTO ExamQuestion (ExamID, QuestionID) VALUES (4, 5);
INSERT INTO ExamQuestion (ExamID, QuestionID) VALUES (5, 4);