-- db 사용 설정
use mydb;

-- db에 존재하는 table 확인
show tables;

-- 현재 유저 확인
SELECT USER();

-- 현재 사용 중인 DB 확인
SELECT DATABASE();

-- MySQL은 매개 변수가 없는 함수는 이름만으로 수행 가능
 SELECT DATABASE();
 
-- EMP table에서 ENAME과 COMM 조회
-- NULL 과 연산하면 결과 NULL
SELECT ENAME, SAL, COMM, SAL+COMM AS 수령액 FROM EMP;

-- EMP table에서 ENAME, SAL, COMM, SAL+COMM 조회, COMM이 NULL이면 0으로 계산
SELECT ENAME,SAL,COMM,SAL+IFNULL(COMM,0) AS 수령액 FROM EMP; 

-- COMM이 NULL이 아니면 COMM, COMM이 NULL이고 SAL이 NULL이 아니면 SAL return
SELECT COALESCE(COMM,SAL) FROM EMP;

-- EMP table에서 NULL이 아닌 data 개수 조회
SELECT COUNT(EMPNO) FROM EMP;

-- EMP table data 개수 조회: 모든 column이 NULL이 아닌 data 개수 조회
SELECT COUNT(*) AS CNT FROM EMP;

-- EMP table에서 SAL의 평균 구하기
SELECT AVG(SAL) AS AVG FROM EMP; 

-- EMP table에서 COMM의 평균 -> 10개 NULL, 4개 NULL 아님
-- NULL을 계산에서 제외했기 때문에 4로 나눔
SELECT AVG(COMM) FROM EMP;
-- NULL cell까지 포함해서 14로 나눔
SELECT SUM(COMM)/COUNT(*) FROM EMP;

-- 같은 결과값 도출
SELECT AVG(IFNULL(COMM,0)) FROM EMP;

-- EMP table의 ENAME과 data 개수 조회 - 에러
SELECT ENAME, COUNT(*) FROM EMP;

-- EMP table에서 DEPTNO 별로 SAL의 평균 조회
-- GROUP BY 가 있는 경우 GROUP BY 절에 없는 column이나 연산식을 조회하면 행의 개수가 맞지 않아서 에러
SELECT  DEPTNO,AVG(SAL) FROM EMP
GROUP BY DEPTNO; 

-- tCity table에서 REGION 별 POPU의 합계
SELECT region, COUNT(popu) FROM tCity
GROUP BY region;

-- 2개 이상의 column으로 그룹화 가능
-- tStaff table에서 depart, gender 별로 data개수 조회
SELECT depart, gender, COUNT(*) FROM tStaff
GROUP BY depart, gender
ORDER BY depart;

-- EMP table에서 DEPTNO가 5번 이상 나오는 경우 DEPTNO와 SAL의 평균 조회
SELECT DEPTNO, AVG(SAL) FROM EMP
-- WHERE COUNT(DEPTNO) >= 5 -- invalid function -> 그룹화 함수는 그룹화 후에 사용해야함
-- 그룹 함수를 이용한 조건은 HAVING 절에 기재
GROUP BY DEPTNO
HAVING COUNT(DEPTNO) >=5;

-- tStaff table에서 DEPART 별로 SAL의 평균이 340이 넘는 부서의 DEAPRT와 SAL의 평균 조회
SELECT depart, AVG(salary) from tStaff
GROUP BY depart
HAVING AVG(salary) > 340;

-- tStaff table에서 depart가 인사과나 영업부인 data의 depart와 salary의 최댓값 조회
-- 집계 함수를 사용하지 않아도 되므로 WHERE에 조건을 작성하는 것이 좋음
SELECT depart, MAX(salary) FROM tStaff
WHERE depart IN ('인사과','영업부') -- IN 대신에 OR 사용해도 됨
GROUP BY depart;
-- HAVING depart IN ('인사과','영업부')

-- EMP table에서 SAL이 많은 순서부터 일련번호 형태로 ENAME과 SAL 조회
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) AS NUM,ENAME, SAL FROM EMP;
-- RANK()
-- DENSE_RANK()

-- 그룹 분할: 3등분
SELECT NTILE(3) OVER(ORDER BY SAL DESC) AS NUM, ENAME, SAL FROM EMP;

-- EMP table에서 DEPTNO별로 SAL이 많은 순서부터 일련번호 형태로 ENAME과 SAL 조회
SELECT DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS NUM,DEPTNO,ENAME, SAL FROM EMP
ORDER BY SAL DESC; -- PARTITION 사용 할 때는 원하는 column으로 정렬하기 위해서 ODER BY를 따로 밑에 작성

-- EMP table에서 SAL의 내림 차순으로 정렬한 다음 data와의 차이를 알고자 하는 경우
SELECT ENAME, SAL, SAL - (LEAD(SAL,1) OVER(ORDER BY SAL DESC)) AS '급여 차이' FROM EMP;

-- EMP table에서 SAL의 내림 차순으로 정렬한 이전 data와의 차이를 알고자 하는 경우
SELECT ENAME, SAL, SAL - (LAG(SAL,1) OVER(ORDER BY SAL DESC)) AS '급여 차이' FROM EMP;

-- EMP table에서 SAL의 내림 차순으로 정렬한 첫 번째 data와의 차이를 알고자 하는 경우 = 최댓값과의 차이
SELECT ENAME, SAL, SAL - (FIRST_VALUE (SAL) OVER(ORDER BY SAL DESC)) AS '급여 차이' FROM EMP;

-- 급여의 누적 백분율
SELECT ENAME, SAL, CUME_DIST() OVER(ORDER BY SAL DESC) * 100 AS '누적 백분율' FROM EMP;

-- EMP table JOB별 DEPTNO 별 SAL의 합계
SELECT JOB, DEPTNO, SUM(SAL) FROM EMP
GROUP BY JOB,DEPTNO;

-- pivot 이용
SELECT JOB,
	SUM(IF(DEPTNO=10,SAL,0)) AS '10',
	SUM(IF(DEPTNO=20,SAL,0)) AS '20',
	SUM(IF(DEPTNO=30,SAL,0)) AS '30',
	SUM(SAL) AS '합계'
FROM EMP
GROUP BY JOB

-- JSON 출력
SELECT JSON_OBJECT('ENAME',ENAME,'SAL', SAL) AS 'JSON' FROM EMP;

-- EMP table에서 DEPTNO 조회: 10,20,30
SELECT DISTINCT DEPTNO FROM EMP;

-- DEPT table에서 DEPTNO를 조회: 10,20,30,40
SELECT DEPTNO FROM DEPT;

-- EMP table과 DEPT table의 DEPTNO의 합집합: 10,20,30,40 -> 중복 제거
SELECT DEPTNO FROM EMP UNION SELECT DEPTNO FROM DEPT;
SELECT DEPTNO FROM EMP UNION ALL SELECT DEPTNO FROM DEPT; -- 중복 모두 출력
SELECT DEPTNO FROM EMP INTERSECT SELECT DEPTNO FROM DEPT; -- 교집합: 10,20,30
SELECT DEPTNO FROM DEPT EXCEPT SELECT DEPTNO FROM EMP; -- 차집합: 40

-- table 구조 확인
DESC EMP;

-- ENAME이 MILLER인 사원의 DNAME 조회
SELECT DEPTNO FROM EMP
WHERE ENAME= 'MILLER';

SELECT DNAME FROM DEPT
WHERE DEPTNO=10;

-- Sub Query 이용
-- 괄호 안의 Sub Query를 먼저 수행해서 10을 찾아오고 그 값을 이용해서 DNAME 조회
SELECT DNAME FROM DEPT
WHERE DEPTNO = (SELECT DEPTNO FROM EMP
				WHERE ENAME= 'MILLER');

-- EMP table에서 SAL의 평균보다 더 많은 SAL을 받는 직원의 ENAME과 SAL을 조회
SELECT ENAME, SAL FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP);

-- EMP table에서 ENMAE이 MILLER인 사원과 동익한 JOB을 가진 사원의 ENAME과 JOB, MILLER 제외
SELECT ENAME, JOB FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE ENAME = 'MILLER') AND ENAME != 'MILLER';

-- EMP table에서 DEPT table의 LOC가 DALLAS인 사원의 ENAME과 SAL을 조회
SELECT ENAME, SAL FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS');

-- EMP table에서 DEPTNO별 SAL의 최대값과 동일한 SAL을 갖는 사원의 EMPNO, ENAME, SAL 조회
-- 에러 -> 서브 쿼리의 결과가 3개라서 =로 비교 불가능
SELECT EMPNO, ENAME, SAL FROM EMP
WHERE SAL = (SELECT MAX(SAL) FROM EMP
			GROUP BY DEPTNO);

-- 서브 쿼리의 결과가 2개 이상인 경우는 그 중의 하나의 값과 일치하면 됨
SELECT EMPNO, ENAME, SAL FROM EMP
WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);
			
-- EMP table에서 DEPTNO가 30인 data들의 SAL보다 큰 data의 ENAME과 SAL 조회
-- 모든 data 보다 커야 하는 경우는 ALL을 사용
SELECT ENAME, SAL FROM EMP
WHERE SAL > ALL(SELECT SAL FROM EMP WHERE DEPTNO = 30);

SELECT ENAME, SAL FROM EMP
WHERE SAL > (SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 30); -- ALL을 MAX로 대체해서 사용 가능

-- data 중 1개 보다 크면 되는 경우는 ANY 사용
SELECT ENAME, SAL FROM EMP
WHERE SAL > ANY(SELECT SAL FROM EMP WHERE DEPTNO = 30);

SELECT ENAME, SAL FROM EMP
WHERE SAL > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30); -- ANY는 MIN으로 대체해서 사용 가능

-- EMP table에서 SAL이 2000이 넘는 data가 있으면 ENAME, SAL 조회
-- 2000이 넘는 데이터가 존재 하므로 모든 데이터를 조회
SELECT ENAME, SAL FROM EMP
WHERE EXISTS(SELECT 1 FROM EMP WHERE SAL > 2000);
			
-- Cartesian Product(교차 곱)
-- FROM 절에 테이블 이름이 2개 이상이고 JOIN조건이 없는 경우 
-- EMP table은 8열 14행, DEPT table은 3열 4행
-- Cartesian product 결과는 11열 56행
SELECT * FROM EMP, DEPT;

-- EQUI JOIN(동등 조인)
-- FROM 절에 테이블 이름이 2개 이상이고 WHERE 절에 2개 테이블의 공통된 컬럼의 값이 같다라는 조인 조건이 있는 경우
SELECT * FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- 한 쪽 테이블에만 존재하는 컬럼을 출력할 때는 컬럼 이름만 기재해도 O
SELECT ENAME, DNAME, LOC FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- 양 쪽 테이블에 모두 존재하는 컬럼의 경우는 앞에 테이블 이름을 명시해야 함
-- 테이블 이름 명시하지 않으면 이름이 애매 모호 하다고 에러 발생
SELECT ENAME, DEPT.DEPTNO, DNAME, LOC FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- FROM에서 부여하는 것은 새로운 이름을 부여하는 것으로 기존 이름은 이제 사용할 수 없음
SELECT ENAME, e.DEPTNO, DNAME, LOC FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO;

-- HASH JOIN
SELECT /*+ ORDERED USE_HASH(d) */
	ENAME, e.DEPTNO, DNAME, LOC FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO;

-- NON EQUI JOIN
-- EMP table의 SAL은 급여, SALGRADE table의 LOSAL은 최저 급여, HISAL은 최대 급여, GRADE는 등급
-- EMP table에서 ENAME과 SAL 조회하고 SAL에 해당하는 GRADE를 조회하고자 하는 경우
SELECT ENAME, SAL, GRADE FROM EMP, SALGRADE
WHERE SAL BETWEEN LOSAL AND HISAL;

-- EMP 테이블에서 ENAME과 관리자 ENAME 조회
-- 앞의 EMP는 현재 종업원이 되고 뒤의 EMP는 관리자
-- 종업원의 관리자 사원 번호와 일치하는 관리자의 사원 번호를 찾아서 이름을 조회
SELECT employee.ENAME, manager.ENAME FROM EMP employee, EMP manager
WHERE employee.MGR = manager.EMPNO;

-- ANSI CROSS JOIN
SELECT * FROM EMP CROSS JOIN DEPT;

-- EMP 테이블과 DEPT 테이블의 INNER JOIN
SELECT * FROM EMP INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

-- 2개의 컬럼 이름이 같은 경우 USING 사용 가능
SELECT * FROM EMP INNER JOIN DEPT
USING(DEPTNO);

-- 2개의 컬럼 이름이 같은 경우 NATURAL JOIN 사용 가능
-- 동일한 컬럼을 1번 만 출력
SELECT * FROM EMP NATURAL JOIN DEPT;

-- OUTER JOIN
SELECT DISTINCT DEPTNO FROM EMP; -- 10,20,30
SELECT DISTINCT DEPTNO FROM DEPT; -- 10,20,30,40

-- EMP의 존재하는 모든 DEPTNO가 JOIN에 참여
SELECT * FROM EMP LEFT OUTER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

-- DEPT의 존재하는 모든 DEPTNO가 JOIN에 참여
-- DEPT에는 존재하지만 EMP에는 존재하지 않는 40이 JOIN에 참여
-- 이 경우 40은 자신의 데이터 말고는 NULL 
SELECT * FROM EMP RIGHT OUTER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

-- MySQL은 FULL OUTER JOIN 지원 X -> UNION 사용해서 해결
SELECT * FROM EMP RIGHT OUTER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO

UNION 

SELECT * FROM EMP LEFT OUTER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;
