/*
*시퀀스 (SEQUENCE)
: 자동으로 번호를 발생시켜주는 역할을 하는 객체
정수를 순차적으로 일정한 값마다 증가시키면서 생성

EX) 사원번호, 회원번호, 도서번호 
*/
/*
*시퀀스 생성하기

CREATE SEQUENCE 시퀀스명
[START WITH  숫자] --> 처음 발생 시킬 지점 [생략시 기본 값은 1]
[INCREAMENT BY 숫자] --> 얼마만큼씩 증가시킬 것인지에 대한 값 지정[기본값 : 1]
[MAXVALUE 숫자] --> 최대값[기본값.. 업청큼]
[MINVALUE 숫자] --> 최소값 [기본값: 1]
[CYCLE | NOCYCLE] --> 값의 순환여부 [기본값 : NOCYCLE]
                  --> CYCLE : 시퀀스 값이 최대값에 도달하면 최소값으로 다시 순환하도록 설정
                 --> NOCYCLE : 시퀀스 값이 최대값에 도달하면 다이상 증가하지 않도록 설정
[NOCACHE | CACHE 숫자] --> 캐시메모리 할당여부 [기본값 : CACHE]
                      --> 캐시메모리 : 미리 발생할 값들을 생성해서 저장해 두는 공간
                                  매번 호출할 때마다 새로 번호를 생성하는 것이 아닌 
                                  캐시메모리라는 공간에 미리 생성된 값들을 가져다가 사용(속도가 빠르다)
참고
-이름 지어주기-
*테이블 : TB
*뷰 : VW
*시퀀스 : SEQ
*트리거 : TRG
*/
-- SEQ_TEST 라는 시퀀스 생성
CREATE SEQUENCE SEQ_TEST;
--*현재 계정이 가지고 있는 시퀀스를 조회
SELECT * FROM USER_SEQUENCES;

SELECT * FROM EMPLOYEE;
--SEQ_EMPNO 라는 이름의 시퀀스 생성
--시작번호를 300 , 증가값 5 최대값 310, 순환X 캐시메모리X
CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
시퀀스 사용하기

-시퀀스.CURRVAL : 현재 시퀀스 값(마지막으로 성공한 NEXTVAL의 수행한 값)
-시퀀스명.NEXTVAL : 시퀀스 값에 일정한 값을 증가시켜 발생한 결과값
                    현재 시퀀스 값에서 INCREMENT BY 설정된 값만큼 증가죈 값
                    
*/
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --오류 발생 NEXTVAL을 한번도 수행하지 않은 이상 CURRVAL는 사용할 수 없다

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 생성 후 처음 수행 시 시작 값 : 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 310

SELECT * FROM USER_SEQUENCES;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 315 ==>최대값이 310으로 되어 있어 그 이상의 값이 조회되므로 오류발생

/*
시퀀스 구조 변경하기
ALTER SEQUENCE 시퀀스명 
[INCREAMENT BY 숫자]--> 증가값 (기본값 : 1)
[MAXVALUE 숫자] --> 최댓값 [기본값 : 엄청 크다]
[MINVALUE 숫자] --> 최소값 [기본값: 1]
[CYCLE | NOCYCLE] --> 값의 순환여부 [기본값 : NOCYCLE]
[NOCACHE | CACHE 숫자] --> 캐시 메모리 사용여부, 숫자 (바이트 단위) (기본값 : CACHE 20)

=> START WITH 변경불가!
*/
-- SEQ_EMPNO 시퀀스의 증가값을 10, 최대값을 400으로 변경
ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10 
MAXVALUE 400;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 320.(310+10)

--시퀀스 삭제 : DROP SEQUENCE 시퀀스명;
--SEQ_EMPNO 시퀀스 삭제
DROP SEQUENCE SEQ_EMPNO;
SELECT * FROM USER_SEQUENCES;
--------------------------------------------------------------------------------
/*
EMPLOYEE 테이블에 시퀀스 적용
-> 시퀀스 사용 컬럼 : 사원번호 (EMP ID)
*/
--*시퀀스 생성하기
CREATE SEQUENCE SEQ_EID
START WITH 300   --시작번호 300
NOCACHE; -- 캐시메모리 X

--시작값: 300, 증가값 : 1, ......... 순환여부: NOCYCLE, 최대값 : 엄청 큼
--시퀀스 사용하기 : EMPLOYEE 테이블에 데이터가 추가될때
INSERT INTO employee (emp_id, emp_name, emp_no, JOB_code, hire_date)
VALUES (SEQ_EID.NEXTVAL, '최원탁', '931015-1111111', 'J4', SYSDATE);

SELECT * FROM USER_SEQUENCES;

INSERT INTO employee (emp_id, emp_name, emp_no, JOB_code, hire_date)
VALUES (SEQ_EID.NEXTVAL, '조건웅', '990928-1111111', 'J4', SYSDATE);

ROLLBACK;
--------------------------------------------------------------------------------






















