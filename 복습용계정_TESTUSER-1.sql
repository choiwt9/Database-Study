-- 다음 사용자 계정 접속 후 아래 내용을 작성해주세요.
-- ID/PW  :  C##TESTUSER / 1234
create user C##TESTUSER identified by "1234";
grant connect, resource to C##TESTUSER;
-- 아래 내용을 추가하기 위한 테이블을 생성해주세요.
-- 각 컬럼별 설명을 추가해주세요.
--=========================================================
/*
	- 학생 정보 테이블 : STUDENT
	- 제약 조건
	  - 학생 이름, 생년월일은 NULL값을 허용하지 않는다.
	  - 이메일은 중복을 허용하지 않는다.
	- 저장 데이터
		+ 학생 번호 ex) 1, 2, 3, ...
		+ 학생 이름 ex) '김말똥', '아무개', ...
		+ 이메일    ex) 'kim12@kh.or.kr', 'dogdog@kh.or.kr', ...
		+ 생년월일  ex) '24/07/25', '00/02/20', '88/12/25', ...
*/
create TABLE student(
student_no number,
student_name VARCHAR2(100) not null,
email VARCHAR2(100) unique,
birthday  VARCHAR2(100) not null
);

COMMENt on column student.student_no is '학생번호';
comment on column student.student_name is '학생이름';
comment on column student.email is '이메일';
comment on column student.birthday is '생년월일';
select*from student;

insert into student
values(1, '김말똥', 'kim12@kh.or.kr','24/07/25');

insert into student
values(2, null, 'dogdog@kh.or.kr','00/02/20');

insert into student
values(3, '최원탁', 'kim12@kh.or.kr','93/10/15');


------------------------------------------------------------
/*
	- 도서 정보 테이블 : BOOK
	- 제약 조건
	  - 제목과 저자명은 NULL값을 허용하지 않는다.
	  - ISBN 번호는 중복을 허용하지 않는다.
	- 저장 데이터
	  + 도서 번호 ex) 1, 2, 3, ...
	  + 제목 ex) '삼국지', '어린왕자', '코스모스', ...
	  + 저자 ex) '지연', '생텍쥐페리', '칼 세이건', ...
	  + 출판일 ex) '14/02/14', '22/09/19', ...
	  + ISBN번호 ex) '9780394502946', '9780152048044', ...
*/
create TABLE book (
bk_no number,
bk_title VARCHAR2(200) not null,
bk_author VARCHAR2(200) not null,
pub_date date,
ISBN VARCHAR2(20) CONSTRAINT ISBN_UQ UNIQUE
);

COMMENT ON COLUMN book.bk_no IS '도서번호';
COMMENT ON COLUMN book.bk_title IS '도서제목';
COMMENT ON COLUMN book.bk_author IS '저자명';
COMMENT ON COLUMN book.pub_date IS '출판일';
COMMENT ON COLUMN book.ISBN IS '일련번호(ISBN)';

INSERT INTO BOOK
VALUES(1, '어린왕자', '생텍쥐페리', '14/02/14', '9780394502946');

INSERT INTO BOOK
VALUES(2, '어린왕자2', '생텍쥐페리', '24/02/14', '9780394502946');
--UNIQUE 제약에 위배
--COMMIT; 데이터 저장
--ROLLBACK; 데이터 저장하지 않음
------------------------------------------------------------
/*
CHECK(조건식) : 해당 컬럼에 저장할 수 있는 값에 대한 조건을 제시
              조건에 만족하는 값만을 저장하고자 할때 사용
            => 정해진 값만을 저장하고자할 때 사용
*/
-- 성별에 대ㄹ한 데이터 저장 시 '남', '여'  값 저장
CREATE TABLE MEMBER_CHECK(
MEM_NO NUMBER NOT NULL,
MEM_ID VARCHAR2(20) NOT NULL,
MEM_PWD VARCHAR2(20) NOT NULL,
MEM_NAME VARCHAR2(20) NOT NULL,
GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
PHONE CHAR(13),
EMAIL VARCHAR2(50),
JOIN_DATE DATE

, UNIQUE (MEM_ID)

);

SELECT*FROM MEMBER_CHECK;

INSERT INTO MEMBER_CHECK
VALUES(1, 'HONG', '1234', '홍길동', '남', NULL, NULL, SYSDATE);
-- GERDER 컬럼이 체크 제약 조건 위배

INSERT INTO MEMBER_CHECK
VALUES(2, 'WAN00', '1234', '허완', '남', NULL, NULL, NULL);

INSERT INTO MEMBER_CHECK
VALUES(2, 'WAN00', '1234', '허완', 'SSS', NULL, NULL, NULL);
-- 체크 조건에 맞는 값만 가능

INSERT INTO MEMBER_CHECK
VALUES(3, 'SEOEUN02', '1234', '최서은', NULL, NULL, NULL, SYSDATE);
--> GENDER 컬럼에 NULL값을 저장했음
--> NULL값을 허용하지 않고자 한다면 NOT NULL을 추가해야 한다
--------------------------------------------------------------
/*
 PRIMARY KEW(기본기)
 :테이블에서 각행을 식별하기 위해 사용되는 칼럼에 부여하는 제약 조건
 
 EX)회원번호, 학번, 제품코드, 주문번호 , 예약번호
 
  PRIMARY KEW => NOT NULL + UNIQUE
  
  * 주의 : 테이블 당 오직 한개만 설정 가능
*/

CREATE TABLE MEMBER_PRI(
MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
MEM_ID VARCHAR2(20) NOT NULL,
MEM_PWD VARCHAR2(20) NOT NULL,
MEM_NAME VARCHAR2(20) NOT NULL,
GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
PHONE CHAR(13),
EMAIL VARCHAR2(50),
JOIN_DATE DATE

, UNIQUE (MEM_ID)
);

INSERT INTO MEMBER_PRI
VALUES (1,'JY999', '1234', '최재영', '남', NULL, NULL, SYSDATE);

INSERT INTO MEMBER_PRI
VALUES (1,'JY333', '1234', '이요셉', '남', NULL, NULL, SYSDATE);
-- 기본키에 중복된 값을 저장하려고 할때 제약 조건 위배됨 (=> UNIQUE 제약조건 위배)
INSERT INTO MEMBER_PRI
VALUES (1,'EY777', '1234', '정은유', '남', NULL, NULL, SYSDATE);
--기본키에 NULL 값을 저장하려고 할때 제약 조건 위배됨(=> NOT NULL 제약조건 위배)

INSERT INTO MEMBER_PRI
VALUES (2,'JY333', '1234', '이요셉', '남', NULL, NULL, SYSDATE);
DROP TABLE MEMBER_PRI;

INSERT INTO MEMBER_PRI
VALUES (3,'EY777', '1234', '정은유', '남', NULL, NULL, SYSDATE);
---------------------------------------------------------
-- 회원번호(MEM_NO), 회원아이디를 기본키로 가지는 테이블 생성
CREATE TABLE MEMBER_PRI2(
MEM_NO NUMBER,
MEM_ID VARCHAR2(20) NOT NULL,
MEM_PWD VARCHAR2(20) NOT NULL,
MEM_NAME VARCHAR2(20) NOT NULL,
GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
PHONE CHAR(13),
EMAIL VARCHAR2(50),
JOIN_DATE DATE,

 UNIQUE (MEM_ID),
 CONSTRAINT MEMPRI12_PK PRIMARY KEY(MEM_NO,MEM_ID )
);
-->복합키 : 두개의 컬럼을 동시에 하나의 키로 지정

INSERT INTO MEMBER_PRI2 
VALUES(1, 'JG555', '1234', '최종군', '남', NULL, NULL, SYSDATE);

INSERT INTO MEMBER_PRI2 
VALUES(1, 'HY666', '1234', '엄희윤', '남', NULL, NULL, SYSDATE);
--=>회원번호는 동일하지만 회원아이디가 달라 추가가 됨

CREATE TABLE MEMBER_LIKE(
MEM_NO NUMBER,
PRODUCT_NAME VARCHAR2(50),
LIKE_DATE DATE,

PRIMARY KEY( MEM_NO, PRODUCT_NAME)
);

INSERT INTO MEMBER_LIKE
VALUES(1, '라디오', '24/07/24');

INSERT INTO MEMBER_LIKE
VALUES(1, '아메리카노', '24/07/25');

SELECT * FROM MEMBER_LIKE;

INSERT INTO MEMBER_LIKE
VALUES(2, '고양이 사료', '24/07/14');

INSERT INTO MEMBER_LIKE
VALUES(2, '고양이 모래', '24/07/15');

INSERT INTO MEMBER_LIKE
VALUES(2, '아메리카노', '24/07/25');

INSERT INTO MEMBER_LIKE
VALUES(3, '삼계탕', '24/07/25');

SELECT MEM_NAME, PRODUCT_NAME
FROM MEMBER_PRI2 
JOIN MEMBER_LIKE USING (MEM_NO);

-------------------------------------------------------------------
/*
FORIGHN KEY(외래키)
: 다른 테이블에 존재하는 값을 저장하고자 할 때 사용되는 제약조건
->다른 테이블을 참조한다고 표현
->주로 외래카를 통해 테이블간의 관계가 형성

-컬럼레벨방식
컬럼별 자료형 REPERENCES 참조할 테이블명{(참조할 컬럼명)}

- 테이블레벨방식
FORIGHN KEY(컬럼명) REPERENCES 참조할 테이블명{(참조할 컬럼명)}

=> 참조할 컬럼명을 생략할 경우 참조하는 테이블의 기본키 컬럼이 매칭됨
*/

--MEMBER 테이블 삭제

DROP TABLE MEMBER;

CREATE TABLE MEMBER_GRADE(
GRADE_NO NUMBER PRIMARY KEY,
GRADE_NAME VARCHAR(20) NOT NULL
);

INSERT INTO MEMBER_GRADE VALUES(100, '일반회원');
INSERT INTO MEMBER_GRADE VALUES(200, 'VIP회원');
INSERT INTO MEMBER_GRADE VALUES(300, 'VVIP회원');

CREATE TABLE MEMBER(
MEM_NO NUMBER PRIMARY KEY,
MEM_ID VARCHAR(20) NOT NULL UNIQUE,
MEM_PWD VARCHAR2(20) NOT NULL,
MEM_NAME VARCHAR2(20) NOT NULL,
GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
JOIN_DATE DATE,
MEM_GRADEID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO)-- 컬럼레벨방식

--,FOREIGN KEY(MEM_GRADEID)  REFERENCES MEMBER_GRADE(GRADE_NO) -- 테이블레벨방식
);

INSERT INTO MEMBER
VALUES (1, 'whdrns456', '0780', '최종군', '남', sysdate, 100);

INSERT INTO MEMBER
VALUES (2, 'jgw0928', '0780', '조건웅', '남', sysdate, 200);

INSERT INTO MEMBER
VALUES (3, 'hh00', 'qwer', '임현호', '남', sysdate, null);
--> 외래키로 설정된 컬럼에는 기본적으로 null값은 저장 가능
INSERT INTO MEMBER
VALUES (4, 'jw33', '0987', '이주원', '여', sysdate, 400);
--> 부모키를 찾을 수 없다. -->회원등급 테이블에 저장되지 않은 값을 사용!
--member_grade (부모테이블)-|------------<=member(자식 테이블)
--1:N 괸계 1 (부모테이블:MEMBER_GRADE) N (자식 테이블:MEMBER)
select*from member_GRADE;
select*from member;

--> 부모테이블 에서 데이터를 하나 삭제한다면?
--데이터 삭제 : DELETE FROM 테이블명 WHERE 조건;

--member_GRADE테이블에서 100번에 해당하는 등급데이터 삭제
DELETE FROM MEMBER_GRADE
WHERE GRADE_NO = 100;
--자식 테이블에서 100이라는 값을 사용하고 있기 때문에 삭제 불가

DELETE FROM MEMBER_GRADE
WHERE GRADE_NO = 300;
--자식 테이블에서 300이라는 값을 사용하지 않고 있기 때문에 삭제 가능

--자식테이블에서 이미 사용하고 있는 값이 있을 경우
--부모테이블로부터 무조건 삭제가 되지 않는 "삭제옵션"이 있다

ROLLBACK;      --데이터 변경사항을 원래대로 돌려 놓는 것
-------------------------------------------------------------
/*
외래키 제약조건 삭제 옵션
:부모테이블의 데이터 삭제시 해당 데이터를 사용하고 있는 자식테이블의 값을 어떻게 할 것인지에 대한 옵션
-(기본값) ON DELETE RESTRICTED: 자식데이터로부터 사용중인 값이 있으면 부모테이블에서 삭제 불가
-ON DELETE SET NULL : 부모테이블에 있는 데이터 삭제 시 해당 데이터를 사용중인 자식 테이블의 값을 NULL로 변경
- ON DELETE CASCADE : 부모테이블에 있는 데이터 삭제 시 해당 데이터를 사용 중인 자식 테이블 값도 삭제
*/

DROP TABLE MEMBER;

CREATE TABLE MEMBER(
MEM_NO NUMBER PRIMARY KEY,
MEM_ID VARCHAR(20) NOT NULL UNIQUE,
MEM_PWD VARCHAR2(20) NOT NULL,
MEM_NAME VARCHAR2(20) NOT NULL,
GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
JOIN_DATE DATE,
MEM_GRADEID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO)

);

INSERT INTO MEMBER
VALUES (1, 'whdrns456', '0780', '최종군', '남', sysdate, 100);

INSERT INTO MEMBER
VALUES (2, 'jgw0928', '0780', '조건웅', '남', sysdate, 200);

INSERT INTO MEMBER
VALUES (3, 'hh00', 'qwer', '임현호', '남', sysdate, null);

SELECT*FROM MEMBER;

DELETE FROM MEMBER_GRADE
WHERE GRADE_NO = 100;
--자식 테이블에서 100번 등급이 사용된 데이터가  NULL로 변경되면서
--부모테이블에서는 데이터가 잘 삭제됨

ROLLBACK;
--------------
DROP TABLE MEMBER;

CREATE TABLE MEMBER(
MEM_NO NUMBER PRIMARY KEY,
MEM_ID VARCHAR(20) NOT NULL UNIQUE,
MEM_PWD VARCHAR2(20) NOT NULL,
MEM_NAME VARCHAR2(20) NOT NULL,
GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
JOIN_DATE DATE,
MEM_GRADEID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE SET NULL

);

INSERT INTO MEMBER
VALUES (1, 'whdrns456', '0780', '최종군', '남', sysdate, 100);

INSERT INTO MEMBER
VALUES (2, 'jgw0928', '0780', '조건웅', '남', sysdate, 200);

INSERT INTO MEMBER
VALUES (3, 'hh00', 'qwer', '임현호', '남', sysdate, null);

DELETE FROM MEMBER
WHERE GRADE_NO = 100;
--자식 테이블에서 100번이 사용된 행 자체가 삭제되었었음
SELECT*FROM MEMBER_GRADE;
SELECT*FROM MEMBER;
-----------------------------------------------
/*
DEFAULT 
: 제약조건은 아님..
컬럼을 선정하지 않고 데이터 추가 시 NULL값이 아닌 기본적인 값을 저장하고자 할때
*/

DROP TABLE MEMBER;
