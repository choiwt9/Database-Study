-- ���� ����� ���� ���� �� �Ʒ� ������ �ۼ����ּ���.
-- ID/PW  :  C##TESTUSER / 1234
create user C##TESTUSER identified by "1234";
grant connect, resource to C##TESTUSER;
-- �Ʒ� ������ �߰��ϱ� ���� ���̺��� �������ּ���.
-- �� �÷��� ������ �߰����ּ���.
--=========================================================
/*
	- �л� ���� ���̺� : STUDENT
	- ���� ����
	  - �л� �̸�, ��������� NULL���� ������� �ʴ´�.
	  - �̸����� �ߺ��� ������� �ʴ´�.
	- ���� ������
		+ �л� ��ȣ ex) 1, 2, 3, ...
		+ �л� �̸� ex) '�踻��', '�ƹ���', ...
		+ �̸���    ex) 'kim12@kh.or.kr', 'dogdog@kh.or.kr', ...
		+ �������  ex) '24/07/25', '00/02/20', '88/12/25', ...
*/
create TABLE student(
student_no number,
student_name VARCHAR2(100) not null,
email VARCHAR2(100) unique,
birthday  VARCHAR2(100) not null
);

COMMENt on column student.student_no is '�л���ȣ';
comment on column student.student_name is '�л��̸�';
comment on column student.email is '�̸���';
comment on column student.birthday is '�������';
select*from student;

insert into student
values(1, '�踻��', 'kim12@kh.or.kr','24/07/25');

insert into student
values(2, null, 'dogdog@kh.or.kr','00/02/20');

insert into student
values(3, '�ֿ�Ź', 'kim12@kh.or.kr','93/10/15');


------------------------------------------------------------
/*
	- ���� ���� ���̺� : BOOK
	- ���� ����
	  - ����� ���ڸ��� NULL���� ������� �ʴ´�.
	  - ISBN ��ȣ�� �ߺ��� ������� �ʴ´�.
	- ���� ������
	  + ���� ��ȣ ex) 1, 2, 3, ...
	  + ���� ex) '�ﱹ��', '�����', '�ڽ���', ...
	  + ���� ex) '����', '�������丮', 'Į ���̰�', ...
	  + ������ ex) '14/02/14', '22/09/19', ...
	  + ISBN��ȣ ex) '9780394502946', '9780152048044', ...
*/
create TABLE book (
bk_no number,
bk_title VARCHAR2(200) not null,
bk_author VARCHAR2(200) not null,
pub_date date,
ISBN VARCHAR2(20) CONSTRAINT ISBN_UQ UNIQUE
);

COMMENT ON COLUMN book.bk_no IS '������ȣ';
COMMENT ON COLUMN book.bk_title IS '��������';
COMMENT ON COLUMN book.bk_author IS '���ڸ�';
COMMENT ON COLUMN book.pub_date IS '������';
COMMENT ON COLUMN book.ISBN IS '�Ϸù�ȣ(ISBN)';

INSERT INTO BOOK
VALUES(1, '�����', '�������丮', '14/02/14', '9780394502946');

INSERT INTO BOOK
VALUES(2, '�����2', '�������丮', '24/02/14', '9780394502946');
--UNIQUE ���࿡ ����
--COMMIT; ������ ����
--ROLLBACK; ������ �������� ����
------------------------------------------------------------
/*
CHECK(���ǽ�) : �ش� �÷��� ������ �� �ִ� ���� ���� ������ ����
              ���ǿ� �����ϴ� ������ �����ϰ��� �Ҷ� ���
            => ������ ������ �����ϰ����� �� ���
*/
-- ������ �뤩�� ������ ���� �� '��', '��'  �� ����
CREATE TABLE MEMBER_CHECK(
MEM_NO NUMBER NOT NULL,
MEM_ID VARCHAR2(20) NOT NULL,
MEM_PWD VARCHAR2(20) NOT NULL,
MEM_NAME VARCHAR2(20) NOT NULL,
GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
PHONE CHAR(13),
EMAIL VARCHAR2(50),
JOIN_DATE DATE

, UNIQUE (MEM_ID)

);

SELECT*FROM MEMBER_CHECK;

INSERT INTO MEMBER_CHECK
VALUES(1, 'HONG', '1234', 'ȫ�浿', '��', NULL, NULL, SYSDATE);
-- GERDER �÷��� üũ ���� ���� ����

INSERT INTO MEMBER_CHECK
VALUES(2, 'WAN00', '1234', '���', '��', NULL, NULL, NULL);

INSERT INTO MEMBER_CHECK
VALUES(2, 'WAN00', '1234', '���', 'SSS', NULL, NULL, NULL);
-- üũ ���ǿ� �´� ���� ����

INSERT INTO MEMBER_CHECK
VALUES(3, 'SEOEUN02', '1234', '�ּ���', NULL, NULL, NULL, SYSDATE);
--> GENDER �÷��� NULL���� ��������
--> NULL���� ������� �ʰ��� �Ѵٸ� NOT NULL�� �߰��ؾ� �Ѵ�
--------------------------------------------------------------
/*
 PRIMARY KEW(�⺻��)
 :���̺��� ������ �ĺ��ϱ� ���� ���Ǵ� Į���� �ο��ϴ� ���� ����
 
 EX)ȸ����ȣ, �й�, ��ǰ�ڵ�, �ֹ���ȣ , �����ȣ
 
  PRIMARY KEW => NOT NULL + UNIQUE
  
  * ���� : ���̺� �� ���� �Ѱ��� ���� ����
*/

CREATE TABLE MEMBER_PRI(
MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
MEM_ID VARCHAR2(20) NOT NULL,
MEM_PWD VARCHAR2(20) NOT NULL,
MEM_NAME VARCHAR2(20) NOT NULL,
GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
PHONE CHAR(13),
EMAIL VARCHAR2(50),
JOIN_DATE DATE

, UNIQUE (MEM_ID)
);

INSERT INTO MEMBER_PRI
VALUES (1,'JY999', '1234', '���翵', '��', NULL, NULL, SYSDATE);

INSERT INTO MEMBER_PRI
VALUES (1,'JY333', '1234', '�̿��', '��', NULL, NULL, SYSDATE);
-- �⺻Ű�� �ߺ��� ���� �����Ϸ��� �Ҷ� ���� ���� ����� (=> UNIQUE �������� ����)
INSERT INTO MEMBER_PRI
VALUES (1,'EY777', '1234', '������', '��', NULL, NULL, SYSDATE);
--�⺻Ű�� NULL ���� �����Ϸ��� �Ҷ� ���� ���� �����(=> NOT NULL �������� ����)

INSERT INTO MEMBER_PRI
VALUES (2,'JY333', '1234', '�̿��', '��', NULL, NULL, SYSDATE);
DROP TABLE MEMBER_PRI;

INSERT INTO MEMBER_PRI
VALUES (3,'EY777', '1234', '������', '��', NULL, NULL, SYSDATE);
---------------------------------------------------------
-- ȸ����ȣ(MEM_NO), ȸ�����̵� �⺻Ű�� ������ ���̺� ����
CREATE TABLE MEMBER_PRI2(
MEM_NO NUMBER,
MEM_ID VARCHAR2(20) NOT NULL,
MEM_PWD VARCHAR2(20) NOT NULL,
MEM_NAME VARCHAR2(20) NOT NULL,
GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
PHONE CHAR(13),
EMAIL VARCHAR2(50),
JOIN_DATE DATE,

 UNIQUE (MEM_ID),
 CONSTRAINT MEMPRI12_PK PRIMARY KEY(MEM_NO,MEM_ID )
);
-->����Ű : �ΰ��� �÷��� ���ÿ� �ϳ��� Ű�� ����

INSERT INTO MEMBER_PRI2 
VALUES(1, 'JG555', '1234', '������', '��', NULL, NULL, SYSDATE);

INSERT INTO MEMBER_PRI2 
VALUES(1, 'HY666', '1234', '������', '��', NULL, NULL, SYSDATE);
--=>ȸ����ȣ�� ���������� ȸ�����̵� �޶� �߰��� ��

CREATE TABLE MEMBER_LIKE(
MEM_NO NUMBER,
PRODUCT_NAME VARCHAR2(50),
LIKE_DATE DATE,

PRIMARY KEY( MEM_NO, PRODUCT_NAME)
);

INSERT INTO MEMBER_LIKE
VALUES(1, '����', '24/07/24');

INSERT INTO MEMBER_LIKE
VALUES(1, '�Ƹ޸�ī��', '24/07/25');

SELECT * FROM MEMBER_LIKE;

INSERT INTO MEMBER_LIKE
VALUES(2, '����� ���', '24/07/14');

INSERT INTO MEMBER_LIKE
VALUES(2, '����� ��', '24/07/15');

INSERT INTO MEMBER_LIKE
VALUES(2, '�Ƹ޸�ī��', '24/07/25');

INSERT INTO MEMBER_LIKE
VALUES(3, '�����', '24/07/25');

SELECT MEM_NAME, PRODUCT_NAME
FROM MEMBER_PRI2 
JOIN MEMBER_LIKE USING (MEM_NO);

-------------------------------------------------------------------
/*
FORIGHN KEY(�ܷ�Ű)
: �ٸ� ���̺� �����ϴ� ���� �����ϰ��� �� �� ���Ǵ� ��������
->�ٸ� ���̺��� �����Ѵٰ� ǥ��
->�ַ� �ܷ�ī�� ���� ���̺��� ���谡 ����

-�÷��������
�÷��� �ڷ��� REPERENCES ������ ���̺��{(������ �÷���)}

- ���̺������
FORIGHN KEY(�÷���) REPERENCES ������ ���̺��{(������ �÷���)}

=> ������ �÷����� ������ ��� �����ϴ� ���̺��� �⺻Ű �÷��� ��Ī��
*/

--MEMBER ���̺� ����

DROP TABLE MEMBER;

CREATE TABLE MEMBER_GRADE(
GRADE_NO NUMBER PRIMARY KEY,
GRADE_NAME VARCHAR(20) NOT NULL
);

INSERT INTO MEMBER_GRADE VALUES(100, '�Ϲ�ȸ��');
INSERT INTO MEMBER_GRADE VALUES(200, 'VIPȸ��');
INSERT INTO MEMBER_GRADE VALUES(300, 'VVIPȸ��');

CREATE TABLE MEMBER(
MEM_NO NUMBER PRIMARY KEY,
MEM_ID VARCHAR(20) NOT NULL UNIQUE,
MEM_PWD VARCHAR2(20) NOT NULL,
MEM_NAME VARCHAR2(20) NOT NULL,
GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
JOIN_DATE DATE,
MEM_GRADEID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO)-- �÷��������

--,FOREIGN KEY(MEM_GRADEID)  REFERENCES MEMBER_GRADE(GRADE_NO) -- ���̺������
);

INSERT INTO MEMBER
VALUES (1, 'whdrns456', '0780', '������', '��', sysdate, 100);

INSERT INTO MEMBER
VALUES (2, 'jgw0928', '0780', '���ǿ�', '��', sysdate, 200);

INSERT INTO MEMBER
VALUES (3, 'hh00', 'qwer', '����ȣ', '��', sysdate, null);
--> �ܷ�Ű�� ������ �÷����� �⺻������ null���� ���� ����
INSERT INTO MEMBER
VALUES (4, 'jw33', '0987', '���ֿ�', '��', sysdate, 400);
--> �θ�Ű�� ã�� �� ����. -->ȸ����� ���̺� ������� ���� ���� ���!
--member_grade (�θ����̺�)-|------------<=member(�ڽ� ���̺�)
--1:N ���� 1 (�θ����̺�:MEMBER_GRADE) N (�ڽ� ���̺�:MEMBER)
select*from member_GRADE;
select*from member;

--> �θ����̺� ���� �����͸� �ϳ� �����Ѵٸ�?
--������ ���� : DELETE FROM ���̺�� WHERE ����;

--member_GRADE���̺��� 100���� �ش��ϴ� ��޵����� ����
DELETE FROM MEMBER_GRADE
WHERE GRADE_NO = 100;
--�ڽ� ���̺��� 100�̶�� ���� ����ϰ� �ֱ� ������ ���� �Ұ�

DELETE FROM MEMBER_GRADE
WHERE GRADE_NO = 300;
--�ڽ� ���̺��� 300�̶�� ���� ������� �ʰ� �ֱ� ������ ���� ����

--�ڽ����̺��� �̹� ����ϰ� �ִ� ���� ���� ���
--�θ����̺�κ��� ������ ������ ���� �ʴ� "�����ɼ�"�� �ִ�

ROLLBACK;      --������ ��������� ������� ���� ���� ��
-------------------------------------------------------------
/*
�ܷ�Ű �������� ���� �ɼ�
:�θ����̺��� ������ ������ �ش� �����͸� ����ϰ� �ִ� �ڽ����̺��� ���� ��� �� �������� ���� �ɼ�
-(�⺻��) ON DELETE RESTRICTED: �ڽĵ����ͷκ��� ������� ���� ������ �θ����̺��� ���� �Ұ�
-ON DELETE SET NULL : �θ����̺� �ִ� ������ ���� �� �ش� �����͸� ������� �ڽ� ���̺��� ���� NULL�� ����
- ON DELETE CASCADE : �θ����̺� �ִ� ������ ���� �� �ش� �����͸� ��� ���� �ڽ� ���̺� ���� ����
*/

DROP TABLE MEMBER;

CREATE TABLE MEMBER(
MEM_NO NUMBER PRIMARY KEY,
MEM_ID VARCHAR(20) NOT NULL UNIQUE,
MEM_PWD VARCHAR2(20) NOT NULL,
MEM_NAME VARCHAR2(20) NOT NULL,
GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
JOIN_DATE DATE,
MEM_GRADEID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO)

);

INSERT INTO MEMBER
VALUES (1, 'whdrns456', '0780', '������', '��', sysdate, 100);

INSERT INTO MEMBER
VALUES (2, 'jgw0928', '0780', '���ǿ�', '��', sysdate, 200);

INSERT INTO MEMBER
VALUES (3, 'hh00', 'qwer', '����ȣ', '��', sysdate, null);

SELECT*FROM MEMBER;

DELETE FROM MEMBER_GRADE
WHERE GRADE_NO = 100;
--�ڽ� ���̺��� 100�� ����� ���� �����Ͱ�  NULL�� ����Ǹ鼭
--�θ����̺����� �����Ͱ� �� ������

ROLLBACK;
--------------
DROP TABLE MEMBER;

CREATE TABLE MEMBER(
MEM_NO NUMBER PRIMARY KEY,
MEM_ID VARCHAR(20) NOT NULL UNIQUE,
MEM_PWD VARCHAR2(20) NOT NULL,
MEM_NAME VARCHAR2(20) NOT NULL,
GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
JOIN_DATE DATE,
MEM_GRADEID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE SET NULL

);

INSERT INTO MEMBER
VALUES (1, 'whdrns456', '0780', '������', '��', sysdate, 100);

INSERT INTO MEMBER
VALUES (2, 'jgw0928', '0780', '���ǿ�', '��', sysdate, 200);

INSERT INTO MEMBER
VALUES (3, 'hh00', 'qwer', '����ȣ', '��', sysdate, null);

DELETE FROM MEMBER
WHERE GRADE_NO = 100;
--�ڽ� ���̺��� 100���� ���� �� ��ü�� �����Ǿ�����
SELECT*FROM MEMBER_GRADE;
SELECT*FROM MEMBER;
-----------------------------------------------
/*
DEFAULT 
: ���������� �ƴ�..
�÷��� �������� �ʰ� ������ �߰� �� NULL���� �ƴ� �⺻���� ���� �����ϰ��� �Ҷ�
*/

DROP TABLE MEMBER;
