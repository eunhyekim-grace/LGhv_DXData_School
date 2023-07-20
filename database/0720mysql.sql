use mydb;

-- SELECT 구문 실행: transaction과 아무런 연관성 없음
SELECT * FROM DEPT;

-- DEPT table에 데이터 1개 삽입: 이전 transaction이 없기 때문에 transaction 생성
INSERT INTO DEPT(DEPTNO, DNAME, LOC) VALUES(50,'회계','서울');

-- 철회: savepoint를 입력하지 않으면 transaction 시작 전으로 복구
ROLLBACK;

-- 삽입 - transaction 생성
INSERT INTO DEPT(DEPTNO, DNAME, LOC) VALUES(50,'회계','서울');

-- DEPT 테이블의 모든 내용을 가진 DEPTCOPY 테이블 생성 
-- DDL(CREATE, DROP, ALTER, TRUNCATE, RENAME)이나 DCL(GRANT, REVOKE)를 수행하면 AUTO COMMIT
-- COMMIT 수행: transaction은 변경 내용을 반영하고 종료
CREATE TABLE DEPTCOPY AS SELECT * FROM DEPT;
SELECT * FROM DEPTCOPY;

-- 철회 -> 돌아갈 곳 X
ROLLBACK;

SELECT * FROM DEPT;

-- transaction 생성
INSERT INTO DEPT(DEPTNO, DNAME, LOC) VALUES(60,'회계','서울');
SAVEPOINT SV1;
INSERT INTO DEPT(DEPTNO, DNAME, LOC) VALUES(70,'회계','서울');
SAVEPOINT SV2;
INSERT INTO DEPT(DEPTNO, DNAME, LOC) VALUES(80,'회계','서울');

SELECT * FROM DEPT;

-- SV1 SAVEPOINT를 생성한 지점으로 이동
ROLLBACK TO SV1;

-- COMMIT;

-- 일반적인 JOIN 방법을 이용해서 JOB이 CLERK인 데이터의 정보를 조회
SELECT * FROM EMP, DEPT
WHERE EMP.DEPTNO  = DEPT.DEPTNO AND JOB = 'CLERK';

-- INLINE VIEW를 이용한 JOIN
SELECT * FROM (SELECT * FROM EMP WHERE JOB = 'CLERK') TEMP, DEPT
WHERE TEMP.DEPTNO  = DEPT.DEPTNO 

-- EMP 테이블에서 EMPNO, ENAME, SAL, COMM만으로 구성된 VIEW 생성
CREATE VIEW KIM
AS
SELECT EMPNO, ENAME, SAL, COMM FROM EMP;

-- VIEW는 테이블 처럼 사용
SELECT * FROM KIM;

-- VIEW에 DML(삽입, 삭제, 갱신) 작업은 가능한 경우도 있고 가능하지 않은 경우도 있음
DESC EMP;

-- VIEW에 데이터 삽입 - VIEW를 만들 때 사용한 EMP 테이블에 데이터 삽입됨
INSERT INTO KIM(EMPNO, ENAME, SAL, COMM) VALUES (9999,'ADAM',1000,2120);

SELECT * FROM KIM;
SELECT * FROM EMP;

-- VIEW의 구조 확인
DESC KIM;

-- VIEW 삭제
DROP VIEW KIM;

-- 임시 테이블 생성
CREATE TEMPORARY TABLE TEMP(
	NAME CHAR(20)
);
SELECT * FROM TEMP;

-- CTE X 수행
SELECT * FROM (SELECT NAME, SALARY, SCORE FROM tStaff WHERE DEPART = '영업부' AND GENDER = '남') TEMP
WHERE SALARY >= (SELECT AVG(SALARY) FROM (SELECT NAME, SALARY, SCORE FROM tStaff WHERE DEPART = '영업부' AND GENDER = '남') TEMP);

-- CTE: SQL 수행 중에만 일시적으로 메모리 공간을 할당 받아서 사용하는 테이블
-- SELECT 구문의 결과를 일시적으로 TEMP라는 테이블 이름을 부여해서 보관
-- CTE를 생성하는 구문은 가장 먼저 수행됨
-- 이 와 유사한 작업을 INLINE VIEW를 할 수 있을 것 처럼 보이지만 INLINE VIEW는 SUB Query보다 늦게 수행되기 때문에 INLINE VIEW는 SUB Query 사용 X
WITH TEMP AS
(SELECT NAME, SALARY, SCORE FROM tStaff WHERE DEPART = '영업부' AND GENDER = '남')
SELECT * FROM TEMP WHERE SALARY >= (SELECT AVG(salary) FROM TEMP);

-- usertbl 테이블 존재 여부 확인
SHOW TABLES;
DESC usertbl; -- 테이블 없으면 ERROR
SELECT * FROM usertbl; -- 테이블 없으면 ERROR

-- DELIMITER는 프로시저 종료를 알리기 위한 기로를 설정하는 것 - 2개로 만드는 이유: 하나 짜리로 만들면 데이터로 사용되는 것과 혼동이 올 수 있어서
-- DBEAVER에서 수행할 때는 SQL 스크립스 실행
DELIMITER //
CREATE PROCEDURE myproc(vuserid char(15), vname varchar(20), vbirthday int(11), vaddr char(100), vmobile char(11), vmdate date)
	BEGIN
		INSERT INTO usertbl
		VALUES(vuserid, vname, vbirthday, vaddr, vmobile, vmdate);
	END //
DELIMITER ;

CALL myproc('mansik','정만식',1974, '목포','01011112222','1974-12-11');

SELECT * FROM usertbl;

-- trigger 수행하기 위한 sample table 생성
CREATE TABLE EMP01(
	EMPNO INT PRIMARY KEY,
	ENAME VARCHAR(30) NOT NULL,
	JOB VARCHAR(100)
);

CREATE TABLE SAL01(
	SALNO INT PRIMARY KEY AUTO_INCREMENT,
	SAL FLOAT(7,2),
	EMPNO INT REFERENCES EMP01(EMPNO) ON DELETE CASCADE
);

SHOW TABLES;

-- EMP01 테이블에 데이터를 추가하면 SAL01 테이블에 데이터가 자동으로 추가되는 트리거
DELIMITER //
CREATE TRIGGER trg_01
AFTER INSERT ON EMP01
FOR EACH ROW
BEGIN 
	INSERT INTO SAL01(SAL, EMPNO) VALUES(100, NEW.EMPNO);
END //
DELIMITER ;

INSERT INTO EMP01 VALUES(1,'아담','프로그래머');

SELECT * FROM SAL01;
SELECT * FROM EMP01;

USE mydb;
SHOW TABLES;

DESC DEPT;

SELECT * FROM DEPT;

-- 파일 저장할 수 있는 테이블
CREATE TABLE BLOBTABLE(
	FILENAME VARCHAR(100),
	FILECONTENT LONGBLOB
);

DESC BLOBTABLE;

SELECT * FROM BLOBTABLE;









