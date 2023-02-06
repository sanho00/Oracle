--1번
alter session set nls_language = 'american';
select sysdate
from dual;

--2번
select EMPLOYEE_ID, LAST_NAME, SALARY, SALARY*1.155"New Salary"
from Employees;

--3번
select EMPLOYEE_ID, LAST_NAME, SALARY, SALARY*1.155 "New Salary", SALARY*1.155 - SALARY "Increase"
from Employees;

--5번
select last_name "Name", length(last_name)"Length"
from Employees
where substr(last_name, 1, 1) in ('A', 'J', 'M');

select last_name "Name", length(last_name)"Length"
from Employees
where last_name like 'A%'
    or last_name like 'J%'
    or last_name like 'M%';

--6번
select last_name "Name", length(last_name)"Length"
from Employees
where last_name like '&name%';  --입력 받을 땐 & 뒤에 변수 선언, H만 입력, 사용자 편의성 좋음

select last_name "Name", length(last_name)"Length"
from Employees
where last_name like &name;   -- 'H%' 입력, 사용자 편의성 안 좋음

--7번
select last_name ||' earns '|| to_char(salary, '$99,999.99') 
    ||' monthly but wants '|| to_char(salary*3, '$99,999.99') "Dream Salaries"
from Employees;

--6번
select last_name, trunc(months_between(sysdate, hire_date))"MONTHS_WORKED"
from Employees
order by sysdate-hire_date;

--8번
select last_name, lpad(salary, 15, '$') as "salary"
from employees;

--9번
select last_name, hire_date, 
    to_char(next_day(add_months(hire_date, 6), 'MON'), 'Day, "the" ddspth "of" Month, YYYY') 
    as review
from employees;

--10번
select last_name, hire_date, to_char(hire_date, 'DAY') as day
from employees;

--11번
select last_name
    , nvl(to_char(commission_pct), 'No Commission') as comm
from employees;

--12번
select rpad(last_name ||' ', length(last_name)+trunc(salary/1000) , '*') as employee_and_their_salaries
from employees;

--13번
select job_id, decode(job_id, 'AD_PRES', 'A', 'ST_MAN', 'B', 'IT_PROG', 'C', 'SA_REP', 
    'D', 'ST_CLERK', 'E', '0') as gra
from employees;

-- 그룹 함수 연습 문제
-- 1번 true
-- 2번 false
-- 3번 true
-- 4번
select max(salary) as "Maximum", min(salary) as "Minimum",
    sum(salary) as "Sum", avg(salary) as "Average"
from employees;

-- 5번
select job_id, max(salary) as "Maximum", min(salary) as "Minimum",
    sum(salary) as "Sum", avg(salary) as "Average"
from employees
group by job_id;

-- 6번
select job_id, count(*)
from employees
group by job_id;

-- 7번
select count(distinct manager_id) as "Number of Managers"
from employees;

-- 8번
select max(salary) - min(salary) as difference
from employees;

-- 9번
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by 2 desc;

-- 10번
select count(*) as total, 
    sum(decode(to_char(hire_date, 'YYYY'), '1995', 1)) as "1995",
    sum(decode(to_char(hire_date, 'YYYY'), '1996', 1)) as "1996",
    sum(decode(to_char(hire_date, 'YYYY'), '1997', 1)) as "1997",
    sum(decode(to_char(hire_date, 'YYYY'), '1998', 1)) as "1998"
from employees;

select count(*) as total,
    sum(case to_char(hire_date, 'YYYY') when '1995' then 1 end) as "1995",
    sum(case to_char(hire_date, 'YYYY') when '1996' then 1 end) as "1996",
    sum(case to_char(hire_date, 'YYYY') when '1997' then 1 end) as "1997",
    sum(case to_char(hire_date, 'YYYY') when '1998' then 1 end) as "1998"
from employees;

-- 11번
select job_id, 
    sum(decode(department_id, 20, salary)) as "Dept 20",
    sum(decode(department_id, 50, salary)) as "Dept 50",
    sum(decode(department_id, 80, salary)) as "Dept 80",
    sum(decode(department_id, 90, salary)) as "Dept 90",
    sum(salary) "Total"
from employees
group by job_id
order by job_id;

select job_id,
    sum(case department_id when 20 then salary end) as "Dept 20",
    sum(case department_id when 50 then salary end) as "Dept 50",
    sum(case department_id when 80 then salary end) as "Dept 80",
    sum(case department_id when 90 then salary end) as "Dept 90",
    sum(salary) "Total"
from employees
group by job_id
order by job_id;

-- 조인 연습 문제

-- 1번
select a.location_id location_id, a.street_address street_address,
    a.city city, a.state_province state_province, b.country_name country_name
from locations a, countries b
where a.country_id = b.country_id;

select a.location_id location_id, a.street_address street_address,
    a.city city, a.state_province state_province, b.country_name country_name
from locations a natural join countries b;

-- 2번
select a.last_name, a.department_id, b.department_name
from employees a, departments  b
where a.department_id = b.department_id;

select a.last_name, deaprtmnet_id, b.department_name
from employees a join departments b using (department_id);


--3번
select a.last_name, a.job_id, a.department_id, b.department_name
from employees a, departments b, locations c
where a.department_id = b.department_id
    and b.location_id = c.location_id
    and c.city = 'Toronto';
    
select a.last_name, a.job_id, a.department_id, b.department_name
from employees a join departments b on a.department_id = b.department_id
    join locations c on b.location_id = c.location_id 
    and c.city = 'Toronto';
    
select a.last_name, a.job_id, a.department_id, b.department_name
from employees a join departments b on a.department_id = b.department_id
    join locations c on b.location_id = c.location_id
    where c.city = 'Toronto';
    
    
-- 4번
select a.last_name as "Employee", a.employee_id as "EMP#",
    b.last_name "Manager", a.manager_id "Mgr#"
    from employees a join employees b
    where a.manager_id = b.employee_id; -- 오류?
    
select a.last_name as "Employee", a.employee_id as "EMP#",
    b.last_name "Manager", a.manager_id "Mgr#"
    from employees a join employees b on a.manager_id = b.employee_id;
    
    
-- 5번
select a.last_name as "Employee", a.employee_id as "EMP#",
    b.last_name "Manager", a.manager_id "Mgr#"
    from employees a join employees b
    where a.manager_id = b.employee_id(+);  -- 오류?
    
select a.last_name as "Employee", a.employee_id as "EMP#",
    b.last_name "Manager", a.manager_id "Mgr#"
    from employees a left outer join employees b on a.manager_id = b.employee_id;
    
    
-- 6번
select a.department_id as department,
    a.last_name as employee,
    b.last_name as colleague
from employees a join employees b
    on a.department_id = b.department_id
    and a.last_name != b.last_name;
    
select a.department_id as department,
    a.last_name as employee,
    b.last_name as colleague
from employees a, employees b
where a.department_id = b.department_id
    and a.last_name != b.last_name;
    
    
-- 7번
select a.last_name as last_name, a.job_id as job_id,
    b.department_name as department_name, a.salary as salary,
    c.grade_level as gra
from employees a, departments b, job_grades c
where a.department_id = b.department_id
    and a.salary between c.lowest_sal and c.highest_sal;
    
select a.last_name as last_name, a.job_id as job_id,
    b.department_name as department_name, a.salary as salary,
    c.grade_level as gra
from employees a join departments b on a.department_id = b.department_id
    join job_grades c on a.salary between c.lowest_sal and c.highest_sal;

    
-- 8번
select a.last_name last_name, a.hire_date hire_date
from employees a, employees b
where b.last_name = 'Davies'
and a.hire_date > b.hire_date;


-- 9번
select a.last_name last_name, a.hire_date hire_date,
    b.last_name last_name, b.hire_date hire_date
from employees a, employees  b
where a.hire_date < b.hire_date
    and a.manager_id = b.employee_id;
