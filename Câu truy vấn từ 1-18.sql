'1. Truy vấn first_name, last_name, job_id và salary của các nhân viên có tên bắt đầu bằng chữ “S”'
SELECT first_name, last_name, job_id, salary FROM employees
WHERE SUBSTRING(first_name,1,1) LIKE 'S%';

'2. Viết truy vấn để tìm các nhân viên có số lương (salary) cao nhất'
SELECT first_name, last_name, job_id,  salary FROM employees
WHERE salary = (select MAX(salary) FROM employees);

'3. Viết truy vấn để tìm các nhân viên có số lương lớn thứ hai. Ví dụ có 5 nhân viên có mức lương lần lượt là 4, 4, 3, 3, 2 thì kết quả  đúng của mức lương lớn thứ hai sẽ là 3,3'
SELECT employee_id, first_name, last_name, job_id, salary FROM employees
WHERE salary = (select MAX(salary) FROM employees 
WHERE salary < (select MAX(salary) FROM employees)
);

'4. Viết truy vấn để tìm các nhân viên có số lương lớn thứ ba'
SELECT employee_id, first_name, last_name, job_id, salary FROM employees
WHERE salary = (select MAX(salary) FROM employees
WHERE salary < (select MAX(salary) FROM employees
WHERE salary < (select MAX(salary) FROM employees)
)
);

'5. Viết truy vấn để hiển thị mức lương của nhân viên cùng với người quản lý tương ứng,  tên nhân viên và quản lý kết hợp từ first_name và last_name.'
SELECT 
CONCAT(E.first_name,' ', E.last_name) AS employee, 
E.salary AS emp_sal,
CONCAT(M.first_name,' ', M.last_name) AS manager,
M.salary AS mgr_sal FROM employees AS E
	INNER JOIN employees AS M 
    ON E.manager_id = M.employee_id;

'6. Viết truy vấn để tìm số lượng nhân viên cần quản lý của mỗi người quản lý, tên quản lý kết hợp từ first_name và last_name.'
SELECT E.manager_id AS employee_id, CONCAT(M.first_name,' ', M.last_name) as manager_name,
COUNT(E.manager_id) AS number_of_reportees  FROM employees AS E
INNER JOIN employees AS M ON E.manager_id = M.employee_id
GROUP BY E.manager_id, manager_name
ORDER BY COUNT(E.manager_id) DESC;

'7. Viết truy vấn để tìm được số lượng nhân viên trong mỗi phòng ban sắp xếp theo thứ tự số nhân viên giảm dần.'
SELECT department_name, COUNT(E.department_id) AS emp_cout FROM departments AS D
INNER JOIN employees AS E ON D.department_id = E.department_id
GROUP BY E.department_id
ORDER BY COUNT(E.department_id) DESC;

'8. Viết truy vấn để tìm số lượng nhân viên được thuê trong mỗi năm sắp xếp theo thứ tự số lương nhân viên giảm dần và nếu số lương nhân viên bằng nhau thì sắp xếp theo năm tăng dần.'
SELECT YEAR(hire_date) AS hired_year,
COUNT(YEAR(hire_date)) AS employees_hired_count
FROM employees
GROUP BY hired_year
ORDER BY employees_hired_count DESC, hired_year ASC;

'9. Viết truy vấn để lấy mức lượng lớn nhất, nhỏ nhất và mức lương trung bình của các nhân viên (làm tròn mức lương trung bình về số nguyên).'
SELECT MIN(salary) AS min_sal,MAX(salary) AS max_sal, ROUND(AVG(salary)) AS avg_sal FROM employees;

'10. Viết truy vấn để chia nhân viên thành ba nhóm dựa vào mức lương, tên nhân viên được kết hợp từ first_name và last_name, kết quả sắp xếp theo tên thứ tự tăng dần.'
SELECT CONCAT(first_name,' ', last_name) AS employee, salary,
CASE 
	WHEN salary >= 2000 AND salary < 5000 THEN 'low'
	WHEN salary >= 5000 AND salary < 10000 THEN 'mid'
	ELSE 'high'
END AS salary_level
FROM employees
ORDER BY employee ASC;

'11. Viết truy vấn hiển thị họ tên nhân viên và số điện thoại theo định dạng (_ _ _)-(_ _ _)-(_ _ _ _). Tên nhân viên kết hợp từ first_name và last_name, kết quả hiển thị như hình vẽ dưới đây.'
SELECT CONCAT(first_name,' ', last_name) AS employee, REPLACE(phone_number,'.', '-') AS phone_number FROM employees;

'12. Viết truy vấn để tìm các nhân viên gia nhập vào tháng 08-1994, tên nhân viên kết hợp từ first_name và last_name.'
SELECT CONCAT(first_name,' ', last_name) AS employee, hire_date
FROM employees
WHERE MONTH(hire_date) = 08 AND YEAR(hire_date) = 1994;

'13. Viết truy vấn để tìm những nhân viên có mức lương cao hơn mức lương trung bình của các nhân viên, kết quả sắp xếp theo thứ tự tăng dần của department_id.'
SELECT CONCAT(E.first_name,' ', E.last_name) AS name,
E.employee_id,
D.department_name AS department,
D.department_id,
E.salary
FROM employees AS E
INNER JOIN departments AS D ON E.department_id = D.department_id
WHERE E.salary > (SELECT avg(E.salary) FROM employees AS E)
ORDER BY E.department_id ASC;

'14. Viết truy vấn để tìm mức lương lớn nhất ở mỗi phòng ban, kết quả sắp xếp theo thứ tự tăng dần của department_id.'
SELECT 
D.department_id,
D.department_name AS department,
MAX(E.salary) AS maximum_salary
FROM employees AS E
INNER JOIN departments AS D ON E.department_id = D.department_id
GROUP BY D.department_id,department
ORDER BY E.department_id ASC;

'15. Viết truy vấn để tìm 5 nhân viên có mức lương thấp nhất'
SELECT first_name, last_name, employee_id, salary FROM employees
ORDER BY salary ASC
LIMIT 5 OFFSET 0;

'16. Viết truy vấn để hiển thị tên nhân viên theo thứ tự ngược lại'
SELECT LOWER(first_name) AS name, REVERSE(LOWER(first_name)) AS name_in_reverse FROM employees;

'17. Viết truy vấn để tìm những nhân viên đã gia nhập vào sau ngày 15 của tháng.'
SELECT employee_id, CONCAT(first_name,' ',last_name) AS employee, hire_date FROM employees
WHERE DAYOFMONTH(hire_date) > 15;


'18. Viết truy vấn để tìm những quản lý và nhân viên làm trong các phòng ban khác nhau, kết quả sắp xếp theo thứ tự tăng dần của tên người quản lý (tên nhân viên và quản lý kết hợp từ first_name và last_name).'
SELECT CONCAT(M.first_name,' ', M.last_name) AS manager,
CONCAT(E.first_name,' ', E.last_name) AS employee, 
M.department_id AS mgr_dept,
E.department_id AS emp_dept FROM employees AS E
	INNER JOIN employees AS M ON E.manager_id = M.employee_id
    INNER JOIN departments AS D ON D.department_id = M.department_id
    HAVING mgr_dept <> emp_dept
    ORDER BY manager;