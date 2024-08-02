-- ��� ���̺��� ��� ���� ��ȸ

SELECT*FROM employee;

-- ���ʽ��� �ִ� ����� �����, �޿�, ���ʽ�, �����ڵ� ��ȸ

SELECT EMP_NAME, SALARY, BONUS, job_code
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;     --BONUS�� NULL�� �ƴ�

-- �̸����� 3��° ���ڰ� m�� ����� ��� ���� ��ȸ

SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '__m%';
--���ϵ�ī�� ��ȣ  LIKE '__\_' ESCAPE '\'

-- ���� ��� �� ��ȸ

SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (2,4);

-- ������� ���� ����� �޿� �� ��ȸ

SELECT TO_CHAR(SUM(SALARY),'L99,999,999') "�޿� ��"
FROM employee
WHERE ENT_YN='N';

-- 9���� �Ի��� ��� �� ��ȸ

SELECT COUNT(*)
FROM employee
WHERE EXTRACT(MONTH FROM hire_date) = 9;

----------------------------------------------------------
/*
	* �˻��ϰ��� �ϴ� ���� :
	
		�����ڵ尡 J7�̰ų� J6�̸鼭 SALARY ���� 200���� �̻��̰�
		BONUS�� �ְ� �����̸� �̸����ּҴ� _�տ� 3���ڸ� �ִ� �����
		�����, �ֹε�Ϲ�ȣ, �����ڵ�, �μ��ڵ�, �޿�, ���ʽ��� ��ȸ�ϰ��� �Ѵ�.
		
		(���������� ��ȸ�� �ȴٸ� 2���� ����� Ȯ���� �� ����)
*/

-- �Ʒ� ���������� ���� �� ���ϴ� ����� ������ �ʴ´�. 
--  � ������ �ִ� �� ������ �ľ��Ͽ� �ۼ��� ��, �ذ����ּ���.
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
      AND EMAIL LIKE '____%' AND BONUS IS NULL;
-- ���� :
/*
1) ���� �ڵ��� ������ �켱 ������ ���� ����� ������� �ʴ´�
=> ��ȣ�� �����ְų�  OR�� IN���� �ٲ���� �Ѵ�.
2)SALARY ������ �ʰ��� �Ǿ� �ִ�
=> >�� >=�� �ٲ���� �Ѵ�.
3)�̸����� �׹�°�ڸ��� �����(_)�� �����ν� ������ �ְ��� �Ѵٸ�  
ESCAPE �� ����Ͽ� ������ ���ϵ�ī��� ��������� ��
=> LIKE '___#_% ESCAPE '#'
4) ���ʽ��� �ִ� ����� ��ȸ�ؾ� �ϴ� �� ���� ����� ��ȸ�ϰ� �ִ�
=> BONUS IS NULL -> BONUS IS NOT NULL
5) ���� ��� ������ ����
=> AND SUBSTR(EMP_NO, 8 ,1)IN (2, 4); �߰������ ��

*/
