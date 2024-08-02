/*
데이터 조회(추출) :SELLECT
 SELECT 조회하고자 하는 정보 FROM 테이블명;
 SELECT * 또는 컬럼명1, 2,...FROM 테이블명;
*/
--모든 사원의 정보 조회
SELECT * FROM EMPLOYEE;

--모든 사원의 이름 주민번호 전화번호 조회

SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE;

-- JOB 테이블에서 직급 이름만 조회
SELECT * FROM JOB;
SELECT JOB_NAME FROM job;

--DEPARTMENT 테이블의 모든 정보를 조회
SELECT * FROM DEPARTMENT;

--직원 테이블의 사원명, 이메일, 연락처, 입사일, 급여 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY FROM EMPLOYEE;

/*
컬럼값에 산술 연산하기
=> SELECT 전에 칼럼명 작성부분에 산술 연산을 할 수 있다.
*/
-- 사원이름, 연봉 정보(SALARY*12) 조회
 --SALARY칼럼 데이터에 12 곱하여 조회
SELECT EMP_NAME, SALARY, SALARY * 12  
FROM employee;

--사원이름, 급여, 보너스 정보, 연봉, 보너스 포함 연봉(급여 + (급여*보너스))*12
SELECT EMP_NAME, BONUS, SALARY * 12, SALARY + (SALARY * BONUS)*12
FROM employee;

/*
-현재 날짜시간정보 : SYSDATE
-가상 테이블(임시 테이블) : DUAL
*/
--현재 시간 정보 조회
SELECT SYSDATE FROM dual; --YY/MM/DD형식으로 조회됨;

--사원이름, 입사일 근무일 수(현재 날짜- 근무일수) 조회
--DATE 타입 - DATE 타입 => 일로 표시됨
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE FROM employee;

/*
*컬럼명 별칭 지정 : 연산식을 사용한 경우 의미파악이 어려워 별칭을 부여하여 명확하고 깔끔하게 조회 가능

[표현법]
1) 컬럼명 별칭
2) 컬럼명 AS 별칭
3) 컬럼명 "별칭"
4)컬럼명 AS"별칭"
*/
--사원이름, 급여, 보너스 정보, 연봉, 보너스 포함 연봉으로 각 별칭 부여
SELECT EMP_NAME "사원이름" , BONUS "보너스", SALARY * 12 "연봉", SALARY + (SALARY * BONUS)*12 "보너스 포함 연봉"
FROM employee;

/*
*리터럴 : 임의로 지정한 문자열('')
->SELECT 절에 사용하는 경우 결과에 반복적으로 표시됨
*/
--이름, 급여, '원' 조회
SELECT EMP_NAME 이름, SALARY 급여, '원' 단위
FROM employee;

/*
연결연산자 : ||
*/
SELECT SALARY || '원' AS 급여 
FROM EMPLOYEE;

--사번, 이름, 급여 한 칼럼에 조회
SELECT EMP_ID || EMP_NAME || SALARY
FROM employee;

---XXX의 급여는 XXX입니다
SELECT EMP_NAME||'의 급여는 ' || SALARY||'원입니다' 급여정보
FROM EMPLOYEE;

-- 사원 테이블에서 직급코드 조회
SELECT JOB_CODE FROM employee;

/*
중복 제거 : DISTINCT
*/
SELECT DISTINCT JOB_CODE FROM employee;

--사원테이블에서 부서코드 조회(중복 제거)

SELECT DISTINCT DEPT_CODE FROM employee;

--SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE FROM employee;
--DISTINCT는 한번밖에 못씀
--여러개의 컬럼을 사용시 한쌍으로 묶어서 중복 제거
SELECT DISTINCT DEPT_CODE, JOB_CODE FROM employee;
============================================================
/*
WHERE절 : 조회하고자 하는 데이터를 특정 조건에 따라 추출하고자 할 때 사용
[표현법]
SELECT 컬럼명, 컬럼 | 데이터 기준 연산식
FROM테이블 명
WHERE 조건;

-비교연산자 
*대소비교 : <, >, >=,<= 
*동등비교 
-같은 때 : =
-다를 때 : !=, <>, ^=
*/
-- 사원 테이블에서 부서코드가 'D9'인 사원들만 조회

SELECT * FROM EMPLOYEE 
WHERE DEPT_CODE = 'D9';

--사원 테이블에서 부서 코드가 D1인 사원들의 사원명, 급여, 부서코드 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D1';

--부서코드가 D1이 아닌 사원들의 정보 조회(사원명, 급여, 부서코드)
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE 
WHERE DEPT_CODE != 'D1';

--급여가 400만원 이상인 사원의 사원명, 부서코드, 급여정보를 조회
SELECT EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-------------실습-----------------------------------

--1. 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉 조회(별칭 적용)
select EMP_NAME 사원명, SALARY AS "급여", HIRE_DATE 입사일, SALARY*12 연봉
FROM EMPLOYEE
WHERE SALARY >= 3000000;

--2. 연봉이 5천만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드 조회(별칭 적용)
select EMP_NAME 사원명, SALARY 급여, SALARY*12 연봉, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE SALARY*12 >=50000000;

--3. 직급코드 'j3' 가 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회(별칭 적용)
SELECT EMP_NO 사번, EMP_NAME 사원명, JOB_CODE 직급코드, ENT_YN 퇴사여부 
FROM EMPLOYEE
WHERE JOB_CODE <> 'J3';

--4. 급여가 350만원 이상 600만원 이하인 모든 사원의 사원명, 사번, 급여 조회(별칭 적용)
--and or로 조건을 연결할 수 있음
SELECT EMP_NAME 사원명, EMP_NO 사번, SALARY 급여 
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;
================================================
/*
BETWEEN END : 조건식에서 사용하는 구문
=> ~이상 ~이하인 범위에대한 조건을 제시하는 구문
[표현법]
비교대상컬럼명 BETWEEN 최솟값 AND 최댓값
=> 해당 컬럼의 값이 최솟값 이상이고 최댓값 이하인 경우
*/
--급여 350만원 이상 600만원 이하인 사원의 사원명, 사번, 급여 조회(BETWEEN X)
SELECT EMP_NAME 사원명, EMP_ID 사번, SALARY 급여
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;
SELECT EMP_NAME 사원명, EMP_ID 사번, SALARY 급여
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;
/*
* NOT : 오라클애서의 논리부정연산자
*/
-- 급여가 3500000 미만 또는 600만원 초과인 사원의 사원명 사번 급여 조회(NOT X)
SELECT EMP_NAME 사원명, EMP_ID 사번, SALARY 급여
FROM EMPLOYEE
WHERE SALARY < 3500000 OR SALARY > 6000000;
-- 급여가 3500000 미만 또는 600만원 초과인 사원의 사원명 사번 급여 조회(NOT O)
SELECT EMP_NAME 사원명, EMP_ID 사번, SALARY 급여
FROM EMPLOYEE
--WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
--NOT은 BETWEEN 앞이나 컬럼명 앞에 붙여서 사용가능!

/*
*IN : 비교대상 컬럼값이 제시한 값들 중에 일치하는 값이 있을 경우 조회하는 연산자
[표현법]
비교대상 컬럼명 IN (값1, 값2,.......)
*/
--부서코드가 D6 이거나 D8이거나 D5인 사원들의 사원명, 부서코드, 급여 조회(IN X)
SELECT EMP_NAME 사원명, DEPT_CODE 부서코드, SALARY 급여
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';

SELECT EMP_NAME 사원명, DEPT_CODE 부서코드, SALARY 급여
FROM EMPLOYEE
WHERE DEPT_CODE IN('D6','D8','D5');
===============================================
/*
*LIKE : 비교하고자 하는 컬럼의 값이 제시한 특정 패턴에 만족할 경우 조회

=> 특정 패턴 : '%', '_'를 와일드카드로 사용
* '%' : 0글자 이상
EX)비교대상컬럼명 LIKE '문자%' => 바교대상컬럼의 값에 문자로 '시작'되는 것을 조회
비교대상컬럼명 LIKE '%문자' => 비교대상 컬럼의 값이 문자로 '끝'나는 것을 조회
=> 비교대상컬럼명 LIKE '%문자%' => 비교대상 컬럼의 값에 문자가 포함되는 것을 조회 (키워드 검색)
*'_': 1글자
EX) 비교대상컬럼명 LIKE '_문자' => 비교대상 컬럼의 값에서 문자 앞에 무조건 한 글자가 올 경우 조회
    비교대상컬럼명 LIKE '__문자' => 비교대상 컬럼의 값에서 문자 앞에 무조건 두 글자가 올 경우 조회
    비교대상컬럼명 LIKE '_문자_' => 비교대상 컬럼의 값에서 문자 앞뒤에 무조건 한 글자씩 올 경우 조회
*/
--사원들 중 전씨인 사원의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';
--사원 이름에 하 가 포함된 사원의 사원명, 주민번호, 연락처 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

--사원이름의 가운데 글자가 하 인 사원의 사원명, 연락처 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';

--사원들 중 연락처의 세번째 자리가 1인 사원의 사원명, 연락처 이메일 조회
SELECT EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

--사원들 중 이메일에 _가 있으면 해당 문자 앞이 3글자인 사원의 사번, 이름, 이메일 조회
SELECT EMP_NAME, EMP_ID, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___%';--원하는대로 조회 안됨
--==>와일드카드로 사용되는 문자와 컬럼에 담긴 문자가 동일하기 때문에 모두 와일드카드로 인식
--ESCAPE 사용하여 등록 후 적용
SELECT EMP_NAME, EMP_ID, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';--시험에 나올 수 있다
=================================================================
/*
*IS NULL / IS NOT NULL : 컬럼값에 NULL이 있을 경우 비교
*/
--보너스를 받지 않는 사원의 사번, 이름, 급여, 보너스 조회
SELECT EMP_NAME, EMP_NO, SALARY, BONUS 
FROM EMPLOYEE
WHERE BONUS IS NULL;
--보너스를 받는 사원의 사번, 이름, 급여, 보너스 조회
SELECT EMP_NAME, EMP_ID, SALARY, BONUS 
FROM EMPLOYEE
WHERE BONUS IS NOT NULL; --=WHERE NOT BONUS IS NULL;

--사수가 없는 사원 (MANAGER_ID 값이 NULL)의 사원명, 사수사변, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

--부서배치를 받지 않았지만 보너스를 받고 있는 사원의 사원명, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;
=================================================================
/*
*연산자 우선순위
(0) ()
(1) 산술연산자: * / + -
(2) 연결연산자: ||
(3) 바교연산자 : > < >= <= = != 
(4) is null / like '패턴' / IN
(5) BETWEEN AND
(6) NOT
(7) AND
(8) OR
*/
-- 직급 코드가 J7이거나 J2인 사원들 중에 급여가 200만원 이상인 사원의 모든 정보를 조회
SELECT * FROM EMPLOYEE
--WHERE JOB_CODE IN ('J7', 'J2') AND SALARY >=2000000;
WHERE (JOB_CODE = 'J7'OR JOB_CODE = 'J2') AND SALARY >=2000000;
========================================================================
/*
*ORDER BY : SELECT문의 가장 마지막 줄에 작성, 실행 순서 또한 마지막에 실행

[표현법]
SELECT 조회할 칼럼...
FROM 테이블명
WHERE 조건식
ORDER BY 정렬기준이 되는 컬럼|별칭|컬럼순번 [ASC/DESC] [NULLS FIRST|NULLS LAST]

ASC : 오름차순 정렬
DESC : 내람차순 정렬

NULLS FIRST : 정렬하고자 하는 컬럼의 값이 NULL인 경우 해당 데이터를 맨 앞에 배치(DESC인 경우 기본값)
NULLS LAST : 정렬하고자 하는 값이 NULL인 경우 해당 데이터를 맨 뒤에 배치
*/
--모든 사원의 사원명 연봉 조회 (연봉별 내림차순 정렬)

SELECT EMP_NAME, SALARY*12 연봉 
FROM EMPLOYEE
-- ORDER BY SALARY*12 DESC --정렬 기준이 되는 칼럼(연산식)
--ORDER BY 연봉 DESC;
ORDER BY 2 DESC;--컬럼 순번도 적용(오라클에서는 1부터 시작)

--보너스 기준 정령
SELECT * FROM EMPLOYEE
--ORDER BY BONUS; --기본값(ASC, NULLS LAST)
--ORDER BY BONUS ASC;
--ORDER BY BONUS ASC NULLS LAST;
--ORDER BY BONUS DESC; --NULLS FIRST(DESC인 경우 기본값)
ORDER BY BONUS DESC, SALARY ASC; --보너스 내림차순, 급여는 오름차순
--=> 보너스 값을 내림차순 정렬하는 데 같은 값인 경우 급여의 오름차순으로 정렬


