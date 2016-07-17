SELECT
	*
FROM
	emp1
;

SELECT
	  ename	'employee name'
	, salary 'Current Salary'
	, hiredate 'Date Hired'
	, deptno 'department Number'
FROM
	emp1
ORDER BY
	  LOWER(ename)	'employee name'
	, salary 'Current Salary'
	, hiredate 'Date Hired'
	, deptno 'department Number'
FROM
	emp1
ORDER BY
	  ename 'Employee Name'
	, Salary
	, ISNULL(Commission, 0) 'Commission'
	, Salary + ISNULL(Commission, 0) 'Total Remuneration'
FROM
	emp1
ORDER BY
	ename
;


SELECT
	  ename 'employee name'
	, salary 'Current Salary'
	, hiredate 'Date Hired'
	, deptno 'department Number'
FROM
	emp1
WHERE
	deptno = 20
ORDER BY
	  ename 'Employee Name'
	, Salary
	, Deptno 'Department Number'
	, Hiredate 'Date Hired'
FROM
	emp1
ORDER BY
	ename
;
	  ename 'Employee Name'
	, Salary
	, Deptno 'Department Number'
	, CAST(Hiredate AS VARCHAR) 'Date Hired'
FROM
	emp1
ORDER BY
	ename
;
	  ename 'Employee Name'
	, Salary
	, Deptno 'Department Number'
	, CONVERT(VARCHAR, Hiredate, 107)'Date Hired'
FROM
	emp1
ORDER BY
	ename
;


SELECT
	  empno 'Employee Number'
	, ename 'Employee Name'
	, hiredate 'Date Hired'
	, DATEDIFF(day, hiredate, getdate()) 'Number of Days Employed'
	, DATEDIFF(month, hiredate, getdate()) 'Number of Months Employed'
	, DATEADD(day, 90, hiredate) 'Date 90 days After Hire Date'
FROM
	emp1
ORDER BY
	empno
;

SELECT
	ename + ' earns ' + CAST(Salary as VARCHAR) + ' in the number ' + deptno + ' department'
		AS 'employee information'
FROM
	emp1
;

SELECT
	  SUBSTRING(ename, 1, CHARINDEX(',' , ename)-1)
		AS 'Employee Last Name'
	, SUBSTRING(ename, CHARINDEX(',', ename) + 2, LEN(ename) - (CHARINDEX(',', ename) + 1))
		AS 'Employee Last Name'
FROM