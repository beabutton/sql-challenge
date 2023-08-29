/*drop table if exists departments;
drop table if exists dept_emp;
drop table if exists dept_manager;
drop table if exists employees;
drop table if exists salaries;
drop table if exists titles;

create table titles(
	title_id varchar(5) primary key,
	title varchar(20) not null);

create table departments (
	dept_no varchar(4) primary key, 
	dept_name varchar(30) not null);

create table employees(
	emp_no int not null primary key, 
	emp_title_id varchar(5) references titles(title_id), 
	birth_date date, 
	first_name varchar(45),
	last_name varchar(45), 
	sex varchar(1),
	hire_date date
);

create table dept_emp(
	emp_no int references employees(emp_no), 
	dept_no varchar(4) references departments(dept_no)
);

create table dept_manager(
	dept_no varchar(4) references departments(dept_no), 
	emp_no int
);

create table salaries(
	emp_no int references employees(emp_no),
	salary decimal
);
*/


--1 List the employee number, last name, first name, sex, and salary of each employee.

select employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
from employees join salaries on employees.emp_no = salaries.emp_no;


--2 List the first name, last name, and hire date for the employees who were hired in 1986.

select first_name, last_name, hire_date from employees where hire_date between '1986-1-1' and '1986-12-31'
order by hire_date;


--3 List the manager of each department along with their department number, department name, employee number, last name, and first name.

select dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
from dept_manager join employees on dept_manager.emp_no = employees.emp_no
join departments on dept_manager.dept_no = departments.dept_no
order by departments.dept_no asc;


--4 List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees join dept_emp on employees.emp_no = dept_emp.emp_no
join departments on departments.dept_no = dept_emp.dept_no
order by departments.dept_name;


--5 List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
select first_name, last_name, sex from employees
where first_name = 'Hercules' and last_name like 'B%'
order by last_name asc;


--6 List each employee in the Sales department, including their employee number, last name, and first name.

select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees 
join dept_emp 
on employees.emp_no = dept_emp.emp_no
join departments on departments.dept_no = dept_emp.dept_no
where departments.dept_name = 'Sales'
order by employees.emp_no asc;


--7 List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees join dept_emp on employees.emp_no = dept_emp.emp_no
join departments on departments.dept_no = dept_emp.dept_no
where departments.dept_name = 'Sales' or departments.dept_name = 'Development'
order by departments.dept_name asc;


--8 List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

select employees.last_name, count(employees.emp_no) as samelast from employees 
group by employees.last_name
order by samelast desc; 

