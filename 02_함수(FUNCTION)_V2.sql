--�Լ� �ι�° ����
/*
�����Լ� 
*DECODE(�񱳴��(�÷�/�����/�Լ���), �񱳰�1, �����1, �񱳰�2, �����2,...)

--�ڹ� switch(�񱳴��){
case �񱳰� 1: �����
case �񱳰� 2: �����
}
*/

--��� ����� �ֹι�ȣ, ���� ��ȸ 1: '��', 2: '��', 3: '����', 4: '����', '�� �� ����
SELECT EMP_ID, EMP_NAME, EMP_NO, 
DECODE(SUBSTR(EMP_NO,8,1), 1, '��', 2, '��',3,'����',4,'����','�� �� ����' )
FROM EMPLOYEE;

--����� ���� �޿�, �λ�� �޿� ��ȸ
/*
������ J7�� ��� 10% �λ�
J6 15% �λ� 
J5 20% �λ� 
�� �ܿ��� 5% �λ�
*/
SELECT EMP_NAME �����, SALARY �����޿�,
SALARY *DECODE(JOB_CODE, 'J7', 1.1, 'J6', 1.15, 'J5', 1.2, 1.05) �λ�ȱ޿�
FROM EMPLOYEE;
/*
CASE WHEN THEN : ���ǽĿ� ���� ������� ��ȯ���ִ� �Լ�
[ǥ����]
CASE
      WHEN ���ǽ�1 : THEN �����1
      WHEN ���ǽ�2 : THEN �����2
      .....
      ELSE �����
END
*/
-- �����, �޿������� ��� ��ȸ
/*
500���� �̻�'���' 350���� �̻� '�߱�' �׿� '�ʱ�'
*/
SELECT emp_name, salary, 
CASE
WHEN SALARY >= 5000000 THEN '���'
WHEN SALARY >= 3500000 THEN '�߱�'
ELSE '�ʱ�'
END "�޿��� ���� ���"
FROM EMPLOYEE;
--====================================================
------------------------�׷��Լ�-------------------------
/*
*SUM : �ش� �÷� ����l ������ ��ȯ

[ǥ����] 
SUM[����Ÿ��Į��]
*/
--��ü ����� �� �޿��� ��ȸ
SELECT SUM(SALARY) FROM EMPLOYEE;

SELECT TO_CHAR(SUM(SALARY), 'L999,999,999')�ѱ޿� FROM EMPLOYEE;
-- ���� ������� �ѱ޿�
SELECT SUM(SALARY)
FROM employee
WHERE SUBSTR(EMP_NO, '8', '1') IN (1, 3); 
--���� ������� �ѱ޿�
SELECT SUM(SALARY)
FROM employee
WHERE SUBSTR(EMP_NO, '8', '1') IN (2, 4);

--�μ��ڵ尡 'D5'�� ������� �� �޿�
SELECT SUM(SALARY*12)
FROM employee
WHERE DEPT_CODE = 'D5';

/*
AVG : �ش� �÷��� ������ ����� ��ȯ


[ǥ����]
AVG(����Ÿ���÷�)
*/
--��ü�����ձ޿�(�ݿø� ����)
SELECT ROUND(AVG(SALARY))
FROM employee;

/*
MIN : �ش� �÷��� ���� �� ���� ���� �� ��ȯ
[ǥ����]MIN(��� Ÿ��)
*/

SELECT MIN(EMP_NAME), MIN(SALARY),MIN(HIRE_DATE)
FROM employee;

/*
MAX : �ش� �÷��� ���� �� ���� ū ���� ��ȯ
[ǥ����] MAX (��� Ÿ��)
*/
SELECT MAX(EMP_NAME), MAX(SALARY),MAX(HIRE_DATE)
FROM employee;

/*
COUNT : ���� ������ ��ȯ���ִ� �Լ� (��, ������ ���� ��� �ش� ���ǿ� �´� ���� ���� ��ȯ)
[ǥ����]
COUNT(*): ��ȸ�� ����� ��� ���� ������ ��ȯ
COUNT(�÷�) : �ش� �÷����� NULL�� �ƴ� �͸� ���� ������ ���� ��ȯ
COUNT(DISTINCT �÷�) : �ش��÷� ���� �ߺ��� ������ �� ���� ������ ���� ��ȯ
=> �ߺ� ���� �� NULL�� �������� �ʰ� ������ ������!
*/

-- ��ü ��� �� ��ȸ
SELECT COUNT(*) "��ü ��� ��" FROM employee;

--���� �����
SELECT COUNT(*)
FROM employee
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');
--���ʽ� �޴� ��� ��
SELECT COUNT(BONUS)
FROM employee;

SELECT COUNT(*)
FROM employee
WHERE BONUS IS NOT NULL;

--�μ� ��ġ ���� ��� �� ��ȸ=> �μ� �ڵ尡 NULL�� �ƴ� ���� ����
SELECT COUNT(DEPT_CODE) FROM employee;

SELECT COUNT(DISTINCT DEPT_CODE) FROM employee;





