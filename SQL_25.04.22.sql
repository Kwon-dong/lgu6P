-- 현재 데이터베이스 확인
SELECT DB_NAME();

-- 데이터베이스 > 테이블(pandas 데이터프레임)
-- 일반적으로 데이터베이스 안에 있는 것
---- 테이블 외에도, view, 프로시저, 트리거, 사용자 정의 함수 등 포함

-- SQL은 초창기 SQLE로 불림 -> SQLE에서 E == English -> SQL 문법이 영어 문법과 매우 흡사함
-- 표준 SQL, 99% 비슷 but, 1% 다름 ==> 데이터베이스 종류마다 데이터타입 지정할때 차이가 좀 있음

-- 테이블 생성
CREATE TABLE promotions(
	promotion_id INT PRIMARY KEY IDENTITY(1, 1), -- 데이터타입 지정
	promotion_name VARCHAR(255) NOT NULL
);
-- lily_book 밑의 Tables 파일에 dbo.promotions 테이블이 추가되어있음을 확인 가능

-- 데이터 추가
-- 웹개발자 분들은 INSERT 구문을 각 웹개발프레임워크와 연동해서 처리
INSERT INTO promotions(
	promotion_name 
)
VALUES(
	'2025 Summer Promotion'
);

-- promotions에 데이터 추가됐는지 확인
SELECT * FROM promotions;   -- 실제 현장에서 이렇게 잘 안씀

-- lily_book 스키마의 staff의 데이터 확인
USE lily_book
SELECT * FROM staff;  

-- 또다른 방법
SELECT * FROM lily_book.dbo.staff;

-- BikeStores 스키마의 production.brands 데이터 확인
USE BikeStores;
SELECT * FROM production.brands

-- 책 '나의 첫 SQL수업' p36
-- SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY
-- FROM A pandas DataFrame SELECT column
SELECT employee_id FROM staff;   -- => SQL 문법은 파이썬 문법과 유사 : staff.loc[:, 'employee_id']
-- 따라서 SQL로 만든 테이블을 판다스 데이터프레임으로 다 변경 가능 -> ChatGPT에 해달라고 ㄱㄱ
-- SQL과 판다스 데이터프레임을 연동해서 같이 공부 ㄱㄱ

-- 책 '나의 첫 SQL수업' p42 == SELECT절과 FROM절
-- SELECT로 한 줄에 여러개 한번에 실행 가능 but 가독성을 위해 하나씩 작성해 주는게 좋음
USE lily_book;
SELECT employee_id, employee_name, birth_date FROM staff;

-- 가독성을 위한 추천 방식 (약어 사용 시)
SELECT 
	ep_id                     -- 사원ID
	, ep_name                 -- 사원명
	, birth_date 
FROM staff
;    -- 세미클론을 맨 밑에 배치하여 해당 쿼리 코드 작성 완료했다는 것을 보임 

SELECT * FROM staff;

-- 조회 시 컬럼 순서를 바꾸려면 SELECT 후에 단어 순서를 바꾸면 됨
SELECT employee_name, employee_id FROM staff;   -- 조회 시 컬럼 순서 변경 가능

-- 컬럼의 별칭 지정하기
-- 일반적으로 컬럼명 지정할 때는, 영어 약어로 지정 ==> 컬럼에 대한 설명, 타입은 데이터 정의서에서 관리
-- 컬럼 별칭을 보통 ALISA (=AS)라고 함
SELECT employee_id, birth_date
FROM staff
;

SELECT employee_id, birth_date AS '생년 월일'  -- 생년월일, '생년월일', "생년월일" 가능 but, 생년 월일은 안됨 => '생년 월일' = "생년 월일"은 가능
FROM staff
;

-- DISTINCT 중복값 제거
SELECT * FROM staff;

SELECT DISTINCT gender FROM staff;  -- 중복값 제거해서 나옴

SELECT gender FROM staff;           -- 모든 gender값이 다 나옴

SELECT employee_name, gender, position FROM staff;
SELECT DISTINCT position, employee_name, gender FROM staff;   -- 사원이 중복이였는데 안 사라짐 because employee_name에 중복 X
SELECT DISTINCT position, gender FROM staff;                  -- 사원 하나가 사라짐 == 중복값이 제거됨

-- 문자열 함수 : 다른 DBMS와 문법 유사, 블로그에 정리 추천 
SELECT * FROM apparel_product_info;


-- LEFT 함수
SELECT product_id, LEFT(product_id, 2) AS 약어  -- LEFT 2니까 product_id값의 왼쪽에서 2번째 문자까지 가져옴
FROM apparel_product_info;

-- SUBSTRING 함수 : 문자열 중간 N번째 자리부터 n개만 출력
-- SUBSTRING(컬럼명, 숫자(N start), 숫자(n end))  ---> N번째 문자부터 시작해서 n개의 문자를 가져옴
-- 파이썬, 다른 프로그래밍 언어는 인덱스가 0부터 시작
-- MS-SQL은 인덱스가 1부터 시작
SELECT product_id, SUBSTRING(product_id, 1, 1) AS 약어  
FROM apparel_product_info;

-- 예제) product_id의 약어로 W와 S만 가져오기
SELECT product_id, SUBSTRING(product_id, 7, 1) AS 약어  
FROM apparel_product_info;

-- CONCAT 함수 : 문자열과 문자열 이어서 출력
SELECT CONCAT(category1, '>', category2, '=', '옷', price) AS 테스트
FROM apparel_product_info;







