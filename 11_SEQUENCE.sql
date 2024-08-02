/*
*������ (SEQUENCE)
: �ڵ����� ��ȣ�� �߻������ִ� ������ �ϴ� ��ü
������ ���������� ������ ������ ������Ű�鼭 ����

EX) �����ȣ, ȸ����ȣ, ������ȣ 
*/
/*
*������ �����ϱ�

CREATE SEQUENCE ��������
[START WITH  ����] --> ó�� �߻� ��ų ���� [������ �⺻ ���� 1]
[INCREAMENT BY ����] --> �󸶸�ŭ�� ������ų �������� ���� �� ����[�⺻�� : 1]
[MAXVALUE ����] --> �ִ밪[�⺻��.. ��ûŭ]
[MINVALUE ����] --> �ּҰ� [�⺻��: 1]
[CYCLE | NOCYCLE] --> ���� ��ȯ���� [�⺻�� : NOCYCLE]
                  --> CYCLE : ������ ���� �ִ밪�� �����ϸ� �ּҰ����� �ٽ� ��ȯ�ϵ��� ����
                 --> NOCYCLE : ������ ���� �ִ밪�� �����ϸ� ���̻� �������� �ʵ��� ����
[NOCACHE | CACHE ����] --> ĳ�ø޸� �Ҵ翩�� [�⺻�� : CACHE]
                      --> ĳ�ø޸� : �̸� �߻��� ������ �����ؼ� ������ �δ� ����
                                  �Ź� ȣ���� ������ ���� ��ȣ�� �����ϴ� ���� �ƴ� 
                                  ĳ�ø޸𸮶�� ������ �̸� ������ ������ �����ٰ� ���(�ӵ��� ������)
����
-�̸� �����ֱ�-
*���̺� : TB
*�� : VW
*������ : SEQ
*Ʈ���� : TRG
*/
-- SEQ_TEST ��� ������ ����
CREATE SEQUENCE SEQ_TEST;
--*���� ������ ������ �ִ� �������� ��ȸ
SELECT * FROM USER_SEQUENCES;

SELECT * FROM EMPLOYEE;
--SEQ_EMPNO ��� �̸��� ������ ����
--���۹�ȣ�� 300 , ������ 5 �ִ밪 310, ��ȯX ĳ�ø޸�X
CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
������ ����ϱ�

-������.CURRVAL : ���� ������ ��(���������� ������ NEXTVAL�� ������ ��)
-��������.NEXTVAL : ������ ���� ������ ���� �������� �߻��� �����
                    ���� ������ ������ INCREMENT BY ������ ����ŭ ������ ��
                    
*/
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --���� �߻� NEXTVAL�� �ѹ��� �������� ���� �̻� CURRVAL�� ����� �� ����

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- ���� �� ó�� ���� �� ���� �� : 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 310

SELECT * FROM USER_SEQUENCES;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 315 ==>�ִ밪�� 310���� �Ǿ� �־� �� �̻��� ���� ��ȸ�ǹǷ� �����߻�

/*
������ ���� �����ϱ�
ALTER SEQUENCE �������� 
[INCREAMENT BY ����]--> ������ (�⺻�� : 1)
[MAXVALUE ����] --> �ִ� [�⺻�� : ��û ũ��]
[MINVALUE ����] --> �ּҰ� [�⺻��: 1]
[CYCLE | NOCYCLE] --> ���� ��ȯ���� [�⺻�� : NOCYCLE]
[NOCACHE | CACHE ����] --> ĳ�� �޸� ��뿩��, ���� (����Ʈ ����) (�⺻�� : CACHE 20)

=> START WITH ����Ұ�!
*/
-- SEQ_EMPNO �������� �������� 10, �ִ밪�� 400���� ����
ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10 
MAXVALUE 400;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 320.(310+10)

--������ ���� : DROP SEQUENCE ��������;
--SEQ_EMPNO ������ ����
DROP SEQUENCE SEQ_EMPNO;
SELECT * FROM USER_SEQUENCES;
--------------------------------------------------------------------------------
/*
EMPLOYEE ���̺� ������ ����
-> ������ ��� �÷� : �����ȣ (EMP ID)
*/
--*������ �����ϱ�
CREATE SEQUENCE SEQ_EID
START WITH 300   --���۹�ȣ 300
NOCACHE; -- ĳ�ø޸� X

--���۰�: 300, ������ : 1, ......... ��ȯ����: NOCYCLE, �ִ밪 : ��û ŭ
--������ ����ϱ� : EMPLOYEE ���̺� �����Ͱ� �߰��ɶ�
INSERT INTO employee (emp_id, emp_name, emp_no, JOB_code, hire_date)
VALUES (SEQ_EID.NEXTVAL, '�ֿ�Ź', '931015-1111111', 'J4', SYSDATE);

SELECT * FROM USER_SEQUENCES;

INSERT INTO employee (emp_id, emp_name, emp_no, JOB_code, hire_date)
VALUES (SEQ_EID.NEXTVAL, '���ǿ�', '990928-1111111', 'J4', SYSDATE);

ROLLBACK;
--------------------------------------------------------------------------------






















