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
-- 1
-- Tạo View ViewStudentBasic hiển thị: StudentID, FullName, và DeptName. Sau đó viết lệnh truy vấn toàn bộ dữ liệu từ View này.
CREATE VIEW ViewStudentBasic AS
SELECT StudentID,FullName,DeptName 
FROM Student s
JOIN Department d ON s.DeptID = d.DeptID;
-- 2
-- Tạo một Regular Index tên là idxFullName cho cột FullName của bảng Student.
CREATE INDEX idxFullName ON Student(FullName);

-- Viết Stored Procedure GetStudentsIT (không có tham số).
	-- Chức năng: Hiển thị toàn bộ sinh viên thuộc khoa "Information Technology" trong bảng Student kết hợp với DeptName từ bảng Department.
	-- Yêu cầu: Gọi procedure bằng lệnh CALL để kiểm tra.
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

-- a) Tạo View ViewStudentCountByDept hiển thị: DeptName, TotalStudents (số lượng sinh viên của mỗi khoa).
-- b) Từ View trên, viết truy vấn hiển thị khoa có nhiều sinh viên nhất.
-- 4 
CREATE VIEW ViewStudentCountByDept AS
SELECT DeptName, COUNT(s.DeptID) as TotalStudents 
FROM Department d
JOIN Student s ON s.DeptID = d.DeptID
group by DeptName
order by TotalStudents  DESC
LIMIT 1;

