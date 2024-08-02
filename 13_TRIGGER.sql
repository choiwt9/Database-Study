/*
Ʈ���� (TRIGGER)
:������ ���̺� DML���� ���� ���� ������ ���� �� (���̺� �̺�Ʈ�� �߻����� ��)
�ڵ����� �Ź� ������ ������ �̸� ������ �δ� ��

EX)ȸ��Ż��� ���� ȸ�� ���̺��� ������ �����ϰ� 
Ż�� ȸ�� ���̺� ������ �߰� �ؾ��� �� �ڵ����� ����
EX)�Ű� Ƚ���� Ư�� ���� �Ѿ�� �� �ش� ȸ���� ������Ʈ ó��
EX) ����� ���� �����͸� ����� �� �ش� ��ǰ�� ��� ������ �����ؾ� �Ҷ�
*/
/*
Ʈ������ ����
-SQL���� ���� �ñ⿡ ���� �з�
+BEFORE TRIGGER : ������ ���̺� �̺�Ʈ�� �߻��ϱ� ���� Ʈ���� ����
+AFTER TRIGGER: ������ ���̺� �̺�Ʈ�� �߻��� �Ŀ� Ʈ���� ����
-SQL���� ���� ������ �޴� �� �࿡ ���� �з�
+���� Ʈ���� : �̺�Ʈ�� �߻��� SQL���� ���� �� �ѹ��� Ʈ���� ����
+�� Ʈ����: �ش� SQL���� ����� ������ �Ź� Ʈ���� ����
          FOR EACH NOW �ɼ� ���� �ʿ�
          : OLD-BEFORE UPDATE (���� �� �ڷ�), BEFORE DELETE (���� �� �ڷ�)
          : NEW-AFTER INSERT (�߰��� �ڷ�), AFTER UPDATE (���� �� �ڷ�)
*/
/*
*Ʈ���� �����ϱ�

CREATE [OR REPLACE] TRIGGER Ʈ�����̸�    --Ʈ���� �⺻����(�Ƹ�)                     
BEFORE|AFTER INSERT|UPDATE|DELETE ON ���̺�� --�̺�Ʈ ���� ����
[FOR EACH ROW]                --�Ź� Ʈ���Ÿ� ������ �������� ���� �ɼ�
[DECLARE] --���� ��� ���� �� �ʱ�ȭ
BEGIN --����� [SQL ��, ���ǹ�, �ݺ���...]
        �̺�Ʈ �߻� �� �ڵ����� ó���� ����
[EXCEPTION] --����ó����
END;
/
*/
--EMPLOYEE ���̺��� �����Ͱ� �߰��� ������ '���Ի���� ȯ���մϴ�.^^' ���
CREATE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN 
DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ�.^^');
END;
/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
VALUES (500, '������', '000501-3000000', 'D4', 'J4', SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
VALUES (501, '����â', '950704-1000000', 'D6', 'J5', SYSDATE);
--------------------------------------------------------------------------------
--��ǰ �԰� �� ��� ����

--*���̺�, ������ ����
-- ��ǰ�� �����ϱ� ���� ���̺�
CREATE TABLE TB_PRODUCT(
PNO NUMBER PRIMARY KEY, --��ǰ��ȣ
PNAME VARCHAR2(30) NOT NULL, --��ǰ��
BRAND VARCHAR2(30) NOT NULL,
PRICE NUMBER DEFAULT 0,
STOCK NUMBER DEFAULT 0
);

--��ǰ ��ȣ�� ����� ������(���۹�ȣ:200, ������: 5, ĳ�ø޸�X)
CREATE SEQUENCE SEQ_PNO
START WITH 200
INCREMENT BY 5
NOCACHE;

-- ���� ������ �߰�
INSERT INTO tb_product(PNO, PNAME, BRAND) VALUES (SEQ_PNO.NEXTVAL, '������15', '���');
INSERT INTO tb_product VALUES (SEQ_PNO.NEXTVAL, '������ ���� 6', '����', 2000000, 500);
INSERT INTO tb_product VALUES (SEQ_PNO.NEXTVAL, '��������', '�����', 80000, 500);

SELECT * FROM tb_product;

COMMIT;  --DB�� �ݿ��ϱ�

--��ǰ ����� ������ �����ϱ� ���� ���̺�

CREATE TABLE TB_PDETAIL(
DNO NUMBER PRIMARY KEY,
PNO NUMBER REFERENCES TB_PRODUCT,
DDATE DATE DEFAULT SYSDATE,
AMOUNT NUMBER NOT NULL,
TYPE CHAR(6) CHECK(TYPE IN ('�԰�','���'))--����� ����
);

-- ����� ������ ���� ������( ������ȣ)
CREATE SEQUENCE SEQ_DNO
NOCACHE;

--205�� ��ǰ, ���� ��¥ 5�� ���
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 205, DEFAULT, 5, '���');

UPDATE tb_product
SET STOCK = STOCK - 5
WHERE PNO = 205;

COMMIT;

SELECT * FROM tb_pdetail;
SELECT * FROM tb_product;

--200��(������ 15)��ǰ�� ��� 10�� �԰�

INSERT INTO TB_PDETAIL VALUES(seq_dno.nextval, 200, DEFAULT, 10, '�԰�');

UPDATE tb_product
SET STOCK = STOCK +10
WHERE PNO = 200;

COMMIT;

--------------------------------------------------------------------------------
/*
TB_PDETALE (����� �̷�) ���̺� ������ �߰� �̺�Ʈ �߻� ��
TB_PRODUCT (��ǰ)���̺� ��� ���� ���� �Ǿ�� �� => �ڵ����� ó���� �� �ֵ��� Ʈ���� ����

--UPDATE ����
��ǰ�� �԰�� ��� => �ش� ��ǰ�� ã�Ƽ� ��� ���� ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + �԰� ����(TB_DETALE.AMOUNT)--> NEW.AMOUNT
WHERE PNO = ���� ��ǰ��ȣ(TB_PDETALE.PNO)--> :NEW.PNO
*/
--** TRG-02 Ʈ���� ����**

CREATE OR REPLACE TRIGGER TRG_02

AFTER INSERT ON TB_PDETAIL
FOR EACH ROW

BEGIN
--�԰�? ���?

IF: NEW.TYPE = '�԰�'
THEN
UPDATE TB_PRODUCT
SET STOCK = STOCK + :NEW.AMOUNT
WHERE PNO = :NEW.PNO;
ELSE
UPDATE TB_PRODUCT
SET STOCK = STOCK - :NEW.AMOUNT
WHERE PNO = :NEW.PNO;
END IF;
END;
/

INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 200, SYSDATE, 100, '�԰�');
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 200, SYSDATE, 10, '���');
SELECT * FROM TB_PRODUCT;
SELECT * FROM TB_PDETAIL;


















