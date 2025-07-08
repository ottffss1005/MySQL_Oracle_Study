/* 주의 사항
 * 단일 line 주석 작성시 -- 와 내용 사이에 blank 필수
 * 
 * step01 - 기본 검색
 * select 절
 * from 절
 * : select면 검색 컬럼, from 절 table명
 * 
 * step02 - 정렬 검색
 * select절 from절 order by절
 * orderby 절엔 어떤 칼럼을 내림?오름?정렬값 설정
 * 
 * 
 * step03 - 조건 검색
 *  select 절
 *  from 절
 *  where 절
 * 
 * step04 - 조건 & 정렬 검색
 *  select절
 *  from 절
 *  where 절
 *  order by 절
 * 
 * ***mysql만의 특징
 * - 데이터값의 대소문자 구분을 기본으로 하지 않음
 * - 데이터는 대소문자 구분은 필수로 해야 함
 * - mysql db선택시
 * 		해결책1ㅣ table 생성후 alter로 대소문자 구분하게 설정
 * 		해결책2| select 시 binary() 사용해서 처리
 */
use fisa;

show tables;

select * from emp;
select * from dept;
desc emp;
desc dept;

-- 1. 해당 계정이 사용 가능한 모든 table 검색
show tables;

-- 2. emp table의 모든 내용(모든 사원(row), 속성(컬럼)) 검색


select * from emp;

-- 3. emp의 구조 검색
desc emp;

-- 4. emp의 사번(empno)만 검색
-- 정렬 미 적용된 문장
select empno from emp;

-- 오름차순 정렬
-- 오름차순: ASC, 내림차순: DSC

-- 5. emp의 사번(empno), 이름(ename)만 검색
-- 하나 이상의 칼럼 검색시 , 표기가 구분
select empno, ename from emp;


-- 6. emp의 사번(empno), 이름(ename)만 검색(별칭 적용)
-- "as 별칭" 문법 적용
select empno as 사번, ename as 사원명 from emp;
select empno as 사번, ename as "사원 명" from emp; -- 여백 있으면 큰 따옴표로 표기

-- 7. 부서 번호(deptno) 검색
select deptno from emp;

select deptno from dept;

-- 8. 중복 제거된 부서 번호 검색 / distinct
select distinct deptno FROM  emp;

-- 9. 8 + 오름차순 정렬(order by)해서 검색
-- 오름 차순 : asc  / 내림차순 : desc
select distinct deptno from emp order by deptno asc;
select distinct deptno from emp order by deptno desc;


-- 10. ? 사번(empno)과 이름(ename) 검색 단 사번은 내림차순(order by desc) 정렬

select empno,ename from emp order by empno desc;

-- 11. ? dept table의 deptno 값만 검색 단 오름차순(asc)으로 검색
select deptno from dept order by deptno asc;

-- 12. ? 입사일(hiredate) 검색, 
-- 입사일이 오래된 직원부터 검색되게 해 주세요
-- 고려사항 : date 타입도 정렬(order by) 가능 여부 확인
-- 탐색도 미리 해줘야 됨
select hiredate from emp;
select hiredate from emp order by hiredate asc;


-- 13. ?모든 사원의 이름과 월 급여(sal)와 연봉 검색
-- 탐색용 sql 문장 먼저 선행하기
select ename, sal FROM  emp;
select ename as 사원명, sal as 월급여, sal*12 as 연봉 from emp;


-- 14. ?모든 사원의 이름과 월급여(sal)와 연봉(sal*12) 검색
-- 단 comm 도 고려(+comm) = 연봉(sal*12) + comm

select ename, sal, sal*12 from emp;
select ename, sal, sal*12, comm from emp;
select ename, sal, sal*12 comm, (sal*12)+comm from emp;

-- comm이 null인 사원들은 연산 불가, 대체해서 연산, 대체값으로 치환
select empno, comm, ifnull(null,0) from emp;
select empno, comm, ifnull(comm,0) from emp;

-- 모든 사원의 이름과 월급여(sal)와 연봉(sal*12)+comm 검색
select ename, sal, sal*12, comm, (sal*12)+ifnull(comm,0) from emp;


-- *** 조건식 ***
-- 15. comm이 null인 사원들의 이름과 comm만 검색
-- where 절 : 조건식 의미
select ename, comm from emp;

select ename, comm from emp where comm is null;

-- 16. comm이 null이 아닌 사원들의 이름과 comm만 검색
-- where 절 : 조건식 의미
-- 아니다 라는 부정 연산자 : not 
select ename, comm from emp where comm is not null;

-- ?모든 직원명, comm으로 내림 차순 정렬
select ename, comm from emp order by ename, comm desc;

-- null값 보유컬럼 오름차순 정렬인 경우 null 부터 검색 


-- 17. ? 사원명이 스미스인 사원의 이름과 사번만 검색
-- = : db에선 동등비교 연산자
-- 참고 : 자바에선  == 동등비교 연산자 / = 대입연산자
select ename from emp;
select empno, ename from emp;
select empno, ename from emp where ename='SMITH';


-- 18. 부서번호가 10번 부서의 직원들 이름, 사번, 부서번호 검색
-- 단, 사번은 내림차순 검색
select ename, empno, deptno from emp;
select ename, empno, deptno from emp where deptno=10 order by empno desc;
-- 실행 순서는 from -> where -> select -> order by

-- 19. ? 기본 syntax를 기반으로 
-- emp  table 사용하면서 문제 만들기
select * from emp;
-- 1) emp 테이블에서 job이 manager인 사원 이름을 출력하고 그 사람들의 연봉을 내림차순 하기
select sal as 'A' from emp where sal >= 3000;
select sal as 'B' from emp where 2000<= sal && sal < 3000;
select sal as 'C' from emp where 1000<= sal && sal < 2000;
select sal as 'D' from emp where 1000 > sal;

-- ?부서 번호(deptno)는 오름 차순(asc) 
-- 단 해당부서(deptno)에 속한 직원번호(empno)도 오름차순(asc) 정렬


-- 결과가 맞는 문장인지의 여부 확인을 위한 추가 문장 개발해 보기 


-- 20. 급여(sal)가 900(>=)이상인 사원들 이름(ename), 사번(empno), 급여(sal) 검색 
select sal from emp;
select ename, empno, sal from emp where sal >= 900;
-- 이름으로 오름차순
-- 20번 + sal 오름차순 정렬 + 단, 이름은 내림차순
select ename, empno, sal from emp where sal >= 900 order by sal asc, ename desc;
select ename, empno, sal from emp where sal >= 900 order by ename asc;

-- 21. deptno 10, job 은 manager(대문자로) 이름, 사번, deptno, job 검색
select job from emp;
select job from emp where job='manager';

select job from emp where job=binary('manager');

select job from emp where job=binary('MANAGER');
-- upper: 대문자 의미하는 용어 / lower: 소문자

-- ename은 대소문자 구분 설정을 alter 명령어로 사전 셋팅
-- 대소문자 구분

-- 대문자 : upper / 소문자 : lower   / uppercase (대문자의미)

-- smith 소문자를 대문자로 변경해서 비교
select ename from emp where ename='smith';

-- 22.? deptno가 10 아닌 직원들 사번, 부서번호만 검색
-- 부정연산자 not / != / <>

select empno, deptno from emp where deptno !=10;
select empno, deptno from emp where deptno <> 10;
select empno, deptno from emp where not deptno =10;

-- 23. sal이 2000이하(sal <= 2000) 이거나(or) 3000이상(sal >= 3000)인 사원명, 급여 검색
select sal
from emp
where sal <= 2000 or sal >= 3000;

-- 24.  comm이 300 or 500 or 1400인
select comm from emp;
select sal from emp where comm in (300, 500, 1400);

-- in 연산식 사용해서 좀더 개선된 코드
-- 25. ?  comm이 300 or 500 or 1400이 아닌 사원명 검색
-- null값 미포함!!!


-- 26. 81/09/28 날 입사한 사원 이름.사번 검색
-- date 타입 비교 학습
-- date 타입은 '' 표현식 가능 
-- yy/mm/dd 포멧은 차후에 변경 예정(함수)
select hiredate from emp;
select ename, deptno from emp where hiredate = '1981/09/28';
select ename, deptno from emp where hiredate = '1981-09-28';
select ename, deptno from emp where hiredate = '81-09-28';

-- 27. 날짜 타입의 범위를 기준으로 검색
-- 범위비교시 연산자 : between~and 1980-12-17~1981-09-28
select hiredate from emp where hiredate between '1980-12-17' and '1981-09028';

-- 28. 검색시 포함된 모든 데이터 검색하는 기술
-- like 연산자 사용
-- % : 철자 개수 무관하게 검색 / _ : 철자 개수 하나를 의미 (암기 사항)
-- 참고: 실행속도는 낮음/ 
-- 빠른 검색이 중요할 경우 검색 기능은 검색 엔진이 내장된 sw 사용을 권장

-- 29. 두번째 음절의 단어가 M(_M)인 모든 사원명 검색 
select ename from emp;
select ename from emp where ename like  '_M%'; -- %빼면 오류임

-- 두 개의 글자, 단 2번째는 M이어야 함
select ename from emp where ename like '_M';

-- 30. 단어가 M을 포함한 모든 사원명 검색 
select ename from emp where ename like '%M%';
