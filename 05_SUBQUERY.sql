/*
 서브쿼리(SUBQUERY)
 :쿼리문 안의 또다른 쿼리문
 메인 역할을 하는 쿼리문을 위해 보조 역할을 하는 쿼리문
*/

--"노옹철"사원과 같은 부서에 속한 사원 정보 조회

--1)노옹철 사원의 부서코드 조회
SELECT dept_code
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

--2)부서코드가 D9인 사원 조회

SELECT *
FROM EMPLOYEE
WHERE dept_code = 'D9';

--3) 두 쿼리문을 하나로 합침
SELECT *
FROM EMPLOYEE
WHERE dept_code = (SELECT dept_code
                FROM EMPLOYEE
                 WHERE EMP_NAME = '노옹철');
                 
-- 전체 사원 평균급여보다 더 많이 급여를 받는 사원 조회
--1) 전체 사원 평균 급여
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;
--2)평균급여보다 더 많이 받는 사원 조회
SELECT emp_name, salary, job_code
FROM EMPLOYEE
WHERE SALARY >= 3047663;
--3)서브쿼리 적용
SELECT emp_name, salary, job_code
FROM EMPLOYEE
WHERE SALARY >=(SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE);
--------------------------------------------
/*
서브쿼리 종류
서브쿼리를 수행한 결과값이 몇행 몇열로 나오냐에 따라 분류

-단일행 서브쿼리 : 서브쿼리에 수행 결과가 오로지 1개일 때(1행 1열)
-다중행 서브쿼리 : 서브쿼리의 수행 결과가 여러행일때 (N 행 1열)
-다중열 서브쿼리 : 서브쿼리 수행결과가 한행, 여러 컬럼일 때(1행 N열)
-다중행, 다중열 서부쿼리 : 서브쿼리의 수행 결과가 여러행 여러 컬럼일때(N행N열)

>> 종류에 따라 서브쿼리 앞에 붙는 연산자가 달라짐
*/
--단일행 서브쿼리
/*
일반적인 비교연산자 사용가능 : =, !=, <=, >=, <, >
*/
--전 직원 평균 급여보다 더 적게 급여를 받는 사원들의 사원명, 직급코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY) FROM employee);

--최저 급여를 받는 사원의 사원명, 급여, 입사일 조회
--최저급여 조회
SELECT MIN (SALARY)
FROM employee;

SELECT EMP_name, salary, hire_date
from employee
where salary = (SELECT MIN (SALARY)
FROM employee);
--'노옹철' 사원의 급여보다 많이 받는 사원의 사원명, 부서코드, 급여 조회
--salary > '노옹철' 사원의 급여
select salary
from employee
where emp_name = '노옹철';

select emp_name, dept_code, salary
from employee
where salary > (select salary
from employee
where emp_name = '노옹철');

--위의 결과에서 부서 코드를 부서명으로 변경하여 조회
select emp_name, dept_title, salary
from employee, department
where dept_code = dept_id 
and salary > (select salary
from employee
where emp_name = '노옹철');

--ANSI구문

select emp_name, dept_title, salary
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE SALARY > (select salary
from employee
where emp_name = '노옹철');

--부서별 급여 합이 가장 큰 부서의 부서코드, 급여합을 조회
--1)부서별 급여 합 중 가장 큰 값을 하나만 조회 --> 17700000
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;
--2) 부서별 급여 합이 17700000인 부서의 급여합 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;

--두 쿼리를 합해보자
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);
--전지연 사원과 같은 부서의 사원들의 사번, 사원명, 연락처, 입사일, 부서명 조회
--단 전지영은 제외

--오라클 구문
SELECT EMP_NO, EMP_NAME,PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE=DEPT_ID
AND DEPT_CODE=(SELECT DEPT_CODE
FROM EMPLOYEE 
WHERE EMP_NAME = '전지연')
AND EMP_NAME <> '전지연';
-- ANSI
SELECT EMP_NO, EMP_NAME,PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN department ON DEPT_CODE = DEPT_ID
WHERE DEPT_CODE = (SELECT DEPT_CODE
FROM EMPLOYEE 
WHERE EMP_NAME = '전지연')
AND EMP_NAME != '전지연';
--------------------------------------------------
/*
다중행 서브쿼리 : 서브쿼리 수행 졀과가 여러행일 경우 (N행 1열)
IN (서브쿼리) : 여러 개의 결과값 중에서 하나라도 일치하는 값이 있다면 조회
>ANY(서브쿼리) : 여러개의 결과값 중에서 하나라도 큰 경우가 있으면 조회
<ANY(서브쿼리) : 여러개의 결과값 중에서 하나라도 작은 경우가 있으면 조회
*비교대상 > 값 1 OR 비교대상 > 결과값 2 OR 비교대상 > 결과값 3.....

>ALL (서브쿼리) : 여러개의 모든 결과값보다 클 경우
<ALL (서브쿼리) : 여러개의 모든 결과값보다 작을 경우
*비교대상 > 결과값1 AND 비교대상 > 결과값2 AND 비교대상 > 결과값3....
*/
--유재식 또는 윤은해 사원과 같은 직급인 사원들의 정보 조회 (사번/사원명/직급코드/급여)
--유재식 또는 윤은해 사원의 직급코드 조회
SELECT JOB_CODE
FROM employee
WHERE emp_NAME IN('유재식', '윤은해');

--직급코드가 J3 또는 J7 인 사원들의 정보 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');
                      
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE               
WHERE JOB_CODE IN( SELECT JOB_CODE
                   FROM employee
                   WHERE emp_NAME IN('유재식', '윤은해'));            
                      
--대리 직급인 사원들 중 과장 직급의 사원의 최소 급여보다 많이 받는 사원정보 조회(사번, 이름, 직급명, 급여)
--과장 직급 급여
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장';
-- ANY 연산자 사용하여 비교
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND SALARY > ANY(SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장')
AND JOB_NAME = '대리';
--------------------------------------------------
/*
다중열 서브 쿼리 : 서브쿼리 수행 결과가 행은 하나이고 컬럼(열)수가 여러개인 경우
*/
-- 하이유 사원과 같은 부서코드, 같은 직급코드에 해당하는 사원정보 조회
--1) 하이유 사원 부서코드, 직급코드
select dept_code, job_code
from employee
where emp_name ='하이유';
                      
select job_code
from employee
where emp_name ='하이유';  

select dept_code
from employee
where emp_name ='하이유';
 -----------------------------  
 --단일행 서브쿼리를 사용할 경우
select emp_name, dept_code, job_code, salary
from employee
where dept_code = (select dept_code
from employee
where emp_name ='하이유')
and job_code =(select job_code
from employee
where emp_name ='하이유');
-------------------------
--다중행 서브쿼리를 사용할 경우
select emp_name, dept_code, job_code, salary
from employee
where (dept_code, job_code) = (select dept_code, job_code
from employee
where emp_name ='하이유');

-------------------------------------------
--박나라 사원과 같은 직급코드, 같은 사수를 같고 있는 사원정보 조회
--1)박나라 사원의 직급코드, 사수번호 조회
select job_code, manager_id
from employee
where emp_name = '박나라';

--2) 같은 직급코드 같은 사수를 가지고 있는 사원정보 조회
select emp_name, job_code, manager_id
from employee
where(job_code, manager_id) = (select job_code, manager_id
from employee
where emp_name = '박나라')
and emp_name != '박나라';
-------------------------------------------------------
/*
다중행 다중열 서브쿼리 : 서브쿼리 결과가 여러행, 여러열인 경우
*/
--각 직급별 최소급여 받는 사원정보 조회
--1)각 직급별 최소 급여
select job_code, min(salary)
from employee
group by job_code;           

--2)각 직급별 최소급여 받는 사원 조회

select emp_id, emp_name, job_code, salary
from employee
where job_code = 'j1' and salary= 8000000
   or job_code = 'j2' and salary= 3700000
   or job_code = 'j3' and salary= 3400000;
                      
select emp_id, emp_name, job_code, salary
from employee
where (job_code, salary) in (select job_code, min(salary)
                          from employee
                         group by job_code );
--각 부서별로 최고급여 받는 사원 정보 조회
select dept_code, max(salary)
from employee
group by dept_code; 

select emp_id, emp_name, dept_code, salary
from employee
where(dept_code, salary) in (select dept_code, max(salary)
                        from employee
                        group by dept_code); 
-------------------------------------------------
/*
인라인 뷰 : 서브쿼리를 from절에 사용하는 것
=> 서브쿼리에 수행결과를 마치 테이블처럼 사용하는 것
*/
--사원들의 사번, 이름, 보너스 포함 연봉, 부서코드 조회
--보너스 포함 연봉이 null이 아니어야 하고 3000만원 이상인 사람들만 조회
--=> null 인경우 다른 값으로 변경
select emp_no, emp_name, (salary + salary*nvl(bonus,0))*12, dept_code
from employee
where (salary + (salary*nvl(bonus,0)))*12 >=30000000
order by 3 desc;

-- => top - n 분석 : 상위 n개 조회
select rownum, 사번, 이름, 보너스포함연봉, 부서코드
from (select emp_no 사번, emp_name 이름, (salary + salary*nvl(bonus,0))*12 보너스포함연봉, dept_code 부서코드
from employee
where (salary + (salary*nvl(bonus,0)))*12 >=30000000
order by 3 desc)
where rownum <= 5;

-- 가장 최근에 입사한 사원 5명을 조회
-- 입사일 기준 내립차순 정렬(사번, 이름, 입사일)
select emp_id 사번, emp_name 이름, hire_date 입사일
from employee
order by hire_date desc;

select rownum, 사번, 이름, 입사일
from (select emp_id 사번, emp_name 이름, hire_date 입사일
      from employee
      order by hire_date desc)
where rownum <= 5;

-------------------------------------------------------

/*
순서를 매기는 함수 (windoㅈ function)

- rank() over(정렬기준) : 동일한 순위 이후위 등수를 동일한 수만큼 건너뛰고 순위계산)
- dense() over(정렬기준) : 동일한 순위가 있더라도 그 다음 등수를 +1 해서 순위계산

select 절에서만 사용가능
*/

--급여가 높은 순서대로 순위를 매겨서 조회

select emp_name, salary, rank()over(order by salary desc)"순위"
from employee;

select emp_name, salary, dense_rank()over (order by salary desc)"순위"
from employee;

--> 상위 5명만 조회
select emp_name, salary, dense_rank()over (order by salary desc)"순위"
from employee
where rownum <= 5;
                      
select * 
from (select emp_name, salary, dense_rank()over (order by salary desc)"순위"
      from employee) 
where rownum <= 5;

--상위 3등 ~ 5등 조회
select*
from(
select emp_name, salary, dense_rank()over (order by salary desc)"순위"
from employee) 
where 순위>=3 and 순위<=5;
-----------------------------------------------------------------------------
--1)
select rownum, emp_name, salary
from employee
where rownum<=5
order by salary desc;

--문제점 (원인): 정렬이 되기 전에 5명이 추려짐
--해결방안
select * 
from(select rownum, emp_name, salary
from employee
order by salary desc)     
where rownum<=5;
                      
select dept_code, sum(salary)"총합", floor(avg(salary)) as "평균", count(*) "인원수"
from employee
where salary > 2700000
group by dept_code
order by dept_code asc;
                      
--문제점 (원인): 부서별 평균 급여가 아닌 사원 개개인 급여를 확인
--해결방안                    
select dept_code, sum(salary)"총합", floor(avg(salary)) as "평균", count(*) "인원수"
from employee
--where salary > 2700000
group by dept_code
having floor(avg(salary))>2700000
order by dept_code asc;     

--또는
select*
from(select dept_code, sum(salary)"총합", floor(avg(salary)) as "평균", count(*) "인원수"
from employee
group by dept_code
order by dept_code asc)
where 평균 >2700000;

                      
                      
                      
                      