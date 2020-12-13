-- 조인 검색
-- 다중 테이블을 대상으로 하는 연산
-- 여러개의 테이블을 결합해서 원하는 데이터를 검색하는 것

-- 조인방법
-- cross join : cartesian product
-- inner join : 조건에 맞는 값만 가져옴
-- outer join : 조건에 맞지 않는 값도 가져옴
-- self join : 자기자신을 대상으로 조인 수행
--             단, 조인 시 컬럼명이 동일하기 때문에 컬럼 구분을 위해 반드시 별칭을 사용해야 함
-- 사용도는 inner join 비중이 가장 높으나, outer, self join 활용이 정확도가 높다

-- inner join
-- 각테이블에 존재하는 동일한 컬럼을 대상으로
-- 결합해서 결과 조회

-- select 컬럼들... from 조인할테이블들
-- where 조인결합조건
-- 예) select A.a, A.b, B.a, B.b from A, B
-- where A.a = B.b (비추 / where절이 섞여있어 혼동가능성 있음)

-- select 컬럼들... from 조인할테이블들
-- on 조인결합컬럼들 (표준)
-- 예) select A.a, A.b, B.a, B.b from A inner join B
-- on A.a = B.b (표준)

-- select 컬럼들... from 조인할테이블들
-- using 조인결합컬럼들 (표준)
-- 예) select A.a, A.b, B.a, B.b from A inner join B
-- using (a) (표준)

-- 23) 주문테이블에서 banana 고객이 주문한 상품의 이름을 조회하세요.
select ordno, prodno, prdname from sales_orders so  inner join sales_products sp using (prodno) where cusid = 'banana';

-- a. 두 테이블 결합하기 cartesian product
select * from sales_orders, sales_products where sales_orders.prodno = sales_products.prodno;
-- 테이블명이 길어서 별칭을 사용해서 간단히 작성
select * from sales_orders so, sales_products sp where so.prodno = sp.prodno;

select * from sales_orders so  inner join sales_products sp on so.prodno = sp.prodno;

select * from sales_orders so  inner join sales_products sp using (prodno);

-- 24) 주문 테이블에서 나이가 30세 이상인 고객이 주문한 주문제품과 주문일자를 조회하세요.
select prodno, orddate from sales_orders so INNER JOIN sales_customers sc on so.cusid = sc.cusid where age >= 30;

-- 25) 주문 테이블에서 고명석 고객이 주문한 제품의 이름을 조회하세요.
select prdname from sales_orders so inner join sales_customers sc on so.cusid = sc.cusid
                                    inner join sales_products sp on so.prodno = sp.prodno where cusname = '고명석';

select cusname, prdname from
         sales_orders so inner join sales_customers sc
                         inner join sales_products sp
          on so.cusid = sc.cusid
          and so.prodno = sp.prodno
where cusname = '고명석';

-- 연습문제A2 (Books 3종 세트) 15 ~ 21
--  15) 주문한 고객번호,고객이름과 주문금액,주소를 조회하세요
select bo.custid,name, saleprice, address from book_orders bo inner join book_members bm on bo.custid = bm.custid
                                                        inner join books bk on bo.bookid = bk.bookid;
-- 선생님 풀이
select custid, name, saleprice, address from book_orders o inner join book_members m using(custid);

-- 15b) 박지성 고객의 주문금액,주소,주문일자를 조회하세요
select price, address, orderdate from book_orders bo inner join book_members bm
                                     inner join books bk
            on bo.custid = bm.custid
            and bo.bookid = bk.bookid
where name = '박지성';
-- 선생님 풀이
select custid, name, saleprice, address from book_orders o inner join book_members m using(custid) where name = '박지성';

-- 16) 주문한 도서이름,주문금액,주문일자를 조회하세요
select bookname, saleprice, orderdate from books bk inner join book_orders bo on bk.bookid = bo.bookid;
-- 선생님 풀이
select bookname, saleprice, orderdate from book_orders bo inner join books bk using(bookid);

-- 17) 박지성 고객의 주문금액,주소,주문일자를 조회하세요
select saleprice, address, orderdate from book_members bm inner join book_orders bo
    on bm.custid = bo.custid where name = '박지성';

-- 18) 주문한 도서이름,주문금액,주문일자를 조회하세요
select bookname, saleprice, orderdate from book_orders bo inner join books bk on bo.bookid = bk.bookid;

-- 19) 가격이 20000인 도서를 주문한 고객 이름 조회하세요
select name from book_members bm inner join book_orders bo on bm.custid = bo.custid
                            inner join books bk on bo.bookid = bk.bookid where price = 20000;
-- 선생님 풀이
select name, saleprice from book_orders bo inner join book_members bm using (custid) where saleprice = 20000;

-- 20) 주문한 고객이름, 도서이름, 주문일자 출력하세요
select name, bookname, orderdate from book_orders bo inner join book_members bm on bo.custid = bm.custid
                           inner join books b on bo.bookid = b.bookid;
-- 선생님 풀이
select name, bookname, orderdate from book_orders bo inner join books bk using (bookid) inner join book_members bm using (custid);

-- 21) 도서를 구매하지 않은 고객을 포함하여 고객이름과 주문한 도서의 판매금액을 조회하세요
-- 주문 + 고객 inner join : 교집합 ==> 주문한 상품과 주문한 고객
-- 주문 + 고객 outer join : 차집합 ==> 주문이 안된 상품과 주문하지 않은 고객
-- 도서를 구매한 고객
select orderid, name from book_orders bo inner join book_members bm using (custid);

-- 도서를 구매한 고객 + 도서를 구해하지 않은 고객
select name from book_orders bo right outer join book_members bm using(custid);

-- 도서를 구해하지 않은 고객
select name, orderid from book_orders bo right outer join book_members bm using(custid) where orderid is null;
-- 주문된 도서 + 주문되지 않은 도서
select bookid, orderid from book_orders bo right outer join books bk using(bookid);
-- 주문되지 않은 도서
select bookid, orderid from book_orders bo right outer join books bk using(bookid) where orderid is null;

-- 연습문제 B3
-- 모든 사원들의 LAST_NAME, 부서 이름 및
-- 부서 번호을 조회하세요
select last_name, department_name, emp.department_id from employees emp
    inner join departments dep on emp.department_id = dep.department_id;
-- 선생님 풀이
select last_name, department_name, department_id from employees e inner join departments d using(department_id);

-- 부서번호 30의 모든 직업들과 부서명으로 조회 하세요. 90 부서 또한 포함한다.
select emp.department_id, job_title,department_name from employees emp INNER JOIN departments d on emp.department_id = d.department_id
 inner join jobs j on emp.job_id = j.job_id
                    WHERE d.department_id = '30' or d.department_id = '90';
-- 선생님 풀이
select job_id, department_name from employees e join departments d using(department_id)
where department_id in (30, 90); -- or 조건문의 조금 더 간결한 문장 in 연산자 사용가능

-- 부서번호 30 이하의 모든 직업들과
-- 부서명으로 조회하세요
select job_id, department_name from employees e join departments d using(department_id)
where department_id <= 30;


-- 커미션을 버는 모든 사람들 중 시애틀에 거주하는 사람들의 LAST_NAME,
-- 부서명, 지역 ID 및 도시 명을 조회하세요
select last_name, department_name, location_id, city  from employees e
    join departments d using(department_id)
    join locations l using (location_id) where commission_pct is not null and city = 'Seattle'; -- 맞는값 없어서 안나옴


-- 커미션을 버는 사람들 중 시애틀에 거주하는
-- 사람들의 LAST_NAME, 부서명, 지역 ID 및
-- 도시 명을 조회하세요 (옥스포드)

-- 자신의 매니저의 이름과 고용일을 조회하세요
select emp.last_name 사원명, mgr.last_name 매니저명, mgr.hire_date  매니저입사일
from employees mgr inner join employees emp on emp.manager_id = mgr.employee_id;


-- 자신의 매니저보다 먼저 고용된 사원들의
-- LAST_NAME 및 고용일을 조회하세요.
select emp.last_name 사원명, emp.hire_date 사원입사일, mgr.last_name 매니저명, mgr.hire_date  매니저입사일
from employees mgr inner join employees emp on emp.manager_id = mgr.employee_id where emp.hire_date < mgr.hire_date;


-- 부서별 사원수를 조회하세요
-- 단, 부서명도 함께 출력합니다
select department_id, count(department_id) 사원수 from employees group by department_id having department_id is not NULL;

select department_name, count(employee_id) 사원수 from employees e
       join departments d using (department_id) group by department_name;

-- 부서별 사원수를 조회하세요
-- 단, 부서명도 함께 출력하고
-- 단, 사원수가 0이어도 부서명을 출력합니다

-- 부서가 없는 사원 조회 + 부서가 있는 사원 조회
select department_name, employee_id from employees e
      left join departments d using (department_id);
-- 사원이 없는 부서 조회 + 사원이 있는 부서 조회
select department_name, count(employee_id) 사원수 from employees e
       right join departments d using (department_id) GROUP BY department_name order by 사원수 desc;

