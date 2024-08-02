/*
DCL(Data Control Language) : 데이터 제어 언어

=> 계정에 시스템 권한/객체접근권한을 부여하거나 회수하는 구문

-시스템 권한 : db에 접근하는 권한, 객체를 생성할 수 있는 권한
-객체 접근 권한 : 특정 객체들을 조작할 수 있는 권한
*/
/*
계정 생성 
creat user 계정명 idendified by 비밀번호;

grant 권한(connect ,resource) to 계정명

시스템 권한 종류
-create session : 접속 권한
-create table : 테이블 생성 권한
-create view : 뷰 생선 권한
-create sequence : 시퀀스 생성 권한
...

객체 접근 권한 종류

종류     | 접근 객체
select  | table, view, sequence  --조회
insert  | table, view            --추가
update  | table, view            --수정
delete  | table, view            --삭제

grant 권한 종류 on 특정객체 to 계정명;
ex) grant select on kh.employee to test;
--> test계정의 kh계정의 employee 테이블을 조회할 수 있는 권한을 부여

권한 회수
revoke 회수할 권한 from 계정명
ex)revoke select on kh.employee from test
--> test 계정에 부여했던 kh계정의 employee테이블을 조회할 수 있는 권한을 회수
*/
/*
role(롤, 규칙) : 특정권한들을 하나의 집합으로 모아놓은 것

-connect : 접속권한 (create session)
-resource : 지원관리(특정 객체 생성 권한)(create table, create view)
*/
--롤 정보조회

select * from role_sys_privs 
where role in ('connect', 'resource');
-----------------------------------------------------------------------------------
/*
TCL(Transaction Control Language)

*트랜잭션 : 데이터베이스의 논리적 연산단위
           데이터 변경사항(dml 사용시)들을 하나의 묶음처럼 트랜잭션에 모아둠
트랜잭션 종류
-commit : 트랜잭션에 담겨져 있는 변경 사항들을 실제 db에 적용하겠다를 의미
-rollback : 트랜잭션에 담겨 있는 변경사항들을 삭제하고 
            마지막 commit으로 돌아감을 의미
--savepoint : 현재 시점에 변경사항들을 임시로 저장해 두는 것을 의미
              ROLLBACK 시 변경 사항을 모두 삭제하지 않고 해당 위치까지만 취소가 가능
*/
--EMP01테이블 삭제
DROP TABLE EMP01; --> DDL 트랜잭션 처리 X.

--EMP01 테이블을 생성 (EMPLOYEE 사번, 사원명, 부서명 조회)
CREATE TABLE EMP01
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID);

SELECT * FROM EMP01;

--사번이 217 214 인 사원 삭제 --> DML.트랜잭션 처리 O.
DELETE FROM EMP01
WHERE EMP_ID IN(217, 214);

ROLLBACK; -- 변경사항 취소(트랜잭션 삭제)
----------------------------------------------------------------------------------
DELETE FROM EMP01 WHERE EMP_ID = 217;
DELETE FROM EMP01 WHERE EMP_ID = 214;

COMMIT;  --변경사항 적용 (DB에 변경사항 적용)
ROLLBACK; --마지막 COMMIT 시점으로 돌아감 (217, 214 사원이 삭제된 시점)
--------------------------------------------------------------------------------
--208,209, 210번 사원삭제
DELETE FROM EMP01
WHERE emp_ID IN (208,209,210);

SELECT * FROM EMP01;

SAVEPOINT SP;
--500번 사원 추가
INSERT INTO EMP01 VALUES (500, '카리나', '해외영업2부');

--215번 사원 삭제
DELETE FROM EMP01
WHERE emp_ID = 215;
-- SP시점으로 롤백
ROLLBACK TO SP;
COMMIT;  --SP시점으로 돌아간 뒤 COMMIT을 했기 때문에 DELETE 208, 209, 210만 DB에 적용
--------------------------------------------------------------------------------
SELECT * FROM EMP01;
--221번 사원 삭제
DELETE FROM EMP01 WHERE EMP_ID = 221;

--DDL문 사용
CREATE TABLE TEST(
TID NUMBER
);
SELECT * FROM TEST;
ROLLBACK; 

--> DDL문(CREATE, ALTER, DROP)을 사용하게 되면 기존 트랜잭션에 저장된 변경사항들이 무조건 반영
-- DDL문 사용전 DML로 사용된 쿼리들이 있다면 확실하게 처리(COMMIT/ROLLBACK)한 뒤에 DDL을 사용해야 함







