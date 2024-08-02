/*
*함수 (FUNCTION)
:전달된 칼럼값을 읽어서 함수를 실행한 결과를 반환

-단일행 함수 : N개의 값을 읽어서 N개의 결과값을 리턴(행마다 함수를 실행한 결과를 반환)
-그룹 함수 : N개의 값을 읽어서 1개의 결과값을 리턴(그룹을 지어 그룹별로 함수를 실행힌 결과를 반환)

+SELECT절에 단일형 함수랄 그룹함수를 함께 사용할 수 없음
=> 결과행의 개수가 다르기 때문에

+함수식을 사용할 수 있는 위치 : SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING 절
*/
--======================단일행 함수========================

/*
문자 타입의 데이터 처리 함수
=> VARCHAR2, CHAR

*LENGTH(컬럼명| '문자열') : 해당 문자열의 글자 수 반환
 LENGTHB(컬럼명|'문자열') : 해당 문자열의 바이트수 반환
 
 => 영문자, 숫자, 특수문자 글자당 1byte
    한글은 글자당 3byte
*/
--'오라클' 단어의 글자수, 바이트 수 확인
SELECT LENGTH('오라클') 글자수, LENGTHB('오라클') 바이트수
FROM DUAL;

SELECT LENGTH('ORACLE') 글자수, LENGTHB('ORACLE') 바이트수
FROM DUAL;

--EMPLOYEE 테이블에서 사원명, 사원명 글자수, 사원명 바이트수, 이메일, 이메일 글자수, 이메일 바이트수
SELECT EMP_NAME,  LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
|| EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;
--------------------------------------------
/*
*INSTR : 문자열로부터 특정 문자의 시작 위치 반환

[표현법]
INSTR(컬럼|'문자열', '찾고자하는 문자' [,찾을 위치의 시작값, 순번])
=> 함수실행결과는 숫자 타입(NUMBER)
*/
SELECT INSTR('AABAACAABBAA', 'B' ) FROM DUAL; -- 앞쪽에 있는 B의 위치
SELECT INSTR('AABAACAABBAA', 'B', 1 ) FROM DUAL;-- 찾을 위치의 시작값 :  1(기본값)
SELECT INSTR('AABAACAABBAA', 'B', -1 ) FROM DUAL;-- 음수값을 시작값으로 제시하면 뒤에서부터 찾는다. 
                                                 --단 위치에 대한 값은 앞에서부터 읽엇 반환
                                                 -- 뒤쪽에 있는 첫번째 B의 위치 : 10
 SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- 순번을 제시할 땐 시작값을 제시해야 한다!
                                                    -- 앞쪽에 있는 두번쩨 B의 위치 : 9
 -- 사원 정보 중 이메일에_의 첫번째 위치, @의 위치 
 
 SELECT EMAIL, INSTR(EMAIL, '_', 1, 1)"_위치", INSTR(EMAIL, '@', 1, 1) " _@위치"
 FROM employee;
------------------------------------------------------------------
/*
*SUBSTR : 문자열에서 특정 문자열 추출해서 반환
[표현법]
SUBSTR(문자열|컬럼, 시작위치[, 길이(갯수)]))
=> 세번째 길이부분을 생략하면 문자열 끝까지 추출!
*/
SELECT SUBSTR('ORACLE SQL DEVELOPER', 10) FROM DUAL; --10번째 위치부터 끝까지 추출 
SELECT SUBSTR('ORACLE SQL DEVELOPER', 8, 3) FROM DUAL; --8번째 위치부터 3글자만 추출 => SQL
SELECT SUBSTR('ORACLE SQL DEVELOPER', -3) FROM DUAL; -- 뒤에서부터 3번째 위치부터 끝까지 추출  PER
SELECT SUBSTR('ORACLE SQL DEVELOPER', -9, 3) FROM DUAL; -- 뒤에서부터 9번째 위치부터 3글자만 추출 DEV

--사원들 중 여사원들만 조회(이름, 주민번호)
SELECT EMP_NAME, emp_no 
FROM employee
--WHERE SUBSTR(emp_no, 8,1)='2' OR SUBSTR(emp_no, 8,1) = '4';
WHERE SUBSTR(emp_no, 8,1) IN ('2', '4');

--사원들 중 남사원들만 조회(이름, 주민번호)
SELECT EMP_NAME, emp_no 
FROM employee
--WHERE SUBSTR(emp_no, 8,1)='1' OR SUBSTR(emp_no, 8,1) = '3'; 
WHERE SUBSTR(emp_no, 8,1) IN ('1', '3')
ORDER BY EMP_NAME; --사원이름 기준 가나다 순으로 정렬(오름차순)

--사원 정보 중 사원명, 이메일, 아이디 조회(이메일에서 @ 앞까지 조회)
--[1] 이메일에서 "@"의 위치를 찾고 => INSTR함수 사용
--[2] 이메일 컬럼의 값에서 1번째 위치에서 '@'위치(1에서 확인) 전까지 추출
SELECT EMP_NAME, EMAIL, EMP_ID, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)
FROM employee;
-------------------------------------------------------------

/*
*IPAD/RPAD : 문자열을 통일감있게 조회할 때 사용
             문자열에 덧붙이고자 하는 문자를 왼쪽 또는 오른쪽에 붙여서 최종 길이만큼 문자열 반환 
             [표현법]
             LPAD(문자열|컬럼, 최종길이[, 덧붙일 문자])
             RPAD(문자열|컬럼, 최종길이[, 덧붙일 문자])
             *덧붙일 문자 생략 시 기본값으로 공백으로 채워짐
*/
 --사원정보 중 사원명을 공백으로 채워서 총 20 갈아로 조회
 SELECT EMP_NAME, LPAD(EMP_NAME, 20) "이름2"
 FROM employee;
 
 SELECT EMP_NAME, RPAD(EMP_NAME, 20) "이름2"
 FROM employee;
 
 
 --사원 정보 이름, 이메일 오른쪽 정렬(총 길이 : 20)하여 조회
 SELECT EMP_NAME, LPAD(EMAIL, 20) 이메일
FROM employee;
 
  --사원 정보 이름, 이메일 왼쪽 정렬(총 길이 : 20)하여 조회
SELECT EMP_NAME, RPAD(EMAIL, 20) 이메일
FROM employee;


SELECT EMP_NAME, RPAD(EMAIL, 20, '#') 이메일
FROM employee;

SELECT RPAD('000000-1', 14, '*')FROM DUAL;

--사원들의 사원명, 주민번호 조회 (XXXXXX-X****** 형식으로 조회
SELECT EMP_NAME,EMP_NO, RPAD(SUBSTR(EMP_NO,1,8),14, '*')"주민번호"
FROM employee;
--------------------------------------------------------
/*
*LTRIM/RTRIM : 문자열에서 특정문자를 제거한 후 나머지를 반환

[표현법]
LTRIM(문자열|컬럼 [,제거하고자 하는 문자들])
RTRIM(문자열|컬럼 [,제거하고자 하는 문자들])
*제거할 문자를 생략 할 시 공백 제거
*/
SELECT LTRIM('    H I') FROM DUAL;--왼쪽(앞에서부터) 다른 문자가 나올 때까지 공백이 제거
SELECT RTRIM('H I      ') FROM DUAL;--오른쪽(뒤에서부터) 공백이 제거9I값 전까지)

SELECT LTRIM('123123HI123', '123') FROM DUAL;
SELECT LTRIM('321321HI123', '321') FROM DUAL;

SELECT LTRIM('KKHHII', '123') FROM DUAL;
/*
TRIM : 문자열 앞/뒤/양쪽에 잇는 지정한 문자들을 제거한 후 나머지 값을 반환

[표현법]
TRIM([LEADING|TRAILING|BOTH][제거할 문자]FROM 문자열|컬럼)
*제거할 문자 생략 시 공백 제거
*기본 옵션BOTH
*/
SELECT TRIM('      H  I      ')"값" FROM DUAL;
SELECT TRIM('L' FROM 'LLLLLHLILLL')"값" FROM DUAL;

SELECT TRIM(LEADING 'L' FROM 'LLLLLHLILLL')"값" FROM DUAL;--LTRIM과 유사
SELECT TRIM(TRAILING 'L' FROM 'LLLLLHLILLL')"값" FROM DUAL;--RTRIM과 유사
SELECT TRIM(BOTH 'L' FROM 'LLLLLHLILLL')"값" FROM DUAL; -- 양쪽에서 제시한 문자를 제거
------------------------------------------------------------
/*
*LOWER / UPPER / INITCAP

-LOWER : 문자열을 모두 소문자로 변경
-UPPER: 문자열을 전부 대문자로 변경
-INITCAP: 띄어쓰기 기준으로 첫 글자마다 대문자로 변경
*/
--'I think so i am'
select LOWER('I think so i am') FROM DUAL;

select UPPER('I think so i am') FROM DUAL;

select INITCAP('I think so i am') FROM DUAL;
-----------------------------------------------------
/*
*CONCAT : 문자열 두개를 전달 받아 하나로 합친 후 문자열 반환
[표현법]
CONCAT(문자열1, 문자열2)
*/
-- 'KH' 'L강의장' 문자 두개를 하나로 합챠서 조회
SELECT CONCAT('KH', ' L강의장') FROM DUAL; 
SELECT 'KH'|| ' L강의장' FROM DUAL; 

SELECT '최원탁'||  30 FROM DUAL; 

SELECT CONCAT(EMP_NAME, '님') FROM EMPLOYEE; 
-- 사원번호와 (사원명)님을 하나의 문자열로 조회=> 200선동일님
SELECT CONCAT(EMP_ID, CONCAT(EMP_NAME, '님')) FROM EMPLOYEE; 
-----------------------------------------------------------------
/*
 *REPLACE : 특정 문자열에서 특정 부분을 다른 부분으로 교체하여 문자열 반환
  [표현]
  REPLACE(문자열, 찾을 문자열, 변경할 문자열) 
*/
SELECT REPLACE('서울시 도봉구 쌍문동', '쌍문동', '번동') FROM DUAL;

--사원 테이블에서 이메일 정보 중 'OR.KR' 부분을 'KH.OR.KR' 값으로 변경하여 조회
SELECT EMAIL, REPLACE(EMAIL, '@or.kr', '@kh.or.kr') 이메일 from employee;

SELECT EMAIL, REPLACE(EMAIL, '@or.kr', '@gmail.com') 이메일 from employee;
--==================================================================
/*
[숫자 타입의 데이터 처리 함수]
*/
/*
* ABS : 숫자의 절댓값을 구해주는 함수
*/
SELECT ABS(-10)"-10의 절댓값" FROM DUAL;

SELECT ABS(-7.7) "-7의 절댓값" FROM DUAL;
-----------------------------------------------------------
/*
*MOD : 두 수를 나눈 나머지 값을 구해주는 함수

MOD(숫자1, 숫자2)--> 숫자 1% 숫지2
*/

SELECT MOD(10, 3) FROM DUAL;

SELECT MOD(10.9, 3) FROM DUAL;
----------------------------------------------------------------
/*
*ROUND : 반올림한 값을 구해주는 함수

ROUND(숫자[,위치]): 위치 => 소숫점 N번째 자리
*/
SELECT ROUND(123.456) FROM DUAL; --123

SELECT ROUND(123.456, 1) FROM DUAL; --123.5
SELECT ROUND(123.456, 2) FROM DUAL; --123.46

SELECT ROUND(123.456, -1) FROM DUAL; --120
SELECT ROUND(123.456, -2) FROM DUAL; --100
--=> 위치값은 양수로 중가할수록 ㄱ=ㅅ숫점 뒤로 한칸씩 이동, 음수로 감소할수록 소숫점 앞자리로 이동
---------------------------------------------------
/*
*CEIL : 올림처리한 값을 구해주는 함수
CEIL(숫자)
*/
SELECT CEIL(123.456) FROM DUAL; --124
/*
FLOOR : 버림처리한 값을 구해주는 함수
*/
SELECT FLOOR(123.456) FROM DUAL; --123

/*
TRUNC : 버림처리한 값을 구해주는 함수(위치 지정 가능)
TRUNC(숫자[,위치])
*/
SELECT TRUNC(123.456) FROM DUAL; --123
SELECT TRUNC(123.456, 1) FROM DUAL;--123.4
SELECT TRUNC(123.456, -1) FROM DUAL;--120
--=================================================================
/*
[날짜 데이터 타입 처리 함수]
*/
-- SYSDATE : 시스템의 현재 날짜 및 시간을 반환
SELECT SYSDATE FROM DUAL;

--MONTH_BETWEEN : 두 날짜 사이의 개월 수를 반환
-- [표현법]MONTH_BETWEEN(날짜1, 날짜2) 개월 수 계산
SELECT EMP_NAME, HIRE_DATE,
CONCAT(CEIL( MONTHS_BETWEEN (SYSDATE,HIRE_DATE)), '개월차') "근속개월수"
FROM employee;


SELECT CEIL(MONTHS_BETWEEN(SYSDATE, '24/06/11'))"공부 시작한 지" FROM DUAL;

SELECT FLOOR(MONTHS_BETWEEN('24/11/25', SYSDATE)) ||'개월 남음' "수료까지.." FROM DUAL;
-------------------------------------------------
--ADD_MONTH : 특정 날짜에 N개월 수를 다하여 반환
-- [표현법]ADD_MONTH(날짜, 더할 개월 수)

SELECT SYSDATE, ADD_MONTHS(SYSDATE, 4) "4개월 후" FROM DUAL;

--사원 테이블에서 사원명, 입사일, 입사일+3개월 "수습종료일" 조회
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3)"수습 종료일"
FROM employee;

-----------------------------------------------------------------------
--NEXT_DAY : 특정 날짜 이후 가장 가까운 요일의 날짜를 반환
--[표현법] NEXT_DAY(날짜, 요일(문자|숫자))
--*1: 일요일 2. 월요일 .......... 7: 토요일
--현재 날짜 기준 가장 가까운 금요일의 날짜 조회

SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;-- 숫자는 언어 설정과 상관 없이 동작됨

SELECT SYSDATE, NEXT_DAY(SYSDATE, '금요일') FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, '금') FROM DUAL;
--언어설정 : KOREAN/ AMERICAN
ALTER SESSION SET NLS_LANGUAGE = KOREAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRI') FROM DUAL;
------------------------------------------------------------
--LAST_DAY : 해당 월의 마지막 날짜를 구해 반환
--[표현법] LAST_DAY(날짜)

--이번달의 마지막 날짜 조회
SELECT LAST_DAY(SYSDATE)FROM DUAL;

--사원테이블에서 사원명, 입사일, 입사한 달의 마지막 날짜 입사한 달의 근무일수 조회

SELECT EMP_NAME "사원명", HIRE_DATE "입사일", LAST_DAY(HIRE_DATE)"입사한 달의 마지막날", 
LAST_DAY(HIRE_DATE)-HIRE_DATE +1"입사한 달 근무일 수"
FROM employee;

--=========================================

/*
 *EXTRACT : 특정 날짜로부터 년도/월/일 값을 추출해서 반환해주는 함수
 [표현법]
 EXTRACT(YEAR FROM 날짜): 날짜에서 연도만 추출
 EXTRACT(MONTH FROM 날짜): 날짜에서 월만 추출
 EXTRACT(DAY FROM 날짜): 날짜에서 일만 추출
*/
--현재 날짜, 기준, 연도, 월, 일을 각각 추출하여 조회
SELECT SYSDATE
, EXTRACT(YEAR FROM SYSDATE)"연도"
, EXTRACT(MONTH FROM SYSDATE)"월"
, EXTRACT(DAY FROM SYSDATE)"일"
FROM DUAL;

--사원테이블 사원명 입사년도, 입사월, 입사일 조회(+입사년도>입사월>입사일 오름차순 정렬)
SELECT EMP_NAME
, EXTRACT(YEAR FROM hIRE_DATE)"입사년도"
, EXTRACT(MONTH FROM hIRE_DATE)"입사월"
, EXTRACT(DAY FROM hIRE_DATE)"입사일"
FROM employee 
ORDER BY 2, 3, 4;

--=================================
/*
*형변환 함수 : 데이터 타입을 변경해주는 함수
- 문자/ 숫자/ 날짜
*/

/*
TO_CHAR : 숫자, 날짜타입의 값을 문자 타입으로 변환시켜주는 함수
[표현법]
TO_CHAR(숫자|날짜[, 포멧])
*/
--숫자타입-->문자타입

SELECT 1234 "숫자타입의 데이터",TO_CHAR(1234)"믄지로 변경한 데이터" FROM DUAL;

SELECT TO_CHAR(1234) "변경만한데이터", TO_CHAR(1234, '999999')"포멧데이터" FROM DUAL;
--=> '9':개수만큼 자리수 확보, 오른쪽 정렬, 빈칸은 공백

SELECT TO_CHAR(1234, '000000')"포멧데이터" FROM DUAL;
--=> '0':개수만큼 자리수 확보, 오른쪽 정렬, 빈칸은 0으로 채움.
SELECT TO_CHAR(1234, 'L999999') "포멧데이터" FROM DUAL;
--=> 현재 설정된 나라의 로컬 화폐단위를 같이 표시
SELECT TO_CHAR(1234, '$999999') "포멧데이터" FROM DUAL;

SELECT TO_CHAR(1000000, 'L9,999,999') "포멧데이터" FROM DUAL;

--사원들의 사원명 월급, 연봉 조회(화폐단위 3자씩 구분하여 표시되도록)

SELECT EMP_NAME"사원명", TO_CHAR(SALARY,'L99,999,999')"월급", TO_CHAR(SALARY*12,'L999,999,999,999')"연봉"
FROM employee;
----------------------------------------------
--날짜 타입 -> 문자 타입
SELECT SYSDATE, TO_CHAR(SYSDATE)"문자로변환" FROM DUAL; 

SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL; --12 시간제
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; --오전 오후 표시
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; --24시간제

SELECT 
TO_CHAR(SYSDATE, 'HH:MI:SS'),
TO_CHAR(SYSDATE, 'PM HH:MI:SS'),
TO_CHAR(SYSDATE, 'AM HH:MI:SS'),
TO_CHAR(SYSDATE, 'HH24:MI:SS') 
FROM DUAL






