/*
*VIEW ��)
: SELECT ��D�� ���� ����� ������� ������ �� �� �ִ� ��ü
=> ���� ����ϴ� �������� ������ �θ� �Ź� �ٽ� �ش� �������� ����� �ʿ䰡 ����.
�ӽ����̺�� ���� ����(���� �����Ͱ� ����Ǵ� �� �ƴ�, �������θ� ����Ǿ� �ִ�.)
*/
--�ѱ����� �ٹ��ϴ� ������� ��ȸ(���, �̸�, �μ���, �޿� �ٹ�������)
--���(EMPLOYEE), �μ�(DEPARTMENT), ����(LOCATION), ����(NATIPNAL)

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME 
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '�ѱ�';

--���þƿ��� �ٹ��ϴ� �������
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME 
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '���þ�';

--�Ϻ����� �ٹ��ϴ� �������

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME 
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '�Ϻ�';
--------------------------------------------------------------------------------
/*
VIEW �����ϱ�

CREATE VIEW ���̸�
AS ��������
*/
--(�������) ��ü�� �̸� �ٶ� ����
--         ���̺� : TB_XXX
--         ��: VW_XXX

CREATE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME 
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
JOIN NATIONAL USING (NATIONAL_CODE);

--�並 ������ �� �ִ� ���� �ο�
--GRANT CREATE VIEW TO C##KH;

SELECT*FROM VW_EMPLOYEE;
--> �����δ� �Ʒ��� ���� ����� ���̴�.
SELECT*FROM(SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME 
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
JOIN NATIONAL USING (NATIONAL_CODE));

--�ѱ����� �ٹ��ϴ� ������� ��ȸ
SELECT*FROM VW_EMPLOYEE
WHERE national_name = '�ѱ�';

--���þƿ��� �ٹ��ϴ� ������� ��ȸ
SELECT*FROM VW_EMPLOYEE
WHERE national_name = '���þ�';

--(����) ���� �������� ������ �� ��� ��ȸ-->TEXT �÷��� ����� �������� ��������
SELECT*FROM user_views;

CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
JOIN NATIONAL USING (NATIONAL_CODE);
--------------------------------------------------------------------------------
--���, ����� ���޸� ����(��|��) �ٹ���� ������ ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME,
DECODE(SUBSTR(EMP_NO, 8,1), 1, '��', 2, '��')
,EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

--������ ��ȸ�� ������ �信 ����
--�Լ��� ������� �ִ� ��� ��Ī�� �ο��ؾ� VIEW�� �� ������ �� ����
CREATE OR REPLACE VIEW VW_EMP_JOB
AS
SELECT EMP_ID, EMP_NAME, JOB_NAME,
DECODE(SUBSTR(EMP_NO, 8,1), 1, '��', 2, '��') ����
,EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)�ٹ�����
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

SELECT * FROM VW_EMP_JOB;

CREATE OR REPLACE VIEW VW_EMP_JOB(���, �̸�, ���޸�, ����, �ٹ����)
AS
SELECT EMP_ID, EMP_NAME, JOB_NAME,
DECODE(SUBSTR(EMP_NO, 8,1), 1, '��', 2, '��') 
,EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

--���ڻ�� ��ȸ
SELECT * FROM vw_emp_job
WHERE ���� = '��';


SELECT * FROM vw_emp_job
WHERE �ٹ���� >= 20;

--�� ����
DROP VIEW vw_emp_job;
--------------------------------------------
/*
������ �並 ���ؼ� DML(INSERT/UPDATE/DELETE)���
��� DML�� �ۼ��ϸ� ���� �����Ͱ� �����
*/
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
FROM JOB;

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

--VW_JOB �� ����� ���̺� �߰�
INSERT INTO vw_job VALUES ('J8', '����');

--VW_JOB �並 ����Ͽ� �����͸� ���� (DML_UPDATE)
UPDATE vw_job
SET job_name = '�˹�'
WHERE JOB_CODE = 'J8';

--VW_JOB �並 ����Ͽ� ������ ���� (DML_DELETE)
DELETE FROM vw_job
WHERE JOB_CODE = 'J8';
------------------------------------------------------------------------
/*
DML ��ɾ�� ������ �Ұ����� ��찡 ����
1) �信 ���ǵ��� ���� �÷��� �����Ϸ��� �ϴ� ���
2) �信 ���ǵǾ� ���� �ʰ� ���̽����̺��� NOT NULL ���������� �����Ǿ� �ִ� ���
3) �������� �Ǵ� �Լ������� ���ǰ� �Ǿ� �ִ� ���
4) DISTINCT(�ߺ� ����) ������ ���ԵǾ� �ִ� ���
5) JOIN�� �̿��Ͽ� ���� ���̺��� ���� ��Ų ���

=> ��� ��κ� ��ȸ�� �뵵�� ����Ѵ�. �׷��� �ǵ��� DML�� ���� �ʴ� �� ����.
*/
--------------------------------------------------------------------------------
/*
VIEW �ɼ�
CREATE [OR REPLACE] [FORCE|(NOFORCE)] VIEW ���̸�
AS ��������
[WITH CHECK OPTION]
[WITH READ ONLY];

- OR REPLACE : ������ ������ �̸��� �䰡 ���� ��� �����ϰ� �������� ���� ��� ���� ����
- FORCE | NOFORCE
  +FORCE : ���������� �ۼ��� ���̺��� �������� �ʾƵ� �並 ����
  +NOFORCE : ���������� �ۼ��� ���̺��� �����ؾ����� �並 ����(�⺻��)
  -WITH CHECK OPTION : DML ���� ���������� �ۼ��� ���ǿ� �´� �����θ� �����ϵ��� �Ǵ� �ɼ�
  -WITH READ ONLY : �並 ��ȸ�� �����ϵ��� �ϴ� �ɼ�
*/
--FORCE|NOFORCE
CREATE OR REPLACE NOFORCE VIEW VW_TEMP
AS SELECT TCODE, TNAME, TCONTECT
FROM TT; --> ���� ���̺��� �����Ƿ� �䵵 ���� �Ұ�(NOFORCE)

CREATE OR REPLACE FORCE VIEW VW_TEMP
AS SELECT TCODE, TNAME, TCONTENT
FROM TT; --> ������ ������ �Բ� �� ����(FORCE)

SELECT*FROM VW_TEMP;

CREATE TABLE TT(
TCODE NUMBER,
TNAME VARCHAR2(20),
TCONTENT  VARCHAR2(100)
);

SELECT*FROM VW_TEMP;

CREATE OR REPLACE VIEW VW_EMP
AS SELECT * 
FROM EMPLOYEE
WHERE SALARY >= 3000000;

SELECT*FROM VW_EMP;


-- 204 ����� �޿��� 200�������� ����

UPDATE VW_EMP 
SET SALARY = 2000000
WHERE EMP_ID = 204;

ROLLBACK;  --������� ���
-- WITH CHECK OPTION �߰�
CREATE OR REPLACE VIEW VW_EMP
AS SELECT * 
FROM EMPLOYEE
WHERE SALARY >= 3000000
WITH CHECK OPTION;

SELECT*FROM VW_EMP;

UPDATE VW_EMP 
SET SALARY = 2000000
WHERE EMP_ID = 204;  --> ���������� �ۼ��� ���ǿ� �������� �ʾ� ���� �Ұ�(=>�����߻�)

UPDATE VW_EMP 
SET SALARY = 4000000
WHERE EMP_ID = 204; --> ���������� �ۼ��� ���ǿ� �����ϴ� ��쵵 ���� ����
--------------------------------------------------------------------------------
--WITH ONLY
CREATE OR REPLACE VIEW VW_EMP
AS SELECT * 
FROM EMPLOYEE
WHERE SALARY >= 3000000
WITH READ ONLY;

SELECT*FROM VW_EMP;

DELETE FROM vw_emp
WHERE EMP_ID = 200; --> READ ONLY �ɼǿ� ���Ͽ� DML ���Ұ�





















