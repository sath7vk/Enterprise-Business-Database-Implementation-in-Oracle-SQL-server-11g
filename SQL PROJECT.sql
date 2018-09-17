-- droppping all tables
drop table project;
drop table client;
drop table skill;
drop table training;
drop table assignment;
drop table department;
alter table employee
drop constraint employee_hire_date_ck;
alter table employee
drop constraint employee_super_id_ck;
alter table employee
drop constraint department_manager_id_fk;
drop table employee;

select * from user_tables;


--SKILL (Code, Description)
create table skill
(
code varchar2(5) PRIMARY KEY,
description varchar2(50) NOT NULL
);




-- DEPARTMENT (Dept_Code, Name, Location, Phone, Manager_ID@)
create table department
(
dept_code number(3) PRIMARY KEY,
name varchar2(20),
location varchar2(20),
phone varchar2(12),
manager_id number(10)
);


--EMPLOYEE (Emp_Num, Emp_Last, Emp_First, DOB, Hire_Date, Super_ID@, Dept_Code@)
create table employee
(
emp_num number(10) PRIMARY KEY,
emp_last varchar2(20),
emp_first varchar2(20),
dob date,
hire_date date DEFAULT sysdate, 
super_id number(3), 
dept_code number(2),
FOREIGN KEY (dept_code) REFERENCES department(dept_code)
);

alter table employee
modify  super_id number(10);

alter table employee
add constraint employee_hire_date_ck 
check ((extract(year from hire_date)-extract(year from dob))>=17);

alter table employee
add constraint employee_super_id_ck 
FOREIGN KEY (super_id) REFERENCES employee(emp_num);

alter table department 
add constraint department_manager_id_fk
FOREIGN KEY (manager_id) REFERENCES employee(emp_num);

alter table department
drop constraint department_manager_id_fk;


-- TRAINING (Train_Num, Code@, Emp_Num@, Date_Acquired, Name, Comments)

create table training
(
train_num number(3) PRIMARY KEY,
Code varchar2(5) NOT NULL,
emp_num number(10)NOT NULL,
Data_acquired date NOT NULL,
name varchar2(50),
comments varchar2(50),
FOREIGN KEY (Code) REFERENCES skill(code),
FOREIGN KEY (emp_num) REFERENCES employee(emp_num)
);


-- CLIENT (Client_ID, Name, Street, City, State, Zip_Code, Industry, Web_Address, Phone,
-- Contact_Name)

create table client 
(
Client_ID varchar2(5) PRIMARY KEY,
Name varchar2(30) NOT NULL, 
Street varchar2(30) NOT NULL, 
City varchar2(20) NOT NULL, 
State varchar2(20) NOT NULL, 
Zip_Code number(5) NOT NULL, 
Industry varchar2(20) , 
Web_Address varchar2(20), 
Phone varchar2(12) NOT NULL,
Contact_Name varchar2(20) NOT NULL
);



-- PROJECT (Proj_Number, Name, Start_Date, Total_Cost, Dept_Code@, Client_ID@)

create table project 
(
Proj_Number varchar2(7) PRIMARY KEY, 
Name varchar2(20) NOT NULL, 
Start_Date date DEFAULT sysdate, 
Total_Cost number(10,2), 
Dept_Code number(2), 
Client_ID varchar2(5),
FOREIGN KEY (dept_code) REFERENCES department(dept_code),
FOREIGN KEY (client_id) REFERENCES  client(client_id)
);

-- ASSIGNMENT (Assign_Num, Proj_Number@, Emp_Num@, Date_Assigned, Date_Ended,
-- Hours_Used)
drop table assignment;

create table assignment 
(
Assign_Num number(4) PRIMARY KEY, 
Proj_Number varchar2(7), 
Emp_Num number(10), 
Date_Assigned date DEFAULT sysdate, 
Date_Ended date ,
hours_used number(5),
FOREIGN KEY (proj_number) REFERENCES project(proj_number),
FOREIGN KEY (Emp_Num) REFERENCES employee(Emp_Num)
);

alter table assignment
add constraint assignment_Date_Ended_ck 
check (Date_Ended>=Date_Assigned);
---------------------------------------------





select * from department;
truncate table department;
desc department;

insert into department 
values (1,'Executive management','New York City','7185432345',	2015071401);

insert into department 
values ( 3	,'Human resources	','New York City','718-217-8932',	2016012911);

insert into department 
values ( 5	,'Finance','	Boston	','774-790-9182'	,2007030122);

insert into department 
values ( 6	,'Accounting	','Boston	','774-813-9013'	,2004011708);

insert into department 
values ( 8	,'Production	','Chicago',	'312-212-6378',2017110318);

insert into department 
values ( 12	,'Purchasing	','Boston	','774-124-8456',	2009031713);


insert into department 
values ( 16	,'R and D','San Francisco','415-890-1234',2010110401);

insert into department 
values ( 20	,'Clients Rel','New York City','718-756-8921',	2008110514);

insert into department 
values ( 22	,'Marketing Comms','New York City','718-123-9018',2012041513);

insert into department 
values ( 35	,'Operations','	Chicago','312-901-9456',	201101101);



select * from employee;
desc employee;

insert into employee
values(2015071401,'Aguilera','Christina','18-DEC-1980','14-JUL-2015',null,1);
insert into employee
values(2016012911,'Timberlake','Justin','31-DEC-1981','29-JAN-2016',2015071401,3);
insert into employee
values(2007030122,'Spears','Britney','2-DEC-1981','1-MAR-2007',2015071401,5);
insert into employee
values(2004011708,'Knowles','Beyonce','04-SEP-1981','17-JAN-2004',2015071401,6);
insert into employee
values(2017110318,'McKnight','Brian','05-JUN-1969','3-NOV-2017',2015071401,8);
insert into employee
values(2009031713,'Lachey','Nick','9-NOV-1973','17-MAR-2009',2015071401,12);
insert into employee
values(2010110401,'Carter','Aaron','7-DEC-1987','04-NOV-2010',2015071401,16);
insert into employee
values(2008110514,'Martin','Ricky','24-OCT-1971','5-NOV-2008',2015071401,20);
insert into employee
values(2012041513,'Lopez','Jennifer','24-DEC-1969','15-APR-2012',2015071401,22);
insert into employee
values(2011011012,'Smith','Will','25-SEP-1968','10-JAN-2011',2015071401,35);


insert into employee
values(12341,'Chenna','Sathwik','19-Aug-83','26-Nov-12',2016012911,3);
insert into employee
values(12342,'Jilla','Karthik',	'29-Nov-84','16-Dec-13',2016012911,3);
insert into employee
values(12343,'Baba','Naseer','22-Nov-84','24-Jun-14',2016012911,3);
insert into employee
values(12344,'Gupta','Chetna','09-Jul-82','6-Jan-15',2007030122,5);
insert into employee
values(12345,'Chilkuri','Nagarjuna','22-Jan-80','12-Mar-17',2007030122,5);
insert into employee
values(12346,'Arora','Abhilahsa','10-Feb-81','28-Aug-16',2007030122,5);
insert into employee
values(12347,'	Yerragopu','Chandu','19-Apr-80','16-Nov-14',2004011708,6);
insert into employee
values(12348,'	Nanduri','Poojitha','25-Sep-82','6-Jan-15',2004011708,6);
insert into employee
values(12349,'	Varma','Aditya','06-Mar-81','22-Feb-16',2004011708,6);
insert into employee
values(123410,'	Kowkuntla','Venky','29-Apr-89','25-Mar-12',2017110318,8);
insert into employee
values(123411,'	KSS	','Harish','23-May-88','16-Apr-13',2017110318,8);
insert into employee
values(123412,'	Kothakota','Aditya','22-Feb-80','8-May-14',2017110318,8);
insert into employee
values(123413,'	Turlapati','Prabhat','09-Jan-81','28-Jun-15',2009031713,12);
insert into employee
values(123414,'	Krishna','Priyusha','18-Jul-82','18-Jul-15',2009031713,12);
insert into employee
values(123415,'	Devnani','Nikhil','16-Jun-81','14-Aug-16',2009031713,12);
insert into employee
values(123416,'	Boone','Breah','11-Jan-80','17-Sep-17',2010110401,16);
insert into employee
values(123417,'	William	','Taft','12-Dec-81','5-Oct-15',2010110401,16);

select * from employee;





select * from EMPLOYEE;


select * from skill;

insert into skill values(1,'Project management');
insert into skill values (2,'	Negotiation');
insert into skill values (3,'	Data analyst');
insert into skill values (4,'Financial management');
insert into skill values (5,'Programming');
insert into skill values (6,'Database administrator');
insert into skill values (7,'Digital marketing');
insert into skill values (8,'Print marketing');
insert into skill values (9,'Client relations');
insert into skill values (10	,'Investor relations');
select * from skill;

select * from training;

desc training;
desc skill;

insert into training
values(11,'6',12341,'26-Nov-13','Introduction to database management','One day course');
insert into training
values(18,'6',12342,'16-Dec-14','Advanced database management','Pre-requisite: DB1');
insert into training
values(27,'1',12343,'24-Jun-15','Project management essentials','Three-part series');
insert into training
values(31,'7',12344,'6-Jan-16','Social media marketin','Lunchtime session');	
insert into training
values(35,'7',	12345,'12-Jan-17','	Marketing for print','Lunchtime session');
insert into training
values(48,'4',12346,'28-Aug-17','Finance for beginners','Half day course');	
insert into training
values(55,'7',	12347,'16-Nov-15','Social media marketing','Lunchtime session');
insert into training
values(62,'2',12348,'6-Jan-16','Social media marketing','Lunchtime session');
insert into training
values(57,'9',12349,'22-Feb-17','Negotiations with clients','Weekend intensive');
insert into training
values(87,'2',123410,'25-Mar-14','Marketing for print','Lunchtime session');	
insert into training
values(89,'9',123411,'16-Apr-15','Negotiations with clients','	Weekend intensive');	
insert into training
values(23,'5',123412,'8-May-16','Marketing for print','Lunchtime session');	

select * from client;
desc client;

insert into client
values('BAC21','Bank of America - Atlanta	','435 Peachtree Avenue	','Atlanta','GA',30301,'Banking','bankofamerica.com	','526-526-5555','Warren Buffett');

insert into client
values('BAC34','Bank of America - Pittsburgh','47 Forbes Avenue','Pittsburgh','PA',15213	,'Banking','bankofamerica.com','475-598-6324','	Jack Bogle');
insert into client
values('BAC65','Bank of America - Seattle	','999 Pike Place','Seattle','WA',	98105,'Banking','bankofamerica.com','638-962-4256','Paul Tudor Jones');
insert into client
values('JPM02','JP Morgan - New York City','	785 W 121st	','New York City','NY',	10007,'Financial services','jpmorgan.com','345-578-8889','George Soros');
insert into client
values('JPM05','JP Morgan - Chicago','45 Wabash Avenue','Chicago','IL',60612,'Financial services','jpmorgan.com','123-526-8579','Ray Dalio');
insert into client
values('CRS07','Credit Suisse - New York City','57 Fashion Avenue','New York City','	NY',10004,'Financial services','creditsuisse.com','634-748-9634','Carl Icahn');
insert into client
values('CRS11','Credit Suisse - San Francisco	','5246 Geary Boulevard	','San Francisco','	CA',94112,'Financial services','creditsuisse.com','410-526-0014','David Swensen');
insert into client
values('BNY03','Bank of New York Mellon','524354 W 52nd Street','New York City','NY',10020,'Banking','bny.com	','417-859-4689','Mary Callahan Erdoes');
insert into client
values('MOS01','Morgan Stanley','5123 Wall Street','New York City	','NY',10027,'Financial services','morganstanley.com','635-685-7586','Charles Schwab');
insert into client
values('MOR01','Morningstar','2 Chicago Avenue','Chicago','IL',60176,'Financial services','morningstar.com','124-546-8596','Sir John Templeton');




DROP TABLE PROJECT;
create table project 
(
Proj_Number varchar2(7) PRIMARY KEY, 
Name varchar2(30) NOT NULL, 
Start_Date date DEFAULT sysdate, 
Total_Cost number(10,2), 
Dept_Code number(2), 
Client_ID varchar2(5),
FOREIGN KEY (dept_code) REFERENCES department(dept_code),
FOREIGN KEY (client_id) REFERENCES  client(client_id)
);

select * from project;
desc project;
insert into project 
values('145-BAC','BOA Account reconciliation','18-MAY-2011',20000,5,'BAC21');
insert into project 
values('901-BAC','BOA Lean operations','07-JAN-2017',100000,35	,'BAC21');
insert into project 
values('145-JPM','JPM Account reconciliation','07-APR-2010',200000,6,	'JPM02');
insert into project 
values('211-JPM','JPM Financial consolidation','18-MAY-2012',50000,	5,'JPM05');
insert into project 
values('014-CRS','CRS Account rationalization','25-JAN-2011',65000,6,'CRS11');
insert into project 
values('114-CRS','CRS Process improvement','7-APR-2011',100000,5,'CRS11');
insert into project 
values('122-BNY','BNY Special project	','5-OCT-2016',600000,16,'BNY03');
insert into project 
values('065-MOS','MOS Account reconciliation','18-JUL-2012',150000	,5,'MOS01');
insert into project 
values('123-MOS','MOS Financial consolidation','5-APR-2014',750000,6,'MOS01');
insert into project 
values('226-MOS','MOS Strategic tax planning','4-JUN-2016',300000,5,'MOS01');

insert into project 
values('438-TEC','Big Data Analytics','4-SEP-2016',null,16,'JPM05');


select * from assignment;
desc assignment;

--proj number: 145 bac
insert into assignment
values(1,'145-BAC',12341,'4-JUN-17','30-JUN-17',160);
insert into assignment
values(2,'145-BAC',12341,'1-JUL-17','30-JUL-17',160);
insert into assignment
values(3,'145-BAC',12341,'1-AUG-17','30-AUG-17',160);
insert into assignment
values(5,'145-BAC',12342,'1-JUL-17','30-JUL-17',160);
insert into assignment
values(6,'145-BAC',12342,'1-AUG-17','30-AUG-17',160);
insert into assignment
values(9,'145-BAC',12343,'1-AUG-17','30-AUG-17',160);
--901-BAC
insert into assignment
values(10,'901-BAC',12348,'1-AUG-17','30-AUG-17',160);
insert into assignment
values(11,'901-BAC',12349,'1-MAY-17','30-MAY-17',160);
insert into assignment
values(12,'901-BAC',12349,'1-JUN-17','30-JUN-17',160);
insert into assignment
values(13,'901-BAC',123410,'1-OCT-17','30-OCT-17',160);
insert into assignment
values(14,'901-BAC',123410,'1-NOV-17','30-NOV-17',160);
insert into assignment
values(15,'901-BAC',123412,'1-JUN-17','30-JUN-17',160);
insert into assignment
values(16,'901-BAC',123412,'1-MAY-17','30-MAY-17',160);

--065-MOS
insert into assignment
values(17,'065-MOS',123415,'1-MAY-17','30-MAY-17',160);
insert into assignment
values(18,'065-MOS',123415,'1-JUN-17','30-JUN-17',160);
insert into assignment
values(19,'065-MOS',123415,'1-JUL-17','30-JUL-17',160);
insert into assignment
values(20,'065-MOS',123417,'1-AUG-17','30-AUG-17',160);
insert into assignment
values(21,'065-MOS',123417,'1-SEP-17','30-SEP-17',160);
insert into assignment
values(22,'065-MOS',123417,'1-OCT-17','30-OCT-17',160);
insert into assignment
values(23,'065-MOS',123417,'1-NOV-17','30-NOV-17',160);
insert into assignment
values(24,'065-MOS',123417,'1-DEC-17',null,null);

select * from assignment;
select * from project where total_cost is null;

insert into assignment
values(27,'438-TEC',2009031713,'10-SEP-17','30-SEP-17',160);
insert into assignment
values(25,'438-TEC',2009031713,'10-OCT-17','30-OCT-17',160);
insert into assignment
values(26,'438-TEC',2009031713,'10-NOV-17','30-NOV-17',160);
insert into assignment
values(28,'438-TEC',2009031713,'1-DEC-17',null,null);
insert into assignment
values(29,'438-TEC',2010110401,'10-SEP-17','30-SEP-17',160);
insert into assignment
values(30,'438-TEC',2010110401,'10-OCT-17','30-OCT-17',160);
insert into assignment
values(31,'438-TEC',2010110401,'10-NOV-17','30-NOV-17',160);
insert into assignment
values(32,'438-TEC',2010110401,'1-DEC-17',null,null);
insert into assignment
values(33,'438-TEC',2008110514,'10-SEP-17','30-SEP-17',160);
insert into assignment
values(34,'438-TEC',2008110514,'10-OCT-17','30-OCT-17',160);
insert into assignment
values(35,'438-TEC',2008110514,'10-NOV-17','30-NOV-17',160);
insert into assignment
values(36,'438-TEC',2008110514,'1-DEC-17',null,null);
insert into assignment
values(37,'438-TEC',123415,'10-SEP-17','30-SEP-17',160);
insert into assignment
values(38,'438-TEC',123415,'10-OCT-17','30-OCT-17',160);
insert into assignment
values(39,'438-TEC',123415,'10-NOV-17','30-NOV-17',160);
insert into assignment
values(40,'438-TEC',123415,'1-DEC-17',null,null);
insert into assignment
values(41,'438-TEC',123416,'10-SEP-17','30-SEP-17',160);
insert into assignment
values(42,'438-TEC',123416,'10-OCT-17','30-OCT-17',160);
insert into assignment
values(43,'438-TEC',123416,'10-NOV-17','30-NOV-17',160);
insert into assignment
values(44,'438-TEC',123416,'1-DEC-17',null,null);



--------------------- showing the data

select * from employee;
select * from department;
select * from skill;
select * from training;
select * from project;
select * from client;
select * from assignment;

---------------- QUERIES


select * from employee;

/*The company’s human resources department needs information on the current training
levels of the employees. They need information that shows, for each employee, and
his/her acquired skills, the number of times he or she received training for that skill, the
most recent date of the training, and the number of months (full months only) that have
passed since the most recent training for the skill. Include all employees in the output,
even if they have not received any training yet. */



select e.emp_num,e.emp_first||' '||e.emp_last,s.description,count(t.train_num) as "NUMBER OF TIMES",
max(t.data_acquired) as "DATA ACQUIRED", round(months_between(sysdate,max(t.data_acquired)),0) as "NUMBER OF MONTHS PASSED" from employee e 
left join (training t left join skill s on t.code=s.code ) on t.emp_num=e.emp_num
group by e.emp_num,t.code,s.description,e.emp_first,e.emp_last;


/*Due to a recent re-organization, the company needs a list that shows who supervises who.
List all the employees in the company clearly indicating the organizational hierarchy.
Include the “level” of the hierarchy each employee is at and the department name of the
employee.
*/


 SELECT LEVEL,
 LPAD(' ', 3*(LEVEL - 1)) || emp_num || ' ' ||
 emp_first || ' ' || emp_last "Employee", d.name
 FROM employee e left join department d on e.dept_code=d.dept_code
 START WITH emp_num = 2015071401
 CONNECT BY PRIOR emp_num = super_id;
 
 
/* For every ongoing project (i.e., a project with total cost being NULL) provide the project
name, project start date. In addition, for each month of the project list the number of
employees assigned that month and hours spent on the project that month. At the end
provide an overall total of the number of employees assigned to the project and the total
hours spent on the project.
*/
select * from assignment;
select * from project where total_cost is null;
select p.name,p.start_date,initcap(to_char(a.date_assigned,'month')),count(a.emp_num),sum(a.hours_used) from assignment a 
join project p on a.proj_number=p.proj_number
where p.total_cost is null
group by p.name,p.start_date,to_char(a.date_assigned,'month');



/*
The company has decided to adopt a bonus policy for their employees. Each employee
will receive a bonus of $200 for every project started last calendar year, on which they
have charged at least 40 hours. As a result, management has asked you to update the
employee records to include their current bonus information. In order to accomplish this,
you will have to add another column to the EMPLOYEE table (i.e., column
BONUS_AMT), before you update the data. After the single Update statement is
performed, list the contents of the Employee table.
*/

alter table employee 
add bonus_amt number(5);

update employee
set bonus_amt=200* ( select count(distinct proj_number)as number_of_projects from project p 
where extract(year from start_date)=extract(year from sysdate)-1
and proj_number in (select proj_number from assignment group by proj_number having sum(hours_used)>40));

/*
For each employee hired last calendar year, list the name and the hire date of the
employee, name of training received (if any), date of the training, and the number of days
between the hire date and the training. Also include number of projects that employee
worked on so far.
*/

select e.emp_first||' '||e.emp_last as employee,e.hire_date,
t.NAME as training_name,t.DATA_ACQUIRED,
abs(e.hire_date-t.data_acquired) as number_of_days, count(distinct a.proj_number) as number_of_projects
from (employee e left join assignment a on e.emp_num=a.emp_num) left join training t on e.emp_num=t.emp_num left join assignment on e.emp_num=a.emp_num
where extract(year from hire_date)=extract(year from sysdate)-1
group by e.emp_first||' '||e.emp_last,e.hire_date,t.NAME,t.DATA_ACQUIRED,abs(e.hire_date-t.data_acquired);

select * from training;
/*
Some projects are discontinued for certain period of time and resumed later. Find out
project name and start date of those projects that have discontinuous activity. Indicate
whether the “discontinued” projects have been completed (i.e., your output should clearly
indicate this by “completed” or “on-going” value in a column).
*/



select proj_number,min(date_assigned),max(date_assigned),ceil(abs(months_between(trunc(min(date_assigned)) - (to_number(to_char(min(date_assigned),'DD')) - 1),
add_months(trunc(max(date_assigned)) - (to_number(to_char(max(date_assigned),'DD')) - 1), 1) -1))) as diff,
count(distinct date_assigned) from assignment group by proj_number;

select name,start_date, case when total_cost is null then 'on-going' else 'completed' end status  
from project where proj_number in ( select proj_number from assignment group by proj_number 
having count(distinct date_assigned) <> ceil(abs(months_between(trunc(min(date_assigned)) - (to_number(to_char(min(date_assigned),'DD')) - 1),
add_months(trunc(max(date_assigned)) - (to_number(to_char(max(date_assigned),'DD')) - 1), 1) -1))));

SELECT Name,
       Start_Date,
       CASE NVL(Total_Cost,0)
	        WHEN 0 THEN 'on-going'
            ELSE 'completed'
       END AS STATUS
FROM   Project JOIN Assignment USING(Proj_Number)
GROUP BY Name,
         Start_Date,
         Total_Cost,
         Proj_Number
HAVING COUNT(DISTINCT EXTRACT(MONTH FROM Date_Ended)||
                      EXTRACT(YEAR FROM Date_Ended)) !=
             CEIL(MONTHS_BETWEEN((CASE NVL(Total_Cost,0)
			                      WHEN 0 THEN LAST_DAY(SYSDATE)
                                  ELSE MAX(LAST_DAY(Date_Ended))
                             END),Start_Date))
ORDER BY Proj_Number;




/*
We need a summary of project information for each quarter of last year. For each quarter
include: number of projects started in the quarter, number of employees working on those
projects in the quarter, number of hours spent on average per project.
*/


select * from project p where extract(year from p.start_date)=extract(year from sysdate)-1;

select to_char(start_date,'q') as Quarter,count(distinct p.proj_number) as No_of_projects, 
count(distinct a.emp_num) as No_of_Employees, sum(a.hours_used)/count( a.emp_num)  as Avg_of_hours_used
from project p left join assignment a on p.proj_number = a.proj_number
where extract(year from p.start_date)=extract(year from sysdate)-1
group by to_char(p.start_date,'q') order by to_char(p.start_date,'q');


/*
For each employee and each skill, list the number of times the employee had training and
the latest date (most recent) when the employee acquired that particular skill. Also,
provide the number of trainings provided/attended for each skill, and the number of skills
acquired by each employee. The output should look like this:
*/


select emp_num, nvl(sum(DECODE(code,'1',1,0)),0) code1, max(decode(code,'1',data_acquired,null)) as code1_date,
nvl(sum(DECODE(code,'2',1,0)),0) code2, max(decode(code,'2',data_acquired,null)) as code2_date,
nvl(sum(DECODE(code,'3',1,0)),0) code3, max(decode(code,'3',data_acquired,null)) as code3_date,
nvl(sum(DECODE(code,'4',1,0)),0) code4, max(decode(code,'4',data_acquired,null)) as code4_date,
nvl(sum(DECODE(code,'5',1,0)),0) code5, max(decode(code,'5',data_acquired,null)) as code5_date,
nvl(sum(DECODE(code,'6',1,0)),0) code6, max(decode(code,'6',data_acquired,null)) as code6_date,
nvl(sum(DECODE(code,'7',1,0)),0) code7, max(decode(code,'7',data_acquired,null)) as code7_date,
nvl(sum(DECODE(code,'8',1,0)),0) code8, max(decode(code,'8',data_acquired,null)) as code8_date,
nvl(sum(DECODE(code,'9',1,0)),0) code9, max(decode(code,'9',data_acquired,null)) as code9_date,
nvl(sum(DECODE(code,'10',1,0)),0)  code10, max(decode(code,'10',data_acquired,null)) as code10_date,
count(code) as total
from training GROUP BY GROUPING SETS (emp_num,());



/*
For each department and each skill combination, list the number of trainings completed
within the department that was associated with the particular skill. Also provide a rank of
each skill within each department. The rank should be based on the number of trainings
completed for that skill. Same rank should be given when the number of trainings is the
same.
*/

insert into training 
values (99,'7',12341,'26-AUG-2017','Social Tech','Online course');

select a.dept_code,a.code,nvl(b.num_trainings,0) as num_trainings, rank() over ( partition by a.dept_code order by nvl(b.num_trainings,0) desc ) as rank from 
(select dept_code,code from department,skill ) a left join
(select dept_code,code,count(*) num_trainings from training t left join employee e on t.emp_num=e.emp_num
group by dept_code,code ) b on a.dept_code=b.dept_code and a.code=b.code
order by a.dept_code,to_number(a.code);



-- part C
/*
Create a report of employee information. For each employee, list their name, the supervisor
name (concatenate first and last name for both the employee and his/her supervisor) and the
trainings each employee has had. For each training list the name of training, training date,
skill obtained through the training, and number of months since the training date. In
addition, provide subtotal of the number of trainings each employee has had. (show all
commands that you used)
*/

-- creating report 

create view report_sql2 as 
select e.emp_first||' '||e.emp_last as employee,s.emp_first||' '||s.emp_last as supervisor, t.name as "TRAINING NAME",
t.DATA_ACQUIRED as "TRAINING DATE",trim(to_char(round(months_between(sysdate,data_acquired),0))) as "NUMBER OF MONTHS"
from employee e left join employee s on e.super_id=s.emp_num
left join training t on e.emp_num=t.emp_num ;


REM "EMPLOYEE INFORMATION REPORT" created on December 4 2017
REM by user SATHWIK
SET FEEDBACK OFF LINESIZE 120 PAGESIZE 60
REM set up the appropriate parameters to increase readability
COLUMN EMPLOYEE HEADING 'EMPLOYEE' FORMAT A25
COLUMN SUPERVISOR HEADING 'SUPERVISOR' FORMAT A25
COLUMN "TRAINING NAME" HEADING 'TRAINING NAME' FORMAT A25
COLUMN "TRAINING DATE" HEADING 'TRAINING DATE' FORMAT A15
COLUMN "NUMBER OF MONTHS" HEADING 'NUMBER OF MONTHS' FORMAT A16 
TTITLE CENTER 'EMPLOYEE TRAININGS INFORMATION REPORT'
BTITLE CENTER 'End of Employee Trainings Information Report' RIGHT 'Run By: ' SQL.USER FORMAT A7
BREAK ON REPORT ON EMPLOYEE SKIP 1
COMPUTE COUNT LABEL 'Num of Trainings' OF "TRAINING NAME" ON EMPLOYEE
SPOOL C:\DBM\REPORT_OUTPUT123885.TXT
SELECT * FROM report_sql2;
SPOOL OFF
REM clean up the parameter values before any other statements
CLEAR BREAK COLUMN COMPUTE
TTITLE OFF
BTITLE OFF
SET FEEDBACK ON LINESIZE 100 PAGESIZE 100



/*
Create a single query that accesses the system catalog to retrieve information about all tables
and all columns, as well as any constraints on the columns. Include the following:
a. Table name
b. Column name
c. Constraint name
d. Constraint type. Instead of the one letter codes, use the two letter indicators as defined
in lecture #12
e. Search condition (for any check constraints), and
f. Table and column that each FK references
*/

/*
select * from user_tables;
/*C – Check or NN; P – Primary Key; R – Foreign Key; U – Unique;
V – With Check option; O – Read Only option*/
/*
select a.constraint_name,a.r_constraint_name,b.table_name,b.column_name from user_constraints a 
left join user_cons_columns b on a.r_constraint_name=b.constraint_name
where a.constraint_type='R';

select * from user_cons_columns;
select * from user_constraints where constraint_name='SYS_C007625';

select constraint_name from user_constraints where constraint_name in (select r_constraint_name 
from user_constraints where constraint_type='R');
*/

drop view partc_view;

create view partc_view as
select a.table_name,a.column_name,b.constraint_name,
decode(c.constraint_type,'C','CK or NN','P','PK','R','FK','U','UK',c.constraint_type) as constraint_type, 
c.search_condition, decode(fk_table.table_name,null,null,trim(fk_table.table_name||' and '||fk_table.column_name)) as foreign_table_column
from user_tab_columns a left join user_cons_columns b  
on a.table_name = b.table_name and a.column_name=b.column_name
left join user_constraints c on b.constraint_name=c.constraint_name
left join ( select a.constraint_name,a.r_constraint_name,b.table_name,b.column_name from user_constraints a 
left join user_cons_columns b on a.r_constraint_name=b.constraint_name
where a.constraint_type='R') fk_table on b.constraint_name=fk_table.constraint_name
order by a.table_name,a.column_name;


/*
Sort the result by table name, then by column name (listed in the same order as they were
created). Include report title, new column headings, and any column formatting that improve
the readability increase (e.g., use BREAK command to suppress repeating names of tables
and columns).
*/

select * from partc_view;

REM "TABLES AND COLUMNS CONSTRAINT INFORMATION REPORT" created on December 4 2017
REM by user SATHWIK
SET FEEDBACK OFF LINESIZE 200 PAGESIZE 60
REM set up the appropriate parameters to increase readability
COLUMN TABLE_NAME HEADING 'TABLE_NAME' FORMAT A20
COLUMN COLUMN_NAME HEADING 'COLUMN_NAME' FORMAT A20
COLUMN CONSTRAINT_NAME HEADING 'CONSTRAINT_NAME' FORMAT A25
COLUMN CONSTRAINT_TYPE HEADING 'CONSTRAINT_TYPE' FORMAT A15
COLUMN SEARCH_CONDITION HEADING 'SEARCH_CONDITION' FORMAT A30 
COLUMN FOREIGN_TABLE_COLUMN HEADING 'FOREIGN_TABLE_COLUMN' FORMAT A25
TTITLE CENTER 'CONSTRAINTS INFORMATION REPORT'
BTITLE CENTER 'End of Constraints Information Report' RIGHT 'Run By: ' SQL.USER FORMAT A7
BREAK ON REPORT ON TABLE_NAME SKIP 1
COMPUTE COUNT LABEL 'Num of Constraints' OF CONSTRAINT_NAME ON TABLE_NAME
SPOOL C:\DBM\REPORT_OUTPUT123885777.TXT
SELECT * FROM partc_view;
SPOOL OFF
REM clean up the parameter values before any other statements
CLEAR BREAK COLUMN COMPUTE
TTITLE OFF
BTITLE OFF
SET FEEDBACK ON LINESIZE 100 PAGESIZE 100









select extract(year from to_date('25-MAR-17')) from dual;
