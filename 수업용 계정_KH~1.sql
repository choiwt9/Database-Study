SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL; --12 시간제
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; --오전 오후 표시
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; --24시간제

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
-- DAY : 요일정보 (X 요일)
--DY : 요일 정보 (X) -> '일' '월' '화' '수' .........'토'

SELECT TO_CHAR(SYSDATE, 'MON') FROM DUAL;
--MON, MONTH :월 정보 (X월)

--사원 테이블에서 사원명 입사 날짜 조회 (XXXX년 XX월 XX일 로 조회)
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') 
FROM EMPLOYEE;
--=> 표시할 문자(글자)는 큰따옴표("")로 묶어서 형식에 제시해야함!
/*
*YYYY : 연도를 네자리로 표현--> 50년 이후 날짜는 2000년대로 인식 => 205X
 YY:  연도를 두자리로 표현
 RRRR: 연도를 네자리로 표현 --> 50년 이상 값은 --> 195X
 RR: 연도를 두자리로 표현 
*/

/*
*월과 관련된 포맷
*MM 월 정보를 2자리로 표현
MOM /MONTH : 월 정보를 'X월' 'JULY'형식으로 표현-> 언어 설정에 따라 다를것임!
*/

SELECT TO_CHAR(SYSDATE,'MM')"두자리 표현" ,
TO_CHAR(SYSDATE,'MON'),
TO_CHAR(SYSDATE,'MONTH')
FROM DUAL;

/*
일과 관련된 포맷 
*DD : 일 정보를 2자리로 표현
 DDD : 해당 날짜의 당 해 기준 몇번째 일수
 D : 요일 정보 => 숫자타입(1: 일요일....7. 토요일)
 DAY : "X요일"
 DY : "X" 표시
*/
SELECT TO_CHAR(SYSDATE, 'DD')"일 정보", 
TO_CHAR(SYSDATE, 'DDD')"몇번째 일수",
TO_CHAR(SYSDATE, 'D')"요일 정보",
TO_CHAR(SYSDATE, 'DAY'),
TO_CHAR(SYSDATE, 'DY')
FROM DUAL;
-----------------------------------------
/*
*TO_DATE : 숫자 타입이나 문자타입을 날짜 타입으로 변경

[표현법]
TO_DATE(숫자|문자[,포맷]) => 날짜타입
*/

SELECT TO_DATE(20240719) FROM DUAL;
SELECT TO_DATE(240719) FROM DUAL;  --> 자동으로 50년 미만은 20XX로 설정
SELECT TO_DATE(880719) FROM DUAL; --> 자동으로 50년 이상은 19XX로 설정
SELECT TO_DATE(020222) FROM DUAL; --> 숫자는 0으로 시작하면 안됨! 
SELECT TO_DATE('020222') FROM DUAL; --> 0으로 시작되는 경우 문자타입으로 제시

SELECT TO_DATE('20240719 104900') FROM DUAL; --> 이경우 형식을 지정해야 함
SELECT TO_DATE('20240719 104900', 'YYYYMMDD HH24MISS') FROM DUAL;

---------------------------------------------

/*
TO_NUMBER :문자 타입의 데이터를 숫자타입으로 변경
[표현법]
TO_NUMBER(문자[,포맷]) : 문자에 대한 포맷을 지정 (기호가 포함되거나 화폐단위 포함되는 경우...)
*/

SELECT TO_NUMBER('0123456789')FROM DUAL;

SELECT '10000' + '500' FROM DUAL; -- 자동으로 문자-->숫자 타입으로 변환되어 산술연산 수행됨
SELECT '10,000' + '500' FROM DUAL;
SELECT TO_NUMBER('10,000', '99,999') + TO_NUMBER('500', '999') FROM DUAL;
--==============================================================

/*
NULL 처리 함수 
*/
/*
*NVL : 해당 컬럼의 값이 NULL일 경우 다른 값으로 사용할 수 있도록 변환해주는 함수

[표현법]
 NVL(컬럼, 해당 컬럼의 값이 NULL일 경우 사용할 값)
*/
-- 사원 테이블의 값이 NULL 인경우 0으로 조회

SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

--사원 테블에서 사원명 보너스 포함 연봉 조회
SELECT EMP_NAME,NVL(BONUS,0), SALARY*12, (SALARY + (SALARY*NVL(BONUS,0)))*12
FROM EMPLOYEE;

/*
NVL2 : 해당 컬럼이 NULL일 경우 표시할 값을 지정허고
                 NULL이 아닐 경우 (데이터가 존재하는 경우)표시할 값을 지정
                 
[표현법]
NVL2(컬럼, 데이터가 존재할 경우 사용할 값, NULL인 경우 사용할 값)
*/
--사원명, 보너스 유무 (O,X) 조회
SELECT EMP_NAME, NVL2(BONUS, 'O','X')"보너스 유무"
FROM employee;

--사원명, 부서코드, 부서 배치 여부('배정완료, 미배정)조회
SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '배정완료','미배정')"부서 배치 여부"
FROM employee;

--NULLIF : 두 값이 일치하면 NULL, 일치하지 않으면 비교대상1반환
--[ 표현법 ] NULLIF(비교대상1, 비교대상2)

SELECT NULLIF('999', '999') FROM DUAL;
SELECT NULLIF('999', '555') FROM DUAL;
--====================================================








