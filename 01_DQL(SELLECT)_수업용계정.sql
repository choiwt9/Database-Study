/*
������ ��ȸ(����) :SELLECT
 SELECT ��ȸ�ϰ��� �ϴ� ���� FROM ���̺��;
 SELECT * �Ǵ� �÷���1, 2,...FROM ���̺��;
*/
--��� ����� ���� ��ȸ
SELECT * FROM EMPLOYEE;

--��� ����� �̸� �ֹι�ȣ ��ȭ��ȣ ��ȸ

SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE;

-- JOB ���̺��� ���� �̸��� ��ȸ
SELECT * FROM JOB;
SELECT JOB_NAME FROM job;

--DEPARTMENT ���̺��� ��� ������ ��ȸ
SELECT * FROM DEPARTMENT;

--���� ���̺��� �����, �̸���, ����ó, �Ի���, �޿� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY FROM EMPLOYEE;

/*
�÷����� ��� �����ϱ�
=> SELECT ���� Į���� �ۼ��κп� ��� ������ �� �� �ִ�.
*/
-- ����̸�, ���� ����(SALARY*12) ��ȸ
 --SALARYĮ�� �����Ϳ� 12 ���Ͽ� ��ȸ
SELECT EMP_NAME, SALARY, SALARY * 12  
FROM employee;

--����̸�, �޿�, ���ʽ� ����, ����, ���ʽ� ���� ����(�޿� + (�޿�*���ʽ�))*12
SELECT EMP_NAME, BONUS, SALARY * 12, SALARY + (SALARY * BONUS)*12
FROM employee;

/*
-���� ��¥�ð����� : SYSDATE
-���� ���̺�(�ӽ� ���̺�) : DUAL
*/
--���� �ð� ���� ��ȸ
SELECT SYSDATE FROM dual; --YY/MM/DD�������� ��ȸ��;

--����̸�, �Ի��� �ٹ��� ��(���� ��¥- �ٹ��ϼ�) ��ȸ
--DATE Ÿ�� - DATE Ÿ�� => �Ϸ� ǥ�õ�
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE FROM employee;

/*
*�÷��� ��Ī ���� : ������� ����� ��� �ǹ��ľ��� ����� ��Ī�� �ο��Ͽ� ��Ȯ�ϰ� ����ϰ� ��ȸ ����

[ǥ����]
1) �÷��� ��Ī
2) �÷��� AS ��Ī
3) �÷��� "��Ī"
4)�÷��� AS"��Ī"
*/
--����̸�, �޿�, ���ʽ� ����, ����, ���ʽ� ���� �������� �� ��Ī �ο�
SELECT EMP_NAME "����̸�" , BONUS "���ʽ�", SALARY * 12 "����", SALARY + (SALARY * BONUS)*12 "���ʽ� ���� ����"
FROM employee;

/*
*���ͷ� : ���Ƿ� ������ ���ڿ�('')
->SELECT ���� ����ϴ� ��� ����� �ݺ������� ǥ�õ�
*/
--�̸�, �޿�, '��' ��ȸ
SELECT EMP_NAME �̸�, SALARY �޿�, '��' ����
FROM employee;

/*
���Ῥ���� : ||
*/
SELECT SALARY || '��' AS �޿� 
FROM EMPLOYEE;

--���, �̸�, �޿� �� Į���� ��ȸ
SELECT EMP_ID || EMP_NAME || SALARY
FROM employee;

---XXX�� �޿��� XXX�Դϴ�
SELECT EMP_NAME||'�� �޿��� ' || SALARY||'���Դϴ�' �޿�����
FROM EMPLOYEE;

-- ��� ���̺��� �����ڵ� ��ȸ
SELECT JOB_CODE FROM employee;

/*
�ߺ� ���� : DISTINCT
*/
SELECT DISTINCT JOB_CODE FROM employee;

--������̺��� �μ��ڵ� ��ȸ(�ߺ� ����)

SELECT DISTINCT DEPT_CODE FROM employee;

--SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE FROM employee;
--DISTINCT�� �ѹ��ۿ� ����
--�������� �÷��� ���� �ѽ����� ��� �ߺ� ����
SELECT DISTINCT DEPT_CODE, JOB_CODE FROM employee;
============================================================
/*
WHERE�� : ��ȸ�ϰ��� �ϴ� �����͸� Ư�� ���ǿ� ���� �����ϰ��� �� �� ���
[ǥ����]
SELECT �÷���, �÷� | ������ ���� �����
FROM���̺� ��
WHERE ����;

-�񱳿����� 
*��Һ� : <, >, >=,<= 
*����� 
-���� �� : =
-�ٸ� �� : !=, <>, ^=
*/
-- ��� ���̺��� �μ��ڵ尡 'D9'�� ����鸸 ��ȸ

SELECT * FROM EMPLOYEE 
WHERE DEPT_CODE = 'D9';

--��� ���̺��� �μ� �ڵ尡 D1�� ������� �����, �޿�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D1';

--�μ��ڵ尡 D1�� �ƴ� ������� ���� ��ȸ(�����, �޿�, �μ��ڵ�)
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE 
WHERE DEPT_CODE != 'D1';

--�޿��� 400���� �̻��� ����� �����, �μ��ڵ�, �޿������� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-------------�ǽ�-----------------------------------

--1. �޿��� 300���� �̻��� ������� �����, �޿�, �Ի���, ���� ��ȸ(��Ī ����)
select EMP_NAME �����, SALARY AS "�޿�", HIRE_DATE �Ի���, SALARY*12 ����
FROM EMPLOYEE
WHERE SALARY >= 3000000;

--2. ������ 5õ���� �̻��� ������� �����, �޿�, ����, �μ��ڵ� ��ȸ(��Ī ����)
select EMP_NAME �����, SALARY �޿�, SALARY*12 ����, DEPT_CODE �μ��ڵ�
FROM EMPLOYEE
WHERE SALARY*12 >=50000000;

--3. �����ڵ� 'j3' �� �ƴ� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ(��Ī ����)
SELECT EMP_NO ���, EMP_NAME �����, JOB_CODE �����ڵ�, ENT_YN ��翩�� 
FROM EMPLOYEE
WHERE JOB_CODE <> 'J3';

--4. �޿��� 350���� �̻� 600���� ������ ��� ����� �����, ���, �޿� ��ȸ(��Ī ����)
--and or�� ������ ������ �� ����
SELECT EMP_NAME �����, EMP_NO ���, SALARY �޿� 
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;
================================================
/*
BETWEEN END : ���ǽĿ��� ����ϴ� ����
=> ~�̻� ~������ ���������� ������ �����ϴ� ����
[ǥ����]
�񱳴���÷��� BETWEEN �ּڰ� AND �ִ�
=> �ش� �÷��� ���� �ּڰ� �̻��̰� �ִ� ������ ���
*/
--�޿� 350���� �̻� 600���� ������ ����� �����, ���, �޿� ��ȸ(BETWEEN X)
SELECT EMP_NAME �����, EMP_ID ���, SALARY �޿�
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;
SELECT EMP_NAME �����, EMP_ID ���, SALARY �޿�
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;
/*
* NOT : ����Ŭ�ּ��� ������������
*/
-- �޿��� 3500000 �̸� �Ǵ� 600���� �ʰ��� ����� ����� ��� �޿� ��ȸ(NOT X)
SELECT EMP_NAME �����, EMP_ID ���, SALARY �޿�
FROM EMPLOYEE
WHERE SALARY < 3500000 OR SALARY > 6000000;
-- �޿��� 3500000 �̸� �Ǵ� 600���� �ʰ��� ����� ����� ��� �޿� ��ȸ(NOT O)
SELECT EMP_NAME �����, EMP_ID ���, SALARY �޿�
FROM EMPLOYEE
--WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
--NOT�� BETWEEN ���̳� �÷��� �տ� �ٿ��� ��밡��!

/*
*IN : �񱳴�� �÷����� ������ ���� �߿� ��ġ�ϴ� ���� ���� ��� ��ȸ�ϴ� ������
[ǥ����]
�񱳴�� �÷��� IN (��1, ��2,.......)
*/
--�μ��ڵ尡 D6 �̰ų� D8�̰ų� D5�� ������� �����, �μ��ڵ�, �޿� ��ȸ(IN X)
SELECT EMP_NAME �����, DEPT_CODE �μ��ڵ�, SALARY �޿�
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';

SELECT EMP_NAME �����, DEPT_CODE �μ��ڵ�, SALARY �޿�
FROM EMPLOYEE
WHERE DEPT_CODE IN('D6','D8','D5');
===============================================
/*
*LIKE : ���ϰ��� �ϴ� �÷��� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ

=> Ư�� ���� : '%', '_'�� ���ϵ�ī��� ���
* '%' : 0���� �̻�
EX)�񱳴���÷��� LIKE '����%' => �ٱ�����÷��� ���� ���ڷ� '����'�Ǵ� ���� ��ȸ
�񱳴���÷��� LIKE '%����' => �񱳴�� �÷��� ���� ���ڷ� '��'���� ���� ��ȸ
=> �񱳴���÷��� LIKE '%����%' => �񱳴�� �÷��� ���� ���ڰ� ���ԵǴ� ���� ��ȸ (Ű���� �˻�)
*'_': 1����
EX) �񱳴���÷��� LIKE '_����' => �񱳴�� �÷��� ������ ���� �տ� ������ �� ���ڰ� �� ��� ��ȸ
    �񱳴���÷��� LIKE '__����' => �񱳴�� �÷��� ������ ���� �տ� ������ �� ���ڰ� �� ��� ��ȸ
    �񱳴���÷��� LIKE '_����_' => �񱳴�� �÷��� ������ ���� �յڿ� ������ �� ���ھ� �� ��� ��ȸ
*/
--����� �� ������ ����� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';
--��� �̸��� �� �� ���Ե� ����� �����, �ֹι�ȣ, ����ó ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

--����̸��� ��� ���ڰ� �� �� ����� �����, ����ó ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';

--����� �� ����ó�� ����° �ڸ��� 1�� ����� �����, ����ó �̸��� ��ȸ
SELECT EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

--����� �� �̸��Ͽ� _�� ������ �ش� ���� ���� 3������ ����� ���, �̸�, �̸��� ��ȸ
SELECT EMP_NAME, EMP_ID, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___%';--���ϴ´�� ��ȸ �ȵ�
--==>���ϵ�ī��� ���Ǵ� ���ڿ� �÷��� ��� ���ڰ� �����ϱ� ������ ��� ���ϵ�ī��� �ν�
--ESCAPE ����Ͽ� ��� �� ����
SELECT EMP_NAME, EMP_ID, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';--���迡 ���� �� �ִ�
=================================================================
/*
*IS NULL / IS NOT NULL : �÷����� NULL�� ���� ��� ��
*/
--���ʽ��� ���� �ʴ� ����� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_NAME, EMP_NO, SALARY, BONUS 
FROM EMPLOYEE
WHERE BONUS IS NULL;
--���ʽ��� �޴� ����� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY, BONUS 
FROM EMPLOYEE
WHERE BONUS IS NOT NULL; --=WHERE NOT BONUS IS NULL;

--����� ���� ��� (MANAGER_ID ���� NULL)�� �����, ����纯, �μ��ڵ� ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

--�μ���ġ�� ���� �ʾ����� ���ʽ��� �ް� �ִ� ����� �����, ���ʽ�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;
=================================================================
/*
*������ �켱����
(0) ()
(1) ���������: * / + -
(2) ���Ῥ����: ||
(3) �ٱ������� : > < >= <= = != 
(4) is null / like '����' / IN
(5) BETWEEN AND
(6) NOT
(7) AND
(8) OR
*/
-- ���� �ڵ尡 J7�̰ų� J2�� ����� �߿� �޿��� 200���� �̻��� ����� ��� ������ ��ȸ
SELECT * FROM EMPLOYEE
--WHERE JOB_CODE IN ('J7', 'J2') AND SALARY >=2000000;
WHERE (JOB_CODE = 'J7'OR JOB_CODE = 'J2') AND SALARY >=2000000;
========================================================================
/*
*ORDER BY : SELECT���� ���� ������ �ٿ� �ۼ�, ���� ���� ���� �������� ����

[ǥ����]
SELECT ��ȸ�� Į��...
FROM ���̺��
WHERE ���ǽ�
ORDER BY ���ı����� �Ǵ� �÷�|��Ī|�÷����� [ASC/DESC] [NULLS FIRST|NULLS LAST]

ASC : �������� ����
DESC : �������� ����

NULLS FIRST : �����ϰ��� �ϴ� �÷��� ���� NULL�� ��� �ش� �����͸� �� �տ� ��ġ(DESC�� ��� �⺻��)
NULLS LAST : �����ϰ��� �ϴ� ���� NULL�� ��� �ش� �����͸� �� �ڿ� ��ġ
*/
--��� ����� ����� ���� ��ȸ (������ �������� ����)

SELECT EMP_NAME, SALARY*12 ���� 
FROM EMPLOYEE
-- ORDER BY SALARY*12 DESC --���� ������ �Ǵ� Į��(�����)
--ORDER BY ���� DESC;
ORDER BY 2 DESC;--�÷� ������ ����(����Ŭ������ 1���� ����)

--���ʽ� ���� ����
SELECT * FROM EMPLOYEE
--ORDER BY BONUS; --�⺻��(ASC, NULLS LAST)
--ORDER BY BONUS ASC;
--ORDER BY BONUS ASC NULLS LAST;
--ORDER BY BONUS DESC; --NULLS FIRST(DESC�� ��� �⺻��)
ORDER BY BONUS DESC, SALARY ASC; --���ʽ� ��������, �޿��� ��������
--=> ���ʽ� ���� �������� �����ϴ� �� ���� ���� ��� �޿��� ������������ ����


