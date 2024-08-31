USE master
GO
IF DB_ID('HRRajShah') IS NOT NULL
	DROP DATABASE HRRajShah
GO
CREATE DATABASE HRRajShah
GO 

CREATE SCHEMA HR;

USE HR_RajShah
GO
CREATE TABLE Candidates(
	CandidateID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NULL,
    Email VARCHAR(50) NOT NULL,
    Phone VARCHAR(10) NOT NULL,
    ShortProfile VARCHAR(100) NULL DEFAULT 'Not Given',
    OfferAccepted VARCHAR(10) NULL 
);


CREATE TABLE CandidateAddress(
    CandidateAddressID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	CandidateID INT NOT NULL,
    AddressLine1 VARCHAR(30) NOT NULL,
	AddressLine2 VARCHAR(30) NULL,
    Street VARCHAR(50) NULL,
    City VARCHAR(10) NOT NULL,
    ZipCode VARCHAR(5) NOT NULL,
    FOREIGN KEY(CandidateID) REFERENCES Candidates(CandidateID) 
);

select * from HR.CandidateAddress;


CREATE TABLE JobPlatform(
    JobPlatformID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    JobPlatformName VARCHAR(100) NOT NULL,
	JobPlatformDescription VARCHAR(300) NOT NULL
    );

CREATE TABLE Job(
    JobID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    JobPlatformID INT NOT NULL,
    NoOfVacancies INT NOT NULL,
    JobCategory VARCHAR(60) NOT NULL,
    JobPosition VARCHAR(60) NOT NULL,
    JobType VARCHAR(60) NOT NULL,
    JobMedium VARCHAR(60) NOT NULL,
    Salary MONEY NULL
    FOREIGN KEY(JobPlatformID) REFERENCES JobPlatform(JobPlatformID),
);

CREATE TABLE JobOpenings(
    JobOpeningsID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    NoOfPositions INT NOT NULL,
	DatePosted DATE NOT NULL,
    JobStartDate DATE NOT NULL,
    JobName VARCHAR(100) NOT NULL,
    JobID INT  NOT NULL,
    FOREIGN KEY(JobID) REFERENCES Job(JobID)

);


CREATE TABLE Documents(
    DocumentID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	CandidateID INT NOT NULL,
    DocumentName VARCHAR(30) NOT NULL,
	DocumentType VARCHAR(30) NOT NULL,
    DocumentUrl VARCHAR(50) NOT NULL
    FOREIGN KEY(CandidateID) REFERENCES Candidates(CandidateID) 
);



CREATE TABLE OnBoarding(
    OnBoardingID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CandidateID INT NOT NULL,
    OnboardingStatus VARCHAR(20) NULL,
	ActualStartDate DATETIME NULL,
    JobID INT NOT NULL,
    FOREIGN KEY(JobID) REFERENCES Job(JobID), 
    FOREIGN KEY(CandidateID) REFERENCES Candidates(CandidateID) 
);



CREATE TABLE Application(
    ApplicationID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	CandidateID INT NOT NULL,
    Education VARCHAR(255) NOT NULL,
    WorkExperience VARCHAR(255) DEFAULT NULL,
    ApplicationTimeStamp DATE NOT NULL,
    JobOpeningsID INT NOT NULL  
    FOREIGN KEY(JobOpeningsID) REFERENCES JobOpenings(JobOpeningsID),
    FOREIGN KEY(CandidateID) REFERENCES Candidates(CandidateID) 
);




CREATE TABLE ApplicationDocuments(
    ApplicationDocumentID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    DocumentID INT NOT NULL,
	ApplicationID INT NOT NULL
    FOREIGN KEY(ApplicationID) REFERENCES Application(ApplicationID),
    FOREIGN KEY(DocumentID) REFERENCES Documents(DocumentID) 
);

CREATE TABLE Reimbursement(
    ReimbursementID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ReimbursementRequestNumber INT NOT NULL,
    ReimbursementAmount MONEY NOT NULL,
    ReimbursementDate DATE NOT NULL, 
    ReimbursementMaxAmount MONEY DEFAULT 30000 NOT NULL,
	ApplicationID INT NOT NULL,
    RequestType VARCHAR(30) NOT NULL,
    RequestStatus VARCHAR(30) NOT NULL
    FOREIGN KEY(ApplicationID) REFERENCES Application(ApplicationID)
);

CREATE TABLE Complaint(
    ComplaintID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ComplaintDescription VARCHAR(255) NOT NULL,
    ComplaintValid BIT NOT NULL,
    ComplaintInterviewStatus VARCHAR(50) NOT NULL,
	ApplicationID INT NOT NULL
    FOREIGN KEY(ApplicationID) REFERENCES Application(ApplicationID)
);



CREATE TABLE ApplicationStatus(
    ApplicationStatusID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ApplicationStatusChangedDate DATETIME NOT NULL,
    StatusID INT NOT NULL,
	ApplicationID INT NOT NULL
    FOREIGN KEY(ApplicationID) REFERENCES Application(ApplicationID)
);


CREATE TABLE Status(
    StatusID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Status VARCHAR(100) NOT NULL
);






CREATE TABLE InterviewLocation(
    InterviewLocationID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    InterviewLocationAddress VARCHAR(20) NULL,
    InterviewLocationCity VARCHAR(20) NULL,
    InterviewLocationState VARCHAR(20) NULL,
    InterviewLocationZIPCode VARCHAR(20) NULL
);



CREATE TABLE InterviewType(
    InterviewTypeID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    InterviewCategory VARCHAR(20) NOT NULL
);





CREATE TABLE Interviews(
    InterviewID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    ApplicationID INT NOT NULL,
    InterviewTypeID INT NOT NULL,
    InterviewLocationID INT NOT NULL,
    FOREIGN KEY(ApplicationID) REFERENCES Application(ApplicationID),
    FOREIGN KEY(InterviewLocationID) REFERENCES InterviewLocation(InterviewLocationID),
    FOREIGN KEY(InterviewTypeID) REFERENCES InterviewType(InterviewTypeID)
);


CREATE TABLE TestDetails(
    TestDetailsID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TestCategory VARCHAR(30) NOT NULL,
    TestMaxScore INT NOT NULL,
    TestDuration TIME NULL
);





CREATE TABLE Tests(
    TestsID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TestStartTime TIME NOT NULL,
    TesEndTime TIME NOT NULL,
    TestDetailsID INT NOT NULL,
    TestScore INT NOT NULL,
    TestGrade varchar(10) NOT NULL,
    ApplicationID INT NOT NULL,
    InterviewID INT NOT NULL
    FOREIGN KEY(InterviewID) REFERENCES Interviews(InterviewID),
    FOREIGN KEY(TestDetailsID) REFERENCES TestDetails(TestDetailsID),
    FOREIGN KEY(ApplicationID) REFERENCES Application(ApplicationID)
);


CREATE TABLE Interviewers(
    InterviewerID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Title VARCHAR(20) NULL,
    Department VARCHAR(20) NOT NULL
);



CREATE TABLE InterviewFeedback(
    InterviewFeedbackID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    InterviewID INT NOT NULL,
    InterviewerID INT NOT NULL,
    Result VARCHAR(100) NOT NULL,
    Notes VARCHAR(100) NULL
    FOREIGN KEY(InterviewID) REFERENCES Interviews(InterviewID),
    FOREIGN KEY(InterviewerID) REFERENCES Interviewers(InterviewerID)
);

CREATE TABLE Evaluation(
    EvaluationID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    InterviewerID INT NOT NULL,
    ApplicationID INT NOT NULL,
    Result VARCHAR(50) NOT NULL,
    EvaluationNotes VARCHAR(50) NULL,
    FOREIGN KEY(InterviewerID) REFERENCES Interviewers(InterviewerID),
    FOREIGN KEY(ApplicationID) REFERENCES Application(ApplicationID)
);




CREATE TABLE Reviews(
    ReviewsID INT NOT NULL,
    CandidateReview VARCHAR(200) NULL,
    InterviewerReview VARCHAR(200) NULL,
    InterviewID INT NOT NULL,
    InterviewerID INT NOT NULL,
    CandidateID INT NOT NULL,
    FOREIGN KEY(CandidateID) REFERENCES Candidates(CandidateID),
    FOREIGN KEY(InterviewID) REFERENCES Interviews(InterviewID),
    FOREIGN KEY(InterviewerID) REFERENCES Interviewers(InterviewerID)
);


CREATE TABLE Blacklist(
    BlacklistID INT NOT NULL,
    Reason VARCHAR(200) NULL,
    CandidateID INT NOT NULL,
    FOREIGN KEY(CandidateID) REFERENCES Candidates(CandidateID),
);

INSERT INTO Candidates(CandidateID,FirstName,LastName,Email,Phone,ShortProfile,OfferAccepted)
VALUES
(1,'Raj','Shah','rshah26@syr.edu','9876534564','Skilled in SQL','Yes'),
(2,'Harsh','Mandviya','hmand6@syr.edu','6534564123','Skilled in Java',''),
(3,'Jill','Goshrani','jigos2@syr.edu','3456446743','Proficient in DBMS, Python',''),
(4,'Jaynam','Shah','jaysa8@syr.edu','3154214546','Skilled in C++','Yes'),
(5,'Mohit','Thakkar','mohit36@syr.edu','3154564546','Skilled in MongoDB',''),
(6,'Manav','Nisar','manan76@syr.edu','3123567548','Skilled in Data Science','Yes'),
(7,'Kavish','Shah','kavah5@syr.edu','3874164564','Proficient in DBMS, Python',''),
(8,'Bhavik','Shah','bhavh96@syr.edu','9126534564','Skilled in MERN','Yes'),
(9,'Rithik','Gujar','rit456@syr.edu','9316534564','Proficient in Java, Python',''),
(10,'Ayush','Shah','ayushh6@syr.edu','3187534564','Proficient in Node.js, Python','Yes');
SELECT * FROM Candidates;

INSERT INTO CandidateAddress(CandidateID,AddressLine1,City,ZipCode)
VALUES
(1,'12 Westcott Street','Syracuse','13210'),
(2,'712 Westcott Street','Syracuse','13210'),
(3,'822 Westcott Street','Syracuse','13210'),
(4,'456 Westcott Street','Syracuse','13210'),
(5,'321 Westcott Street','Syracuse','13210'),
(6,'897 Westcott Street','Syracuse','13210'),
(7,'567 Westcott Street','Syracuse','13210'),
(8,'1743 Westcott Street','Syracuse','13210'),
(9,'678 Westcott Street','Syracuse','13210'),
(10,'245 Westcott Street','Syracuse','13210');

SELECT * FROM CandidateAddress;

INSERT INTO Documents(CandidateID, DocumentName, DocumentType, DocumentURL)
VALUES
		(1,'Resume','PDF','https://yourwebsite.com/pages/'),
		(2,'CV','PDF','https://yourwebsite.com/pages/'),
		(3,'CV','PDF','https://yourwebsite.com/pages/'),
		(4,'Resume','Word','https://yourwebsite.com/pages/'),
		(5,'CV','Word','https://yourwebsite.com/pages/'),
		(6,'Resume','Word','https://yourwebsite.com/pages/'),
		(7,'CV','Word','https://yourwebsite.com/pages/'),
		(8,'Resume','Word','https://yourwebsite.com/pages/'),
		(9,'Resume','PDF','https://yourwebsite.com/pages/'),
        (10,'Resume','PDF','https://yourwebsite.com/pages/');

SELECT * FROM Documents;

INSERT INTO JobPlatform(JobPlatformName,JobPlatformDescription)
VALUES
('Job board','Company Job Board'),
('Social Media','LinkedIn'),
('Social Media','Indeed'),
('Social Media','Glassdoor'),
('College Connect','Handshake'),
('Referral','Company Employee'),
('Email','Email'),
('SMS','SMS'),
('Career Fair','College connect'),
('HR Recruiter','Inperson');

SELECT * from JobPlatform;

INSERT INTO Job(JobPlatformID,JobMedium,JobType,JobCategory,JobPosition,NoOfVacancies,Salary)
VALUES
(1,'Online','Full Time','IT','Manager',10,100000),
(2,'Online','Summer Internship','Sales','Associate',10,40000),
(3,'Online','Full Time','Testing','Testing',10,120000),
(4,'Online','Full Time','Software','Developer',10,190000),
(5,'Online','Part Time','Software','Associate Developer',10,123000),
(6,'Online','Part Time','Testing','Associate Tester',10,113000),
(7,'Onsite','Full Time','Testing','Associate Manager',10,110000),
(8,'Onsite','Summer Internship','Test','Associate',10,71000),
(9,'Onsite','Full Time','IT','Developer ',10,120000),
(10,'Onsite','Summer Internship','IT','Developer',10,50000);

SELECT * FROM Job;

INSERT INTO JobOpenings(JobName,JobStartDate,DatePosted,NoOfPositions,JobID)
VALUES
('SDE-1','12-12-2022','10-10-2022',10,4),
('SDE-2','12-18-2023','10-10-2022',10,4),
('Test Engineer','2-2-2023','10-10-2022',10,3),
('Data Science Engineer','10-1-2023','10-10-2022',10,9),
('Machine Learning Engineer','12-22-2023','10-10-2022',10,9),
('Intern - SDE','12-25-2022','10-20-2022',10,10),
('Test Intern','12-11-2022','10-10-2022',10,8),
('Sales Intern','12-17-2022','10-10-2022',10,2),
('Marketing Intern','12-18-2022','12-10-2022',10,2),
('Associate Developer','12-27-2022','11-10-2022',10,5);

SELECT * FROM JobOpenings;

INSERT INTO Status(Status)
VALUES
			('Declined'),
			('Accepted'),
			('Negotiating');
SELECT * from Status;

INSERT INTO TestDetails
			(TestCategory,TestMaxScore,TestDuration)
VALUES
('online',100,'01:00:00'),
('onsite',100,'01:00:00');

SELECT * FROM TestDetails;

INSERT INTO InterviewType(InterviewCategory)
VALUES
('Onsite'),
('Online');

SELECT * FROM InterviewType;

INSERT INTO InterviewLocation(InterviewLocationAddress,InterviewLocationState,InterviewLocationCity,InterviewLocationZIPCode)
VALUES
('PDC1A Main Office','NY','NYC','10132'),
('PDC1B Main Office','NY','NYC','10132'),
('PDC1C Main Office','NY','NYC','10132'),
('PDC1D Main Office','NY','NYC','10132'),
('PDC1E Main Office','NY','NYC','10132'),
('PDC1F Main Office','NY','NYC','10132'),
('PDC1G Main Office','NY','NYC','10132'),
('PDC1H Main Office','NY','NYC','10132'),
('PDC1I Main Office','NY','NYC','10132'),
('PDC1J Main Office','NY','NYC','10132'),
('REMOTE','','','' );

SELECT * FROM InterviewLocation;


INSERT INTO Interviewers(InterviewerID,FirstName,LastName,Title,Department)
VALUES
(1,'Robin','Sharma','Executives','IT'),
(2,'Jon','Repp','Hiring manager','IT'),
(3,'Marvin','Mandela','HR manager','HR'),
(4,'Aaron','Wanda','Executives','IT'),
(5,'Cristiano','Repp','Hiring manager','IT'),
(6,'Yash','Joshi','Hiring manager','Marketing'),
(7,'Jainam','Gosrani','Executives','Marketing'),
(8,'Rohan','Singh','Hiring manager','IT'),
(9,'Sonali','Kubde','Executives','IT'),
(10,'Saniya','Jain',' Hiring manager','IT');

SELECT * FROM Interviewers;

INSERT INTO Application
			(CandidateID,ApplicationTimeStamp,Education,WorkExperience,JobOpeningsID)
VALUES
			(1,'12-07-2022','MS in Computer Science','Accenture',2),
			(2,'12-07-2022','BSC in Computer Science','LTI',1),
			(3,'12-07-2022','MS in CS','MindTree',3),
			(4,'12-07-2022','MS in Computer Science','Amazon',4),
			(5,'12-07-2022','MS in CS','Chewy',5),
            (6,'12-07-2022','MS in CS','MindTree',4),
			(7,'12-07-2022','MS in Computer Science','Amazon',3),
			(8,'12-07-2022','BSC in Computer Science','LTI',4),
			(8,'11-22-2022','BSC in Computer Science','LTI',5),		
        	(9,'11-30-2022','MS in Computer Science','Accenture',6),
            (10,'11-30-2022','MS in Computer Science','Accenture',6);

SELECT * FROM Application;

SELECT Application.ApplicationID,Documents.DocumentID FROM Documents
join Application
on Application.CandidateID=Documents.CandidateID;


INSERT INTO ApplicationDocuments(ApplicationID,DocumentID)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,8),
(10,9),
(11,10);

SELECT * FROM ApplicationDocuments;


INSERT INTO Interviews(InterviewID,StartTime,EndTime,InterviewTypeID,InterviewLocationID,ApplicationID)
VALUES
            (1,'09:30:00','10:30:00',1,2,1),
			(2,'09:30:00','10:30:00',1,3,2),
			(3,'09:30:00','10:30:00',1,4,3),
			(4,'09:30:00','10:30:00',1,6,4),
			(5,'09:30:00','10:30:00',1,6,5),
			(6,'10:30:00','11:30:00',2,11,6),
			(7,'10:30:00','11:30:00',2,11,7),
			(8,'10:30:00','11:30:00',2,11,8),
			(9,'10:30:00','11:30:00',2,11,9),
			(10,'10:30:00','11:30:00',2,11,10),
            (11,'10:30:00','11:30:00',1,8,1);
---1-11


INSERT INTO Tests(ApplicationID,TestStartTime,TesEndTime,TestDetailsID,TestScore,TestGrade,InterviewID)
VALUES
			(1,'09:30:00','10:30:00',1,81,'A',1),
			(2,'09:30:00','10:30:00',1,71,'B+',2),
			(3,'09:30:00','10:30:00',1,51,'C+',3),
			(4,'09:30:00','10:30:00',1,100,'A+',4),
			(5,'09:30:00','10:30:00',1,51,'C+',5),
			(6,'10:30:00','11:30:00',2,71,'B+',6),
			(7,'10:30:00','11:30:00',2,81,'A',7),
			(8,'10:30:00','11:30:00',2,71,'B+',8),
			(9,'10:30:00','11:30:00',2,51,'C+',9),
			(10,'10:30:00','11:30:00',2,71,'B+',10),
            (1,'10:30:00','11:30:00',1,91,'A+',1),
            (1,'10:30:00','11:30:00',1,85,'A',1);


SELECT * FROM Tests;

-------------------------------------------------------------

SELECT * FROM Interviews;
SELECT * FROM Application;
SELECT * FROM TestDetails;

INSERT INTO InterviewFeedback(InterviewID,InterviewerID, Result, Notes)
VALUES
(1,1,'Pass','Passed the interview'),
(1,5,'Pass','Passed the interview'),
(2,2,'Fail','Failed the interview'),
(3,3,'Fail','Failed the interview'),
(4,4,'Pass','Passed the interview'),
(5,5,'Pass','Passed the interview'),
(6,6,'Pass','Passed the interview'),
(7,7,'Fail','Failed the interview'),
(8,8,'Pass','Passed the interview'),
(9,9,'Fail','Failed the interview'),
(10,10,'Pass','Passed the interview'),
(11,2,'Pass','Passed the interview');

SELECT * from Application;


INSERT INTO Evaluation(ApplicationID, InterviewerID, Result, EvaluationNotes)
VALUES
(1,1,'Accepted','Candidate fit for the role'),
(1,5,'Accepted','Candidate fit for the role'),
(1,2,'Accepted','Candidate fit for the role'),
(2,2,'Rejected','Candidate not fit for the role'),
(3,3,'Rejected','Candidate not fit for the role'),
(4,4,'Accepted','Candidate fit for the role'),
(5,5,'Rejected','Candidate not fit for the role'),
(6,6,'Accepted','Candidate fit for the role'),
(7,7,'Rejected','Candidate not fit for the role'),
(8,8,'Accepted','Candidate fit for the role'),
(9,9,'Accepted','Candidate fit for the role'),
(10,10,'Accepted','Candidate fit for the role');



SELECT * FROM Evaluation;


INSERT INTO Reimbursement(ReimbursementRequestNumber,ReimbursementAmount,ReimbursementDate,RequestStatus,RequestType,ApplicationID)
VALUES 
(1001,10000,'12-06-2022','Open','HotelReservation',1),
(1002,18000,'11-16-2022','Open','Air Tickets',2),
(1003,20000,'12-05-2022','Open','Air Tickets',3),
(1004,10000,'11-14-2022','Open','Car Rental',4),
(1005,20000,'11-16-2022','Open','HotelReservation',5),
(1006,10000,'12-12-2022','Open','HotelReservation',6),
(1007,14000,'11-06-2022','Open','Car Rental',7),
(1008,10000,'11-9-2022','Open','Air Tickets',8),
(1009,16000,'12-06-2022','Open','Car Rental',9),
(1010,30000,'11-01-2022','Open','Air Tickets',10);
SELECT * FROM Reimbursement;
--------------------------------------------------------------------------
SELECT * FROM Candidates;
SELECT * FROM JOB;
SELECT * FROM JobOpenings;
SELECT * FROM Application;
SELECT * FROM Interviews;





INSERT INTO OnBoarding(OnboardingStatus,ActualStartDate,JobID,CandidateID)
VALUES
			('Completed','2023-12-28',4,1),
            ('OnHold','2021-12-12',9,4),
            ('Completed','2021-12-25',10,6),
			('OnHold','2022-12-28',9,8);

SELECT * FROM OnBoarding;


INSERT INTO Complaint(ApplicationID,ComplaintDescription,ComplaintInterviewStatus,ComplaintValid)
VALUES
(2,'Did not get an interview call','Waiting',''),
(3,'Did not get an interview call','Waiting',''),
(5,'Did not get an interview call','Re-Interview','1');


SELECT * FROM Complaint;












SELECT * FROM [Status];
SELECT * FROM Application;
1D
2a
3n

INSERT INTO ApplicationStatus(StatusID, ApplicationID,ApplicationStatusChangedDate)
VALUES
            (2,1,'12-06-2022 09:00:10'),
            (3,2,'12-06-2022 09:00:10'),
            (3,3,'12-06-2022 09:00:10'),
            (2,4,'12-06-2022 09:00:10'),
			(3,5,'12-06-2022 09:00:10'),
			(2,6,'12-06-2022 09:00:10'),
			(1,7,'12-06-2022 09:00:10'),
			(2,8,'12-06-2022 09:00:10'),
            (3,9,'12-06-2022 09:00:10'),
            (1,10,'12-06-2022 09:00:10');
SELECT * FROM ApplicationStatus;

--Reviews
SELECT Interviewers.InterviewerID
FROM Interviewers

SELECT * from Interviews;
SELECT * from Application;
SELECT * from Candidates;

INSERT into Reviews(InterviewerID,InterviewID,CandidateID,InterviewerReview,CandidateReview)
VALUES
(5,1,1,'Good Candidate','Smooth Process'),
(2,1,1,'Good Candidate','Smooth Process'),
(1,1,1,'Good Candidate','Smooth Process'),
(2,2,2,'Bad Candidate','Bad Process'),
(3,3,3,'Bad Candidate','Bad Process'),
(4,4,4,'Good Candidate','Smooth Process'),
(5,5,5,'Bad Candidate','Bad Process'),
(6,6,6,'Good Candidate','Smooth Process'),
(7,7,7,'Good Candidate','Smooth Process'),
(8,8,8,'Good Candidate','Process Good');

SELECT * from Application;
SELECT * from Candidates;

INSERT INTO Blacklist(BlacklistID,CandidateID,Reason)
VALUES(1,10,'Not Joined the Company');

SELECT * from HR.JobOpenings;


select * from Blacklist;

SELECT * FROM Job;

create view JobView as
JobID, JobPosition, JobMedium , JobType 
FROM Job j;



CREATE VIEW JobView 
AS
SELECT j.JobID, j.JobCategory,j.JobMedium,jp.JobPlatformName,j.JobPosition
FROM HR.Job j
INNER JOIN HR.JobPlatform jp 
ON j.JobPlatformID=jp.JobPlatformID;


SELECT * FROM JobView;





select * from Candidates;


CREATE VIEW Application_Details 
AS
SELECT a.ApplicationID, c.FirstName,c.LastName,s.Status 
FROM HR.Application a
JOIN HR.Candidates c
ON a.CandidateID=c.CandidateID 
JOIN HR.ApplicationStatus ac
ON a.ApplicationID=ac.ApplicationID 
JOIN HR.Status s 
ON ac.StatusID=s.StatusID;

SELECT * FROM Application_Details;


CREATE VIEW InterviewDetails 
AS
SELECT a.ApplicationID, c.FirstName AS CandidateFirstName,c.LastName AS CandidateLasttName,i.StartTime,i.EndTime,f.Result,s.FirstName,s.LastName,s.Title,s.Department
FROM HR.Candidates c
JOIN HR.Application a
ON a.CandidateID=c.CandidateID 
JOIN HR.Interviews i
ON a.ApplicationID=i.ApplicationID
JOIN HR.InterviewFeedback f
ON i.InterviewID=f.InterviewID
JOIN HR.Interviewers s
ON f.InterviewerID=s.InterviewerID;

SELECT * from InterviewDetails;



CREATE VIEW CandidatePersonaltInfo 
AS
SELECT c.FirstName,c.LastName, c.Email,c.Phone,a.AddressLine1,a.City,a.ZipCode 
FROM HR.Candidates c
JOIN HR.CandidateAddress a
ON c.CandidateID=a.CandidateID;

SELECT * FROM CandidatePersonaltInfo;
 






CREATE PROCEDURE ReassignGrades 
AS
BEGIN
UPDATE HRTests
SET TestGrade = CASE
WHEN  TestScore >35 then 'PASS'
ELSE 'FAIL'
END
END
GO
SELECT * FROM HR.Tests;











Create PROCEDURE StatusUpdate_Complaint AS 
BEGIN 
UPDATE HRComplaint 
SET ComplaintInterviewStatus = CASE 
WHEN ComplaintValid = 0 then 'Rejected' 
ELSE 'Reinterview' 
END 
END 
GO 
EXEC StatusUpdate_Complaint;

SELECT * from HR.Complaint;








CREATE PROC InterviewerFeedbackOnInterview as
BEGIN
UPDATE HR.InterviewFeedback
SET Notes = CASE
WHEN Notes LIKE '%Passed%' THEN 'Deserving Candidate'
ELSE 'Not Deserving Candidate'
END
END
GO
EXEC InterviewerFeedbackOnInterview;

SELECT * from HR.InterviewFeedback;









CREATE PROCEDURE OfferDecision AS
BEGIN 
UPDATE HR.Candidates
SET OfferAccepted = CASE
WHEN OfferAccepted ='Yes' then 'Accepted'
WHEN OfferAccepted ='No' then 'Declined'
ELSE NULL
END
END
GO
EXEC OfferDecision;
SELECT * FROM HR.Candidates;









CREATE ROLE ComplaintDepartment
GO
GRANT INSERT,UPDATE,DELETE on HR.Complaint to ComplaintDepartment
GO
GRANT SELECT on DATABASE:: HR_RajShah to ComplaintDepartment;

CREATE ROLE InterviewingDepartment
GO
GRANT SELECT ON HR.Interviews to InterviewingDepartment
GO
GRANT SELECT ON HR.Interviewers to InterviewingDepartment
GO
GRANT SELECT ON HR.InterviewFeedback to InterviewingDepartment
GO
GRANT SELECT ON HR.Evaluation to InterviewingDepartment
GO
GRANT SELECT, UPDATE ON HR.JobOpenings to InterviewingDepartment;

SELECT * FROM HR.OnBoarding;

SELECT * FROM OnBoarding;



CREATE ROLE CandidateEntry; 
GRANT UPDATE ON Candidates TO CandidateEntry
GO 

CREATE LOGIN RajShah WITH PASSWORD = 'rshah@123', 
DEFAULT_DATABASE = HR_RajShah; 
CREATE USER Raj FOR LOGIN RajShah; 
ALTER ROLE CandidateEntry ADD MEMBER Raj;

CREATE ROLE InsertNewJob;
GRANT INSERT, UPDATE ON JobOpenings TO InsertNewJob 
GO 


Create Function HR.OnboardingFunc(@Job_type varchar(200))
Returns Table
Return
(
 select o.StartDate, c.Firstname, c.Lastname, c.offeraccepted, j.JobPosition, j.jobMedium
 from HR.Onboarding o 
 JOIN HR.Job j
 on o.jobID=j.jobID 
 JOIN Hr.Candidates c 
 ON o.CandidateID=c.CandidateID
 where j.JobType=@Job_type
);
Select * from HR.OnboardingFunc('Full Time');

Create function HR.Jobfunc(@Job_name varchar(100))
Returns Table
Return
(
Select jo.JobName,j.JobPosition,j.JobCategory,j.JobType,j.Salary
from HR.Job j 
JOIN HR.JobOpenings jo
ON j.JobID= jo.JobID
Where jo.JobName=@Job_name
);
Select * from HR.Jobfunc('SDE-1');










Create function HR.Test_Details(@test int) 
Returns Table
Return
(
 select att.TestsID,c.candidateID,concat(c.FirstName,' ',c.LastName) as Candidate_Name, t.TestCategory, att.TestGrade
 from HR.testdetails t 
 join HR.tests att 
 on t.TestDetailsID = att.TestDetailsID
 JOIN HR.application a
 on att.ApplicationID = a.ApplicationID
 JOIN HR.candidates c 
 on c.CandidateID = a.CandidateID
 where att.testsID = @test
);
GO
select * from Hr.Test_Details('1');




Create function HR.Interview_Details(@interview int) 
Returns Table
Return
(
 select t.InterviewID,concat(c.FirstName,' ',c.LastName) as CandidateName, concat(I.FirstName,' ',I.LastName) as InterviewerName, att.Result
 from HR.Interviews t 
 join HR.InterviewFeedback att 
 on t.InterviewID = att.InterviewID
 join HR.Interviewers I
 on I.InterviewerID=att.InterviewerID
 JOIN HR.application a
 on t.ApplicationID = a.ApplicationID
 JOIN HR.candidates c 
 on c.CandidateID = a.CandidateID
 where t.InterviewID = @interview
);
GO
select * from Hr.Interview_Details('1');








Create function HR.CandidateContactInformation(@ApplicationId int)
Returns Table
Return
(
 SELECT C.FirstName, C.LastName, C.Email, C.Phone
 FROM HR.Candidates c
 JOIN HR.Application a
 ON a.CandidateId=c.CandidateId
 WHERE 
);




CREATE FUNCTION CandidateReimbursementDetails(@CandidateID INT)
RETURNS TABLE
RETURN(SELECT a.ApplicationID,a.ApplicationID,C.CandidateEmailId,R.* 
from Application as a
JOIN Reiumbursement as R 
ON a.CandidateID = @CandidateID
R.CandidateID);

select * from HR.CandidateContactInformation(1)


---This query inserts the candidate into blocklistCandidate once the status is changed to Declined.



Create Trigger TriggerReview
ON HR.Reviews
AFTER INSERT
AS
Declare @InterviewerID INT, @InterviewID INT
BEGIN
UPDATE HR.Reviews 
SET InterviewerReview = CASE
WHEN InterviewerReview LIKE '%Good%' THEN 'POSITIVE'
ELSE 'NEGATIVE'
END
end

INSERT INTO HR.Reviews(CandidateReview,InterviewerReview,CandidateID,InterviewID,InterviewerID) VALUES('Good','Need Work',2,2,8)


SELECT * from HR.Reviews;


CREATE TRIGGER TriggerBlacklist ON HR.ApplicationStatus
AFTER UPDATE
AS
DECLARE @CandidateID INT, @Reason VARCHAR(50)
IF EXISTS
(SELECT c.CandidateID 
FROM HR.Candidates c,HR.Application a,HR.ApplicationStatus ac 
WHERE c.CandidateId=a.CandidateId AND a.ApplicationId=ac.ApplicationId AND 
ac.StatusID=1 AND c.CandidateID NOT IN (SELECT candidateid FROM HR.Blacklist))
BEGIN
SELECT @CandidateID = c.CandidateID, @Reason = 'Not joined the company' FROM 
HR.Candidates c, HR.Application a,HR.ApplicationStatus ac 
WHERE c.CandidateId=a.CandidateId AND a.ApplicationId=ac.ApplicationId AND ac.StatusID=1 and c.CandidateID 
NOT IN (SELECT CandidateID FROM HR.Blacklist)
INSERT INTO HR.Blacklist VALUES (4,@Reason, @CandidateID,1)
END
UPDATE HR.ApplicationStatus SET StatusId = 1 WHERE ApplicationID = 9;
SELECT * FROM HR.Blacklist;




Create Trigger TriggerTestResult
ON HR.Tests
AFTER Insert
AS
DECLARE @TestsId INT
BEGIN
SELECT @TestsId=TestsID FROM HR.Tests WHERE TestGrade = NULL
UPDATE HR.Tests Set TestGrade = CASE
WHEN TestScore>=60 THEN 'PASS'
ELSE 'FAIL'
END
END
WHERE TestsID = @TestsId
END
INSERT INTO HR.Tests VALUES(12,'09:30:00','10:30:00',1,85,NULL,1,1);

SELECT * from hr.Tests;


Create Trigger TriggerUpdateVacancies
ON HR.ApplicationStatus
After Update AS
DECLARE @jobOpeningID INT 
IF EXISTS   (SELECT * FROM HR.Application a,HR.ApplicationStatus sc 
            WHERE a.ApplicationID=sc.ApplicationID AND a.CandidateID NOT IN (SELECT CandidateID from HR.Blacklist) AND sc.StatusId=1)
BEGIN
SELECT @jobOpeningID = jo.jobOpeningsId 
FROM HR.JobOpenings jo JOIN HR.Job j 
ON jo.JobId=j.JobId
JOIN HR.Application a 
ON a.JobOpeningsId = jo.JobOpeningsId 
JOIN HR.Candidates c 
ON c.CandidateId= a.CandidateId
JOIN HR.ApplicationStatus sc 
ON sc.ApplicationId=a.ApplicationId 
WHERE c.CandidateId NOT IN (SELECT candidateId FROM HR.Blacklist) AND StatusId=1 
UPDATE HR.JobOpenings SET NoOfVacancies = NoOfVacancies+1 WHERE JobOpeningsID = @jobOpeningID
END
UPDATE HR.ApplicationStatus
SET StatusID = 1 WHERE ApplicationID = 7;

SELECT * FROM HR.ApplicationStatus;
SELECT * from HR.JobOpenings;

SELECT * FROM HR.Application;


BEGIN TRAN
DECLARE @reimbursestatus varchar(20);
SELECT @reimbursestatus = RequestStatus
FROM HR.Reimbursement
UPDATE HR.Reimbursement
SET requestStatus = 'Processed'
WHERE ReimbursementAmount <= ReimbursementMaxAmount;
UPDATE HR.Reimbursement
SET RequestStatus = 'Declined'
WHERE ReimbursementAmount > ReimbursementMaxAmount;
COMMIT TRAN

SELECT * from HR.Reimbursement;



BEGIN TRAN
DECLARE @jobsalary int;
SELECT @jobsalary = Salary
FROM HR.Job
UPDATE HR.Job
SET Salary = @jobsalary + 40000
WHERE JobPosition = 'Developer'
UPDATE HR.Job
SET Salary = @jobsalary + 23000
WHERE JobPosition = 'Testing'
COMMIT TRAN



CREATE VIEW Update_Vacancy AS
SELECT c.CandidateId,c.FirstName,c.LastName,c.OfferAccepted,j.NoOfVacancies
FROM HR.Candidates c JOIN HR.Application a
ON c.CandidateID = a.CandidateID
JOIN HR.JobOpenings j
ON a.JobOpeningsID=j.JobOpeningsID 
WHERE c.OfferAccepted='Accepted';

select * from Update_Vacancy;

BEGIN TRAN
DECLARE @vacancy int;
SELECT @vacancy = NoOfVacancies
FROM Update_Vacancy;
UPDATE Update_Vacancy
SET NoOfVacancies = @vacancy + 1
COMMIT TRAN


select * from HR.JobOpenings;
SELECT * FROM HR.JOB;



BEGIN TRAN
UPDATE HR.Tests
SET TestScore = TestScore + 10
WHERE TestScore <= 60
COMMIT TRAN

SELECT * FROM HR.Tests;



/*
Consider several business reports to produce. Business reports may involve somewhat complex queries using aggregate and analytic
functions, CTEs, etc. Your queries/reports would be more likely parameterized procedures. For instance, you can generate annual
growth in application numbers, offers vs acceptances, or average time for recruitment process. It could be for a particular interviewer.
This may or not result in a graph. You can consider it more like OLAP transactions.
*/



/*This procedure displays reimbursement amount distribution based on date.
Parameter named ReimbursementDate is passed in parameterized procedure because we want records of distrubtion after 1 november 22022 only */
CREATE PROCEDURE ReimbursementDistributionResult @ReimbursementDate date
AS
BEGIN
SELECT ReimbursementDate, ReimbursementID, ReimbursementAmount, 
PERCENT_RANK() OVER (PARTITION BY ReimbursementDate
ORDER BY ReimbursementAmount) AS PctRank,
CUME_DIST() OVER (PARTITION BY ReimbursementDate
ORDER BY ReimbursementAmount) AS CumeDist,
PERCENTILE_CONT(.5) WITHIN GROUP (ORDER BY ReimbursementAmount)
OVER (PARTITION BY ReimbursementDate) AS PercentileCont, 
PERCENTILE_DISC(.5) WITHIN GROUP (ORDER BY ReimbursementAmount)
OVER (PARTITION BY ReimbursementDate) AS PercentileDisc
FROM HR.Reimbursement
WHERE ReimbursementDate > @ReimbursementDate;

END

EXEC ReimbursementDistributionResult @ReimbursementDate ='11-01-2022';



SELECT * FROM HR.Reimbursement;
/* Count the number of interview a interviewer takes */
CREATE PROCEDURE InterviewerTakesInvterview @InterviewerID INT
AS
BEGIN
WITH TakesInvterview AS 
(SELECT i.InterviewerID as InterviewerID, concat(i.FirstName,' ',i.LastName) as InterviewerName,ij.InterviewID
FROM HR.Interviewers i
JOIN HR.InterviewFeedback ij
ON i.InterviewerID=ij.InterviewerID
)

SELECT InterviewerID,InterviewerName, COUNT(InterviewID) AS InterviewConducted
FROM TakesInvterview
WHERE InterviewerID=@InterviewerID
GROUP BY InterviewerID,InterviewerName
ORDER BY InterviewerID;
END
EXEC InterviewerTakesInvterview @InterviewerID=5;

CREATE PROCEDURE InterviewerEvaluationResult @InterviewerName VARCHAR(30)
AS
BEGIN
WITH InterviewerEvaluation AS (
SELECT i.InterviewerID as InterviewerID,concat(i.FirstName,' ',i.LastName) as InterviewerName, e.result
FROM HR.Interviewers i
JOIN HR.Evaluation e
ON i.InterviewerID=e.InterviewerID
WHERE concat(i.FirstName,' ',i.LastName) = @InterviewerName)
SELECT InterviewerID,InterviewerName,COUNT(Result) AS [Evaluation Result]
FROM InterviewerEvaluation
GROUP BY InterviewerID,InterviewerName
ORDER BY InterviewerID;
END
EXEC InterviewerEvaluationResult @InterviewerName='Jon Repp';


SELECT * from HR.Job;

CREATE PROCEDURE AveragePayForJobposition @JobType VARCHAR(30),@JobPosition VARCHAR(30)
AS
BEGIN
SELECT JobType,JobPosition,AVG(Salary) AS [Job Salary]
FROM HR.Job
WHERE JobType = @JobType AND JobPosition=@JobPosition
GROUP BY JobType,JobPosition
END
EXEC AveragePayForJobposition @JobType='Full Time', @JobPosition='Developer';