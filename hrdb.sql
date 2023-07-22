show tables;

-- TO find out the total number of Employees
select count(*) as "Total Employees"
from hr;

select concat(first_name,' ',last_name) as "Full_Name",birthdate,gender
from hr;

-- TO understand the diversity in the workplace

-- 1. Percentage of Males and Females
select round(sum(case when gender="male" then 1 else 0 end)/count(*)*100,2)as "Male Percentage", round(sum(case when gender="female" then 1 else 0 end)/count(*)*100,2) as "Female Percentage"
from hr;

-- 2. Count of Employees by race
select race,count(id) as "Employee Count"
from hr
group by race
order by count(id) desc;

-- Age Distribution of Employees
-- 1. Maximum, Minimum and Average age of Employees
select max(age) as "Max Age",
min(age) as "Min Age",
avg(age) as "Average Age"
from hr;

-- 2. Age Groups
select case when age<18 then "Under 18" 
when age between 18 and 25 then "18-25"
when age between 26 and 35 then "26-35"
when age between 36 and 45 then "36-45"
when age between 46 and 55 then "46-55"
when age>55 then "above 55"
end as age_groups,
count(*) as count
from hr
group by age_groups
order by age_groups;

-- Department and Job Title Analysis

-- 1. Identify the number of employees in each department and job title

select department, jobtitle, count(id)
from hr
group by department,jobtitle
order by department,jobtitle;

-- 2. Determine the most common job titles and departments in the organization

select department, jobtitle, count(id) as employees_count
from hr
group by department, jobtitle
order by employees_count desc
limit 1;

-- Employee Tenure

-- 1. Calculate the average tenure (duration of employment) of employees
select avg(datediff(termdate,hire_date))/365 as "avg_tenure_years"
from hr;

-- 2. Identify the employees with the longest and shortest tenure
select first_name, max(datediff(termdate,hire_date)/365) as longest_tenure
from hr
group by longest_tenure;

select concat(first_name,' ',last_name), min(datediff(termdate,hire_date)/365) as "shortest_tenure"
from hr;

-- Location Analysis
-- 1. Count the number of employees in each location (city and state)
select location_state,location_city,count(id) as "Employee Count"
from hr
group by location_state, location_city
order by location_state,location_city;

-- 2. Identify which locations have the highest employee count
select location_state,location_city,count(id) as Employee_count
from hr
group by location_state, location_city
order by Employee_count desc;

-- Hiring and Termination Patterns
-- 1. Analyze the hiring and termination trends over time using hiring and termination dates
select year(hire_date) as hire_year, count(id) as num_of_employees_hired
from hr
group by hire_year
order by hire_year;

select year(termdate) as term_year, count(id) as num_of_employees_terminated
from hr
group by term_year
order by term_year;


-- Group employees by age, gender, and race to analyze demographic distributions
select race,gender,
  case
    when age<18 then "Under 18" 
    when age between 18 and 25 then "18-25"
    when age between 26 and 35 then "26-35"
    when age between 36 and 45 then "36-45"
    when age between 46 and 55 then "46-55"
    when age>55 then "above 55"
  END as age_range,
  count(*) as emp_count
from hr

group by race,gender,age_range
order by emp_count desc;

-- Find the average age of employees in each department and job title
select department,jobtitle,avg(age) as avg_age
from hr
group by department,jobtitle
order by department,jobtitle;

-- NUmber of Employees who worked at the company for less than a year
select (count(distinct case when datediff(termdate,hire_date) < 365 then id end)) as "retention rate"
from hr;

alter table hr
add month int;

update hr
set month = month(birthdate);


-- Employee Churn Analysis
select year(termdate) as termination_year,count(*) as Employee_churn_count
from hr
where termdate is not null
group by termination_year
order by Employee_churn_count desc;

select month(termdate) as termination_month, count(*) as Employee_churn_count
from hr
where year(termdate) = 2021
group by termination_month
order by Employee_churn_count desc;

select department,jobtitle,
case
    when age<18 then "Under 18" 
    when age between 18 and 25 then "18-25"
    when age between 26 and 35 then "26-35"
    when age between 36 and 45 then "36-45"
    when age between 46 and 55 then "46-55"
    when age>55 then "above 55"
  END as age_range,
  location_city,
  location_state,
  count(*) as Employee_churn_count
from hr
where termdate is not null
group by department,jobtitle,age_range,location_city,location_state
order by Employee_churn_count desc;

-- Employee Average Tenure By Department
select department, round(avg(datediff(termdate,hire_date)/365),2) as Avg_tenure
from hr
where termdate is not null
group by department
order by Avg_tenure desc;















