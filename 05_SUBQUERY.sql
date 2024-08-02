/*
 ��������(SUBQUERY)
 :������ ���� �Ǵٸ� ������
 ���� ������ �ϴ� �������� ���� ���� ������ �ϴ� ������
*/

--"���ö"����� ���� �μ��� ���� ��� ���� ��ȸ

--1)���ö ����� �μ��ڵ� ��ȸ
SELECT dept_code
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';

--2)�μ��ڵ尡 D9�� ��� ��ȸ

SELECT *
FROM EMPLOYEE
WHERE dept_code = 'D9';

--3) �� �������� �ϳ��� ��ħ
SELECT *
FROM EMPLOYEE
WHERE dept_code = (SELECT dept_code
                FROM EMPLOYEE
                 WHERE EMP_NAME = '���ö');
                 
-- ��ü ��� ��ձ޿����� �� ���� �޿��� �޴� ��� ��ȸ
--1) ��ü ��� ��� �޿�
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;
--2)��ձ޿����� �� ���� �޴� ��� ��ȸ
SELECT emp_name, salary, job_code
FROM EMPLOYEE
WHERE SALARY >= 3047663;
--3)�������� ����
SELECT emp_name, salary, job_code
FROM EMPLOYEE
WHERE SALARY >=(SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE);
--------------------------------------------
/*
�������� ����
���������� ������ ������� ���� ��� �����Ŀ� ���� �з�

-������ �������� : ���������� ���� ����� ������ 1���� ��(1�� 1��)
-������ �������� : ���������� ���� ����� �������϶� (N �� 1��)
-���߿� �������� : �������� �������� ����, ���� �÷��� ��(1�� N��)
-������, ���߿� �������� : ���������� ���� ����� ������ ���� �÷��϶�(N��N��)

>> ������ ���� �������� �տ� �ٴ� �����ڰ� �޶���
*/
--������ ��������
/*
�Ϲ����� �񱳿����� ��밡�� : =, !=, <=, >=, <, >
*/
--�� ���� ��� �޿����� �� ���� �޿��� �޴� ������� �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY) FROM employee);

--���� �޿��� �޴� ����� �����, �޿�, �Ի��� ��ȸ
--�����޿� ��ȸ
SELECT MIN (SALARY)
FROM employee;

SELECT EMP_name, salary, hire_date
from employee
where salary = (SELECT MIN (SALARY)
FROM employee);
--'���ö' ����� �޿����� ���� �޴� ����� �����, �μ��ڵ�, �޿� ��ȸ
--salary > '���ö' ����� �޿�
select salary
from employee
where emp_name = '���ö';

select emp_name, dept_code, salary
from employee
where salary > (select salary
from employee
where emp_name = '���ö');

--���� ������� �μ� �ڵ带 �μ������� �����Ͽ� ��ȸ
select emp_name, dept_title, salary
from employee, department
where dept_code = dept_id 
and salary > (select salary
from employee
where emp_name = '���ö');

--ANSI����

select emp_name, dept_title, salary
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE SALARY > (select salary
from employee
where emp_name = '���ö');

--�μ��� �޿� ���� ���� ū �μ��� �μ��ڵ�, �޿����� ��ȸ
--1)�μ��� �޿� �� �� ���� ū ���� �ϳ��� ��ȸ --> 17700000
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;
--2) �μ��� �޿� ���� 17700000�� �μ��� �޿��� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;

--�� ������ ���غ���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);
--������ ����� ���� �μ��� ������� ���, �����, ����ó, �Ի���, �μ��� ��ȸ
--�� �������� ����

--����Ŭ ����
SELECT EMP_NO, EMP_NAME,PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE=DEPT_ID
AND DEPT_CODE=(SELECT DEPT_CODE
FROM EMPLOYEE 
WHERE EMP_NAME = '������')
AND EMP_NAME <> '������';
-- ANSI
SELECT EMP_NO, EMP_NAME,PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN department ON DEPT_CODE = DEPT_ID
WHERE DEPT_CODE = (SELECT DEPT_CODE
FROM EMPLOYEE 
WHERE EMP_NAME = '������')
AND EMP_NAME != '������';
--------------------------------------------------
/*
������ �������� : �������� ���� ������ �������� ��� (N�� 1��)
IN (��������) : ���� ���� ����� �߿��� �ϳ��� ��ġ�ϴ� ���� �ִٸ� ��ȸ
>ANY(��������) : �������� ����� �߿��� �ϳ��� ū ��찡 ������ ��ȸ
<ANY(��������) : �������� ����� �߿��� �ϳ��� ���� ��찡 ������ ��ȸ
*�񱳴�� > �� 1 OR �񱳴�� > ����� 2 OR �񱳴�� > ����� 3.....

>ALL (��������) : �������� ��� ��������� Ŭ ���
<ALL (��������) : �������� ��� ��������� ���� ���
*�񱳴�� > �����1 AND �񱳴�� > �����2 AND �񱳴�� > �����3....
*/
--����� �Ǵ� ������ ����� ���� ������ ������� ���� ��ȸ (���/�����/�����ڵ�/�޿�)
--����� �Ǵ� ������ ����� �����ڵ� ��ȸ
SELECT JOB_CODE
FROM employee
WHERE emp_NAME IN('�����', '������');

--�����ڵ尡 J3 �Ǵ� J7 �� ������� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');
                      
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE               
WHERE JOB_CODE IN( SELECT JOB_CODE
                   FROM employee
                   WHERE emp_NAME IN('�����', '������'));            
                      
--�븮 ������ ����� �� ���� ������ ����� �ּ� �޿����� ���� �޴� ������� ��ȸ(���, �̸�, ���޸�, �޿�)
--���� ���� �޿�
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';
-- ANY ������ ����Ͽ� ��
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND SALARY > ANY(SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����')
AND JOB_NAME = '�븮';
--------------------------------------------------
/*
���߿� ���� ���� : �������� ���� ����� ���� �ϳ��̰� �÷�(��)���� �������� ���
*/
-- ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ������� ��ȸ
--1) ������ ��� �μ��ڵ�, �����ڵ�
select dept_code, job_code
from employee
where emp_name ='������';
                      
select job_code
from employee
where emp_name ='������';  

select dept_code
from employee
where emp_name ='������';
 -----------------------------  
 --������ ���������� ����� ���
select emp_name, dept_code, job_code, salary
from employee
where dept_code = (select dept_code
from employee
where emp_name ='������')
and job_code =(select job_code
from employee
where emp_name ='������');
-------------------------
--������ ���������� ����� ���
select emp_name, dept_code, job_code, salary
from employee
where (dept_code, job_code) = (select dept_code, job_code
from employee
where emp_name ='������');

-------------------------------------------
--�ڳ��� ����� ���� �����ڵ�, ���� ����� ���� �ִ� ������� ��ȸ
--1)�ڳ��� ����� �����ڵ�, �����ȣ ��ȸ
select job_code, manager_id
from employee
where emp_name = '�ڳ���';

--2) ���� �����ڵ� ���� ����� ������ �ִ� ������� ��ȸ
select emp_name, job_code, manager_id
from employee
where(job_code, manager_id) = (select job_code, manager_id
from employee
where emp_name = '�ڳ���')
and emp_name != '�ڳ���';
-------------------------------------------------------
/*
������ ���߿� �������� : �������� ����� ������, �������� ���
*/
--�� ���޺� �ּұ޿� �޴� ������� ��ȸ
--1)�� ���޺� �ּ� �޿�
select job_code, min(salary)
from employee
group by job_code;           

--2)�� ���޺� �ּұ޿� �޴� ��� ��ȸ

select emp_id, emp_name, job_code, salary
from employee
where job_code = 'j1' and salary= 8000000
   or job_code = 'j2' and salary= 3700000
   or job_code = 'j3' and salary= 3400000;
                      
select emp_id, emp_name, job_code, salary
from employee
where (job_code, salary) in (select job_code, min(salary)
                          from employee
                         group by job_code );
--�� �μ����� �ְ�޿� �޴� ��� ���� ��ȸ
select dept_code, max(salary)
from employee
group by dept_code; 

select emp_id, emp_name, dept_code, salary
from employee
where(dept_code, salary) in (select dept_code, max(salary)
                        from employee
                        group by dept_code); 
-------------------------------------------------
/*
�ζ��� �� : ���������� from���� ����ϴ� ��
=> ���������� �������� ��ġ ���̺�ó�� ����ϴ� ��
*/
--������� ���, �̸�, ���ʽ� ���� ����, �μ��ڵ� ��ȸ
--���ʽ� ���� ������ null�� �ƴϾ�� �ϰ� 3000���� �̻��� ����鸸 ��ȸ
--=> null �ΰ�� �ٸ� ������ ����
select emp_no, emp_name, (salary + salary*nvl(bonus,0))*12, dept_code
from employee
where (salary + (salary*nvl(bonus,0)))*12 >=30000000
order by 3 desc;

-- => top - n �м� : ���� n�� ��ȸ
select rownum, ���, �̸�, ���ʽ����Կ���, �μ��ڵ�
from (select emp_no ���, emp_name �̸�, (salary + salary*nvl(bonus,0))*12 ���ʽ����Կ���, dept_code �μ��ڵ�
from employee
where (salary + (salary*nvl(bonus,0)))*12 >=30000000
order by 3 desc)
where rownum <= 5;

-- ���� �ֱٿ� �Ի��� ��� 5���� ��ȸ
-- �Ի��� ���� �������� ����(���, �̸�, �Ի���)
select emp_id ���, emp_name �̸�, hire_date �Ի���
from employee
order by hire_date desc;

select rownum, ���, �̸�, �Ի���
from (select emp_id ���, emp_name �̸�, hire_date �Ի���
      from employee
      order by hire_date desc)
where rownum <= 5;

-------------------------------------------------------

/*
������ �ű�� �Լ� (windo�� function)

- rank() over(���ı���) : ������ ���� ������ ����� ������ ����ŭ �ǳʶٰ� �������)
- dense() over(���ı���) : ������ ������ �ִ��� �� ���� ����� +1 �ؼ� �������

select �������� ��밡��
*/

--�޿��� ���� ������� ������ �Űܼ� ��ȸ

select emp_name, salary, rank()over(order by salary desc)"����"
from employee;

select emp_name, salary, dense_rank()over (order by salary desc)"����"
from employee;

--> ���� 5�� ��ȸ
select emp_name, salary, dense_rank()over (order by salary desc)"����"
from employee
where rownum <= 5;
                      
select * 
from (select emp_name, salary, dense_rank()over (order by salary desc)"����"
      from employee) 
where rownum <= 5;

--���� 3�� ~ 5�� ��ȸ
select*
from(
select emp_name, salary, dense_rank()over (order by salary desc)"����"
from employee) 
where ����>=3 and ����<=5;
-----------------------------------------------------------------------------
--1)
select rownum, emp_name, salary
from employee
where rownum<=5
order by salary desc;

--������ (����): ������ �Ǳ� ���� 5���� �߷���
--�ذ���
select * 
from(select rownum, emp_name, salary
from employee
order by salary desc)     
where rownum<=5;
                      
select dept_code, sum(salary)"����", floor(avg(salary)) as "���", count(*) "�ο���"
from employee
where salary > 2700000
group by dept_code
order by dept_code asc;
                      
--������ (����): �μ��� ��� �޿��� �ƴ� ��� ������ �޿��� Ȯ��
--�ذ���                    
select dept_code, sum(salary)"����", floor(avg(salary)) as "���", count(*) "�ο���"
from employee
--where salary > 2700000
group by dept_code
having floor(avg(salary))>2700000
order by dept_code asc;     

--�Ǵ�
select*
from(select dept_code, sum(salary)"����", floor(avg(salary)) as "���", count(*) "�ο���"
from employee
group by dept_code
order by dept_code asc)
where ��� >2700000;

                      
                      
                      
                      