-- SQL Assignment
-- Name: Janani B

-- creating the database
create database company_db;
use company_db;

-- creating tables before starting the assignment

create table department (
    dept_id int auto_increment primary key,
    dept_name varchar(100) not null,
    location varchar(100)
);

create table employee (
    emp_id int auto_increment primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100),
    hire_date date,
    salary decimal(10,2),
    dept_id int,
    gender varchar(10),
    foreign key (dept_id) references department(dept_id)
);

create table project (
    project_id int auto_increment primary key,
    project_name varchar(100),
    budget decimal(10,2),
    dept_id int,
    foreign key (dept_id) references department(dept_id)
);

-- inserting sample data
insert into department (dept_name, location) values
('HR', 'New York'),
('IT', 'San Francisco'),
('Finance', 'Chicago'),
('Marketing', 'Boston');

insert into employee (first_name, last_name, email, hire_date, salary, dept_id, gender) values
('John', 'Doe', 'john.doe@company.com', '2023-03-15', 72000.00, 2, 'Male'),
('Jane', 'Smith', 'jane.smith@company.com', '2023-07-20', 65000.00, 1, 'Female'),
('Mike', 'Johnson', 'mike.j@company.com', '2022-11-10', 55000.00, 3, 'Male'),
('Sara', 'Lee', 'sara.lee@company.com', '2024-01-05', 78000.00, 2, 'Female'),
('Tom', 'Brown', 'tom.b@company.com', '2021-06-01', 48000.00, 4, 'Male');

insert into project (project_name, budget, dept_id) values
('Website Redesign', 75000.00, 2),
('HR Portal', 30000.00, 1),
('Budget Analysis', 45000.00, 3);


-- 1) create a new database called company_db
create database company_db;

-- 2) select the database
use company_db;

-- 3) create skills table with skill_id, skill_name, category
create table skills (
    skill_id int auto_increment primary key,
    skill_name varchar(100) not null,
    category varchar(100)
);

-- 4) show all databases
show databases;

-- 5) show all tables in company_db
show tables;

-- 6) rename employee table to staff
rename table employee to staff;

-- 7) insert alice green into employee table
insert into employee (first_name, last_name, email, hire_date, salary, dept_id, gender)
values ('Alice', 'Green', 'alice.green@company.com', '2024-01-10', 62000.00, 4, 'Female');

-- 8) insert two projects at once
insert into project (project_name, budget, dept_id)
values ('Mobile App', 60000.00, 2),
       ('Training Program', 25000.00, 1);

-- 9) add sales department to department table
insert into department (dept_name, location)
values ('Sales', 'Boston');

-- 10) insert tom with only first_name and email, rest will be null
insert into employee (first_name, email)
values ('Tom', 'tom@company.com');

-- 11) get all records from employee table
select * from employee;

-- 12) select emp_id, first_name, email with custom column names
select emp_id as "Employee ID",
       first_name as "Name",
       email as "Email Address"
from employee;

-- 13) employees hired after january 1 2023
select * from employee
where hire_date > '2023-01-01';

-- 14) projects with budget more than 40000, highest first
select * from project
where budget > 40000
order by budget desc;

-- 15) show unique locations from department table
select distinct location from department;

-- 16) add phone_number column after email column
alter table employee
add column phone_number varchar(15) after email;

-- 17) update salary of john doe to 65000
update employee
set salary = 65000
where first_name = 'John' and last_name = 'Doe';

-- 18) change gender to Other for all IT department employees
update employee
set gender = 'Other'
where dept_id = 2;

-- 19) remove phone_number column
alter table employee
drop column phone_number;

-- 20) employees with salary between 60000 and 80000
select * from employee
where salary between 60000 and 80000;

-- 21) employees whose first name starts with J
select * from employee
where first_name like 'J%';

-- 22) projects belonging to dept 1 or dept 2
select * from project
where dept_id in (1, 2);

-- 23) employees who have email (not null)
select * from employee
where email is not null;

-- 24) departments not located in new york or chicago
select * from department
where location not in ('New York', 'Chicago');

-- 25) employees hired in year 2023
select * from employee
where year(hire_date) = 2023;

-- 26) total salary of all employees
select sum(salary) as total_salary
from employee;

-- 27) average budget of all projects
select avg(budget) as avg_budget
from project;

-- 28) highest salary in the company
select max(salary) as highest_salary
from employee;

-- 29) how many employees are in IT department
select count(*) as it_employee_count
from employee
where dept_id = 2;

-- 30) lowest project budget
select min(budget) as min_budget
from project;

-- 31) get employee names along with their department names
select e.emp_id, e.first_name, e.last_name, d.dept_name
from employee e
inner join department d on e.dept_id = d.dept_id;

-- 32) list all departments and count of employees in each (including empty ones)
select d.dept_name, count(e.emp_id) as employee_count
from department d
left join employee e on d.dept_id = e.dept_id
group by d.dept_name;

-- 33) show projects with their department name
select p.project_name, p.budget, d.dept_name
from project p
inner join department d on p.dept_id = d.dept_id;

-- 34) employees working in san francisco
select e.first_name, e.last_name, d.location
from employee e
inner join department d on e.dept_id = d.dept_id
where d.location = 'San Francisco';

-- 35) departments that have no projects
select d.dept_name
from department d
left join project p on d.dept_id = p.dept_id
where p.dept_id is null;

-- 36) combine first name and last name as full name
select concat(first_name, ' ', last_name) as "Full Name"
from employee;

-- 37) convert department names to uppercase
select upper(dept_name) as dept_name
from department;

-- 38) get first 3 letters of each employee email
select first_name, left(email, 3) as email_prefix
from employee;

-- 39) absolute value of -50000
select abs(-50000) as absolute_value;

-- 40) average salary rounded to 2 decimal places
select round(avg(salary), 2) as avg_salary
from employee;

-- 41) show only first 3 employees ordered by latest hire date
select * from employee
order by hire_date desc
limit 3;

-- 42) get records 4 to 6 (second page with 3 records per page)
select * from employee
order by emp_id
limit 3 offset 3;

-- 43) label salary as High if >= 70000 else Low
select first_name, salary,
if(salary >= 70000, 'High', 'Low') as salary_category
from employee;

-- 44) categorize project budgets as Large, Medium or Small
select project_name, budget,
case
    when budget >= 60000 then 'Large'
    when budget >= 40000 then 'Medium'
    else 'Small'
end as budget_category
from project;

-- 45) total budget for each department
select dept_id, sum(budget) as total_budget
from project
group by dept_id;

-- 46) find employee with the longest first name
select first_name, length(first_name) as name_length
from employee
order by name_length desc
limit 1;

-- 47) employees joined in last 90 days
select * from employee
where hire_date >= date_sub(curdate(), interval 90 day);

-- 48) delete employees who earn less than 60000
delete from employee
where salary < 60000;

-- 49) drop the project table
drop table project;

-- 50) restore database from backup and verify then delete
-- step 1: open terminal and run this command
-- mysql -u root -p company_db < backup_file.sql

-- step 2: check if tables are restored correctly
use company_db;
show tables;
select table_name, table_rows
from information_schema.tables
where table_schema = 'company_db';

-- step 3: delete the database after verifying
drop database company_db;
