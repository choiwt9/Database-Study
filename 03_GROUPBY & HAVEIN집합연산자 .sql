/*
GRUP BY 절
: 그룹 기준을 제시할 수 있는 구문
: 여러개의 값들을 하나의 그룹으로 묶어서 처리하는 목적으로 사용 
*/
-- 전체 사원의 급여 총합 조회
SELECT SUM (SALARY)
FROM employee;

--부서별 급여 총합
SELECT DEPT_CODE, SUM (SALARY)
FROM employee
GROUP BY DEPT_CODE;

--부서별 사원 수 조회
SELECT DEPT_CODE, COUNT(*)     --3   
FROM employee                  --1
GROUP BY DEPT_CODE;            --2

--부서코드가 D6, D9, D1인 각 부서별 총 합 사원 수 조회
SELECT DEPT_CODE, SUM (SALARY), COUNT(*)           --4
FROM employee                                      --1
WHERE DEPT_CODE IN('D6', 'D9', 'D1')               --2
GROUP BY DEPT_CODE                                 --3
ORDER BY DEPT_CODE;                                --5

--각 직급별 총 사원 수/보너스를 받는 사원 수/ 급여합/평균 급여/최저급여/최고급여 조회 직급코드 오름차순
SELECT JOB_CODE, COUNT(*), COUNT(BONUS), 
SUM(SALARY), ROUND(AVG(SALARY)), MIN(SALARY), MAX(SALARY) 
FROM employee 
GROUP BY job_code  
ORDER BY job_code;

--남자 사원 수, 여자 사원 수 조회
SELECT DECODE(SUBSTR(EMP_NO, 8 ,1), '1', '남', '2', '여')"성별", COUNT(*)"사원 수"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8 ,1);

--부서별, 직급별 사원수, 급여 총합 조회
SELECT DEPT_CODE, JOB_CODE, COUNT(*),SUM (SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE --부서코드 기준으로 그룹화하고 그 내에서 직급코드 기준으로 세부그룹화
ORDER BY DEPT_CODE;
-------------------------------------------------------------------
/*
HAVING 절
: 그룹에 대한 조건을 제시할 때 사용되는 구문 ( 보통 그룹화 함수식을 가지고 조건을 작성함)
*/
-- 각 부서별 평균 급여 조회 (부서코드, 평균 급여-->반올림처리)
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM employee
where SALARY >= 3000000
GROUP BY DEPT_CODE;

--각 부서별 평균급여가 300만원 이상인부서만 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM employee
--where AVG(SALARY) >= 3000000 그룹함수는 where절 사용 불가
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

--직급별 작급 코드, 총 급여 합 조회(단 직급별 급여 합이 1000만원 이상인 직급만 조회)
SELECT JOB_CODE, SUM(SALARY)
from employee
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

--부서별 보너스를 받는 사원이 없는 부서의 부서코드 조회
SELECT DEPT_CODE
from employee
--WHERE BONUS IS NULL  부서 상관 없이 보너스가 NULL인 사원들을 먼저 걸러냄
--> 해당 부서에 보너스가 있는 사원이 있을 수가 있다
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0; --그룹화한 후 COUNT함수를 사용하여 BONUS를 받는 사원이 없는 조건을 재시해야함

--------------------------------------
/*
*실행 순서
SELECT * | 조회하고자 하는 컬럼 AS"별칭" | 함수식 | 연산식 --5
FROM 조회하고자 하는 테이블 |DUAL          --1
WHERE 조건식 (연산자들을 사용하여 작성)       --2
GROUP BY : 그룹화할 기준이 되는 칼럼 | 함수식   --3
HAVING 조건식 (그룹함수를 활용하여 작성)        --4
ORDER BY 컬럼| 별칭 | 컬럼순서 [ASC|DESC] [NULLS FIRST | NULLS LAST]  --6

-> 오라클은 순서(위치)1부터 시작
*/
-----------------------------------------------------------
/*
집합 연산자
: 여러개의 쿼리문을 하나의 쿼리문으로 만들어주는 연산자

-UNION : 합집합 OR (두 쿼리문을 수행한 결과값을 더해줌)
-INTERSECT : 교집합 AND (두 쿼리문을 수행한 결과값의 중복된 부분을 추출)
-UNION ALL : 합집합 + 교집합 (중복되는 부분이 두번 조회될 수 있다)
-MINUS : 차집합(선행 결과값에 후행 결과값을 뺀 나머지)
*/
--**UNION**
-- 부서코드가 D5인 사원 또는 급여가 300만원 초과인 사원들의 사번, 이름, 부사 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

--부서코드가 D5인 사원의 사번, 이름, 부사 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5';

--급여가 300만원 초과인 사원들의 사번, 이름, 부사 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > 3000000;

--UNION으로 위의 2개 쿼리문을 합치기

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > 3000000;  --OR과 동일하게 출력

--교집합(INTERSECT)
--부서코드가 D5인 사원 이고 급여가 300만원 초과인 사원들의 사번, 이름, 부TJ 코드, 급여 조
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > 3000000;

--UNION ALL

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5' --12개
UNION ALL --14개
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > 3000000; --2개

-- MINUS
--선행 결과값에서 후행 결과값을 뺀 나머지
--부서 코드가 D5인 사원들 중 급여가 300만원 초과인 사원들을 제외
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5' 
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > 3000000; 
-------------------------------------------------------------
/*
 집합 연산자 사용시 주의 사항 
 1) 쿼리문의 컬럼 개수가 동일
 2) 컬럼자리마다 동일한 타입으로 작성
 3) 정렬하고자 한다면 ORDER BY는 마지막에 작성해야함
*/
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > 3000000  --OR과 동일하게 출력
ORDER BY EMP_ID;


































