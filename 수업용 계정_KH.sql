--=========================================================================
-- 수업용 계정 로그인 후 아래 정보를 조회할 수 있는 쿼리문을 작성해주세요 :D
--=========================================================================
-- 이메일의 아이디 부분에(@ 앞부분) k가 포함된 사원 정보 조회
select *  
from employee
where email like '%k%@%'; 

-- 부서별 사수가 없는 사원 수 조회
select dept_code, count(*)
from employee
where manager_id is null
group by dept_code;

-- 연락처 앞자리가 010, 011로 시작하는 사원 수 조회
select substr (phone,1,3), count(*)
from employee
where substr (phone,1,3) in('011', '010')
group by substr (phone,1,3);

-- 부서별 사수가 없는 사원 정보 조회 (부서명, 사번, 사원명 조회)
--사원정보 : employee, 부서정보 : department --> 연결고리 컬럼 : 부서 코드(dept_code, dept_id)
-- ** 오라클 구문 **
select dept_title ,emp_id ,Emp_name
from employee, department
where dept_code = dept_id --조인할 때 기준이 되는 컬럼
and manager_id is null;

-- ** ANSI 구문 **
select dept_title ,emp_id ,Emp_name
from employee 
join department on dept_code = dept_id
where manager_id is null;
-- 부서별 사수가 없는 사원 수 조회 (부서명, 사원수 조회)
-- ** 오라클 구문 **
select dept_title, count(*)
from employee, department
where dept_code = dept_id
and manager_id is null
group by dept_title;
-- ** ANSI 구문 **
select dept_title, count(*)
from employee
join department on dept_code = dept_id
where manager_id is null
group by dept_title;





