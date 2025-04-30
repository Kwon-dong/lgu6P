-- ���� �����ͺ��̽� Ȯ��
SELECT DB_NAME();

-- �����ͺ��̽� > ���̺�(pandas ������������)
-- �Ϲ������� �����ͺ��̽� �ȿ� �ִ� ��
---- ���̺� �ܿ���, view, ���ν���, Ʈ����, ����� ���� �Լ� �� ����

-- SQL�� ��â�� SQLE�� �Ҹ� -> SQLE���� E == English -> SQL ������ ���� ������ �ſ� �����
-- ǥ�� SQL, 99% ��� but, 1% �ٸ� ==> �����ͺ��̽� �������� ������Ÿ�� �����Ҷ� ���̰� �� ����

-- ���̺� ����
CREATE TABLE promotions(
	promotion_id INT PRIMARY KEY IDENTITY(1, 1), -- ������Ÿ�� ����
	promotion_name VARCHAR(255) NOT NULL
);
-- lily_book ���� Tables ���Ͽ� dbo.promotions ���̺��� �߰��Ǿ������� Ȯ�� ����

-- ������ �߰�
-- �������� �е��� INSERT ������ �� �����������ӿ�ũ�� �����ؼ� ó��
INSERT INTO promotions(
	promotion_name 
)
VALUES(
	'2025 Summer Promotion'
);

-- promotions�� ������ �߰��ƴ��� Ȯ��
SELECT * FROM promotions;   -- ���� ���忡�� �̷��� �� �Ⱦ�

-- lily_book ��Ű���� staff�� ������ Ȯ��
USE lily_book
SELECT * FROM staff;  

-- �Ǵٸ� ���
SELECT * FROM lily_book.dbo.staff;

-- BikeStores ��Ű���� production.brands ������ Ȯ��
USE BikeStores;
SELECT * FROM production.brands

-- å '���� ù SQL����' p36
-- SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY
-- FROM A pandas DataFrame SELECT column
SELECT employee_id FROM staff;   -- => SQL ������ ���̽� ������ ���� : staff.loc[:, 'employee_id']
-- ���� SQL�� ���� ���̺��� �Ǵٽ� ���������������� �� ���� ���� -> ChatGPT�� �ش޶�� ����
-- SQL�� �Ǵٽ� �������������� �����ؼ� ���� ���� ����

-- å '���� ù SQL����' p42 == SELECT���� FROM��
-- SELECT�� �� �ٿ� ������ �ѹ��� ���� ���� but �������� ���� �ϳ��� �ۼ��� �ִ°� ����
USE lily_book;
SELECT employee_id, employee_name, birth_date FROM staff;

-- �������� ���� ��õ ��� (��� ��� ��)
SELECT 
	ep_id                     -- ���ID
	, ep_name                 -- �����
	, birth_date 
FROM staff
;    -- ����Ŭ���� �� �ؿ� ��ġ�Ͽ� �ش� ���� �ڵ� �ۼ� �Ϸ��ߴٴ� ���� ���� 

SELECT * FROM staff;

-- ��ȸ �� �÷� ������ �ٲٷ��� SELECT �Ŀ� �ܾ� ������ �ٲٸ� ��
SELECT employee_name, employee_id FROM staff;   -- ��ȸ �� �÷� ���� ���� ����

-- �÷��� ��Ī �����ϱ�
-- �Ϲ������� �÷��� ������ ����, ���� ���� ���� ==> �÷��� ���� ����, Ÿ���� ������ ���Ǽ����� ����
-- �÷� ��Ī�� ���� ALISA (=AS)��� ��
SELECT employee_id, birth_date
FROM staff
;

SELECT employee_id, birth_date AS '���� ����'  -- �������, '�������', "�������" ���� but, ���� ������ �ȵ� => '���� ����' = "���� ����"�� ����
FROM staff
;

-- DISTINCT �ߺ��� ����
SELECT * FROM staff;

SELECT DISTINCT gender FROM staff;  -- �ߺ��� �����ؼ� ����

SELECT gender FROM staff;           -- ��� gender���� �� ����

SELECT employee_name, gender, position FROM staff;
SELECT DISTINCT position, employee_name, gender FROM staff;   -- ����� �ߺ��̿��µ� �� ����� because employee_name�� �ߺ� X
SELECT DISTINCT position, gender FROM staff;                  -- ��� �ϳ��� ����� == �ߺ����� ���ŵ�

-- ���ڿ� �Լ� : �ٸ� DBMS�� ���� ����, ��α׿� ���� ��õ 
SELECT * FROM apparel_product_info;


-- LEFT �Լ�
SELECT product_id, LEFT(product_id, 2) AS ���  -- LEFT 2�ϱ� product_id���� ���ʿ��� 2��° ���ڱ��� ������
FROM apparel_product_info;

-- SUBSTRING �Լ� : ���ڿ� �߰� N��° �ڸ����� n���� ���
-- SUBSTRING(�÷���, ����(N start), ����(n end))  ---> N��° ���ں��� �����ؼ� n���� ���ڸ� ������
-- ���̽�, �ٸ� ���α׷��� ���� �ε����� 0���� ����
-- MS-SQL�� �ε����� 1���� ����
SELECT product_id, SUBSTRING(product_id, 1, 1) AS ���  
FROM apparel_product_info;

-- ����) product_id�� ���� W�� S�� ��������
SELECT product_id, SUBSTRING(product_id, 7, 1) AS ���  
FROM apparel_product_info;

-- CONCAT �Լ� : ���ڿ��� ���ڿ� �̾ ���
SELECT CONCAT(category1, '>', category2, '=', '��', price) AS �׽�Ʈ
FROM apparel_product_info;







