/*
JOIN
: 두개 이상의 테이블에서 조회하고자 할 때 사용되는 구문
조회 결과는 하나의 결과물(RESULT SET)로 나옴

*관계형 데이터베이스 (RDB)에서는 최소한의 데이터를 각각의 테이블에 저장
중복 저장을 최소화하기 위해 최대한 쪼개서 돤리함

=> 관계형 데이터 베이스에서 쿼리문을 이용한 테이블간의 '관계'를 맺는 방법
(각 테이블간의 연결고리를 통해서 데이터를 매칭시켜 조회)

JOIN은 크게 "오라클 전용 구문"과 "ANSI구문" (미국국립 표준 협회)

오라클 전용 구문             |       ANSI 구문
-----------------------------------------------------------------------
등가 조인                  |       내부조인
(EQUAL JOIN)              |     (INNER JOIN) --> JOIN USING/ON
----------------------------------------------------------------------
포괄 조인                   |      왼쪽 외부 조인 (LEFT OUTER JOIN)
(LEFT OUTER)              |       오른쪽 외부 조인(RIHT OUTER JOIN)
(RIGHT OUTER)             |    전체 외부 조인 ( FULL OUTER JOIN)
-----------------------------------------------------------------------
자체 조인(SELF JOIN)         |   JOIN ON
비등가 조인(NON EQUAL JOIN)  |       
--------------------------------------------------------------------------
*/
--전체 사원들의 사번, 사원명, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

--부서 코드, 부서명 조회(부서 정보가 저장된 테이블: DEPARTMENT)
SELECT DEPT_id, dept_title
FROM department;

--전체 사원들의 사번, 사원명, 직급코드 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

--직급코드, 직급명 조회(직급정보 : JOB)
SELECT JOB_CODE, JOB_NAME
FROM JOB;

/*
*등가조인 / 내부조인
=>연결시키는 컬럼의 값이 일치하는 행들만 조회(일치하지 않는 값은 조회시 제외)
*/

--오라클 전용 구문
/*
*FROM절에 조회하고자하는 테이블을 나열(,로 구분)
*WHERE절에 매칭시킬 컬럼에 대한 조건 작성
*/
--사원의 사번,이름, 부서명을 조회(부서코드 컬럼 => EMPLOYEE: DEPT_CODE, DEPARTMENT: DEPT_ID)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--=>NULL(EMPLOYEE.DEPT_CODE),마케팅부(D3), 해외영업 3부(D7), 국내영업부(D4) -> DEPARTMENT 데이터는 제외됨
--각 테이블에만 존재하는 값들로 조회해서 제외됨

--사원의 사번, 이름, 직급명을 조회(직급코드 칼럼=> EMPLOYEE: JOB_CODE, JOB: JOB_CODE)
--두 테이블의 컬럼명이 동일한 경우 별칭을 지어줌으로서 구분할 수 있다.
SELECT EMP_ID,EMP_NAME,JOB_NAME
FROM employee E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE; 

--ANSI 구문--
/*
FROM 절에 기준이 되는 테이블을 하나 작성
JOIN절에 조인하고자 하는 테이블을 기술 + 매칭시키고자 하는 조건을 작성
-JOIN USING : 컬럼명이 같은 경우
-JOIN ON : 컬럼명이 같거나 다른 경우
*/
-- 사번, 사원명, 부서명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN department ON(DEPT_CODE = DEPT_ID);

--사번 사원명 직급명 조회(EMPLOYEE: JOB_CODE, JOB: JOB_CODE)
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM employee
JOIN job USING (JOB_CODE);

--JOIN ON 구문 사용
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM employee E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

--대리 직급인 사원의 사번, 사원명, 직급명, 급여 조회
SELECT EMP_NAME, EMP_ID, JOB_NAME, SALARY 
FROM EMPLOYEE E, job J
WHERE E.JOB_CODE = J.JOB_CODE 
AND JOB_NAME = '대리';

SELECT EMP_NAME, EMP_ID, JOB_NAME, SALARY 
FROM EMPLOYEE 
JOIN job USING (JOB_CODE)
WHERE JOB_NAME = '대리';
----------------------------퀴즈---------------------

--[1] 부서가 인사관리부인 사원들의 사번, 사원명, 보너스 조회
--오라클
SELECT EMP_NAME, EMP_ID, BONUS
FROM EMPLOYEE , DEPARTMENT 
WHERE dept_code = dept_id
AND DEPT_TITLE = '인사관리부';

--ANSI
SELECT EMP_NAME, EMP_ID, BONUS
FROM EMPLOYEE 
JOIN department ON (dept_code = DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';

--[2]부서(DEPARTMENT)와 지역(LOCATION) 정보를 참고하여 
--전체 부서의 부서 코드, 부서명, 지역 코드, 지역명 조회 
--오라클
SELECT dept_id, DEPT_TITLE, LOCATION_ID, LOCAL_NAME  
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;
--ANSI
SELECT dept_id, DEPT_TITLE, LOCATION_ID, LOCAL_NAME  
FROM DEPARTMENT
JOIN location ON (LOCATION_ID = LOCAL_CODE);

--[3] 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
--오라클
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE  
FROM EMPLOYEE, department
WHERE DEPT_CODE =DEPT_ID AND BONUS IS NOT NULL;
--ANSI
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE  
FROM EMPLOYEE
JOIN department ON dept_code= DEPT_ID
WHERE BONUS IS NOT NULL;
--[4] 부서가 총무부가 아닌 사원들의 사원명, 급여 조회
--오라클
SELECT EMP_NAME, SALARY
FROM EMPLOYEE, department
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE != '총무부';
--ANSI
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
JOIN department ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE != '총무부';
---------------------------------------------------------------
/*
포괄조인 / 외부조인 (OUTER JOIN)
: 두 테이블간의 JOIN 시 일치하지 않는 행도 조회하는 구문
단 LEFT/RIGHT 지정해야함(기준이 되는 테이블)
*/
--사원명, 부서명, 급여, 연봉 정보 조회
--*LEFT JOIN : 두 테이블 중 왼쪽에 작성된 테이블 기준
--오라클 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, department
WHERE DEPT_CODE = DEPT_ID(+); --기준이 아닌 컬럼에 +

--ANSI구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
LEFT JOIN department ON DEPT_CODE = DEPT_ID;

--*RIGHT JOIN : 두 테이블 중 오른쪽에 작성된 테이블 기준
--오라클 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, department
WHERE DEPT_CODE(+) = DEPT_ID
ORDER BY EMP_NAME; 
--ANSI구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
RIGHT JOIN department ON DEPT_CODE = DEPT_ID;

--FULL JOIN : 두 테이블이 가진 모든 행을 조회(오라클 전용 구문 X)
--ANSI 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
FULL JOIN department ON DEPT_CODE = DEPT_ID;
-----------------------------------------------------
/*
비등가 조인(NON EQUAL JOIN)
:매칭시킬 칼럼에 대한 조건 작성 시 '='를 사용하지 않는 조인

*ANSI : 구문에서는 JOIN ON만 사용 가능*
*/
-- 사원에 대한 급여 등급 조회(사원명, 급여, 급여등급)
-- 사원(EMPLOYEE), 급여등급 (SAL_GRADE)
--*오라클*
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
--WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

--ANSI 구문
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
--SALARY BETWEEN MIN_SAL AND MAX_SAL;
--------------------------------------------------------------
/*
자체 조인(SELF JOIN)
: 같은 테이블을 다시한번 조인하는 구문
*/
--전체 사원의 사번, 사원명, 부서코드, 사수사번, 사수 사원명, 사수 부서코드 조회
--사원 (EMPLOYEE), 사수(사원)(EMPLOYEE)--> 테이블 명이 동일하므로 '별칭' 부여
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE,
M.EMP_ID, M.EMP_NAME, M.DEPT_CODE
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID; --사원의 사수번호와 사번을 조건으로 주어 사수정보를 조회

--ANSI구문
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE,
M.EMP_ID, M.EMP_NAME, M.DEPT_CODE
FROM EMPLOYEE E
JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;
--LEFT JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID; --사수가 없는 사원정보도 조회하고자 할 때
------------------------------------------------------------------
/*
다중 조인
: 2개 이상의 테이블을 조인하는 것
*/
--사번, 사원명, 부서명,직급명 조회
--사원(EMPLOYEE) / 부서(DEPARTMENT) / 직급(JOB)
--오라클 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

--ANSI구문

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE); --순서는 보통 상관 없음

--사번, 사원명, 부서명, 지역명 조회
SELECT*FROM EMPLOYEE; -- 부서코드 : DEPT_CODE
SELECT*FROM DEPARTMENT; -- 부서코드 : DEPT_ID, 지역코드: LICATION_ID
SELECT*FROM location; --지역코드 : LOCAL_CODE

--오라클 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, location
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE;
--ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID --EMPLOYEE 테이블과 DEPARTMENT 테이블 조인
JOIN location ON LOCATION_ID = LOCAL_CODE; -- DEPARTMENT 테이블과 LOCATION 테이블 조인
--------------------------------------

--1) 사번, 사원명, 부서명, 지역명, 국가명 조회

--오라클 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION L, NATIONAL N
WHERE DEPT_CODE = DEPT_ID
AND l.national_code = n.national_code
AND location_id = local_code;
--ANSI구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
FROM EMPLOYEE 
join DEPARTMENT on DEPT_CODE = DEPT_ID
join LOCATION on location_id = local_code
join national using (national_code);

--2)사번, 사원명,부서명, 지역명, 국가명 급여등급 조회
--오라클 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, job_name, local_NAME, SAL_LEVEL
FROM EMPLOYEE e, DEPARTMENT, LOCATION l, national n, job j, SAL_GRADE
WHERE DEPT_CODE = DEPT_ID
and e.job_code = j.job_code
and salary between min_sal and max_sal
and location_id = local_code
and l.national_code = n.national_code;



--ANSI구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, job_name, local_NAME, SAL_LEVEL
FROM EMPLOYEE 
join DEPARTMENT on DEPT_CODE = DEPT_ID
join job using (job_code)
join sal_grade on salary between min_sal and max_sal
join LOCATION on location_id = local_code
join national using (national_code);























