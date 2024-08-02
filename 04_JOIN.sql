/*
JOIN
: �ΰ� �̻��� ���̺��� ��ȸ�ϰ��� �� �� ���Ǵ� ����
��ȸ ����� �ϳ��� �����(RESULT SET)�� ����

*������ �����ͺ��̽� (RDB)������ �ּ����� �����͸� ������ ���̺� ����
�ߺ� ������ �ּ�ȭ�ϱ� ���� �ִ��� �ɰ��� �ø���

=> ������ ������ ���̽����� �������� �̿��� ���̺��� '����'�� �δ� ���
(�� ���̺��� ������� ���ؼ� �����͸� ��Ī���� ��ȸ)

JOIN�� ũ�� "����Ŭ ���� ����"�� "ANSI����" (�̱����� ǥ�� ��ȸ)

����Ŭ ���� ����             |       ANSI ����
-----------------------------------------------------------------------
� ����                  |       ��������
(EQUAL JOIN)              |     (INNER JOIN) --> JOIN USING/ON
----------------------------------------------------------------------
���� ����                   |      ���� �ܺ� ���� (LEFT OUTER JOIN)
(LEFT OUTER)              |       ������ �ܺ� ����(RIHT OUTER JOIN)
(RIGHT OUTER)             |    ��ü �ܺ� ���� ( FULL OUTER JOIN)
-----------------------------------------------------------------------
��ü ����(SELF JOIN)         |   JOIN ON
�� ����(NON EQUAL JOIN)  |       
--------------------------------------------------------------------------
*/
--��ü ������� ���, �����, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

--�μ� �ڵ�, �μ��� ��ȸ(�μ� ������ ����� ���̺�: DEPARTMENT)
SELECT DEPT_id, dept_title
FROM department;

--��ü ������� ���, �����, �����ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

--�����ڵ�, ���޸� ��ȸ(�������� : JOB)
SELECT JOB_CODE, JOB_NAME
FROM JOB;

/*
*����� / ��������
=>�����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ��ȸ(��ġ���� �ʴ� ���� ��ȸ�� ����)
*/

--����Ŭ ���� ����
/*
*FROM���� ��ȸ�ϰ����ϴ� ���̺��� ����(,�� ����)
*WHERE���� ��Ī��ų �÷��� ���� ���� �ۼ�
*/
--����� ���,�̸�, �μ����� ��ȸ(�μ��ڵ� �÷� => EMPLOYEE: DEPT_CODE, DEPARTMENT: DEPT_ID)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--=>NULL(EMPLOYEE.DEPT_CODE),�����ú�(D3), �ؿܿ��� 3��(D7), ����������(D4) -> DEPARTMENT �����ʹ� ���ܵ�
--�� ���̺��� �����ϴ� ����� ��ȸ�ؼ� ���ܵ�

--����� ���, �̸�, ���޸��� ��ȸ(�����ڵ� Į��=> EMPLOYEE: JOB_CODE, JOB: JOB_CODE)
--�� ���̺��� �÷����� ������ ��� ��Ī�� ���������μ� ������ �� �ִ�.
SELECT EMP_ID,EMP_NAME,JOB_NAME
FROM employee E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE; 

--ANSI ����--
/*
FROM ���� ������ �Ǵ� ���̺��� �ϳ� �ۼ�
JOIN���� �����ϰ��� �ϴ� ���̺��� ��� + ��Ī��Ű���� �ϴ� ������ �ۼ�
-JOIN USING : �÷����� ���� ���
-JOIN ON : �÷����� ���ų� �ٸ� ���
*/
-- ���, �����, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN department ON(DEPT_CODE = DEPT_ID);

--��� ����� ���޸� ��ȸ(EMPLOYEE: JOB_CODE, JOB: JOB_CODE)
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM employee
JOIN job USING (JOB_CODE);

--JOIN ON ���� ���
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM employee E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

--�븮 ������ ����� ���, �����, ���޸�, �޿� ��ȸ
SELECT EMP_NAME, EMP_ID, JOB_NAME, SALARY 
FROM EMPLOYEE E, job J
WHERE E.JOB_CODE = J.JOB_CODE 
AND JOB_NAME = '�븮';

SELECT EMP_NAME, EMP_ID, JOB_NAME, SALARY 
FROM EMPLOYEE 
JOIN job USING (JOB_CODE)
WHERE JOB_NAME = '�븮';
----------------------------����---------------------

--[1] �μ��� �λ�������� ������� ���, �����, ���ʽ� ��ȸ
--����Ŭ
SELECT EMP_NAME, EMP_ID, BONUS
FROM EMPLOYEE , DEPARTMENT 
WHERE dept_code = dept_id
AND DEPT_TITLE = '�λ������';

--ANSI
SELECT EMP_NAME, EMP_ID, BONUS
FROM EMPLOYEE 
JOIN department ON (dept_code = DEPT_ID)
WHERE DEPT_TITLE = '�λ������';

--[2]�μ�(DEPARTMENT)�� ����(LOCATION) ������ �����Ͽ� 
--��ü �μ��� �μ� �ڵ�, �μ���, ���� �ڵ�, ������ ��ȸ 
--����Ŭ
SELECT dept_id, DEPT_TITLE, LOCATION_ID, LOCAL_NAME  
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;
--ANSI
SELECT dept_id, DEPT_TITLE, LOCATION_ID, LOCAL_NAME  
FROM DEPARTMENT
JOIN location ON (LOCATION_ID = LOCAL_CODE);

--[3] ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
--����Ŭ
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE  
FROM EMPLOYEE, department
WHERE DEPT_CODE =DEPT_ID AND BONUS IS NOT NULL;
--ANSI
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE  
FROM EMPLOYEE
JOIN department ON dept_code= DEPT_ID
WHERE BONUS IS NOT NULL;
--[4] �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿� ��ȸ
--����Ŭ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE, department
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE != '�ѹ���';
--ANSI
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
JOIN department ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE != '�ѹ���';
---------------------------------------------------------------
/*
�������� / �ܺ����� (OUTER JOIN)
: �� ���̺��� JOIN �� ��ġ���� �ʴ� �൵ ��ȸ�ϴ� ����
�� LEFT/RIGHT �����ؾ���(������ �Ǵ� ���̺�)
*/
--�����, �μ���, �޿�, ���� ���� ��ȸ
--*LEFT JOIN : �� ���̺� �� ���ʿ� �ۼ��� ���̺� ����
--����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, department
WHERE DEPT_CODE = DEPT_ID(+); --������ �ƴ� �÷��� +

--ANSI����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
LEFT JOIN department ON DEPT_CODE = DEPT_ID;

--*RIGHT JOIN : �� ���̺� �� �����ʿ� �ۼ��� ���̺� ����
--����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, department
WHERE DEPT_CODE(+) = DEPT_ID
ORDER BY EMP_NAME; 
--ANSI����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
RIGHT JOIN department ON DEPT_CODE = DEPT_ID;

--FULL JOIN : �� ���̺��� ���� ��� ���� ��ȸ(����Ŭ ���� ���� X)
--ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
FULL JOIN department ON DEPT_CODE = DEPT_ID;
-----------------------------------------------------
/*
�� ����(NON EQUAL JOIN)
:��Ī��ų Į���� ���� ���� �ۼ� �� '='�� ������� �ʴ� ����

*ANSI : ���������� JOIN ON�� ��� ����*
*/
-- ����� ���� �޿� ��� ��ȸ(�����, �޿�, �޿����)
-- ���(EMPLOYEE), �޿���� (SAL_GRADE)
--*����Ŭ*
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
--WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

--ANSI ����
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
--SALARY BETWEEN MIN_SAL AND MAX_SAL;
--------------------------------------------------------------
/*
��ü ����(SELF JOIN)
: ���� ���̺��� �ٽ��ѹ� �����ϴ� ����
*/
--��ü ����� ���, �����, �μ��ڵ�, ������, ��� �����, ��� �μ��ڵ� ��ȸ
--��� (EMPLOYEE), ���(���)(EMPLOYEE)--> ���̺� ���� �����ϹǷ� '��Ī' �ο�
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE,
M.EMP_ID, M.EMP_NAME, M.DEPT_CODE
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID; --����� �����ȣ�� ����� �������� �־� ��������� ��ȸ

--ANSI����
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE,
M.EMP_ID, M.EMP_NAME, M.DEPT_CODE
FROM EMPLOYEE E
JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;
--LEFT JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID; --����� ���� ��������� ��ȸ�ϰ��� �� ��
------------------------------------------------------------------
/*
���� ����
: 2�� �̻��� ���̺��� �����ϴ� ��
*/
--���, �����, �μ���,���޸� ��ȸ
--���(EMPLOYEE) / �μ�(DEPARTMENT) / ����(JOB)
--����Ŭ ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

--ANSI����

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE); --������ ���� ��� ����

--���, �����, �μ���, ������ ��ȸ
SELECT*FROM EMPLOYEE; -- �μ��ڵ� : DEPT_CODE
SELECT*FROM DEPARTMENT; -- �μ��ڵ� : DEPT_ID, �����ڵ�: LICATION_ID
SELECT*FROM location; --�����ڵ� : LOCAL_CODE

--����Ŭ ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, location
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE;
--ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID --EMPLOYEE ���̺�� DEPARTMENT ���̺� ����
JOIN location ON LOCATION_ID = LOCAL_CODE; -- DEPARTMENT ���̺�� LOCATION ���̺� ����
--------------------------------------

--1) ���, �����, �μ���, ������, ������ ��ȸ

--����Ŭ ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION L, NATIONAL N
WHERE DEPT_CODE = DEPT_ID
AND l.national_code = n.national_code
AND location_id = local_code;
--ANSI����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
FROM EMPLOYEE 
join DEPARTMENT on DEPT_CODE = DEPT_ID
join LOCATION on location_id = local_code
join national using (national_code);

--2)���, �����,�μ���, ������, ������ �޿���� ��ȸ
--����Ŭ ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, job_name, local_NAME, SAL_LEVEL
FROM EMPLOYEE e, DEPARTMENT, LOCATION l, national n, job j, SAL_GRADE
WHERE DEPT_CODE = DEPT_ID
and e.job_code = j.job_code
and salary between min_sal and max_sal
and location_id = local_code
and l.national_code = n.national_code;



--ANSI����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, job_name, local_NAME, SAL_LEVEL
FROM EMPLOYEE 
join DEPARTMENT on DEPT_CODE = DEPT_ID
join job using (job_code)
join sal_grade on salary between min_sal and max_sal
join LOCATION on location_id = local_code
join national using (national_code);























