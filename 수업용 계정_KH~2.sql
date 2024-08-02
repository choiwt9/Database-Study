-- 사원 테이블에서 모든 정보 조회

SELECT*FROM employee;

-- 보너스가 있는 사원의 사원명, 급여, 보너스, 직급코드 조회

SELECT EMP_NAME, SALARY, BONUS, job_code
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;     --BONUS가 NULL이 아님

-- 이메일의 3번째 글자가 m인 사원의 모든 정보 조회

SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '__m%';
--와일드카드 기호  LIKE '__\_' ESCAPE '\'

-- 여자 사원 수 조회

SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (2,4);

-- 퇴사하지 않은 사원의 급여 합 조회

SELECT TO_CHAR(SUM(SALARY),'L99,999,999') "급여 합"
FROM employee
WHERE ENT_YN='N';

-- 9월에 입사한 사원 수 조회

SELECT COUNT(*)
FROM employee
WHERE EXTRACT(MONTH FROM hire_date) = 9;

----------------------------------------------------------
/*
	* 검색하고자 하는 내용 :
	
		직급코드가 J7이거나 J6이면서 SALARY 값이 200만원 이상이고
		BONUS가 있고 여자이며 이메일주소는 _앞에 3글자만 있는 사원의
		사원명, 주민등록번호, 직급코드, 부서코드, 급여, 보너스를 조회하고자 한다.
		
		(정상적으로 조회가 된다면 2개의 결과를 확인할 수 있음)
*/

-- 아래 쿼리문에서 실행 시 원하는 결과가 나오지 않는다. 
--  어떤 문제가 있는 지 원인을 파악하여 작성한 후, 해결해주세요.
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
      AND EMAIL LIKE '____%' AND BONUS IS NULL;
-- 원인 :
/*
1) 직급 코드의 조건이 우선 순위로 인해 제대로 실행되지 않는다
=> 괄호로 묶어주거나  OR을 IN으로 바꿔줘애 한다.
2)SALARY 조건이 초과로 되어 있다
=> >를 >=로 바꿔줘야 한다.
3)이메일의 네번째자리에 언더바(_)를 값으로써 조건을 주고자 한다면  
ESCAPE 를 사용하여 나만의 와일드카드로 구분해줘야 함
=> LIKE '___#_% ESCAPE '#'
4) 보너스가 있는 사원을 조회해야 하는 데 없는 사원을 조회하고 있다
=> BONUS IS NULL -> BONUS IS NOT NULL
5) 여자 사원 족건이 누락
=> AND SUBSTR(EMP_NO, 8 ,1)IN (2, 4); 추가해줘야 함

*/
