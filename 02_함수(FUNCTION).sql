/*
*�Լ� (FUNCTION)
:���޵� Į������ �о �Լ��� ������ ����� ��ȯ

-������ �Լ� : N���� ���� �о N���� ������� ����(�ึ�� �Լ��� ������ ����� ��ȯ)
-�׷� �Լ� : N���� ���� �о 1���� ������� ����(�׷��� ���� �׷캰�� �Լ��� ������ ����� ��ȯ)

+SELECT���� ������ �Լ��� �׷��Լ��� �Բ� ����� �� ����
=> ������� ������ �ٸ��� ������

+�Լ����� ����� �� �ִ� ��ġ : SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING ��
*/
--======================������ �Լ�========================

/*
���� Ÿ���� ������ ó�� �Լ�
=> VARCHAR2, CHAR

*LENGTH(�÷���| '���ڿ�') : �ش� ���ڿ��� ���� �� ��ȯ
 LENGTHB(�÷���|'���ڿ�') : �ش� ���ڿ��� ����Ʈ�� ��ȯ
 
 => ������, ����, Ư������ ���ڴ� 1byte
    �ѱ��� ���ڴ� 3byte
*/
--'����Ŭ' �ܾ��� ���ڼ�, ����Ʈ �� Ȯ��
SELECT LENGTH('����Ŭ') ���ڼ�, LENGTHB('����Ŭ') ����Ʈ��
FROM DUAL;

SELECT LENGTH('ORACLE') ���ڼ�, LENGTHB('ORACLE') ����Ʈ��
FROM DUAL;

--EMPLOYEE ���̺��� �����, ����� ���ڼ�, ����� ����Ʈ��, �̸���, �̸��� ���ڼ�, �̸��� ����Ʈ��
SELECT EMP_NAME,  LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
|| EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;
--------------------------------------------
/*
*INSTR : ���ڿ��κ��� Ư�� ������ ���� ��ġ ��ȯ

[ǥ����]
INSTR(�÷�|'���ڿ�', 'ã�����ϴ� ����' [,ã�� ��ġ�� ���۰�, ����])
=> �Լ��������� ���� Ÿ��(NUMBER)
*/
SELECT INSTR('AABAACAABBAA', 'B' ) FROM DUAL; -- ���ʿ� �ִ� B�� ��ġ
SELECT INSTR('AABAACAABBAA', 'B', 1 ) FROM DUAL;-- ã�� ��ġ�� ���۰� :  1(�⺻��)
SELECT INSTR('AABAACAABBAA', 'B', -1 ) FROM DUAL;-- �������� ���۰����� �����ϸ� �ڿ������� ã�´�. 
                                                 --�� ��ġ�� ���� ���� �տ������� �о� ��ȯ
                                                 -- ���ʿ� �ִ� ù��° B�� ��ġ : 10
 SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- ������ ������ �� ���۰��� �����ؾ� �Ѵ�!
                                                    -- ���ʿ� �ִ� �ι��� B�� ��ġ : 9
 -- ��� ���� �� �̸��Ͽ�_�� ù��° ��ġ, @�� ��ġ 
 
 SELECT EMAIL, INSTR(EMAIL, '_', 1, 1)"_��ġ", INSTR(EMAIL, '@', 1, 1) " _@��ġ"
 FROM employee;
------------------------------------------------------------------
/*
*SUBSTR : ���ڿ����� Ư�� ���ڿ� �����ؼ� ��ȯ
[ǥ����]
SUBSTR(���ڿ�|�÷�, ������ġ[, ����(����)]))
=> ����° ���̺κ��� �����ϸ� ���ڿ� ������ ����!
*/
SELECT SUBSTR('ORACLE SQL DEVELOPER', 10) FROM DUAL; --10��° ��ġ���� ������ ���� 
SELECT SUBSTR('ORACLE SQL DEVELOPER', 8, 3) FROM DUAL; --8��° ��ġ���� 3���ڸ� ���� => SQL
SELECT SUBSTR('ORACLE SQL DEVELOPER', -3) FROM DUAL; -- �ڿ������� 3��° ��ġ���� ������ ����  PER
SELECT SUBSTR('ORACLE SQL DEVELOPER', -9, 3) FROM DUAL; -- �ڿ������� 9��° ��ġ���� 3���ڸ� ���� DEV

--����� �� ������鸸 ��ȸ(�̸�, �ֹι�ȣ)
SELECT EMP_NAME, emp_no 
FROM employee
--WHERE SUBSTR(emp_no, 8,1)='2' OR SUBSTR(emp_no, 8,1) = '4';
WHERE SUBSTR(emp_no, 8,1) IN ('2', '4');

--����� �� ������鸸 ��ȸ(�̸�, �ֹι�ȣ)
SELECT EMP_NAME, emp_no 
FROM employee
--WHERE SUBSTR(emp_no, 8,1)='1' OR SUBSTR(emp_no, 8,1) = '3'; 
WHERE SUBSTR(emp_no, 8,1) IN ('1', '3')
ORDER BY EMP_NAME; --����̸� ���� ������ ������ ����(��������)

--��� ���� �� �����, �̸���, ���̵� ��ȸ(�̸��Ͽ��� @ �ձ��� ��ȸ)
--[1] �̸��Ͽ��� "@"�� ��ġ�� ã�� => INSTR�Լ� ���
--[2] �̸��� �÷��� ������ 1��° ��ġ���� '@'��ġ(1���� Ȯ��) ������ ����
SELECT EMP_NAME, EMAIL, EMP_ID, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)
FROM employee;
-------------------------------------------------------------

/*
*IPAD/RPAD : ���ڿ��� ���ϰ��ְ� ��ȸ�� �� ���
             ���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� �ٿ��� ���� ���̸�ŭ ���ڿ� ��ȯ 
             [ǥ����]
             LPAD(���ڿ�|�÷�, ��������[, ������ ����])
             RPAD(���ڿ�|�÷�, ��������[, ������ ����])
             *������ ���� ���� �� �⺻������ �������� ä����
*/
 --������� �� ������� �������� ä���� �� 20 ���Ʒ� ��ȸ
 SELECT EMP_NAME, LPAD(EMP_NAME, 20) "�̸�2"
 FROM employee;
 
 SELECT EMP_NAME, RPAD(EMP_NAME, 20) "�̸�2"
 FROM employee;
 
 
 --��� ���� �̸�, �̸��� ������ ����(�� ���� : 20)�Ͽ� ��ȸ
 SELECT EMP_NAME, LPAD(EMAIL, 20) �̸���
FROM employee;
 
  --��� ���� �̸�, �̸��� ���� ����(�� ���� : 20)�Ͽ� ��ȸ
SELECT EMP_NAME, RPAD(EMAIL, 20) �̸���
FROM employee;


SELECT EMP_NAME, RPAD(EMAIL, 20, '#') �̸���
FROM employee;

SELECT RPAD('000000-1', 14, '*')FROM DUAL;

--������� �����, �ֹι�ȣ ��ȸ (XXXXXX-X****** �������� ��ȸ
SELECT EMP_NAME,EMP_NO, RPAD(SUBSTR(EMP_NO,1,8),14, '*')"�ֹι�ȣ"
FROM employee;
--------------------------------------------------------
/*
*LTRIM/RTRIM : ���ڿ����� Ư�����ڸ� ������ �� �������� ��ȯ

[ǥ����]
LTRIM(���ڿ�|�÷� [,�����ϰ��� �ϴ� ���ڵ�])
RTRIM(���ڿ�|�÷� [,�����ϰ��� �ϴ� ���ڵ�])
*������ ���ڸ� ���� �� �� ���� ����
*/
SELECT LTRIM('    H I') FROM DUAL;--����(�տ�������) �ٸ� ���ڰ� ���� ������ ������ ����
SELECT RTRIM('H I      ') FROM DUAL;--������(�ڿ�������) ������ ����9I�� ������)

SELECT LTRIM('123123HI123', '123') FROM DUAL;
SELECT LTRIM('321321HI123', '321') FROM DUAL;

SELECT LTRIM('KKHHII', '123') FROM DUAL;
/*
TRIM : ���ڿ� ��/��/���ʿ� �մ� ������ ���ڵ��� ������ �� ������ ���� ��ȯ

[ǥ����]
TRIM([LEADING|TRAILING|BOTH][������ ����]FROM ���ڿ�|�÷�)
*������ ���� ���� �� ���� ����
*�⺻ �ɼ�BOTH
*/
SELECT TRIM('      H  I      ')"��" FROM DUAL;
SELECT TRIM('L' FROM 'LLLLLHLILLL')"��" FROM DUAL;

SELECT TRIM(LEADING 'L' FROM 'LLLLLHLILLL')"��" FROM DUAL;--LTRIM�� ����
SELECT TRIM(TRAILING 'L' FROM 'LLLLLHLILLL')"��" FROM DUAL;--RTRIM�� ����
SELECT TRIM(BOTH 'L' FROM 'LLLLLHLILLL')"��" FROM DUAL; -- ���ʿ��� ������ ���ڸ� ����
------------------------------------------------------------
/*
*LOWER / UPPER / INITCAP

-LOWER : ���ڿ��� ��� �ҹ��ڷ� ����
-UPPER: ���ڿ��� ���� �빮�ڷ� ����
-INITCAP: ���� �������� ù ���ڸ��� �빮�ڷ� ����
*/
--'I think so i am'
select LOWER('I think so i am') FROM DUAL;

select UPPER('I think so i am') FROM DUAL;

select INITCAP('I think so i am') FROM DUAL;
-----------------------------------------------------
/*
*CONCAT : ���ڿ� �ΰ��� ���� �޾� �ϳ��� ��ģ �� ���ڿ� ��ȯ
[ǥ����]
CONCAT(���ڿ�1, ���ڿ�2)
*/
-- 'KH' 'L������' ���� �ΰ��� �ϳ��� ��í�� ��ȸ
SELECT CONCAT('KH', ' L������') FROM DUAL; 
SELECT 'KH'|| ' L������' FROM DUAL; 

SELECT '�ֿ�Ź'||  30 FROM DUAL; 

SELECT CONCAT(EMP_NAME, '��') FROM EMPLOYEE; 
-- �����ȣ�� (�����)���� �ϳ��� ���ڿ��� ��ȸ=> 200�����ϴ�
SELECT CONCAT(EMP_ID, CONCAT(EMP_NAME, '��')) FROM EMPLOYEE; 
-----------------------------------------------------------------
/*
 *REPLACE : Ư�� ���ڿ����� Ư�� �κ��� �ٸ� �κ����� ��ü�Ͽ� ���ڿ� ��ȯ
  [ǥ��]
  REPLACE(���ڿ�, ã�� ���ڿ�, ������ ���ڿ�) 
*/
SELECT REPLACE('����� ������ �ֹ���', '�ֹ���', '����') FROM DUAL;

--��� ���̺��� �̸��� ���� �� 'OR.KR' �κ��� 'KH.OR.KR' ������ �����Ͽ� ��ȸ
SELECT EMAIL, REPLACE(EMAIL, '@or.kr', '@kh.or.kr') �̸��� from employee;

SELECT EMAIL, REPLACE(EMAIL, '@or.kr', '@gmail.com') �̸��� from employee;
--==================================================================
/*
[���� Ÿ���� ������ ó�� �Լ�]
*/
/*
* ABS : ������ ������ �����ִ� �Լ�
*/
SELECT ABS(-10)"-10�� ����" FROM DUAL;

SELECT ABS(-7.7) "-7�� ����" FROM DUAL;
-----------------------------------------------------------
/*
*MOD : �� ���� ���� ������ ���� �����ִ� �Լ�

MOD(����1, ����2)--> ���� 1% ����2
*/

SELECT MOD(10, 3) FROM DUAL;

SELECT MOD(10.9, 3) FROM DUAL;
----------------------------------------------------------------
/*
*ROUND : �ݿø��� ���� �����ִ� �Լ�

ROUND(����[,��ġ]): ��ġ => �Ҽ��� N��° �ڸ�
*/
SELECT ROUND(123.456) FROM DUAL; --123

SELECT ROUND(123.456, 1) FROM DUAL; --123.5
SELECT ROUND(123.456, 2) FROM DUAL; --123.46

SELECT ROUND(123.456, -1) FROM DUAL; --120
SELECT ROUND(123.456, -2) FROM DUAL; --100
--=> ��ġ���� ����� �߰��Ҽ��� ��=������ �ڷ� ��ĭ�� �̵�, ������ �����Ҽ��� �Ҽ��� ���ڸ��� �̵�
---------------------------------------------------
/*
*CEIL : �ø�ó���� ���� �����ִ� �Լ�
CEIL(����)
*/
SELECT CEIL(123.456) FROM DUAL; --124
/*
FLOOR : ����ó���� ���� �����ִ� �Լ�
*/
SELECT FLOOR(123.456) FROM DUAL; --123

/*
TRUNC : ����ó���� ���� �����ִ� �Լ�(��ġ ���� ����)
TRUNC(����[,��ġ])
*/
SELECT TRUNC(123.456) FROM DUAL; --123
SELECT TRUNC(123.456, 1) FROM DUAL;--123.4
SELECT TRUNC(123.456, -1) FROM DUAL;--120
--=================================================================
/*
[��¥ ������ Ÿ�� ó�� �Լ�]
*/
-- SYSDATE : �ý����� ���� ��¥ �� �ð��� ��ȯ
SELECT SYSDATE FROM DUAL;

--MONTH_BETWEEN : �� ��¥ ������ ���� ���� ��ȯ
-- [ǥ����]MONTH_BETWEEN(��¥1, ��¥2) ���� �� ���
SELECT EMP_NAME, HIRE_DATE,
CONCAT(CEIL( MONTHS_BETWEEN (SYSDATE,HIRE_DATE)), '������') "�ټӰ�����"
FROM employee;


SELECT CEIL(MONTHS_BETWEEN(SYSDATE, '24/06/11'))"���� ������ ��" FROM DUAL;

SELECT FLOOR(MONTHS_BETWEEN('24/11/25', SYSDATE)) ||'���� ����' "�������.." FROM DUAL;
-------------------------------------------------
--ADD_MONTH : Ư�� ��¥�� N���� ���� ���Ͽ� ��ȯ
-- [ǥ����]ADD_MONTH(��¥, ���� ���� ��)

SELECT SYSDATE, ADD_MONTHS(SYSDATE, 4) "4���� ��" FROM DUAL;

--��� ���̺��� �����, �Ի���, �Ի���+3���� "����������" ��ȸ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3)"���� ������"
FROM employee;

-----------------------------------------------------------------------
--NEXT_DAY : Ư�� ��¥ ���� ���� ����� ������ ��¥�� ��ȯ
--[ǥ����] NEXT_DAY(��¥, ����(����|����))
--*1: �Ͽ��� 2. ������ .......... 7: �����
--���� ��¥ ���� ���� ����� �ݿ����� ��¥ ��ȸ

SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;-- ���ڴ� ��� ������ ��� ���� ���۵�

SELECT SYSDATE, NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
--���� : KOREAN/ AMERICAN
ALTER SESSION SET NLS_LANGUAGE = KOREAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRI') FROM DUAL;
------------------------------------------------------------
--LAST_DAY : �ش� ���� ������ ��¥�� ���� ��ȯ
--[ǥ����] LAST_DAY(��¥)

--�̹����� ������ ��¥ ��ȸ
SELECT LAST_DAY(SYSDATE)FROM DUAL;

--������̺��� �����, �Ի���, �Ի��� ���� ������ ��¥ �Ի��� ���� �ٹ��ϼ� ��ȸ

SELECT EMP_NAME "�����", HIRE_DATE "�Ի���", LAST_DAY(HIRE_DATE)"�Ի��� ���� ��������", 
LAST_DAY(HIRE_DATE)-HIRE_DATE +1"�Ի��� �� �ٹ��� ��"
FROM employee;

--=========================================

/*
 *EXTRACT : Ư�� ��¥�κ��� �⵵/��/�� ���� �����ؼ� ��ȯ���ִ� �Լ�
 [ǥ����]
 EXTRACT(YEAR FROM ��¥): ��¥���� ������ ����
 EXTRACT(MONTH FROM ��¥): ��¥���� ���� ����
 EXTRACT(DAY FROM ��¥): ��¥���� �ϸ� ����
*/
--���� ��¥, ����, ����, ��, ���� ���� �����Ͽ� ��ȸ
SELECT SYSDATE
, EXTRACT(YEAR FROM SYSDATE)"����"
, EXTRACT(MONTH FROM SYSDATE)"��"
, EXTRACT(DAY FROM SYSDATE)"��"
FROM DUAL;

--������̺� ����� �Ի�⵵, �Ի��, �Ի��� ��ȸ(+�Ի�⵵>�Ի��>�Ի��� �������� ����)
SELECT EMP_NAME
, EXTRACT(YEAR FROM hIRE_DATE)"�Ի�⵵"
, EXTRACT(MONTH FROM hIRE_DATE)"�Ի��"
, EXTRACT(DAY FROM hIRE_DATE)"�Ի���"
FROM employee 
ORDER BY 2, 3, 4;

--=================================
/*
*����ȯ �Լ� : ������ Ÿ���� �������ִ� �Լ�
- ����/ ����/ ��¥
*/

/*
TO_CHAR : ����, ��¥Ÿ���� ���� ���� Ÿ������ ��ȯ�����ִ� �Լ�
[ǥ����]
TO_CHAR(����|��¥[, ����])
*/
--����Ÿ��-->����Ÿ��

SELECT 1234 "����Ÿ���� ������",TO_CHAR(1234)"������ ������ ������" FROM DUAL;

SELECT TO_CHAR(1234) "���游�ѵ�����", TO_CHAR(1234, '999999')"���䵥����" FROM DUAL;
--=> '9':������ŭ �ڸ��� Ȯ��, ������ ����, ��ĭ�� ����

SELECT TO_CHAR(1234, '000000')"���䵥����" FROM DUAL;
--=> '0':������ŭ �ڸ��� Ȯ��, ������ ����, ��ĭ�� 0���� ä��.
SELECT TO_CHAR(1234, 'L999999') "���䵥����" FROM DUAL;
--=> ���� ������ ������ ���� ȭ������� ���� ǥ��
SELECT TO_CHAR(1234, '$999999') "���䵥����" FROM DUAL;

SELECT TO_CHAR(1000000, 'L9,999,999') "���䵥����" FROM DUAL;

--������� ����� ����, ���� ��ȸ(ȭ����� 3�ھ� �����Ͽ� ǥ�õǵ���)

SELECT EMP_NAME"�����", TO_CHAR(SALARY,'L99,999,999')"����", TO_CHAR(SALARY*12,'L999,999,999,999')"����"
FROM employee;
----------------------------------------------
--��¥ Ÿ�� -> ���� Ÿ��
SELECT SYSDATE, TO_CHAR(SYSDATE)"���ڷκ�ȯ" FROM DUAL; 

SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL; --12 �ð���
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; --���� ���� ǥ��
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; --24�ð���

SELECT 
TO_CHAR(SYSDATE, 'HH:MI:SS'),
TO_CHAR(SYSDATE, 'PM HH:MI:SS'),
TO_CHAR(SYSDATE, 'AM HH:MI:SS'),
TO_CHAR(SYSDATE, 'HH24:MI:SS') 
FROM DUAL






