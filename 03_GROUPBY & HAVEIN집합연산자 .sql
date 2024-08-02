/*
GRUP BY ��
: �׷� ������ ������ �� �ִ� ����
: �������� ������ �ϳ��� �׷����� ��� ó���ϴ� �������� ��� 
*/
-- ��ü ����� �޿� ���� ��ȸ
SELECT SUM (SALARY)
FROM employee;

--�μ��� �޿� ����
SELECT DEPT_CODE, SUM (SALARY)
FROM employee
GROUP BY DEPT_CODE;

--�μ��� ��� �� ��ȸ
SELECT DEPT_CODE, COUNT(*)     --3   
FROM employee                  --1
GROUP BY DEPT_CODE;            --2

--�μ��ڵ尡 D6, D9, D1�� �� �μ��� �� �� ��� �� ��ȸ
SELECT DEPT_CODE, SUM (SALARY), COUNT(*)           --4
FROM employee                                      --1
WHERE DEPT_CODE IN('D6', 'D9', 'D1')               --2
GROUP BY DEPT_CODE                                 --3
ORDER BY DEPT_CODE;                                --5

--�� ���޺� �� ��� ��/���ʽ��� �޴� ��� ��/ �޿���/��� �޿�/�����޿�/�ְ�޿� ��ȸ �����ڵ� ��������
SELECT JOB_CODE, COUNT(*), COUNT(BONUS), 
SUM(SALARY), ROUND(AVG(SALARY)), MIN(SALARY), MAX(SALARY) 
FROM employee 
GROUP BY job_code  
ORDER BY job_code;

--���� ��� ��, ���� ��� �� ��ȸ
SELECT DECODE(SUBSTR(EMP_NO, 8 ,1), '1', '��', '2', '��')"����", COUNT(*)"��� ��"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8 ,1);

--�μ���, ���޺� �����, �޿� ���� ��ȸ
SELECT DEPT_CODE, JOB_CODE, COUNT(*),SUM (SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE --�μ��ڵ� �������� �׷�ȭ�ϰ� �� ������ �����ڵ� �������� ���α׷�ȭ
ORDER BY DEPT_CODE;
-------------------------------------------------------------------
/*
HAVING ��
: �׷쿡 ���� ������ ������ �� ���Ǵ� ���� ( ���� �׷�ȭ �Լ����� ������ ������ �ۼ���)
*/
-- �� �μ��� ��� �޿� ��ȸ (�μ��ڵ�, ��� �޿�-->�ݿø�ó��)
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM employee
where SALARY >= 3000000
GROUP BY DEPT_CODE;

--�� �μ��� ��ձ޿��� 300���� �̻��κμ��� ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM employee
--where AVG(SALARY) >= 3000000 �׷��Լ��� where�� ��� �Ұ�
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

--���޺� �۱� �ڵ�, �� �޿� �� ��ȸ(�� ���޺� �޿� ���� 1000���� �̻��� ���޸� ��ȸ)
SELECT JOB_CODE, SUM(SALARY)
from employee
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

--�μ��� ���ʽ��� �޴� ����� ���� �μ��� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
from employee
--WHERE BONUS IS NULL  �μ� ��� ���� ���ʽ��� NULL�� ������� ���� �ɷ���
--> �ش� �μ��� ���ʽ��� �ִ� ����� ���� ���� �ִ�
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0; --�׷�ȭ�� �� COUNT�Լ��� ����Ͽ� BONUS�� �޴� ����� ���� ������ ����ؾ���

--------------------------------------
/*
*���� ����
SELECT * | ��ȸ�ϰ��� �ϴ� �÷� AS"��Ī" | �Լ��� | ����� --5
FROM ��ȸ�ϰ��� �ϴ� ���̺� |DUAL          --1
WHERE ���ǽ� (�����ڵ��� ����Ͽ� �ۼ�)       --2
GROUP BY : �׷�ȭ�� ������ �Ǵ� Į�� | �Լ���   --3
HAVING ���ǽ� (�׷��Լ��� Ȱ���Ͽ� �ۼ�)        --4
ORDER BY �÷�| ��Ī | �÷����� [ASC|DESC] [NULLS FIRST | NULLS LAST]  --6

-> ����Ŭ�� ����(��ġ)1���� ����
*/
-----------------------------------------------------------
/*
���� ������
: �������� �������� �ϳ��� ���������� ������ִ� ������

-UNION : ������ OR (�� �������� ������ ������� ������)
-INTERSECT : ������ AND (�� �������� ������ ������� �ߺ��� �κ��� ����)
-UNION ALL : ������ + ������ (�ߺ��Ǵ� �κ��� �ι� ��ȸ�� �� �ִ�)
-MINUS : ������(���� ������� ���� ������� �� ������)
*/
--**UNION**
-- �μ��ڵ尡 D5�� ��� �Ǵ� �޿��� 300���� �ʰ��� ������� ���, �̸�, �λ� �ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

--�μ��ڵ尡 D5�� ����� ���, �̸�, �λ� �ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5';

--�޿��� 300���� �ʰ��� ������� ���, �̸�, �λ� �ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > 3000000;

--UNION���� ���� 2�� �������� ��ġ��

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > 3000000;  --OR�� �����ϰ� ���

--������(INTERSECT)
--�μ��ڵ尡 D5�� ��� �̰� �޿��� 300���� �ʰ��� ������� ���, �̸�, ��TJ �ڵ�, �޿� ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > 3000000;

--UNION ALL

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5' --12��
UNION ALL --14��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > 3000000; --2��

-- MINUS
--���� ��������� ���� ������� �� ������
--�μ� �ڵ尡 D5�� ����� �� �޿��� 300���� �ʰ��� ������� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5' 
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > 3000000; 
-------------------------------------------------------------
/*
 ���� ������ ���� ���� ���� 
 1) �������� �÷� ������ ����
 2) �÷��ڸ����� ������ Ÿ������ �ۼ�
 3) �����ϰ��� �Ѵٸ� ORDER BY�� �������� �ۼ��ؾ���
*/
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > 3000000  --OR�� �����ϰ� ���
ORDER BY EMP_ID;


































