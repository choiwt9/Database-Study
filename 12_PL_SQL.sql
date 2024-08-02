/*
*PL/SQL : PROCEDURE LANGUAGE EXTENSION TO SQL

����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���
SQL ���� ������ ��������, ����, �ݺ� ���� �ڿ��Ͽ� SQL������ ����
�ټ��� SQL���� �ѹ��� ���� ����

*����*
[�����] : DECLARE�� ����
[�����] : BEGIN ���� ����. SQL�� �Ǵ� ��� (���ǹ� �ݺ���)���� ������ �ۼ��ϴ� �κ�
[����ó����] : EXCEPTION ���� ���� ���ܹ߻� �� �ذ��ϱ� ���� �κ�
*/

SET SERVEROUTPUT ON;
-- HELLO ORACLE ���
BEGIN 
--�ڹ� : system.out.print
DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/
--------------------------------------------------------------------------------
/*
*����� (DECLARE)
: ���� �Ǵ� ��� �����ϴ� �κ�(����� ���ÿ� �ʱ�ȭ�� ����)

-������ Ÿ�� ���� ����
+�Ϲ� Ÿ��
+���۷��� Ÿ��
+ROW Ÿ��
*/
/*
�Ϲ� Ÿ�� ����
������[CONSTANT] �ڷ��� [:=��]
--��� ���� �� CONSTANT�� �ٿ���
--�ʱ�ȭ �Ҷ��� := ��ȣ�� �ٿ���
*/
DECLARE
EID NUMBER;       --EID��� �̸����� NUMBER Ÿ���Ǻ��� ����
ENAME VARCHAR2(20); --ENAME�̶�� �̸��� VARCHAR2(20)Ÿ�� ���� ����
PI CONSTANT NUMBER := 3.14; --PI ��� �̸��� NUMBER Ÿ�� ��� ���� �� 3.14 �� �ʱ�ȭ
BEGIN
--������ �� ����
EID := 100;
ENAME :='�ֿ�Ź';
--�� ���� ����� ����� ���� ���
--Ư�����ڿ� ������ ���� ����ϰ��� �Ҷ� ���Ῥ���� ���
DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
--���� �Է¹޾� ������ ����
DECLARE
EID NUMBER;       
ENAME VARCHAR2(20);
PI CONSTANT NUMBER := 3.14;
BEGIN
--���� �Է� ���� �� &��ü ������ �������� �ۼ�
EID := &�����ȣ;
ENAME :='�ֿ�Ź';

DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
--------------------------------------------------------------------------------
/*
���۷��� Ÿ�� ����
: � ���̺��� � �÷��� ������ Ÿ���� �����Ͽ� �ش� Ÿ������ ������ ����
������ ���̺���.�÷���%TYPE
*/
DECLARE
EID EMPLOYEE.EMP_ID%TYPE;  --EID��� ������ EMPLOYEE ���̺��� EMP_ID�÷��� Ÿ���� ����
ENAME EMPLOYEE.EMP_NAME%TYPE; --ENAME ������ EMPLOYEE ���̺��� EMP_NAME �÷��� Ÿ���� ����
SAL EMPLOYEE.SALARY%TYPE; -- SAL ������ EMPLOYEE ���̺��� SALARY �÷��� Ÿ���� ����
BEGIN 
--EID:='100';
--ENAME :='�ֿ�Ź';
--SAL := 3000000;
SELECT EMP_ID, EMP_NAME, SALARY
INTO EID, ENAME, SAL --�� �÷��� ������� ������ ����
FROM EMPLOYEE
--WHERE EMP_ID = 200;
WHERE EMP_ID = &���;
DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/
--����--
/*
���۷��� Ÿ�� ������ EID, ENAME, JCODE, SAL, DTITLE �����ϰ�
�� �ڷ����� EMPLOYEE ���̺��� EMP_ID, EMP_NAME, JOB_CODE, SALARY�÷���
DEPARTMENT ���̺��� DEPT_TITLE�� �����ϰ� �� ��
����ڰ� �Է��� ����� ��������� ��ȸ�Ͽ� ������ ��� ���

��� ����: {���}, {�̸�, {�����ڵ�}, {����, {�μ���}
*/
DECLARE 
EID EMPLOYEE.EMP_ID%TYPE;
ENAME EMPLOYEE.EMP_NAME%TYPE;
JCODE EMPLOYEE.JOB_CODE%TYPE;
SAL EMPLOYEE.SALARY%TYPE;
DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
INTO EID , ENAME, JCODE, SAL, DTITLE
FROM employee 
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE EMP_ID = &���;
DBMS_OUTPUT.PUT_LINE(EID || ',' || ENAME   || ',' || JCODE   || ',' || SAL   || ',' || DTITLE  );
END;
/
-------------------------------------------------------------------------------------------
/*
ROW Ÿ�� ���� 
: ���̺��� �� �࿡ ���� ��� �÷����� �ѹ��� ���� �� �ִ� ����

������ ���̺���%ROWTYPE
*/
DECLARE
E EMPLOYEE%ROWTYPE;
BEGIN
SELECT*
INTO E
FROM EMPLOYEE
WHERE EMP_ID = &���;
--����� �޿� ���ʽ� ���
DBMS_OUTPUT.PUT_LINE('����� : ' || E.EMP_NAME);
DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY);
--DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || E.BONUS);
--NULL�� ��� 0���� ǥ���ϱ� ���� NVL�Լ� ��밡��
DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || NVL(E.BONUS,0));
END;
/
--==============================================================================
/*
*����� (BEGIN)

**���ǹ�**
-���� IF��: IF ���ǽ� THEN ���೻�� END IF;
-IF/ELSE��: IF ���ǽ� THEN ���ǽ� ���϶� ���೻�� ELSE �����϶� ���೻�� END IF;
-IF/ELSIF �� : IF ���ǽ�1 THEN ���೻��1 ELSIF ���ǽ�2 THEN ���೻��2...........[���೻��] END IF;

-CASE/WHEN/THEN ��
CASE �񱳴�� WHEN ����񱳰�1 THEN �����1
            WHEN �񱳰�2 THEN �����2
            WHEN �񱳰�3 THEN �����3
            ...
            ELSE �����N
     END;          
*/
--����ڿ��� ����� �Է¹��� �� �ش� ����� ���, �̸�, �޿�, ���ʽ� ������ �Է�
--�� �����Ϳ� ���� ���� : ���(EID), �̸�(ENAME), �޿�(SAL), ���ʽ�(BONUS)
--�� ���ʽ� ���� 0�� ��� '���ʽ��� ���� �ʴ� ����Դϴ�' ���
DECLARE 
EID EMPLOYEE.EMP_ID%TYPE;
ENAME EMPLOYEE.EMP_NAME%TYPE;
SAL EMPLOYEE.SALARY%TYPE;
BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
INTO EID, ENAME, SAL, BONUS
FROM EMPLOYEE
WHERE EMP_ID  =&���;
DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
DBMS_OUTPUT.PUT_LINE('�޿� : ' || SAL);
IF BONUS = 0 
THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���� �ʴ� ����Դϴ�');
ELSE DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || NVL(BONUS,0));
END IF;
END;
/
-------------------------------------------------------------------------
/*
DECLARE
--���۷������� (EID, ENAME, DTITLE, NCODE)
��������(EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE)
--�Ϲ�Ÿ�Ժ��� (TEAM ����Ÿ��)--> '������' �Ǵ� '�ؿ���' ������ ����
BIGIN
--����ڰ� �Է��� ����� �ش��ϴ� ��� �̸� �μ��� �ٹ����� �ڵ� ��ȸ
--��ȸ �� �ش� ���� ������ ����
-- �̶� NCODE�� ���� KO�� ��� '������'�� TEAM ������ ����
        KO�� �ƴ� ��� '�ؿ���'�� TEAM������ ����
--��� ���� : ���, �̸�, �μ�, �Ҽ� --> ���� �Ǵ� �����ٷ� ���
END;
/
*/
DECLARE
EID EMPLOYEE.EMP_ID%TYPE;
ENAME EMPLOYEE.EMP_NAME%TYPE;
DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
NCODE LOCATION.NATIONAL_CODE%TYPE;

TEAM VARCHAR2(20);
BEGIN
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
INTO EID, ENAME, DTITLE, NCODE
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE EMP_ID = &���;
IF NCODE = 'KO' 
THEN TEAM := '������';
ELSE TEAM := '�ؿ���';
END IF;
DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
DBMS_OUTPUT.PUT_LINE('�μ��� : ' || DTITLE);
DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);
END;
/

DECLARE
SCORE NUMBER;
GRADE CHAR(1);
BEGIN 
SCORE := &����;
IF SCORE>=90
THEN GRADE := 'A';
ELSIF SCORE >= 80
THEN GRADE := 'B';
ELSIF 70>= SCORE
THEN GRADE := 'C';
ELSIF 60 >= SCORE
THEN GRADE := 'D';
ELSE GRADE := 'F';
END IF;

DBMS_OUTPUT.PUT_LINE('������ ' || SCORE || '�̰�, �����' || GRADE || '�Դϴ�.' );
IF GRADE = 'F'
THEN DBMS_OUTPUT.PUT_LINE('���� ����Դϴ�' );
END IF;
END;
/
----------------------------------------------------------
-����� �ش��ϴ� ����� �μ� �ڵ� �������� �μ����� ���(JOIN X)
DECLARE
EMP EMPLOYEE%ROWTYPE;
DTITLE VARCHAR2(50);
BEGIN
SELECT *
INTO EMP
FROM EMPLOYEE
WHERE EMP_ID = &���;

--�ش� ����� �μ��ڵ� �������� ����
DTITLE := CASE EMP.DEPT_CODE
           WHEN 'D1' THEN '�λ������'
           WHEN 'D2' THEN 'ȸ�������'
           WHEN 'D3' THEN '�����ú�'
           WHEN 'D4' THEN '����������'
           WHEN 'D5' THEN '�ؿܿ���1��'
           WHEN 'D6' THEN '�ؿܿ���2��'
           WHEN 'D7' THEN '�ؿܿ���3��'
           WHEN 'D8' THEN '���������'
           WHEN 'D9' THEN '�ѹ���'
               ELSE '�μ�����'
               END;
-----------------------------------------------------------
DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || '����� �ҼӺμ���' || DTITLE || '�Դϴ�.');
END;
/

SELECT*FROM DEPARTMENT;
--------------------------------------------------------------------------------
/*
*�ݺ��� 

-�⺻ ����  
            LOOP
            �ݺ��� ����
            �ݺ����� ������ ����
            END LOOP;
            * �ݺ����� ������ ����
            [1] IF ���ǽ� THEN EXIT; END IF;
            [2] EXIT WHEN ���ǽ�;
-FOR LOOP ��
        FOR ���� IN [REVERSE] �ʱⰪ..������
        LOOP �ݺ��� ���� END LOOP;
        *REVERSE : ���������� �ʱⰪ���� �ݺ�(������)
-WHILE LOOP��
        WHILE ���ǽ�
        LOOP �ݺ��� ���� END LOOP;            
*/
--�⺻�������� HELLO ORACLE �ټ��� ���
DECLARE
N NUMBER := 1;
BEGIN
LOOP 
DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
N := N+1;
IF N > 5 
THEN EXIT;
END IF;
END LOOP;
END;
/
--FOR������ HELLO ORACLE �ټ��� ���--

BEGIN
FOR I IN 1..5
LOOP
DBMS_OUTPUT.PUT_LINE(I || ' )HELLO ORACLE!!');
END LOOP;
END;
/

BEGIN
FOR I IN REVERSE 1..5
LOOP
DBMS_OUTPUT.PUT_LINE(I || ' )HELLO ORACLE!!');
END LOOP;
END;
/
--------------------------------------------------------------------------------
-- TEST ���̺� ����
DROP TABLE TEST;

CREATE TABLE TEST(
TNO NUMBER PRIMARY KEY,
TDATE DATE
);

CREATE SEQUENCE SEQ_TNO
INCREMENT BY 2
MAXVALUE 1000
NOCYCLE
NOCACHE;

--TEST TABLE �� �����͸� 100�� �߰�(TNO ������ ���, TDATE : ������¥)
BEGIN 
FOR I IN 1..100
LOOP 
INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL, SYSDATE);
END LOOP;
END;
/
SELECT * FROM TEST;
--------------------------------------------------------------------------------
/*
*����ó����
- ���� (EXCEPTION): ���� �߿� �߻��� ����

EXCEPTION
    WHEN ���ܸ� THEN ����ó������;
    WHEN ���ܸ� THEN ����ó������;
    ...
    WHEN OTHERS THEN ����ó������;
    *����Ŭ���� �̸� ������ ���� => �ý��� ����
      -NO_DATA_FOUND : ��ȸ�� ����� ���� ��
      -TOO_MANY_ROW : ��ȸ�� ����� ���� ���� ��(=> ������ ����)
      -ZERO_DIVINE : 0���� ���� �������� �Ҷ�
      -DUP_VAL_ON_INDEX : UNIQUE ���ǿ� ����ɶ� (�ߺ��Ǵ� ���)
      ...
      *OTHERS: � ���ܵ� �߻��Ǿ�����
*/
--����ڿ��� ���ڸ� �Է¹޾� 10���� ���� ����� ���.(0�� �Է� �Ǿ����� ������ �߻��� �� �ִ�.)
DECLARE
NUM NUMBER;

BEGIN
NUM := &����;
DBMS_OUTPUT.PUT_LINE(10/NUM);
EXCEPTION
WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('0���� ���� �� �����ϴ�.');
END;
/
--EMPLOYEE ���̺��� EMP_ID �÷��� �⺻Ű�� ����
--ALTER TABLE EMPLOYEE ADD PRIMARY KEY(EMP_ID);

--�⺻Ű(PRIMARY KEY) UNIQUE + NOT NULL
BEGIN
UPDATE EMPLOYEE
SET EMP_ID = '&������_���'
WHERE EMP_NAME = '���ö';

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�ߺ��� ����Դϴ�.');
END;
/
----------����--------------------------------------------------------------------
/*
����� ����� �Է��� �ش� ����� ����� ���
-���: XXX
-
*/
DECLARE
EID EMPLOYEE.EMP_ID%TYPE;
ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN 
SELECT EMP_ID, EMP_NAME
INTO EID, ENAME
FROM EMPLOYEE
WHERE MANAGER_ID = '&�����ȣ'; --����Ÿ������ �Է¹ް��� �� ��� ���� ����ǥ�� �����ش�
DBMS_OUTPUT.PUT_LINE('��� :' || EID);
DBMS_OUTPUT.PUT_LINE('�̸� :' || ENAME);

EXCEPTION 
WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�Է��� �������� ���� ����� �����ϴ�');
WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('�ش� ����� ����� �����ϴ�.');
WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('�����ڿ��� �����ϼ���');
END;
/






