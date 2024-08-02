--=========================================================================
-- ������ ���� �α��� �� �Ʒ� ������ ��ȸ�� �� �ִ� �������� �ۼ����ּ��� :D
--=========================================================================
-- �̸����� ���̵� �κп�(@ �պκ�) k�� ���Ե� ��� ���� ��ȸ
select *  
from employee
where email like '%k%@%'; 

-- �μ��� ����� ���� ��� �� ��ȸ
select dept_code, count(*)
from employee
where manager_id is null
group by dept_code;

-- ����ó ���ڸ��� 010, 011�� �����ϴ� ��� �� ��ȸ
select substr (phone,1,3), count(*)
from employee
where substr (phone,1,3) in('011', '010')
group by substr (phone,1,3);

-- �μ��� ����� ���� ��� ���� ��ȸ (�μ���, ���, ����� ��ȸ)
--������� : employee, �μ����� : department --> ����� �÷� : �μ� �ڵ�(dept_code, dept_id)
-- ** ����Ŭ ���� **
select dept_title ,emp_id ,Emp_name
from employee, department
where dept_code = dept_id --������ �� ������ �Ǵ� �÷�
and manager_id is null;

-- ** ANSI ���� **
select dept_title ,emp_id ,Emp_name
from employee 
join department on dept_code = dept_id
where manager_id is null;
-- �μ��� ����� ���� ��� �� ��ȸ (�μ���, ����� ��ȸ)
-- ** ����Ŭ ���� **
select dept_title, count(*)
from employee, department
where dept_code = dept_id
and manager_id is null
group by dept_title;
-- ** ANSI ���� **
select dept_title, count(*)
from employee
join department on dept_code = dept_id
where manager_id is null
group by dept_title;





