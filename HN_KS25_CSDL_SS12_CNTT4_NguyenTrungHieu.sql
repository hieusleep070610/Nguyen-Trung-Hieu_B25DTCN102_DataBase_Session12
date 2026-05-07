CREATE DATABASE StudentDB;
USE StudentDB;
-- 1. Bảng Khoa
CREATE TABLE Department (
    DeptID VARCHAR(5) PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

-- 2. Bảng SinhVien
CREATE TABLE Student (
    StudentID VARCHAR(6) PRIMARY KEY,
    FullName VARCHAR(50),
    Gender VARCHAR(10),
    BirthDate DATE,
    DeptID VARCHAR(5),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- 3. Bảng MonHoc
CREATE TABLE Course (
    CourseID VARCHAR(6) PRIMARY KEY,
    CourseName VARCHAR(50),
    Credits INT
);

-- 4. Bảng DangKy
CREATE TABLE Enrollment (
    StudentID VARCHAR(6),
    CourseID VARCHAR(6),
    Score DECIMAL(4,2), 
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Chèn dữ liệu mẫu
INSERT INTO Department VALUES
('IT','Information Technology'),
('BA','Business Administration'),
('ACC','Accounting');

INSERT INTO Student VALUES
('S00001','Nguyen An','Male','2003-05-10','IT'),
('S00002','Tran Binh','Male','2003-06-15','IT'),
('S00003','Le Hoa','Female','2003-08-20','BA'),
('S00004','Pham Minh','Male','2002-12-12','ACC'),
('S00005','Vo Lan','Female','2003-03-01','IT'),
('S00006','Do Hung','Male','2002-11-11','BA'),
('S00007','Nguyen Mai','Female','2003-07-07','ACC'),
('S00008','Tran Phuc','Male','2003-09-09','IT');
INSERT INTO Course VALUES
('C00001','Lập trình C',5),
('BA102','Kinh tế vi mô',3),
('ACC10','Thuế',4);
INSERT INTO Enrollment VALUES
('S00001','C00001',7.5),
('S00002','C00001',8),
('S00003','BA102',6),
('S00004','ACC10',5),
('S00005','C00001',4.8),
('S00006','BA102',6.7),
('S00007','ACC10',9),
('S00008','C00001',7);

-- 1
CREATE VIEW ViewStudentBasic AS
SELECT StudentID,FullName,DeptName 
FROM Student s
JOIN Department d ON s.DeptID = d.DeptID;
-- 2
CREATE INDEX idxFullName ON Student(FullName);

-- 3
DELIMITER //
CREATE procedure GetStudentsIT ()
BEGIN
	SELECT StudentID,FullName,DeptName 
	FROM Student s
	JOIN Department d ON s.DeptID = d.DeptID
    WHERE DeptName = 'Information Technology';
END 
// DELIMITER ;

CALL GetStudentsIT();

-- 4 
CREATE VIEW ViewStudentCountByDept AS
SELECT DeptName, COUNT(s.DeptID) as TotalStudents 
FROM Department d
JOIN Student s ON s.DeptID = d.DeptID
group by DeptName
order by TotalStudents DESC
LIMIT 1;
-- 5
DELIMITER //
CREATE procedure GetTopScoreStudent(IN varCourseID VARCHAR(6))
BEGIN
	SELECT StudentID,CourseID ,Score 
    FROM Enrollment
    WHERE CourseID = varCourseID
    ORDER BY Score DESC
    LIMIT 1;
END 
// DELIMITER ;

CALL GetTopScoreStudent('C00001');
