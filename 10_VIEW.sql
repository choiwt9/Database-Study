/*
*VIEW 뷰)
: SELECT 문D을 통해 얻어진 결과물을 저장해 둘 수 있는 객체
=> 자주 사용하는 쿼리문을 저장해 두면 매번 다시 해당 쿼리문을 기술할 필요가 없다.
임시테이블과 같은 존재(실제 데이터가 저장되는 게 아닌, 논리적으로만 저장되어 있다.)
*/
--한국에서 근무하는 사원정보 조회(사번, 이름, 부서명, 급여 근무국가명)
--사원(EMPLOYEE), 부서(DEPARTMENT), 지역(LOCATION), 국가(NATIPNAL)

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME 
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '한국';

--러시아에서 근무하는 사원정보
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME 
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '러시아';

--일본에서 근무하는 사원정보

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME 
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '일본';
--------------------------------------------------------------------------------
/*
VIEW 생성하기

CREATE VIEW 뷰이름
AS 서브쿼리
*/
--(참고사항) 객체의 이름 줄때 참고
--         테이블 : TB_XXX
--         뷰: VW_XXX

CREATE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME 
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
JOIN NATIONAL USING (NATIONAL_CODE);

--뷰를 생성할 수 있는 권한 부여
--GRANT CREATE VIEW TO C##KH;

SELECT*FROM VW_EMPLOYEE;
--> 실제로는 아래와 같이 실행될 것이다.
SELECT*FROM(SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME 
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
JOIN NATIONAL USING (NATIONAL_CODE));

--한국에서 근무하는 사원정보 조회
SELECT*FROM VW_EMPLOYEE
WHERE national_name = '한국';

--러시아에서 근무하는 사원정보 조회
SELECT*FROM VW_EMPLOYEE
WHERE national_name = '러시아';

--(참고) 현재 계정으로 설정된 뷰 목록 조회-->TEXT 컬럼에 저장된 서브쿼리 정보있음
SELECT*FROM user_views;

CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
JOIN NATIONAL USING (NATIONAL_CODE);
--------------------------------------------------------------------------------
--사번, 사원명 직급명 성별(남|여) 근무년수 정보를 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME,
DECODE(SUBSTR(EMP_NO, 8,1), 1, '남', 2, '여')
,EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

--위에서 조회한 쿼리를 뷰에 저장
--함수식 연산식이 있는 경우 별칭을 부여해야 VIEW로 잘 생성될 수 있음
CREATE OR REPLACE VIEW VW_EMP_JOB
AS
SELECT EMP_ID, EMP_NAME, JOB_NAME,
DECODE(SUBSTR(EMP_NO, 8,1), 1, '남', 2, '여') 성별
,EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)근무연수
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

SELECT * FROM VW_EMP_JOB;

CREATE OR REPLACE VIEW VW_EMP_JOB(사번, 이름, 직급명, 성별, 근무년수)
AS
SELECT EMP_ID, EMP_NAME, JOB_NAME,
DECODE(SUBSTR(EMP_NO, 8,1), 1, '남', 2, '여') 
,EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

--여자사원 조회
SELECT * FROM vw_emp_job
WHERE 성별 = '여';


SELECT * FROM vw_emp_job
WHERE 근무년수 >= 20;

--뷰 삭제
DROP VIEW vw_emp_job;
--------------------------------------------
/*
생성된 뷰를 통해서 DML(INSERT/UPDATE/DELETE)사용
뷰로 DML을 작성하면 실제 데아터가 저장됨
*/
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
FROM JOB;

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

--VW_JOB 를 사용해 테이블 추가
INSERT INTO vw_job VALUES ('J8', '인턴');

--VW_JOB 뷰를 사용하여 데이터를 변경 (DML_UPDATE)
UPDATE vw_job
SET job_name = '알바'
WHERE JOB_CODE = 'J8';

--VW_JOB 뷰를 사용하여 데이터 삭제 (DML_DELETE)
DELETE FROM vw_job
WHERE JOB_CODE = 'J8';
------------------------------------------------------------------------
/*
DML 명령어로 조작이 불가능한 경우가 많음
1) 뷰에 정의디지 않은 컬럼을 조작하려고 하는 경우
2) 뷰에 정의되어 있지 않고 베이스테이블에서 NOT NULL 제약조건이 지정되어 있는 경우
3) 산술연산식 또는 함수식으로 정의가 되어 있는 경우
4) DISTINCT(중복 방지) 구문이 포함되어 있는 경우
5) JOIN을 이용하여 여러 테이블을 연결 시킨 경우

=> 뷰는 대부분 조회의 용도로 사용한다. 그래서 되도록 DML을 쓰지 않는 게 좋다.
*/
--------------------------------------------------------------------------------
/*
VIEW 옵션
CREATE [OR REPLACE] [FORCE|(NOFORCE)] VIEW 뷰이름
AS 서브쿼리
[WITH CHECK OPTION]
[WITH READ ONLY];

- OR REPLACE : 기존에 동일한 이름의 뷰가 있을 경우 갱신하고 존재하지 않을 경우 새로 생성
- FORCE | NOFORCE
  +FORCE : 서브쿼리에 작성한 테이블이 존재하지 않아도 뷰를 생성
  +NOFORCE : 서브쿼리에 작성한 테이블이 존재해야지만 뷰를 생성(기본값)
  -WITH CHECK OPTION : DML 사용시 서브쿼리에 작성한 조건에 맞는 값으로만 실행하도록 되는 옵션
  -WITH READ ONLY : 뷰를 조회만 가능하도롯 하는 옵션
*/
--FORCE|NOFORCE
CREATE OR REPLACE NOFORCE VIEW VW_TEMP
AS SELECT TCODE, TNAME, TCONTECT
FROM TT; --> 현재 테이블이 없으므로 뷰도 생성 불가(NOFORCE)

CREATE OR REPLACE FORCE VIEW VW_TEMP
AS SELECT TCODE, TNAME, TCONTENT
FROM TT; --> 컴파일 오류와 함께 뷰 생성(FORCE)

SELECT*FROM VW_TEMP;

CREATE TABLE TT(
TCODE NUMBER,
TNAME VARCHAR2(20),
TCONTENT  VARCHAR2(100)
);

SELECT*FROM VW_TEMP;

CREATE OR REPLACE VIEW VW_EMP
AS SELECT * 
FROM EMPLOYEE
WHERE SALARY >= 3000000;

SELECT*FROM VW_EMP;


-- 204 사원의 급여를 200만원으로 변경

UPDATE VW_EMP 
SET SALARY = 2000000
WHERE EMP_ID = 204;

ROLLBACK;  --변경사항 취소
-- WITH CHECK OPTION 추가
CREATE OR REPLACE VIEW VW_EMP
AS SELECT * 
FROM EMPLOYEE
WHERE SALARY >= 3000000
WITH CHECK OPTION;

SELECT*FROM VW_EMP;

UPDATE VW_EMP 
SET SALARY = 2000000
WHERE EMP_ID = 204;  --> 서브쿼리에 작성한 조건에 부합하지 않아 변경 불가(=>오류발생)

UPDATE VW_EMP 
SET SALARY = 4000000
WHERE EMP_ID = 204; --> 서브쿼리에 작성한 조건에 부합하는 경우도 변경 가능
--------------------------------------------------------------------------------
--WITH ONLY
CREATE OR REPLACE VIEW VW_EMP
AS SELECT * 
FROM EMPLOYEE
WHERE SALARY >= 3000000
WITH READ ONLY;

SELECT*FROM VW_EMP;

DELETE FROM vw_emp
WHERE EMP_ID = 200; --> READ ONLY 옵션에 의하여 DML 사용불가





















