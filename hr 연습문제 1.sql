-- 연습 문제 day1

--1번
select employee_id, last_name, salary*12 "annual salary"
from employees;


--2번
describe departments

--3번
select * 
from departments;

--4번
describe employees

--5번
select employee_id, last_name, job_id, hire_date as stardate
from employees;

-- 6번
select distinct job_id
from employees;

-- 7번
select employee_id as "Emp#", last_name as "Employee", job_id as "Job", hire_date as "Hire Date"
from employees;

-- 8번
select last_name||', '||job_id as "Employee and Title"
from employees;

-- 9번
select employee_id||','||first_name||','||last_name||upper(first_name)
    ||','||phone||','||job_id||','||hire_date||','||salary||','||commissiion_pct||','||
    department_id as the_output
from employees;

--10번
select last_name, salary
from employees
where salary >= 12000;

--11번
select last_name, department_id
from employees
where employee_id = 176;

-- 12번
select last_name, salary
from employees
where salary not between 5000 and 12000;

-- 4번
select last_name, job_id, hire_date
from employees
where last_name in ('Matos', 'Taylor')
order by salary;

--5번
select last_name, department_id
from employees
where department_id in (50, 20)
order by last_name;

--6번
select last_name "Employee", salary "Monthly Salary"
from employees
where salary between 5000 and 12000
    and department_id in (50, 20);
    
--7번
select last_name, hire_date
from employees
where hire_date like '%94%';

select last_name, job_id, hire_date
from employees
where to_char(hire_date, 'YYYY') = '1994';

select last_name, job_id, hire_date
from employees
where extract (year from hire_date) = 1994;

--8번
select last_name, job_id
from employees
where manager_id is null;

--9번
select last_name, salary, commission_pct
from employees
where commission_pct is not null
order by salary desc;

--10번
select last_name, salary
from employees
where salary >= 12000
order by salary desc;

--11번
select employee_id, last_name, salary, department_id
from employees
where manager_id = &mgr_no
order by last_name;

--12번
select last_name
from employees
where last_name like '__a%';

--13번
select last_name
from employees
where last_name like '%a%e%' or last_name like '%e%a%';

--14번
select last_name, job_id, salary
from employees
where salary not in (2500, 3500, 7000)
order by last_name;

--15번
select last_name "Employee", salary "Monthly Salary", commission_pct
from employees
where commission_pct = 0.2;

