/*
D : DATA, L :  LANGUAGE
DQL(QUERY, ������ ��ȸ): SELECT(��ȸ)
DML(MANIPULATION, ������ ����) : INSERT(�߰�/����), UPDATE(����), DELETE(����)
DDL(DEFINITION, ������ ����) : CREATE(����), ALTER(����), DROP(����)
DCL(CONTROL, ������ ����) : GRANT, REMOVE
TCL (TRANSACTION, Ʈ������ ����): COMMIT, ROLLBACK 
*/
--------------------------------------------------------------------------------
/*
DML :(������ ���� ���)
:���̺� �����͸� �߰��ϰų�(INSERT)
                 �����ϰų�(UPDATE)
                  �����ϱ�����(DELETE) 
                     ����ϴ� ���
*/
/*
������ �߰� : INSERT
=>���̺� ���ο� ���� �߰�
INSERT INTO ���̺�� VALUES (��,��,��.......)
=>���̺��� ��� �÷��ǰ��� �����Ͽ� ����(�߰�)
�÷� ������ �°� �����ؾ� ��(�ش� �÷��� ������ Ÿ�Կ� �°�)
*/
SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE
VALUES(300, '��ο�', '930806-1000000', 'MINWOOK@OR.KR', '01012345678', 
'D4','J4', 3000000, 0.3, NULL, SYSDATE, NULL, 'N');

/*
2)INSERT INTO ���̺��(�÷���, �÷���, �÷���) VALUES (��, ��, ��)
->�÷��� ���� �����Ͽ� �ش� �÷��� ���� ������ �߰�
���õ��� ���� �÷��� ���� ���� �⺻������ NULL���� ����
�⺻���� ���� �ɼ�(DEFAULT)�� �ִ� ��� �ش� �⺻������ ����
=> NOT NULL ���������� �ִ� ��� ���� �÷��� �����Ͽ� ���� �߰��ϰų� 
DEFAULT �ɼ��� �����ؾ���
*/
INSERT INTO employee(emp_id, emp_name, emp_no, email, job_code)
VALUES (301, '������', '000501-3000000', 'JUNHYEOK2@OR.KR', 'J7');
---------------------------------------------------------------------------------
/*
INSERT INTO ���̺��(��������)
=> VALUES �κ� ��� ���������� ��ȸ�� ������� ��°�� INSERT �ϴ� ���
*/

CREATE TABLE EMP01(
EMP_ID NUMBER,
EMP_NAME VARCHAR2(20),
DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP01;


SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN department ON (DEPT_CODE = DEPT_ID);

--���� ���� ����� EMP01���̺� �߰�

INSERT INTO emp01 (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM employee 
LEFT JOIN department ON (DEPT_CODE = DEPT_ID));
-----------------------------------------------------------------------
/*
INSERT ALL 
:�ΰ� �̻��� ���̺� ���� �����͸� �߰��� �� ���
�̶� ���Ǵ� ���������� ������ ���
*/
--���, �����, �μ��ڵ�, �Ի��� ������ ������ ���̺�
CREATE TABLE EMP_DEPT
AS(SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM employee
WHERE 1=0);--1=0 --> FALSE ���ǹ�!!!

SELECT * FROM emp_dept;
--���, �̸�, ������ ������ ������ ���̺�
CREATE TABLE EMP_MANAGER
AS(SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE
WHERE 1=0);

--�μ��ڵ� D1�� ��� ����� �μ��ڵ� ������ �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
FROM employee
WHERE DEPT_CODE = 'D1';

INSERT ALL 
INTO EMP_DEPT VALUES (EMP_ID, EMP_NAME, DEPT_CODE,HIRE_DATE)
INTO emp_manager VALUES (EMP_ID, EMP_NAME,MANAGER_ID)
(SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
FROM employee
WHERE DEPT_CODE = 'D1');
/*
INSERT ALL
INTO ���̺�� VALUES (�÷���,�÷���, �÷���..... )
INTO ���̺�� VALUES (�÷���, �÷���, �÷���.....)
��������;
*/
SELECT * FROM emp_dept;
SELECT * FROM emp_manager;
-----------------------------------------------------------------
/*
UPDATE : ���̺� ����Ǿ� �ִ� ������ �������� ���� �����ϴ� ����

UPDATE ���̺�� 
 SET �÷� = ��, 
     �÷� + ��............
     [WHERE ���ǽ�]----> WHERE���� �������� ��� ���̺��� ��� ����  SET ���� ������ �÷��� �����Ͱ� ����
     
     *������Ʈ �� ���������� �� Ȯ���ؾ���!
*/
--DEPT_TABLE ���̺� DEPARTMENT ���̺� ����
CREATE TABLE DEPT_TABLE AS (SELECT * FROM department);

SELECT * FROM DEPT_TABLE;

--�μ��ڵ�(DEPT_ID)����'D1'�� �λ��� �μ����� '�λ���'���� ����
UPDATE DEPT_TABLE 
SET DEPT_TITLE = '�λ���'
WHERE DEPT_ID = 'D1';
--�μ��ڵ�(DEPT_ID)����'D9'�� �λ��� �μ����� '������ȹ��'���� ����
UPDATE DEPT_TABLE 
SET DEPT_TITLE = '������ȹ��'
WHERE DEPT_ID = 'D9';

--������̺��� EMP_TABLE�� ���� (���, �̸�, �μ��ڵ�, �޿�, ���ʽ� ������)
CREATE TABLE EMP_TABLE 
AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS 
FROM EMPLOYEE);

SELECT * FROM EMP_TABLE;

UPDATE EMP_TABLE
SET SALARY = 1000000
WHERE EMP_NAME = '������';

SELECT * FROM EMP_TABLE
WHERE EMP_NAME='������';

-- ���ȥ ����� �޿��� 500���� ���ʽ��� 0,2 �� ����
SELECT * FROM EMP_TABLE
WHERE EMP_NAME='���ȥ';

UPDATE EMP_TABLE
SET SALARY = 5000000, BONUS = 0.2
WHERE EMP_NAME = '���ȥ';

--��ü ����� �޿��� �����޿��� 10% �λ�! (�����޿� *1.1)
UPDATE EMP_TABLE
SET SALARY = SALARY * 1.1;

SELECT * FROM emp_table;
--------------------------------------------------------------------------------
/*
UPDATE ������ �������� ����ϱ�

UPDATE ���̺��
SET �÷��� = (��������)
WHERE ���ǽ�
*/
--����� ����� �޿��� ���ʽ��� ����� ����� �޿��� �����ϰ� ����
UPDATE emp_table
SET SALARY = (SELECT SALARY FROM EMP_TABLE WHERE EMP_NAME = '�����'),
    BONUS = (SELECT BONUS FROM EMP_TABLE WHERE EMP_NAME = '�����')
    WHERE EMP_NAME = '����';

SELECT * FROM EMP_TABLE WHERE EMP_NAME IN ('����','�����');

SELECT * 
FROM EMP_TABLE 
WHERE (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME = '�����');

UPDATE emp_table
SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME = '�����')
    WHERE EMP_NAME = '������';

--ASIA �������� �ٹ����� ������� ���ʽ����� 0.3 ���� ����
SELECT * FROM LOCATION 
WHERE LOCAL_NAME LIKE 'ASIA%';

SELECT * FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME LIKE 'ASIA%';

SELECT * FROM EMP_TABLE
JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
JOIN LOCATION ON LOCATION_ID = lOCAL_CODE
WHERE LOCAL_NAME LIKE 'ASIA%';

--�ش� ������� ���ʽ� ���� 0.3 ���� ���� 
UPDATE EMP_TABLE
SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID FROM EMP_TABLE
                JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
                 JOIN LOCATION ON LOCATION_ID = lOCAL_CODE
                  WHERE LOCAL_NAME LIKE 'ASIA%');

SELECT * FROM EMP_TABLE;

COMMIT;
--------------------------------------------------------------------------------
/*
DELETE : ���̺� ������ ����� �����͸� �����Ҷ� ����ϴ� ����
DELETE FROM ���̺�� 
(WHERE ���ǽ�); --> WHERE�� ������ ��� �����͸� ����
*/
--EMPLOYEE ���̺��� ��� ������ ����

DELETE FROM employee;

SELECT * FROM EMPLOYEE;
ROLLBACK;

--------------------------------------------------------------------------------
-- ������ ����� ������ ����
DELETE FROM employee
WHERE EMP_NAME = '������';

--300�� ����ǵ����� ����
DELETE FROM employee
WHERE EMP_ID = 300;

COMMIT;

--�μ� ���̺��� �μ��ڵ尡 D1�� �μ� ����
DELETE FROM department
WHERE DEPT_ID = 'D1';
--> D1���� EMPLOYEE ���̺��� ������̱� ������ ���� �Ұ�(�ܷ�Ű �����Ǿ� ����)




