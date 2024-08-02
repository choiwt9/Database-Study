/*
*PL/SQL : PROCEDURE LANGUAGE EXTENSION TO SQL

오라클 자체에 내장되어 있는 절차적 언어
SQL 문장 내에서 변수정의, 조건, 반복 등을 자원하여 SQL단점을 보완
다수의 SQL문을 한번에 시행 가능

*구조*
[선언부] : DECLARE로 시작
[실행부] : BEGIN 으로 시작. SQL문 또는 제어문 (조건문 반복문)등의 로직을 작성하는 부분
[예외처리부] : EXCEPTION 으로 시작 예외발생 시 해결하기 위한 부분
*/

SET SERVEROUTPUT ON;
-- HELLO ORACLE 출력
BEGIN 
--자바 : system.out.print
DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/
--------------------------------------------------------------------------------
/*
*선언부 (DECLARE)
: 변수 또는 상수 선언하는 부분(선언과 동시에 초기화도 가능)

-데이터 타입 선언 종류
+일반 타입
+레퍼런스 타입
+ROW 타입
*/
/*
일반 타입 변수
변수명[CONSTANT] 자료형 [:=값]
--상수 선언 시 CONSTANT를 붙여줌
--초기화 할때는 := 기호를 붙여줌
*/
DECLARE
EID NUMBER;       --EID라는 이름ㅇ의 NUMBER 타입의변수 선언
ENAME VARCHAR2(20); --ENAME이라는 이름의 VARCHAR2(20)타입 변수 선언
PI CONSTANT NUMBER := 3.14; --PI 라는 이름의 NUMBER 타입 상수 선언 및 3.14 로 초기화
BEGIN
--변수에 값 대입
EID := 100;
ENAME :='최원탁';
--각 변수 상수에 저장된 값을 출력
--특정문자와 변수를 같이 출력하고자 할때 연결연산자 사용
DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
--값을 입력받아 변수에 대입
DECLARE
EID NUMBER;       
ENAME VARCHAR2(20);
PI CONSTANT NUMBER := 3.14;
BEGIN
--값을 입력 받을 때 &대체 변수명 형식으로 작성
EID := &사원번호;
ENAME :='최원탁';

DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
--------------------------------------------------------------------------------
/*
레퍼런스 타입 변수
: 어떤 테이블의 어떤 컬럼의 데이터 타입을 참조하여 해당 타입으로 변수를 지정
변수명 테이블명.컬럼명%TYPE
*/
DECLARE
EID EMPLOYEE.EMP_ID%TYPE;  --EID라는 변수는 EMPLOYEE 테이블의 EMP_ID컬럼의 타입을 참조
ENAME EMPLOYEE.EMP_NAME%TYPE; --ENAME 변수는 EMPLOYEE 테이블의 EMP_NAME 컬럼의 타입을 참조
SAL EMPLOYEE.SALARY%TYPE; -- SAL 변수는 EMPLOYEE 테이블의 SALARY 컬럼의 타입을 참조
BEGIN 
--EID:='100';
--ENAME :='최원탁';
--SAL := 3000000;
SELECT EMP_ID, EMP_NAME, SALARY
INTO EID, ENAME, SAL --각 컬럼의 결과값을 변수에 대입
FROM EMPLOYEE
--WHERE EMP_ID = 200;
WHERE EMP_ID = &사번;
DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/
--문제--
/*
레퍼런스 타입 변수로 EID, ENAME, JCODE, SAL, DTITLE 선언하고
각 자료형을 EMPLOYEE 테이블의 EMP_ID, EMP_NAME, JOB_CODE, SALARY컬럼과
DEPARTMENT 테이블의 DEPT_TITLE을 참조하게 한 뒤
사용자가 입력한 사번의 사원정보를 조회하여 변수에 담아 출력

출력 형식: {사번}, {이름, {직급코드}, {월급, {부서명}
*/
DECLARE 
EID EMPLOYEE.EMP_ID%TYPE;
ENAME EMPLOYEE.EMP_NAME%TYPE;
JCODE EMPLOYEE.JOB_CODE%TYPE;
SAL EMPLOYEE.SALARY%TYPE;
DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
INTO EID , ENAME, JCODE, SAL, DTITLE
FROM employee 
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE EMP_ID = &사번;
DBMS_OUTPUT.PUT_LINE(EID || ',' || ENAME   || ',' || JCODE   || ',' || SAL   || ',' || DTITLE  );
END;
/
-------------------------------------------------------------------------------------------
/*
ROW 타입 변수 
: 테이블의 한 행에 대한 모든 컬럼값을 한번에 담을 수 있는 변수

변수명 테이블명%ROWTYPE
*/
DECLARE
E EMPLOYEE%ROWTYPE;
BEGIN
SELECT*
INTO E
FROM EMPLOYEE
WHERE EMP_ID = &사번;
--사원명 급여 보너스 출력
DBMS_OUTPUT.PUT_LINE('사원명 : ' || E.EMP_NAME);
DBMS_OUTPUT.PUT_LINE('급여 : ' || E.SALARY);
--DBMS_OUTPUT.PUT_LINE('보너스 : ' || E.BONUS);
--NULL인 경우 0으로 표시하기 위해 NVL함수 사용가능
DBMS_OUTPUT.PUT_LINE('보너스 : ' || NVL(E.BONUS,0));
END;
/
--==============================================================================
/*
*실행부 (BEGIN)

**조건문**
-단일 IF문: IF 조건식 THEN 실행내용 END IF;
-IF/ELSE문: IF 조건식 THEN 조건식 참일때 실행내용 ELSE 거짓일때 실행내용 END IF;
-IF/ELSIF 문 : IF 조건식1 THEN 실행내용1 ELSIF 조건식2 THEN 실행내용2...........[실행내용] END IF;

-CASE/WHEN/THEN 문
CASE 비교대상 WHEN 동등비교값1 THEN 결과값1
            WHEN 비교값2 THEN 결과값2
            WHEN 비교값3 THEN 결과값3
            ...
            ELSE 결과값N
     END;          
*/
--사용자에게 사번을 입력받은 후 해당 사원의 사번, 이름, 급여, 보너스 정보를 입력
--각 데이터에 대한 변수 : 사번(EID), 이름(ENAME), 급여(SAL), 보너스(BONUS)
--단 보너스 값이 0인 경우 '보너스를 받지 않는 사원입니다' 출력
DECLARE 
EID EMPLOYEE.EMP_ID%TYPE;
ENAME EMPLOYEE.EMP_NAME%TYPE;
SAL EMPLOYEE.SALARY%TYPE;
BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
INTO EID, ENAME, SAL, BONUS
FROM EMPLOYEE
WHERE EMP_ID  =&사번;
DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
DBMS_OUTPUT.PUT_LINE('급여 : ' || SAL);
IF BONUS = 0 
THEN DBMS_OUTPUT.PUT_LINE('보너스를 받지 않는 사람입니다');
ELSE DBMS_OUTPUT.PUT_LINE('보너스 : ' || NVL(BONUS,0));
END IF;
END;
/
-------------------------------------------------------------------------
/*
DECLARE
--레퍼런스변수 (EID, ENAME, DTITLE, NCODE)
참조변수(EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE)
--일반타입변수 (TEAM 문자타입)--> '국내팀' 또는 '해외팀' 저장할 예정
BIGIN
--사용자가 입력한 사번에 해당하는 사번 이름 부서명 근무국가 코드 조회
--조회 후 해당 값을 변수에 저장
-- 이때 NCODE의 값이 KO일 경우 '국내팀'을 TEAM 변수에 저장
        KO가 아닐 경우 '해외팀'을 TEAM변수에 저장
--출력 형식 : 사번, 이름, 부서, 소속 --> 한줄 또는 여러줄로 출력
END;
/
*/
DECLARE
EID EMPLOYEE.EMP_ID%TYPE;
ENAME EMPLOYEE.EMP_NAME%TYPE;
DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
NCODE LOCATION.NATIONAL_CODE%TYPE;

TEAM VARCHAR2(20);
BEGIN
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
INTO EID, ENAME, DTITLE, NCODE
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE EMP_ID = &사번;
IF NCODE = 'KO' 
THEN TEAM := '국내팀';
ELSE TEAM := '해외팀';
END IF;
DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
DBMS_OUTPUT.PUT_LINE('부서명 : ' || DTITLE);
DBMS_OUTPUT.PUT_LINE('소속 : ' || TEAM);
END;
/

DECLARE
SCORE NUMBER;
GRADE CHAR(1);
BEGIN 
SCORE := &점수;
IF SCORE>=90
THEN GRADE := 'A';
ELSIF SCORE >= 80
THEN GRADE := 'B';
ELSIF 70>= SCORE
THEN GRADE := 'C';
ELSIF 60 >= SCORE
THEN GRADE := 'D';
ELSE GRADE := 'F';
END IF;

DBMS_OUTPUT.PUT_LINE('점수는 ' || SCORE || '이고, 등급은' || GRADE || '입니다.' );
IF GRADE = 'F'
THEN DBMS_OUTPUT.PUT_LINE('재평가 대상입니다' );
END IF;
END;
/
----------------------------------------------------------
-사번에 해당하는 사원의 부서 코드 기준으로 부서명을 출력(JOIN X)
DECLARE
EMP EMPLOYEE%ROWTYPE;
DTITLE VARCHAR2(50);
BEGIN
SELECT *
INTO EMP
FROM EMPLOYEE
WHERE EMP_ID = &사번;

--해당 사원의 부서코드 기준으로 저장
DTITLE := CASE EMP.DEPT_CODE
           WHEN 'D1' THEN '인사관리부'
           WHEN 'D2' THEN '회계관리부'
           WHEN 'D3' THEN '마케팅부'
           WHEN 'D4' THEN '국내영업부'
           WHEN 'D5' THEN '해외영업1부'
           WHEN 'D6' THEN '해외영업2부'
           WHEN 'D7' THEN '해외영업3부'
           WHEN 'D8' THEN '기술지원부'
           WHEN 'D9' THEN '총무부'
               ELSE '부서없음'
               END;
-----------------------------------------------------------
DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || '사원의 소속부서는' || DTITLE || '입니다.');
END;
/

SELECT*FROM DEPARTMENT;
--------------------------------------------------------------------------------
/*
*반복문 

-기본 구문  
            LOOP
            반복할 구문
            반복문을 종료할 구문
            END LOOP;
            * 반복문을 종료할 구문
            [1] IF 조건식 THEN EXIT; END IF;
            [2] EXIT WHEN 조건식;
-FOR LOOP 문
        FOR 변수 IN [REVERSE] 초기값..최종값
        LOOP 반복할 구문 END LOOP;
        *REVERSE : 최종값부터 초기값까지 반복(역방향)
-WHILE LOOP문
        WHILE 조건식
        LOOP 반복할 구문 END LOOP;            
*/
--기본구문으로 HELLO ORACLE 다섯번 출력
DECLARE
N NUMBER := 1;
BEGIN
LOOP 
DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
N := N+1;
IF N > 5 
THEN EXIT;
END IF;
END LOOP;
END;
/
--FOR문으로 HELLO ORACLE 다섯번 출력--

BEGIN
FOR I IN 1..5
LOOP
DBMS_OUTPUT.PUT_LINE(I || ' )HELLO ORACLE!!');
END LOOP;
END;
/

BEGIN
FOR I IN REVERSE 1..5
LOOP
DBMS_OUTPUT.PUT_LINE(I || ' )HELLO ORACLE!!');
END LOOP;
END;
/
--------------------------------------------------------------------------------
-- TEST 테이블 삭제
DROP TABLE TEST;

CREATE TABLE TEST(
TNO NUMBER PRIMARY KEY,
TDATE DATE
);

CREATE SEQUENCE SEQ_TNO
INCREMENT BY 2
MAXVALUE 1000
NOCYCLE
NOCACHE;

--TEST TABLE 에 데이터를 100개 추가(TNO 시퀀스 사용, TDATE : 현제닐짜)
BEGIN 
FOR I IN 1..100
LOOP 
INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL, SYSDATE);
END LOOP;
END;
/
SELECT * FROM TEST;
--------------------------------------------------------------------------------
/*
*예외처리부
- 예외 (EXCEPTION): 실행 중에 발생한 오류

EXCEPTION
    WHEN 예외명 THEN 예외처리구문;
    WHEN 예외명 THEN 예외처리구문;
    ...
    WHEN OTHERS THEN 예외처리구문;
    *오라클에서 미리 정의한 예외 => 시스템 예외
      -NO_DATA_FOUND : 조회된 결과가 없을 때
      -TOO_MANY_ROW : 조회된 결과가 여러 행일 때(=> 변수에 대입)
      -ZERO_DIVINE : 0으로 값을 나누려고 할때
      -DUP_VAL_ON_INDEX : UNIQUE 조건에 위배될때 (중복되는 경우)
      ...
      *OTHERS: 어떤 예외든 발생되었을때
*/
--사용자에게 숫자를 입력받아 10으로 나눈 결과를 출력.(0이 입력 되었을때 오류가 발생할 수 있다.)
DECLARE
NUM NUMBER;

BEGIN
NUM := &숫자;
DBMS_OUTPUT.PUT_LINE(10/NUM);
EXCEPTION
WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('0으로 나눌 수 없습니다.');
END;
/
--EMPLOYEE 테이블에 EMP_ID 컬럼을 기본키로 설정
--ALTER TABLE EMPLOYEE ADD PRIMARY KEY(EMP_ID);

--기본키(PRIMARY KEY) UNIQUE + NOT NULL
BEGIN
UPDATE EMPLOYEE
SET EMP_ID = '&변경할_사번'
WHERE EMP_NAME = '노옹철';

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('중복된 사번입니다.');
END;
/
----------문제--------------------------------------------------------------------
/*
사수의 사번을 입력빋아 해당 사원의 사번을 출력
-사번: XXX
-
*/
DECLARE
EID EMPLOYEE.EMP_ID%TYPE;
ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN 
SELECT EMP_ID, EMP_NAME
INTO EID, ENAME
FROM EMPLOYEE
WHERE MANAGER_ID = '&사수번호'; --문자타입으로 입력받고자 할 경우 작은 따옴표로 감싸준다
DBMS_OUTPUT.PUT_LINE('사번 :' || EID);
DBMS_OUTPUT.PUT_LINE('이름 :' || ENAME);

EXCEPTION 
WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('입력한 사수사번을 가진 사원이 없습니다');
WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('해당 사수의 사원이 많습니다.');
WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('관리자에게 문의하세요');
END;
/







