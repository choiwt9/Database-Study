/*
DDL :  ������ ���� ���
����Ŭ���� �����ϴ� ��ü�� ���� �����(CREATE)
������ �����ϰ�(ALTER) 
���� ��ü�� �����ϴ� ���(DROP)
=> ���� �����Ͱ� �ƴ� ��Ģ�� �����ϴ� ���
* ����Ŭ������ ��ü(����) : ���̺�, ��, ������, �ε���, ��Ű��, Ʈ����, ���ν���, �Լ�, ���Ǿ�, �����
*/
-- CREATE : ��ü�� ���� �����ϴ� ����
/*
���̺� ���� �ϱ�
=> ���̺�: ��� ���� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
��� �����͵��� ���̺��� ���� ����

CREATE TABLE ���̺��(
�÷��� �ڷ��� (ũ��),
�÷��� �ڷ���,
�÷��� �ڷ���,
......
)
-�ڷ���
*����=> NUNBER 
*����=> �ݵ�� ũŰ ������ ����� �Ѵ�.
+ CHAR(����Ʈ ũ��):��������(������ ������ �����͸� ���� ���)
-> ������ ���̺��� ���� ���� ���� ��� �������� ä���� ����
�ִ� 2000����Ʈ���� ���� ����

+VARCHAR2(����Ʈ ũ��):�������� (�������� ���̰� ������ ���� ���� ���)
-> ����Ǵ� ������ ���̸�ŭ�� ���� ũ�Ⱑ ����
�ִ� 4000����Ʈ���� ���� ����
*��¥ => DATE
*/
-- ȸ�������� ������ ���̺� : MEMBER
/*
-ȸ����ȣ     :���� (NUMBER)
-ȸ�����̵�    :���� (VARCHAR2(20))
-ȸ����й�ȣ  :����(VARCHAR2(20))
-ȸ���̸�      :����(VARCHAR2(20))
-����         :���� -'��' / '��'(CHAR(3))
-����ó        :���� - (CHAR(13)
-�̸���         :���� - (VARCHAR2(50))
-������        :��¥ - (DATE)
*/

CREATE TABLE MEMBER(
MEM_NO NUMBER,
MEM_ID VARCHAR2(20),
MEM_PWD VARCHAR2(20),
MEM_NAME VARCHAR2(20),
GENDER CHAR(3),
PHONE CHAR(13),
EMAIL VARCHAR2(50),
JOIN_DATE DATE
);
SELECT * FROM MEMBER;
/*
�÷��� ���� �߰��ϱ�

COMMENT ON COLUMN ���̺��, �÷��� IS '������'
*�߸��ۼ����� ��� �ٽ��ۼ� �� ���� => �������
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.GENDER IS '����';
COMMENT ON COLUMN MEMBER.PHONE IS '����ó';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.JOIN_DATE IS '������';

--���̺� �����ϱ� : DROP TABLE ���̺��
--DROP TABLE MEMBER;

--���̺� ������ �߰��ϱ� : INSERT INTO ���̺�� VALUES(��, ��, ��,........)
INSERT INTO MEMBER VALUES (1, 'wontak9', '1234', '�ֿ�Ź', '��', '010-1234-5678', 'wontak9@gmail.com', sysdate);
INSERT INTO MEMBER VALUES (2, 'DAWUN', '1234', '��ٿ�', '��', NULL, NULL, sysdate) ;
INSERT INTO MEMBER VALUES (NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

COMMIT ;
-------------------------------------
/*
��������: ���ϴ� �����Ͱ��� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
         ������ ���Ἲ�� �����ϱ� ���� ����
����: NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGH KEY         
*/
/*
NOT NULL ��������
: �ش� �÷��� �ݵ�� ���� �����ؾ� �ϴ� ��� �����ϴ� ����
=> ����� NULL���� ����Ǹ� �ȵŴ� ���
*������ �߰�/���� �� NULL���� ������� ����
*�÷� ���� ������θ� ���� ����
*/
--NOT NULL ������ �߰��� ȸ�����̺� : MEMBER_NOTNULL
CREATE TABLE MEMBER_NOTNULL(
MEM_NO NUMBER NOT NULL,
MEM_ID VARCHAR2(20) NOT NULL,
MEM_PWD VARCHAR2(20)NOT NULL,
MEM_NAME VARCHAR2(20)NOT NULL,
GENDER CHAR(3) NOT NULL,
PHONE CHAR(13) NOT NULL,
EMAIL VARCHAR2(50) NOT NULL,
JOIN_DATE DATE NOT NULL
);
SELECT * FROM MEMBER_NOTNULL;

INSERT INTO MEMBER_NOTNULL
VALUES (1,'DAWUN', '1234', '��ٿ�', '��', '010-1234-5678', 'DAWUN@GMAIL.COM', sysdate);

INSERT INTO MEMBER VALUES (2, 'wontak9', '1234', '�ֿ�Ź', '��', NULL, NULL, NULL);

INSERT INTO MEMBER VALUES (3, NULL, '1234', 'QQQ', '��', NULL, NULL, NULL);
--������ ��� ȸ�����̵� �κ��� NULL�̶� ���� �߻�(�������� ����)
INSERT INTO MEMBER_NOTNULL
VALUES (1,'DAWUN', '1234', '��ٿ�', '��', '010-1234-5678', 'DAWUN@GMAIL.COM', sysdate);
--�ߺ��Ǵ� �����Ͱ� �������� �߰��� ��. ������ ��Ȳ
-----------------------------------------------------------

/*
UNIQUE ��������
: �ش��÷��� �ߺ��� ���� ���� ��� �����ϴ� ��������

*������ �߰� ���� ������ ������ �ִ� ������ �� �߿� �ߺ��Ǵ� ���� ������� ���� �߻�
*/
CREATE TABLE MEMBER_UNIQUE(
MEM_NO NUMBER NOT NULL,
MEM_ID VARCHAR2(20) NOT NULL UNIQUE, --�÷� ���� ���
MEM_PWD VARCHAR2(20)NOT NULL,
MEM_NAME VARCHAR2(20)NOT NULL,
GENDER CHAR(3) NOT NULL,
PHONE CHAR(13) NOT NULL,
EMAIL VARCHAR2(50) NOT NULL,
JOIN_DATE DATE NOT NULL

--,UNIQUE(MEM_ID)
);

SELECT * FROM MEMBER_UNIQUE;

INSERT INTO member_unique
VALUES (1, 'CHOIWONTAK', '1234', '�ֿ�Ź', '��', '010-1234-1234', 'WONTAK9@GMAIL.COM', SYSDATE);

INSERT INTO member_unique
VALUES (2, 'CHOIWONTAK', '9999', '�ٿ��', '��', NULL, NULL, NULL);
--UNIQUE ���� ���ǿ� ����Ǿ� ������ �߰� �ȵ�
-->�������뿡 �������Ǹ����� �˷���, �˾ƺ��� �����
--> �������� ���� �� �ľ����Ǹ��� �������� ������ �ý��ۿ��� �˾Ƽ� �̸� �ο�
-----------------------------------------------
/*
���� ���Ǹ� �����ϱ�

*�÷� ���� ���
CREATE TABLE ���̺�� (�÷��� �ڷ���[CONSTRANT �������Ǹ�] ��������
);

*���̺� ������� 
CREATE TABLE ���̺��(
�÷��� ������
�÷��� ������

[CONSTRANT �������Ǹ�] ��������
);
*/

--MEMBER_UNIQUE ���̺� ����

DROP TABLE MEMBER_UNIQUE;

CREATE TABLE MEMBER_UNIQUE(
MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL,
MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NT NOT NULL, --�÷� ���� ���
MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NT NOT NULL,
MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NT NOT NULL,
GENDER CHAR(3) ,
PHONE CHAR(13) ,
EMAIL VARCHAR2(50) ,
JOIN_DATE DATE 

,CONSTRAINT MEMID_UQ UNIQUE (MEM_ID)
);

INSERT INTO member_UNIQUE
VALUES(1,'WONTAK', '1234', '�ֿ�Ź', '��', '010-1234-1234', 'WONTAK9@GMAIL.COM', SYSDATE);

INSERT INTO member_unique
VALUES(2,'QWER', '1234', 'QWER', '��', NULL, NULL, NULL);

INSERT INTO member_unique
VALUES(3,NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO member_unique
VALUES(4,'WONTAK', '1234', 'QWER', '��', NULL, NULL, NULL);
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
 PRIMARY KEW(�⺻Ű)
 :���̺��� ������ �ĺ��ϱ� ���� ���Ǵ� Į���� �ο��ϴ� ���� ����
 
 EX)ȸ����ȣ, �й�, ��ǰ�ڵ�, �ֹ���ȣ , �����ȣ
 
  PRIMARY KEY => NOT NULL + UNIQUE
  
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
JOIN_DATE DATE,

UNIQUE (MEM_ID)
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
CREATE TABLE MEMBER(
 MEM_NO NUMBER PRIMARY KEY,   --ȸ����ȣ 
 MEM_NAME VARCHAR2(20) NOT NULL,--ȸ���̸�
 AGE NUMBER,--����
 HOBEY VARCHAR2(20) DEFAULT '����',--���
 JOIN_DATE DATE DEFAULT SYSDATE--������
);

INSERT INTO MEMBER VALUES(1, '¯��', 5, '��������', '24/07/01');
INSERT INTO MEMBER VALUES(2, '�ͱ�', 5, '�๰', NULL);
INSERT INTO MEMBER VALUES(3, '����', 5, NULL, NULL);

SELECT*FROM MEMBER;

INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES (4, '����');
-- �������� ���� �÷��� ���� ���� �⺻������ NULL�� ����
--�� �ش��÷��� �⺻���� �����Ǿ� ������ NULL�� �ƴ� �⺻������ ����
------------------------------------------------------------
--���̺� �����ϱ�
CREATE TABLE MEMBER_COPY
AS (SELECT*FROM MEMBER);
-------------------------------------------------------------
/*
ALTER TABLE : ���̺� ��������� �����ϰ��� �Ҷ� ���

ALTER TABLE ���̺�� ������ ����
-NOT NULL : ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL;

-UNIQUE : ALTER TABLE ���̺�� ADD �÷��� NOT NULL UNIQUE(�÷���);
-CHECK : ALTER TABLE ���̺�� ADD CHECK(�÷��� ���� ���ǽ�);
-PRIMARY KEY : ALTER TABLE ���̺�� ADD PRIMARY KEY(�÷���);
-FOREIGN KEY : ALTER TABLE ���̺�� ADD FOREIGN KEY(�÷���) REFERENCES ������ ���̺��[(������ �÷���)];
*/
-- MEMBER_COPY ���̺��� ȸ����ȣ(MEM_NO)�÷��� �⺻Ű ����
ALTER TABLE MEMBER_COPY ADD PRIMARY KEY(MEM_NO);

--EMPLOYEE���̺��� DEPT_CODE �÷��� �ܷ�Ű ����-> DEPARTMENT ���̺��� DEPT_ID
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE)REFERENCES DEPARTMENT;
--EMPLOYEE���̺��� JOB_CODE �÷��� �ܷ�Ű ���� -> JOB_���̺��� JOB_CODE(�⺻Ű)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE)REFERENCES JOB;
--------------------------------------------------------------------------------





