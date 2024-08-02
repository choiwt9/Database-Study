-- 1. JOB ���̺��� ��� ���� ��ȸ
SELECT*FROM JOB;

-- 2. JOB ���̺��� ���� �̸� ��ȸ
SELECT JOB_NAME FROM job;

-- 3. DEPARTMENT ���̺��� ��� ���� ��ȸ
SELECT*FROM DEPARTMENT;

-- 4. EMPLOYEE���̺��� ������, �̸���, ��ȭ��ȣ, ����� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE FROM employee;

-- 5. EMPLOYEE���̺��� �����, ��� �̸�, ���� ��ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY FROM employee;

-- 6. EMPLOYEE���̺��� �̸�, ����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�Ѽ��ɾ� - (����*���� 3%)) ��ȸ
SELECT EMP_NAME, SALARY*12 , (SALARY+(SALARY*BONUS))*12, (SALARY + (SALARY*BONUS))*12 - (SALARY*12*0.03) FROM employee;
--bonus Į���� ���� null�� ������ �Ѽ��ɾ�, �Ǽ��ɾ� ������ NULL�� ǥ�õ�(����Ŀ� NULL�� ������ ����� NULL)

-- 7. EMPLOYEE���̺��� �Ǽ��ɾ�(6�� ����)�� 5õ���� �̻��� ����� �̸�, ����, �Ǽ��ɾ�, ����� ��ȸ
SELECT EMP_NAME, SALARY, (SALARY*BONUS)*12 - ((SALARY*BONUS)*12)/0.03,HIRE_DATE
FROM employee
WHERE ((SALARY + (SALARY*BONUS))*12 - (SALARY*12*0.03)) >= 50000000;

-- 8. EMPLOYEE���̺� ������ 4000000�̻��̰� JOB_CODE�� J2�� ����� ��ü ���� ��ȸ
SELECT*FROM employee
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';

-- 9. EMPLOYEE���̺� DEPT_CODE�� D9�̰ų� D5�� ��� �� 
--     ������� 02�� 1�� 1�Ϻ��� ���� ����� �̸�, �μ��ڵ�, ����� ��ȸ
SELECT  EMP_NAME, DEPT_CODE, HIRE_DATE
FROM employee
WHERE HIRE_DATE < '02/01/01' AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D5');

SELECT  EMP_NAME, DEPT_CODE, HIRE_DATE
FROM employee
WHERE HIRE_DATE < '02/01/01' AND DEPT_CODE IN('D9','D5');












