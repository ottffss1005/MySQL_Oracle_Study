# 📚 MySQL_Oracle Study

<br>

## 👥 팀원

- 박여명  
- 고태우  
- 서민지  
- 최소영

-----

## Oracle SQL 문제 정리(0708)

```sql
SELECT * FROM emp;
SELECT * FROM dept;

-- #1. hiredate가 1981년 5월 이후인 직원들의 COMM을 출력하기 단, NULL이면 0값으로 대체
SELECT comm, NVL(comm,0) AS comm_null FROM emp WHERE hiredate >= TO_DATE('1981-05-01', 'YYYY-MM-DD');

-- #2. 커미션이 null 이 아닌 직원을 가진 부서에 속한 사원 중 마지막 글자가 'N'인 데이터를(부서코드와 사원명) alias 써서 "부서 코드", "사원명"이라는 컬럼명으로 출력
SELECT deptno AS "부서코드", ename AS "사원명" FROM emp WHERE comm IS not NULL AND ename LIKE '%N';

-- #3. SAL + COMM 총합 평균보다 높은 사람, 직업 출력 null->0으로 대체
SELECT * FROM emp;
SELECT ename, job FROM emp WHERE (sal+nvl(comm,0))> (SELECT avg(sal+nvl(comm,0)) FROM emp);

-- #4.  각 부서 별 월급 평균, 부서 번호 출력 (부서 번호 오름차순)
SELECT deptno, avg(sal) FROM emp GROUP BY deptno ORDER BY deptno ASC;


