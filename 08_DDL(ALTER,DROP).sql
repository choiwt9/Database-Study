/*
DDL : 데이터 정의언어

객체 생성(CREATE), 변경(ALTER), 삭제(DROP)하는 구문
*/
/*
ALTER : 객체를 변경하는 구문

ALTER TABLE 테이블명 변경할 내용
*변경되는 내용
-제약조건 추가/수정(삭제 후 추가)/삭제
-컬럼명/제약조건 이름/테이블명 변경
-컬럼 추가/ 수정/ 삭제
*/
/*
컬럼 추가/수정/삭제
-컬럼 추가 : ALTER TABLE 테이블명 ADD 컬럼명 자료형[기본값|제약조건];
*/
--DEPT_TABLE 테이블에 CNAME:VARCHAR2(20) 컬럼 추가
ALTER TABLE DEPT_TABLE ADD CNMAE VARCHAR2(20);

SELECT*FROM DEPT_TABLE;

ALTER TABLE DEPT_TABLE ADD LNAME VARCHAR2(20) DEFAULT '한국';

/*
컬럼 수정 (MODIFY)
-데이터 타입 수정 : ALTER TABLE 테이블명 MODIFY 컬럼명 변경할 데이터 타입
-기본값 수정 : ALTER TABLE 테이블명 MODIFY 컬럼명 DEFAULT 변경할 기본값
*/

--DEEP_TABLE 테이블의 DEPT_ID컬럼을 변경
--크기를 2바이트 -> 5바이트로 변경
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID CHAR(5);
-- 숫자타입으로 변경
--ALTER TABLE DEPT_TABLE MODIFY DEPT_ID NUMBER;
--> 형식오류 발생

--DEPT_TABLE 테이블의 DEPT_TITLE 컬럼을 변경
-- * 크기를 35 바이트 -> 10바이트로 변경
--ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(10);--> 크기오류 발생!

-- * 크기를 35 바이트 -> 50바이트로 변경
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(50);
--EMP_TABLE 테이블의 SALARY 컬럼을 NUMBER -> VARCHAR2(50)으로 변경
--ALTER TABLE EMP_TABLE MODIFY SALARY VARCHAR2(50);

--여러개의 컬럼 변경 가능!
ALTER TABLE DEPT_TABLE 
MODIFY DEPT_TITLE VARCHAR2(55)
MODIFY LNAME DEFAULT '코리아';
/*
컬럼 삭제 : DROP COLUMN

ALTER TABLE 테이블 명 DROP COLUMN 컬럼명
*/
--DEPT_TABLE DEPT_COPY\
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPT_TABLE;

SELECT*FROM dept_copy;

ALTER TABLE DEPT_COPY DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY DROP COLUMN CNMAE;
ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_ID; --오류발생
-->테이블에 최소한 한개의 컬럼은 존재해야 함
-----------------------------------------------------
--제약조건 추가/삭제/수정
/*
기본키 (PRIMARY KEY): ALTER TABLE 테이블명 ADD PRIMARY KEY (컬럼명)
외래키 (FOREIGN KEY): ALTER TABLE 테이블명 ADD FOREIGN KEY (컬럼명) REFERENCES 참조 테이블명[(참조할 칼럼명)]
*UNIQUE(중복을 허용하지 않는 제약 조건) ALTER TABLE 테이블명 ADD UNIQUE(컬럼명)
*CHECK(특정 값들만 저장하고자 할때 사용하는 제약 조건, NULL값 가능): ALTER TABLE 테이블명 ADD CHECK (컬럼에 대한 조건식)
*NOT NULL(NULL값을 허용하지 않는 제약 조건) : ALTER TABLE 테이블명 MODIFY 컬럼명
*/
--DEPT_TABLE 테이블에 아래 제약 조건을 추가
-- DEPT_ID컬럼에 PK(기본기) 제약 조건 추가
-- DEPT_TITLE 컬럼에 UNIQUE 제약조건 추가
--LNAME컬럼에 NOT NULL 제약조건 추가
ALTER TABLE DEPT_TABLE
ADD CONSTRAINT DT_PK PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT DT_UQ UNIQUE(DEPT_TITLE)
MODIFY LNAME NOT NULL;

/*
[제약 조건 삭제]
ALTER TABLE 테이블명 DROP CONSTRAINT 제약 조건명 / NOT NULL
ALTER TABLE 테이블명 MODIFY 컬럼명 NULL
*/
ALTER TABLE DEPT_TABLE DROP CONSTRAINT DT_PK;

ALTER TABLE DEPT_TABLE
DROP CONSTRAINT DT_UQ
MODIFY LNAME NULL;

SELECT*FROM DEPT_TABLE;
-------------------------------------------------------
--테이블 삭제
--DROP TABLE 테이블명
DROP TABLE DEPT_TABLE;
--어딘가에 참조되거 있는 부모테이블은 삭제 안됨
--지우고자 할 경우 1)자식 테이블을 삭제 후 부모 테이블을 삭제
--               2)부모테이블만 삭제하는데 제약조건까지 삭제
--                DROP TABLE 테이블명 CASCADE CONSTRAINT
-----------------------------------------------
CREATE TABLE DEPT_TABLE
AS SELECT * FROM department;

/*
컬럼명, 제약조건명 테이블명 변경 (RENAME)
*/ 
--1) 컬럼명 변경 : RENAME COLUMN 기존 컬럼명 TO 바꿀 컬럼명

-- DEPT_TITLE --> DEPT_NAME 변경

ALTER TABLE DEPT_TABLE RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
--2)제약조건명 변경 RENAME CONSTRAINT 기존 제약 조건명 TO바꿀 제약조건명
ALTER TABLE DEPT_TABLE RENAME CONSTRAINT SYS_C008512 TO DT_DEPTID_NN;

--3)테이블명 변경
ALTER TABLE DEPT_TABLE RENAME TO DEPT_END;

ALTER TABLE DEPT_END RENAME TO DEPT_TABLE;
----------------------------------------------------
--TRUNCATE : 테이블 초기화
--=> DROP 과는 다르게 테이블의 데이터를 전부 삭제하여 테이블의 초기상태로 돌려주는 것
SELECT * FROM DEPT_END;
TRUNCATE TABLE DEPT_END;


