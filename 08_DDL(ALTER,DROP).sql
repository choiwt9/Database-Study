/*
DDL : ������ ���Ǿ��

��ü ����(CREATE), ����(ALTER), ����(DROP)�ϴ� ����
*/
/*
ALTER : ��ü�� �����ϴ� ����

ALTER TABLE ���̺��� ������ ����
*����Ǵ� ����
-�������� �߰�/����(���� �� �߰�)/����
-�÷���/�������� �̸�/���̺��� ����
-�÷� �߰�/ ����/ ����
*/
/*
�÷� �߰�/����/����
-�÷� �߰� : ALTER TABLE ���̺��� ADD �÷��� �ڷ���[�⺻��|��������];
*/
--DEPT_TABLE ���̺��� CNAME:VARCHAR2(20) �÷� �߰�
ALTER TABLE DEPT_TABLE ADD CNMAE VARCHAR2(20);

SELECT*FROM DEPT_TABLE;

ALTER TABLE DEPT_TABLE ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';

/*
�÷� ���� (MODIFY)
-������ Ÿ�� ���� : ALTER TABLE ���̺��� MODIFY �÷��� ������ ������ Ÿ��
-�⺻�� ���� : ALTER TABLE ���̺��� MODIFY �÷��� DEFAULT ������ �⺻��
*/

--DEEP_TABLE ���̺��� DEPT_ID�÷��� ����
--ũ�⸦ 2����Ʈ -> 5����Ʈ�� ����
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID CHAR(5);
-- ����Ÿ������ ����
--ALTER TABLE DEPT_TABLE MODIFY DEPT_ID NUMBER;
--> ���Ŀ��� �߻�

--DEPT_TABLE ���̺��� DEPT_TITLE �÷��� ����
-- * ũ�⸦ 35 ����Ʈ -> 10����Ʈ�� ����
--ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(10);--> ũ����� �߻�!

-- * ũ�⸦ 35 ����Ʈ -> 50����Ʈ�� ����
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(50);
--EMP_TABLE ���̺��� SALARY �÷��� NUMBER -> VARCHAR2(50)���� ����
--ALTER TABLE EMP_TABLE MODIFY SALARY VARCHAR2(50);

--�������� �÷� ���� ����!
ALTER TABLE DEPT_TABLE 
MODIFY DEPT_TITLE VARCHAR2(55)
MODIFY LNAME DEFAULT '�ڸ���';
/*
�÷� ���� : DROP COLUMN

ALTER TABLE ���̺� �� DROP COLUMN �÷���
*/
--DEPT_TABLE DEPT_COPY\
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPT_TABLE;

SELECT*FROM dept_copy;

ALTER TABLE DEPT_COPY DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY DROP COLUMN CNMAE;
ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_ID; --�����߻�
-->���̺��� �ּ��� �Ѱ��� �÷��� �����ؾ� ��
-----------------------------------------------------
--�������� �߰�/����/����
/*
�⺻Ű (PRIMARY KEY): ALTER TABLE ���̺��� ADD PRIMARY KEY (�÷���)
�ܷ�Ű (FOREIGN KEY): ALTER TABLE ���̺��� ADD FOREIGN KEY (�÷���) REFERENCES ���� ���̺���[(������ Į����)]
*UNIQUE(�ߺ��� ������� �ʴ� ���� ����) ALTER TABLE ���̺��� ADD UNIQUE(�÷���)
*CHECK(Ư�� ���鸸 �����ϰ��� �Ҷ� ����ϴ� ���� ����, NULL�� ����): ALTER TABLE ���̺��� ADD CHECK (�÷��� ���� ���ǽ�)
*NOT NULL(NULL���� ������� �ʴ� ���� ����) : ALTER TABLE ���̺��� MODIFY �÷���
*/
--DEPT_TABLE ���̺��� �Ʒ� ���� ������ �߰�
-- DEPT_ID�÷��� PK(�⺻��) ���� ���� �߰�
-- DEPT_TITLE �÷��� UNIQUE �������� �߰�
--LNAME�÷��� NOT NULL �������� �߰�
ALTER TABLE DEPT_TABLE
ADD CONSTRAINT DT_PK PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT DT_UQ UNIQUE(DEPT_TITLE)
MODIFY LNAME NOT NULL;

/*
[���� ���� ����]
ALTER TABLE ���̺��� DROP CONSTRAINT ���� ���Ǹ� / NOT NULL
ALTER TABLE ���̺��� MODIFY �÷��� NULL
*/
ALTER TABLE DEPT_TABLE DROP CONSTRAINT DT_PK;

ALTER TABLE DEPT_TABLE
DROP CONSTRAINT DT_UQ
MODIFY LNAME NULL;

SELECT*FROM DEPT_TABLE;
-------------------------------------------------------
--���̺� ����
--DROP TABLE ���̺���
DROP TABLE DEPT_TABLE;
--��򰡿� �����ǰ� �ִ� �θ����̺��� ���� �ȵ�
--������� �� ��� 1)�ڽ� ���̺��� ���� �� �θ� ���̺��� ����
--               2)�θ����̺��� �����ϴµ� �������Ǳ��� ����
--                DROP TABLE ���̺��� CASCADE CONSTRAINT
-----------------------------------------------
CREATE TABLE DEPT_TABLE
AS SELECT * FROM department;

/*
�÷���, �������Ǹ� ���̺��� ���� (RENAME)
*/ 
--1) �÷��� ���� : RENAME COLUMN ���� �÷��� TO �ٲ� �÷���

-- DEPT_TITLE --> DEPT_NAME ����

ALTER TABLE DEPT_TABLE RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
--2)�������Ǹ� ���� RENAME CONSTRAINT ���� ���� ���Ǹ� TO�ٲ� �������Ǹ�
ALTER TABLE DEPT_TABLE RENAME CONSTRAINT SYS_C008512 TO DT_DEPTID_NN;

--3)���̺��� ����
ALTER TABLE DEPT_TABLE RENAME TO DEPT_END;

ALTER TABLE DEPT_END RENAME TO DEPT_TABLE;
----------------------------------------------------
--TRUNCATE : ���̺� �ʱ�ȭ
--=> DROP ���� �ٸ��� ���̺��� �����͸� ���� �����Ͽ� ���̺��� �ʱ���·� �����ִ� ��
SELECT * FROM DEPT_END;
TRUNCATE TABLE DEPT_END;

