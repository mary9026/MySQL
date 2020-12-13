-- 서브쿼리 subquery
-- 메인쿼리안에 또 다른 쿼리문으로 구성
-- 스칼라 서브쿼리 : 결과값으로 하나의 값이 조회
-- 인라인 뷰 : 결과값으로 여러개의 값이 조회

-- where, from, select 등에 서브쿼리 사용가능

-- 26) 달콤비스킷을 생산한 제조업체가 만든 제품의 이름과 단가를 검색
-- a) 달콤비스킷을 생산한 제조업체를 찾자
select prdmaker from sales_products where prdname = '달콤비스킷';
-- b) 한빛제과가 만든 제품의 이름과 단가를 검색
select prdname, price from sales_products where prdmaker = '한빛제과';
-- c) 두개의 질의문을 하나로 합침
select prdname, price from sales_products where prdmaker = '한빛제과'
= (select prdmaker from sales_products where prdname = '달콤비스킷');

-- 27) 적립금이 가장 많은 고객의 이름과 적립금 조회
-- a) 가장 많은 적립금은 ?
select max(bonus) from sales_customers;
-- b) 적립금이 5000원인 고객의 이름과 적립금 ?
select cusname, bonus from sales_customers where bonus = 5000;
-- c) 두개의 질의문을 하나로 합침
select cusname, bonus from sales_customers where bonus =
(select max(bonus) from sales_customers);

-- 28) banana(2번) 고객이 주문한 제품의 제품명과 제조업체를 조회
-- a) banana 고객이 주문한 제품
select prodno from sales_orders where cusid = 'banana';
-- b) 주문한 제품의 제품명과 제조업체를 조회
select prdname, prdmaker from sales_products where prodno in ('p06', 'p01', 'p04');
-- c) 두 개의 질의문을 하나로 합침
select prdname, prdmaker from sales_products where prodno in (select prodno from sales_orders where cusid = 'banana');

-- 29) banana 고객이 주문하지 않은 제품의 제품명과 제조업체를 조회
-- a) banana 고객이 주문한 제품
select prodno from sales_orders where cusid = 'banana';
-- b) 주문하지 않은 제품의 제품명과 제조업체를 조회
select prdname, prdmaker from sales_products where prodno not in ('p06', 'p01', 'p04');
-- c) 두개의 질의문을 하나로 합침
select prdname, prdmaker from sales_products where prodno not in
                                                   (select prodno from sales_orders where cusid = 'banana');

-- 30) 대한식품이 제조한 모든 제품의 단가보다 비싼 제품의 제품명, 단가, 제조업체 조회
-- a) 대한 식품이 제조한 모든 제품의 단가
select prdname, price from sales_products where prdmaker = '대한식품';
-- b) 대한식품 제품의 단가보다 비싼 제품의 제품명, 단가, 제조업체 조회 (하기 문장은 어차피 처리 안됨)
select prdname, price, prdmaker from sales_products where price > (4500, 1200) ;
-- c) 두개의 질문을 하나로 합침
select prdname, price, prdmaker from sales_products where price >
all (select price from sales_products where prdmaker = '대한식품');

-- 31) 2019년 3월 15일에 제품을 주문한 고객의 이름 조회
-- a) 2019년 3월 15일에 제품 주문
select cusid from sales_orders where orddate = '2019-03-15';
-- b) apple 고객 이름
select cusname from sales_customers where cusid = 'apple';
-- c) 두개의 질의문을 하나로 합침
select cusname from sales_customers where cusid = (select cusid from sales_orders where orddate = '2019-03-15');
-- d) inner join 으로 풀어보기 ## 조인으로 문제 처리 시 시스템 부하 올 수 있음, 특별한 경우 아니면 서브쿼리로 풀 것 ##
select cusid, cusname from sales_customers cs join sales_orders so using(cusid) where orddate = '2019-03-15';

-- 32)  2019년 3월 15일에 제품을 주문하지 않은 고객의 이름 조회
-- a) 2019년 3월 15일에 제품 주문
select cusid from sales_orders where orddate = '2019-03-15';
-- b) apple 을 제외한 고객 이름 리스트
select cusname from sales_customers where cusid not in ('apple');
select cusname from sales_customers where cusid <> ('apple');
-- c) 두개의 질의문을 하나로 합침
select cusname from sales_customers where cusid not in (select cusid from sales_orders where orddate = '2019-03-15');
select cusname from sales_customers where cusid <> (select cusid from sales_orders where orddate = '2019-03-15');

-- 연습문제 A4 - HR 데이터베이스

-- LAST_NAME 이 Zlotkey 와 동일한 부서에 근무하는 모든 사원들의 사번 및 고용날짜를 조회한다. 단, Zlotkey 는 제외한다.
-- a)zlotkey 의 부서번호
select department_id, last_name from employees where last_name = 'Zlotkey';
-- b) 부서번호가 80번인 사람들 리스트
select employee_id, hire_date, department_id from employees where department_id = 80;
-- c) 두개의 질의문을 하나로 합침
select employee_id, hire_date, department_id from employees where department_id =
        (select department_id from employees where last_name = 'Zlotkey') and last_name <> 'Zlotkey';

-- 회사 전체 평균 연봉보다 더 받는 사원들의 사번 및 LAST_NAME 을 조회한다.
-- a) 회사 전체 평균 연봉
select round(avg(salary)) 평균연봉 from employees;
-- b) 평균연봉인 6462 보다 연봉이 높은 사원들의 사번 및 last_name
select employee_id, last_name from employees where salary > 6462;
-- c) 두개의 합
select employee_id, last_name from employees where salary > (select round(avg(salary)) from employees);

-- LAST_NAME 에 u가 포함되는 사원들과 동일 부서에 근무하는 사원들의 사번 및 LAST_NAME 을 조회한다.
-- a) last name에 u가 포함되는 사원
select distinct department_id from employees where last_name like '%u%';
-- b) u와 동일부서 근무자들의 사번과 last name
select employee_id, last_name from employees where department_id in (60, 100, 30, 50, 80);
-- c) 두개의 합
select employee_id, last_name from employees where department_id in
 (select distinct department_id from employees where last_name like '%u%');

-- King 을 매니저로 두고 있는 모든 사원들의 LAST_NAME 및 연봉을 조회한다.
-- 즉, King의 부하직원의 성과 연봉 조회하라
-- a) king의 사번
select employee_id from employees where last_name = 'King';
-- b) king 사번이 매니저 아이디로 들어간 사람들의 성과 연봉
select last_name, salary, manager_id from employees where manager_id in (100, 156);
-- c) 두개의 합
select last_name, salary, manager_id from employees where manager_id in
(select employee_id from employees where last_name = 'King');

-- EXECUTIVE 부서에 근무하는 모든 사원들의 부서 번호, LAST_NAME, JOB_ID를  조회한다.
-- a) executive의 부서번호
select department_id from departments where department_name = 'EXECUTIVE';
-- b) 부서번호 90번이 소속된 사원들의 부서번호, last name, jobid
select department_id, last_name, job_id from employees where department_id = 90;
-- c) 두개의 합
select department_id, last_name, job_id from employees where department_id =
       (select department_id from departments where department_name = 'EXECUTIVE');

-- 회사 전체 평균 연봉보다 더 버는 사원들 중 LAST_NAME 에 u 가 있는 사원들이 근무하는 부서에서
-- 근무하는 사원들의 사번, LAST_NAME 및 연봉을 조회한다.
-- a) 회사 전체 평균 연봉
select avg(salary) from employees;
-- b) 평균연봉보다 더 버는 사원 중 last name 에 u가 있는 사원들의 근무부서
select department_id from employees where salary > 6462 and last_name like '%u%';
-- c) 50, 60, 80, 100 부서번호에 근무하는 사원
select employee_id, last_name, salary from employees where department_id in (50, 60, 80, 100);
-- d) 세 개의 질의문을 하나로 합침
select employee_id, last_name, salary from employees where department_id in
(select distinct department_id from employees where last_name like '%u%' and salary >
(select avg(salary) from employees));

-- 직업ID 가 SA_MAN 인 사원들이 받을 수 있는 최대 연봉보다 높게 받는
-- 사원들의 LAST_NAME, JOB_ID 및 연봉을 조회한다.
-- a) sa_man 인 사람들의 최대 연봉
select max_salary from jobs where job_id = 'SA_MAN';
-- b) 20080 보다 높은 연봉을 받는 사원들의 last_name, job_id, 연봉을 조회한다.
select last_name, job_id, salary from employees where salary > 20080;
-- c) 두개의 질의문을 하나로 합침
select last_name, job_id, salary from employees where salary >
    (select max_salary from jobs where job_id = 'SA_MAN');

-- 직업 ID 가 SA_MAN 인 사원들의 최대 연봉보다 높게 받는 사원들의 LAST_NAME, JOB_ID 및 연봉을 조회한다.
-- a) sa_man 인 사원들의 최대 연봉
select max(salary) from employees where job_id = 'SA_MAN';
-- b) sa_man인 사원들의 최대 연봉보다 많이 받는 사원들
select last_name, job_id, salary from employees where salary > 14000;
-- c) 두개의 질의문을 하나로 합침
select last_name, job_id, salary from employees where salary >
  (select max(salary) from employees where job_id = 'SA_MAN');

-- 직업ID가 SA_MAN인 모든 사원들의 연봉보다 높게 받는 사원들의 LAST_NAME, JOB_ID 및 연봉을 조회한다.
-- a) sa_man인 모든 사원들의 연봉
select salary from employees where job_id = 'SA_MAN';
-- b) sa_man인 모든 사원들의 연봉보다 많이 받는 사원 (문법적으로 안맞음)
select last_name, job_id, salary from employees where salary > (10500, ..., 14000);
-- c) 두개의 질의문을 하나로 합침
select last_name, job_id, salary from employees where salary >
   all (select salary from employees where job_id = 'SA_MAN');

-- 도시 이름이 T 로 시작하는 지역에 근무하는 사원들의 사번, LAST_NAME 및 부서 번호를 조회한다.
-- a) 도시 이름이 T로 시작하는 지역
select location_id from locations where city like 'T%';
-- b) T로 시작하는 지역에 근무하는 사원
select department_id from departments where location_id in (1200, 1800);
-- c) T로 시작하는 지역에 근무하는 사원
select employee_id, last_name, department_id from employees where department_id = 20;
-- d) 세개의 질의문을 하나로 합침
select employee_id, last_name, department_id from employees where department_id =
(select department_id from departments where location_id in
(select location_id from locations where city like 'T%'));

-- DML : update
-- 데이터베이스의 특정 레코드의 값을 변경할때 사용
-- update 테이블명
-- set 변경할컬럼명 = 변경값,...
-- where 조건식

-- 33) 제품테이블에서 제품번호가 p03인 제품명을 '통큰파이'로 변경하세요
update sales_products set prdname = '통큰파이' where prodno = 'p03';

-- 34) 제품테이블에 있는 모든 제품의 단가를 10% 인상하고 그 결과를 조회하세요
update sales_products set price = price * 1.1;
select prdname, price from sales_products;

-- 35) 정소화 고객이 주문한 제품의 수량을 5개로 수정하세요
update sales_customers c join sales_orders o using (cusid)
set qty = 5 where cusid = '정소화';

select * from sales_orders;
-- 서브쿼리 사용해서 상기 문제 풀이
-- a) 정소화 고객의 cusid
select cusid from sales_customers where cusname = '정소화';
-- b) 정소화 고객이 주문한 제품의 수량 변경
update sales_orders set qty = 5 where cusid = 'apple';
-- c) 세개의 질의문을 하나로 합침
update sales_orders set qty = 5 where cusid =
(select cusid from sales_customers where cusname = '정소화');

-- DML : delete
-- 지정한 레코드(행)을 삭제함
-- delete from 테이블명 where 조건식;

-- 36) 주문일자가 2019-05-22인 주문내역을 삭제하세요
delete from sales_orders where orddate = '2019-05-22';

-- 37) 정소화 고객이 주문한 내역을 삭제하세요
delete from sales_orders where cusid = 'apple';

delete from sales_orders where cusid = (select cusid from sales_customers where cusname = '정소화');

-- 38) 주문 내역을 모두 삭제하세요 (수동모드로 반드시 바꿔서 진행 !!)
delete from sales_orders;
select * from sales_orders;
rollback;
commit;

