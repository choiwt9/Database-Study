SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL; --12 �ð���
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; --���� ���� ǥ��
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; --24�ð���

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
-- DAY : �������� (X ����)
--DY : ���� ���� (X) -> '��' '��' 'ȭ' '��' .........'��'

SELECT TO_CHAR(SYSDATE, 'MON') FROM DUAL;
--MON, MONTH :�� ���� (X��)

--��� ���̺��� ����� �Ի� ��¥ ��ȸ (XXXX�� XX�� XX�� �� ��ȸ)
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') 
FROM EMPLOYEE;
--=> ǥ���� ����(����)�� ū����ǥ("")�� ��� ���Ŀ� �����ؾ���!
/*
*YYYY : ������ ���ڸ��� ǥ��--> 50�� ���� ��¥�� 2000���� �ν� => 205X
 YY:  ������ ���ڸ��� ǥ��
 RRRR: ������ ���ڸ��� ǥ�� --> 50�� �̻� ���� --> 195X
 RR: ������ ���ڸ��� ǥ�� 
*/

/*
*���� ���õ� ����
*MM �� ������ 2�ڸ��� ǥ��
MOM /MONTH : �� ������ 'X��' 'JULY'�������� ǥ��-> ��� ������ ���� �ٸ�����!
*/

SELECT TO_CHAR(SYSDATE,'MM')"���ڸ� ǥ��" ,
TO_CHAR(SYSDATE,'MON'),
TO_CHAR(SYSDATE,'MONTH')
FROM DUAL;

/*
�ϰ� ���õ� ���� 
*DD : �� ������ 2�ڸ��� ǥ��
 DDD : �ش� ��¥�� �� �� ���� ���° �ϼ�
 D : ���� ���� => ����Ÿ��(1: �Ͽ���....7. �����)
 DAY : "X����"
 DY : "X" ǥ��
*/
SELECT TO_CHAR(SYSDATE, 'DD')"�� ����", 
TO_CHAR(SYSDATE, 'DDD')"���° �ϼ�",
TO_CHAR(SYSDATE, 'D')"���� ����",
TO_CHAR(SYSDATE, 'DAY'),
TO_CHAR(SYSDATE, 'DY')
FROM DUAL;
-----------------------------------------
/*
*TO_DATE : ���� Ÿ���̳� ����Ÿ���� ��¥ Ÿ������ ����

[ǥ����]
TO_DATE(����|����[,����]) => ��¥Ÿ��
*/

SELECT TO_DATE(20240719) FROM DUAL;
SELECT TO_DATE(240719) FROM DUAL;  --> �ڵ����� 50�� �̸��� 20XX�� ����
SELECT TO_DATE(880719) FROM DUAL; --> �ڵ����� 50�� �̻��� 19XX�� ����
SELECT TO_DATE(020222) FROM DUAL; --> ���ڴ� 0���� �����ϸ� �ȵ�! 
SELECT TO_DATE('020222') FROM DUAL; --> 0���� ���۵Ǵ� ��� ����Ÿ������ ����

SELECT TO_DATE('20240719 104900') FROM DUAL; --> �̰�� ������ �����ؾ� ��
SELECT TO_DATE('20240719 104900', 'YYYYMMDD HH24MISS') FROM DUAL;

---------------------------------------------

/*
TO_NUMBER :���� Ÿ���� �����͸� ����Ÿ������ ����
[ǥ����]
TO_NUMBER(����[,����]) : ���ڿ� ���� ������ ���� (��ȣ�� ���Եǰų� ȭ����� ���ԵǴ� ���...)
*/

SELECT TO_NUMBER('0123456789')FROM DUAL;

SELECT '10000' + '500' FROM DUAL; -- �ڵ����� ����-->���� Ÿ������ ��ȯ�Ǿ� ������� �����
SELECT '10,000' + '500' FROM DUAL;
SELECT TO_NUMBER('10,000', '99,999') + TO_NUMBER('500', '999') FROM DUAL;
--==============================================================

/*
NULL ó�� �Լ� 
*/
/*
*NVL : �ش� �÷��� ���� NULL�� ��� �ٸ� ������ ����� �� �ֵ��� ��ȯ���ִ� �Լ�

[ǥ����]
 NVL(�÷�, �ش� �÷��� ���� NULL�� ��� ����� ��)
*/
-- ��� ���̺��� ���� NULL �ΰ�� 0���� ��ȸ

SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

--��� �׺��� ����� ���ʽ� ���� ���� ��ȸ
SELECT EMP_NAME,NVL(BONUS,0), SALARY*12, (SALARY + (SALARY*NVL(BONUS,0)))*12
FROM EMPLOYEE;

/*
NVL2 : �ش� �÷��� NULL�� ��� ǥ���� ���� �������
                 NULL�� �ƴ� ��� (�����Ͱ� �����ϴ� ���)ǥ���� ���� ����
                 
[ǥ����]
NVL2(�÷�, �����Ͱ� ������ ��� ����� ��, NULL�� ��� ����� ��)
*/
--�����, ���ʽ� ���� (O,X) ��ȸ
SELECT EMP_NAME, NVL2(BONUS, 'O','X')"���ʽ� ����"
FROM employee;

--�����, �μ��ڵ�, �μ� ��ġ ����('�����Ϸ�, �̹���)��ȸ
SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '�����Ϸ�','�̹���')"�μ� ��ġ ����"
FROM employee;

--NULLIF : �� ���� ��ġ�ϸ� NULL, ��ġ���� ������ �񱳴��1��ȯ
--[ ǥ���� ] NULLIF(�񱳴��1, �񱳴��2)

SELECT NULLIF('999', '999') FROM DUAL;
SELECT NULLIF('999', '555') FROM DUAL;
--====================================================








