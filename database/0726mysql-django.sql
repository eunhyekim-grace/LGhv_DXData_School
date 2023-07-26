-- DB 확인
show databases;

-- DB 삭제
-- DROP Database mydb;

-- DB 생성
-- CREATE database mydb;

-- DB 안의 table 확인
use mydb;

show tables;

-- myapp_item table의 구조 확인
desc myapp_item;

-- 조회를 위해 sample data 삽입
INSERT INTO myapp_item VALUES('1','레몬',500, '비타민 A','lemon.jpg');
INSERT INTO myapp_item VALUES('2','사과', 230, '비타민 D', 'apple.jpg');
INSERT INTO myapp_item VALUES('3','오렌지',300, '비타민 E','orange.jpg');
INSERT INTO myapp_item VALUES('4','키위', 150, '비타민 C', 'kiwi.jpg');
INSERT INTO myapp_item VALUES('5','포도',400, '비타민 A','grape.jpg');
INSERT INTO myapp_item VALUES('6','딸기', 130, '비타민 D', 'strawberry.jpg');


SELECT * FROM myapp_item;