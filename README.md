# Human Resource Database Management System

## Overview

This project involves the creation and management of a Human Resource (HR) Database using a Database Management System (DBMS). The DBMS is designed to control the creation, maintenance, and use of databases for managing HR processes, such as employee hiring and administrative tasks. The system efficiently stores and retrieves database data, providing a consolidated view for programmers, database administrators, and end users, without requiring them to understand the actual location of the data.

The HR Database is utilized by business organizations to manage the hiring process for new employees. The system handles everything from job application submission to final hiring decisions, including interview management, feedback, and reimbursement processes. The database is structured to encompass all essential DBMS concepts such as DDL, DML, Views, Role Assignment, Stored Procedures, Transactions, Scripts, Functions, Triggers, and Business Reports, while considering Database Design Structure (Normalization).

## Features

- **Employee Hiring Management**: Streamlines the process of recruiting new employees, from application submission to final hiring decisions.
- **Administrative Module**: Manages the administrative tasks related to HR, such as interview scheduling, feedback collection, and reimbursement.
- **Comprehensive DBMS Concepts**: Implements various DBMS features including DDL, DML, stored procedures, and more.
- **Review System**: Allows candidates and interviewers to provide feedback on each other during the hiring process.

## System Design

### ER Diagram

The system's design is illustrated through an Entity-Relationship (ER) diagram, which includes the following key tables:

1. **Candidates Table**: Stores personal information of job candidates.
2. **CandidateAddress Table**: Contains address details of candidates.
3. **Application Table**: Records application data, including work history and education.
4. **Document Table**: Manages documents required for job applications (e.g., CV, resume).
5. **ApplicationDocument Table**: Links the Application and Document tables.
6. **Complaint Table**: Stores complaints filed by candidates regarding the interview process.
7. **Reimbursement Table**: Tracks candidate expenses related to interviews.
8. **Interviewer Table**: Contains details of interviewers responsible for hiring.
9. **Interview Table**: Records details of interviews, including time, location, and type.
10. **InterviewType Table**: Stores information on whether the interview is onsite or online.
11. **InterviewLocation Table**: Contains address details for interview locations.
12. **InterviewFeedback Table**: Captures feedback and results from interviews.
13. **Evaluation Table**: Stores evaluation results and notes from interviews.
14. **ApplicationStatus Table**: Tracks the status of job applications.
15. **Status Table**: Contains possible application statuses such as accepted, declined, or negotiating.
16. **Tests Table**: Records test details, including start/end time, scores, and grades.
17. **TestDetails Table**: Contains information about test categories, timing, and maximum scores.
18. **Job Table**: Contains job details including type, medium, and positions available.
19. **JobOpenings Table**: Tracks job descriptions and the number of open positions.
20. **JobPlatform Table**: Stores information on job platforms (onsite or online).
21. **Onboarding Table**: Manages onboarding processes and statuses.
22. **Reviews Table**: Links candidates, interviews, and interviewers for review purposes.
23. **Blacklist Table**: Stores reasons for blacklisting candidates.

## Methodology

### DBMS Concepts Used

The HR Database utilizes various DBMS concepts, including:

- **Data Definition Language (DDL)**
- **Data Manipulation Language (DML)**
- **Views**
- **Role Assignment**
- **Stored Procedures**
- **Transactions**
- **Scripts**
- **Functions**
- **Triggers**
- **Business Reports**

### Database Design

The database is designed with normalization in mind to ensure efficient data storage and retrieval. This reduces redundancy and improves data integrity.

### Prerequisites

To set up the HR Database Management System, you need:

- A DBMS such as MySQL, PostgreSQL, or any other relational database.
- SQL scripts to create and populate the database tables.

