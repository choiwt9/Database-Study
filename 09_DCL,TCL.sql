/*
DCL(Data Control Language) : ������ ���� ���

=> ������ �ý��� ����/��ü���ٱ����� �ο��ϰų� ȸ���ϴ� ����

-�ý��� ���� : db�� �����ϴ� ����, ��ü�� ������ �� �ִ� ����
-��ü ���� ���� : Ư�� ��ü���� ������ �� �ִ� ����
*/
/*
���� ���� 
creat user ������ idendified by ��й�ȣ;

grant ����(connect ,resource) to ������

�ý��� ���� ����
-create session : ���� ����
-create table : ���̺� ���� ����
-create view : �� ���� ����
-create sequence : ������ ���� ����
...

��ü ���� ���� ����

����     | ���� ��ü
select  | table, view, sequence  --��ȸ
insert  | table, view            --�߰�
update  | table, view            --����
delete  | table, view            --����

grant ���� ���� on Ư����ü to ������;
ex) grant select on kh.employee to test;
--> test������ kh������ employee ���̺��� ��ȸ�� �� �ִ� ������ �ο�

���� ȸ��
revoke ȸ���� ���� from ������
ex)revoke select on kh.employee from test
--> test ������ �ο��ߴ� kh������ employee���̺��� ��ȸ�� �� �ִ� ������ ȸ��
*/
/*
role(��, ��Ģ) : Ư�����ѵ��� �ϳ��� �������� ��Ƴ��� ��

-connect : ���ӱ��� (create session)
-resource : ��������(Ư�� ��ü ���� ����)(create table, create view)
*/
--�� ������ȸ

select * from role_sys_privs 
where role in ('connect', 'resource');
-----------------------------------------------------------------------------------
/*
TCL(Transaction Control Language)

*Ʈ����� : �����ͺ��̽��� ���� �������
           ������ �������(dml ����)���� �ϳ��� ����ó�� Ʈ����ǿ� ��Ƶ�
Ʈ����� ����
-commit : Ʈ����ǿ� ����� �ִ� ���� ���׵��� ���� db�� �����ϰڴٸ� �ǹ�
-rollback : Ʈ����ǿ� ��� �ִ� ������׵��� �����ϰ� 
            ������ commit���� ���ư��� �ǹ�
--savepoint : ���� ������ ������׵��� �ӽ÷� ������ �δ� ���� �ǹ�
              ROLLBACK �� ���� ������ ��� �������� �ʰ� �ش� ��ġ������ ��Ұ� ����
*/
--EMP01���̺� ����
DROP TABLE EMP01; --> DDL Ʈ����� ó�� X.

--EMP01 ���̺��� ���� (EMPLOYEE ���, �����, �μ��� ��ȸ)
CREATE TABLE EMP01
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID);

SELECT * FROM EMP01;

--����� 217 214 �� ��� ���� --> DML.Ʈ����� ó�� O.
DELETE FROM EMP01
WHERE EMP_ID IN(217, 214);

ROLLBACK; -- ������� ���(Ʈ����� ����)
----------------------------------------------------------------------------------
DELETE FROM EMP01 WHERE EMP_ID = 217;
DELETE FROM EMP01 WHERE EMP_ID = 214;

COMMIT;  --������� ���� (DB�� ������� ����)
ROLLBACK; --������ COMMIT �������� ���ư� (217, 214 ����� ������ ����)
--------------------------------------------------------------------------------
--208,209, 210�� �������
DELETE FROM EMP01
WHERE emp_ID IN (208,209,210);

SELECT * FROM EMP01;

SAVEPOINT SP;
--500�� ��� �߰�
INSERT INTO EMP01 VALUES (500, 'ī����', '�ؿܿ���2��');

--215�� ��� ����
DELETE FROM EMP01
WHERE emp_ID = 215;
-- SP�������� �ѹ�
ROLLBACK TO SP;
COMMIT;  --SP�������� ���ư� �� COMMIT�� �߱� ������ DELETE 208, 209, 210�� DB�� ����
--------------------------------------------------------------------------------
SELECT * FROM EMP01;
--221�� ��� ����
DELETE FROM EMP01 WHERE EMP_ID = 221;

--DDL�� ���
CREATE TABLE TEST(
TID NUMBER
);
SELECT * FROM TEST;
ROLLBACK; 

--> DDL��(CREATE, ALTER, DROP)�� ����ϰ� �Ǹ� ���� Ʈ����ǿ� ����� ������׵��� ������ �ݿ�
-- DDL�� ����� DML�� ���� �������� �ִٸ� Ȯ���ϰ� ó��(COMMIT/ROLLBACK)�� �ڿ� DDL�� ����ؾ� ��







