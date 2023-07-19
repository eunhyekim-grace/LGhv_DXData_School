-- DB 사용 설정
use mydb;

-- TABLE 생성
-- 이름 contact
-- 속성 
	-- NUM은 정수, 일련 번호, 기본 키
	-- NAME은 한굴 7자까지 저장, 글자 수는 변경X 가정
	-- ADDRESS는 한굴 100자까지 저장, 글자수 변경 자주 발생
	-- TEL은 숫자로되 문자열 11자리, 글자수 변경 X
	-- EMAIL은 영문 100자리 이내, 글자수 변경 자주 발생
	-- BIRTHDAY는 날짜만 저장
	-- 주로 조회를 하고 일련 번호는 1~, 인코딩은 utf8

CREATE TABLE contact(
	num INTEGER AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(21),-- 변경 X
	address TEXT, -- CHAR(300) 메모리 초과
	tel VARCHAR(11),
	email CHAR(100), -- 변경 O
	birthday DATE
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- contact table에 age 컬럼을 정수 자료형으로 추가
ALTER TABLE contact 
ADD age INTEGER;

-- contact table 구조 확인
DESC contact;

-- contact table에서 age 컬럼 삭제
ALTER TABLE contact 
DROP age;

DESC contact;

-- contact table에서 tel 컬럼 이름을 phone으로 자료형은 정수로 수정
ALTER TABLE contact
CHANGE tel phone INTEGER;

DESC contact;

-- contact table 삭제
DROP TABLE contact;

SHOW TABLES;

-- DEPT 테이블은 EMP 테이블에서 DEPTNO 컬럼을 참조하므로 삭제가 X
DROP TABLE DEPT;

-- NOT NULL 제약 조건 설정
CREATE TABLE Nulltable(
	name CHAR(10) NOT NULL,
	age INTEGER
);
INSERT INTO Nulltable(name,age) VALUES ('grace',22);
-- 기본 값 X 에러 발생
INSERT INTO Nulltable(age) VALEUS(22); 

DROP TABLE Nulltable;

SHOW TABLES;

-- 기본값 설정
CREATE TABLE tDefault(
	name CHAR(10) NOT NULL,
	age INTEGER DEFAULT 0
);

INSERT INTO tDefault(name,age) VALUES ('grace', 22);
-- 기본값이 설정된 컬럼을 제외하고 입력하면 그 컬럼에는 기본값 삽입됨
INSERT INTO tDefault(name) VALUES ('hi');

-- 데이터 확인
SELECT * FROM tDefault;

-- name, gender(성별 - 남/여), age(나이는 양수) 속성으로 갖는 테이블 생성
CREATE TABLE tCheck(
	name CHAR(10) NOT NULL,
	gender CHAR(3) CHECK(gender IN ('남','여')),
	age INT CHECK(age >= 0)
);

INSERT INTO tCheck(name,gender,age) VALUES ('김좌진', '남', 53);
-- CONSTRAINT VIOLATED ERROR
INSERT INTO tCheck(name,gender,age) VALUES ('홍범도', '남', -23); -- age가 음수
INSERT INTO tCheck(name,gender,age) VALUES ('김좌진', '여자', 53) -- gender가 '여' 가 아닌 '여자'

SELECT * FROM tCheck;

-- 기본키 설정: 제약 조건 이름 없이
CREATE TABLE tPK1(
	name CHAR(10) PRIMARY KEY,
	age INT
);

-- 기본키 설정: 제약 조건 이름과 함께 생성
CREATE TABLE tPK2(
	name CHAR(10),
	age INT,
	CONSTRAINT PK_tPK2 PRIMARY KEY(name) -- table 제약 조건
);

-- 2개의 컬럼으로 기본키 설정: 테이블을 생성할 때 PRIMARY KEY는 한 번만 사용 가능
CREATE TABLE tPK3(
	name CHAR(10),
	age INT,
	CONSTRAINT PK_tPK3 PRIMARY KEY(name, age)
);

INSERT INTO tPK3(name,age) VALUES('adam', 54);
-- 기본 키인 name의 값이 같아서 삽입 실패
INSERT INTO tPK3(name,age) VALUES('adam',53);
-- 기본 키인name의 값이 NULL 삽입 실패
INSERT INTO tPK3(age) VALUES(54)

-- UNIQUE 제약 조건
CREATE TABLE tUnique(
	name CHAR(10),
	age INT UNIQUE,
	CONSTRAINT tUnique PRIMARY KEY(name)
);

INSERT INTO tUnique(name,age) VALUES('adma', 54);
-- age가 중복되서 실패
INSERT INTO tUunique(name,age) VALUES('jessica',54);
-- UNIQUE는 NULL은 삽입 가능
INSERT INTO tUnique(name) VALUES('jessica');
INSERT INTO tUnique(name) VALUES('hunter');

SELECT * FROM tUnique;

-- 외래키를 지정하지 않는 2개의 테이블

-- 직원 테이블
CREATE TABLE tEmployee(
	name CHAR(10) PRIMARY KEY,
	salary INT NOT NULL,
	addr VARCHAR(30) NOT NULL
);

INSERT INTO tEmployee VALUES('아이린',650, '대구');
INSERT INTO tEmployee VALUES('정만식',730,'목포');
INSERT INTO tEmployee VALUES('이국종',1000,'양천구');

SELECT * FROM tEmployee;

-- PJ 테이블
-- employee는 pj에 참여한 직원 이름
CREATE TABLE tProject(
	projectid INT PRIMARY KEY,
	employee CHAR(10) NOT NULL,
	project VARCHAR(30) NOT NULL,
	cost INT
);

INSERT INTO tProject VALUES(1,'아이린', '웹',3000);
-- joy는 tEployee 테이블에 없는 이름인데도 삽입이 가능
INSERT INTO tProject VALUES(2, 'joy','microservice',10000);

SELECT * FROM tProject;

-- 기존 테이블 삭제
DROP TABLE tEmployee;
DROP TABLE tProject;
SHOW TABLES;

-- 외래키 설정 - 직원과 프로젝트의 관계는 1:N
-- 직원 테이블 
CREATE TABLE tEmployee(
	name CHAR(10) PRIMARY KEY,
	salary INT NOT NULL,
	addr VARCHAR(30) NOT NULL
);

INSERT INTO tEmployee VALUES('아이린',650, '대구');
INSERT INTO tEmployee VALUES('정만식',730,'목포');
INSERT INTO tEmployee VALUES('이국종',1000,'양천구');

SELECT * FROM tEmployee;

-- 프로젝트 테이블
-- employee는 프로젝트에 참여한 직원 이름
CREATE TABLE tProject(
	projectid INT PRIMARY KEY,
	employee CHAR(10) NOT NULL,
	project VARCHAR(30) NOT NULL,
	cost INT,
	CONSTRAINT FK_emp FOREIGN KEY(employee) REFERENCES tEmployee(name)
);

INSERT INTO tProject VALUES(1,'아이린', '웹',3000);
-- joy는 tEployee 테이블에 없는 이름이라 삽입 불가
INSERT INTO tProject VALUES(2, 'joy','microservice',10000);
-- tEmployee 테이블의 데이터 삭제
DELETE FROM tEmployee WHERE name = '정만식';
-- 아이린은 tProject 테이블에서 참조하고 있기 때문에 삭제 불가능
DELETE FROM tEmployee WHERE name = '아이린';
-- tEmployee 테이블 삭제 불가능
DROP TABLE tEmployee;
SELECT * FROM tProject;


-- 실습을 위해 기존 테이블 삭제
DROP TABLE tProject;
DROP TABLE tEmployee;
SHOW TABLES;

-- 외래키 설정 - 직원과 프로젝트의 관계는 1:N, 옵션 - cascade
-- 직원 테이블 
CREATE TABLE tEmployee(
	name CHAR(10) PRIMARY KEY,
	salary INT NOT NULL,
	addr VARCHAR(30) NOT NULL
);

INSERT INTO tEmployee VALUES('아이린',650, '대구');
INSERT INTO tEmployee VALUES('정만식',730,'목포');
INSERT INTO tEmployee VALUES('이국종',1000,'양천구');

SELECT * FROM tEmployee;

-- 프로젝트 테이블
-- tEmployee 테이블의 name이 수정되거나 삭제 될 때 같이 수정되거나 삭제됨
CREATE TABLE tProject(
	projectid INT PRIMARY KEY,
	employee CHAR(10) NOT NULL,
	project VARCHAR(30) NOT NULL,
	cost INT,
	CONSTRAINT FK_emp FOREIGN KEY(employee) REFERENCES tEmployee(name) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO tProject VALUES(1,'아이린','웹',3000);

SELECT * FROM tProject;

-- tEmployee 테이블에서 아이린을 배주현으로 수정
UPDATE tEmployee SET name = '배주현' WHERE name = '아이린';

SELECT * FROM tEmployee;
SELECT * FROM tProject;

-- ----------------------------------------------------
-- 외래키 설정 - 직원과 프로젝트의 관계는 1:N, option - null
DROP TABLE tProject;
DROP TABLE tEmployee;
SHOW TABLES;

-- 직원 테이블 
CREATE TABLE tEmployee(
	name CHAR(10) PRIMARY KEY,
	salary INT NOT NULL,
	addr VARCHAR(30) NOT NULL
);

INSERT INTO tEmployee VALUES('아이린',650, '대구');
INSERT INTO tEmployee VALUES('정만식',730,'목포');
INSERT INTO tEmployee VALUES('이국종',1000,'양천구');

SELECT * FROM tEmployee;

-- 프로젝트 테이블
-- tEmployee 테이블의 name이 수정되거나 삭제 될 때 값이 NULL로 변경
CREATE TABLE tProject(
	projectid INT PRIMARY KEY,
	employee CHAR(10),
	project VARCHAR(30) NOT NULL,
	cost INT,
	CONSTRAINT FK_emp FOREIGN KEY(employee) REFERENCES tEmployee(name)
		ON DELETE SET NULL ON UPDATE SET NULL
);

INSERT INTO tProject VALUES(1,'아이린','웹',3000);
SELECT * FROM tProject;

-- tEmployee 테이블에서 아이린을 배주현으로 수정: employee 값이 NULL로 설정
UPDATE tEmployee SET name = '배주현' WHERE name = '아이린';

SELECT * FROM tEmployee;
SELECT * FROM tProject;

-- 일련 번호 사용
CREATE TABLE BOARD(
	num INT AUTO_INCREMENT PRIMARY KEY, -- PRIMARY KEY or UNIQUE 없이 AUTO_INCREMENT 사용 X
	title CHAR(100),
	content TEXT
);

INSERT INTO BOARD(title, content) VALUES('제목1', '내용1');
INSERT INTO BOARD(title, content) VALUES('제목2', '내용2');
-- 자동으로 1,2, ... 순서대로 삽입
SELECT * FROM BOARD;

-- 2번 data 삭제
DELETE FROM BOARD WHERE num = 2;
INSERT INTO BOARD(title, content) VALUES('제목3', '내용3');
-- 3번으로 삽입
SELECT * FROM BOARD;

-- AUTO_INCREMENT 값도 직접 삽입 가능 - 권장X
INSERT INTO BOARD(num, title, content) VALUES(200,'제목','내용');
INSERT INTO BOARD(title, content) VALUES('제목?','내용?');
SELECT * FROM BOARD;

-- 일련 번호 초기화
ALTER TABLE BOARD AUTO_INCREMENT = 1000;
INSERT INTO BOARD(title, content) VALUES ('제목?','내용?');
SELECT * FROM BOARD;

SELECT * FROM information_schema.table_constraints;

-- 데이터 삽입을 위해 테이블 구조 확인
DESC tCity;

-- 컬럼 이름을 나열해서 데이터 삽입
INSERT INTO tCity(name, area, popu, metro, region) VALUES('평택',200,130,'n','경기');
-- 모든 컬럼의 값을 순서대로 입력하는 경우는 컬럼 이름 생략 가능
INSERT INTO tCity VALUES ('목포',23, 52, 'n','전라');
-- NOT NULL이 설정된 컬럼을 제외하고는 생략하고 삽입 가능
INSERT INTO tCity(name, area, metro, region) VALUES ('여수',25,'n','전라');
-- 한 번에 여러개 삽입
INSERT INTO tCity(name, area, metro, region) 
VALUES ('대전',120,'y','충청'), ('마산',87,'n','경상');

SELECT * FROM tCity;

-- tCity 테이블에서 name이 대전인 데이터 삭제
DELETE FROM tCity WHERE name = '대전';

-- tCity 테이블에서 name이 마산인 데이터의 popu를 40으로 수정
UPDATE tCity SET popu = 40 WHERE name = '마산';
SELECT * FROM tCity;

