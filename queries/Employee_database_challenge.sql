--- Deriverable 1 
-- create a new table called "retirement titles"
-- joining the employees and titles table between dates 1952 to 1955

SELECT e.emp_no,
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- view the new table 
SELECT * FROM retirement_titles;
		
-- to keep the most recent title of the employees
-- remove duplicates by using the distinct on function 
-- creating a unique table using the INTO clause 
SELECT DISTINCT ON (rt.emp_no)
					rt.emp_no,
					rt.first_name,
					rt.last_name,
					rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY emp_no, to_date DESC;

-- View the new unique table 
SELECT * FROM unique_titles;

-- retrieve the number of employees by their most recent job title who are about to retire.
-- create another table
SELECT COUNT (uni.title), uni.title
INTO retiring_titles
FROM unique_titles as uni
GROUP BY uni.title
ORDER BY COUNT DESC;

-- view the retiring titles
SELECT * FROM retiring_titles;

-- The employees eligible for the mentorship program 
-- retrieve current employees between January 1, 1965 and December 31, 1965
SELECT DISTINCT ON (emp.emp_no)
					emp.emp_no,
					emp.first_name,
					emp.last_name,
					emp.birth_date,
					dep.from_date,
					dep.to_date,
					t.title
INTO mentorship_eligibility
FROM employees as emp
LEFT JOIN dept_emp as dep
ON(emp.emp_no = dep.emp_no)
LEFT JOIN titles as t
ON (emp.emp_no = t.emp_no)
WHERE (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp.emp_no 

-- view the mentorship table 
SELECT * FROM mentorship_eligibility;
