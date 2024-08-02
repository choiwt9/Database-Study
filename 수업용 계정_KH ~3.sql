-- ��������???�������� ������ ���� ���� �� �Ʒ� SQL���� �ۼ����ּ��� ��������???��������
--============================================================================--
-- [1] '240724' ���ڿ��� '2024�� 7�� 24��'�� ǥ���غ���

select to_char(to_date('240724'), 'yyyy "��" fmmm "��" dd"��"')
from dual;

--fm�� �տ� ���̸� 0�� ����
-- [2] ������ �¾ �� ��ĥ°���� Ȯ���غ��� (���糯¥ - �������)

select ceil(sysdate - TO_DATE('93/10/15'))
from dual;

-- [3] ���� ������ �ٲ㺸��
-- bElIVe iN YoURseLF.      -->  Belive in yourself.
select concat(upper(substr('bElIVe iN YoURseLF.', 1, 1)),lower(substr('bElIVe iN YoURseLF.', 2)))
from dual;
-- [4] ������ 7�������� ������� �Ի���� ��� �� ��ȸ (�Ʒ��� ���� ���)
/*
------------------------------------------------------------
    ����     |   �Ի��   |   �Ի� �����|
         7�� |       4�� |          2��|
         7�� |       9�� |          1��|
         ...
         9�� |       6�� |          1��|
------------------------------------------------------------
*/
select lpad(substr(emp_no, 3, 2) || '��', 8) "����",
lpad(EXTRACT(MONTH from hire_date)|| '��', 8) as "�Ի��"
,lpad(count(*) || '��', 5) "�Ի� �����"
from employee
where to_number(substr(emp_no, 3, 2)) >= 7
group by substr(emp_no, 3, 2), EXTRACT(MONTH from hire_date)
order by ����, 2;
-- [5] �����μ� ����� ���, �����, �μ���, ���޸� ��ȸ
select emp_id, emp_name, dept_title, job_name
from employee
join department on (dept_code = dept_id)
join job using (job_code)
where dept_title like '%����%';
