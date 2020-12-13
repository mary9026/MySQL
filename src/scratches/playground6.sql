-- 뷰 view
-- 다른 테이블을 기반으로 만들어진 가상(논리적)의 테이블을 의미함
-- 뷰는 실제로 데이터를 저장하고 있지는 않음
-- 하지만, 사용자가 이 사실을 인지하지 못하고 실제의 테이블처럼 조작 가능

-- 뷰의 목적 : 특정필드에만 접근 허용 (보안)
--            데치터조작의 간소화 (조인/검색)

-- create view  뷰이름 as select문

-- 수정 방법 : create or replace view 뷰이름 as select문 / alter view 뷰이름 as select문 / 두가지 있음

-- 39) vip 고객의 아이디, 이름, 나이로 구성된 뷰 생성. 단, 이름은 우수고객으로 작성
select cusid, cusname, age from sales_customers where grade = 'VIP';

create view 우수고객 as select cusid, cusname, age from sales_customers where grade = 'VIP';

select * from 우수고객;

-- 40) 제조업체별 제품수로 구성된 뷰 생성
--     뷰이름은 업체별제품수로 지정
select prdmaker, count(prodno) 제품수 from sales_products group by prdmaker;

create view 업체별제품수 as select prdmaker, count(prodno) 제품수 from sales_products group by prdmaker;

select * from 업체별제품수;

create view 업체별제품수2 (업체, 제품수) as select prdmaker, count(prodno) 제품수 from sales_products group by prdmaker;

select * from 업체별제품수3;

-- 41) 우수고객 테이블에서 나이가 25세이상인 회원 조회
select * from 우수고객 where age >= 25;

-- 뷰를 이용한 데이터 삽입, 수정, 삭제
-- 뷰는 원본테이블의 분신이므로
-- 삽입, 수정, 삭제 작업은 원본테이블을 대상으로 진행
-- 단, 삽입, 수정, 삭제는 제한적으로 수행될 수 있음

-- 42) 제품번호, 재고량, 제조업체를 골라서
--     제품1이라는 뷰를 생성하고 제품번호는 p08, 재고량은 1000 제조업체는 신선식품이라는 정보를 추가함
create view 제품1 as select prodno, stock, prdmaker from sales_products;

insert into 제품1 values ('p08',1000,'신선식품');

select * from 제품1;

-- 테이블의 컬럼에 특정 제약이 설정되어 있는 경우
-- 뷰를 통한 데이터 삽입은 제한될 수 있음
create table sales_product2 (
    prodno int primary key,
    prdname varchar(10) not null, -- not null 입력 시 필수입력항목이 되므로 view 실행시 해당 항목을 넣지 않으면 안됨
    stock int,
    price int,
    prdmaker varchar(10)
);

-- sales_products2 테이블에서
-- 제품번호, 재고량, 제조업체를 골라서
-- 제품2라는 뷰를 생성하고
-- 제품번호는 9, 재고량은 5000,
-- 제조업체는 새로운식품이라는 정보를 추가함
create view 제품2 as select prodno, stock, prdmaker from sales_product2;

insert into 제품2 values (9, 5000, '새로운식품');
-- 제품이름이 누락되었기 때문에 입력 실패로 뜰 것임

select * from 제품2;

-- sales_products 테이블에서
-- 제품명, 재고량, 제조업체를 골라서
-- 제품3이라는 뷰를 생성
-- 제품명이 얼큰라면의 정보를 삭제하세요
create view 제품3 as select prdname, stock, prdmaker from sales_products;

select * from 제품3;

delete from 제품3 where prdname = '얼큰라면';
-- prdname 컬럼이 기본키 컬럼이 아니므로 지우면 안되는 데이터까지 지워질 수 있음

select * from 제품3;

-- 주문, 상품, 고객테이블을 조인하고
-- 판매데이터라는 뷰를 만드세요
-- 또한, banana 고객이 주문한 상품이름을 조회하세요
create view 판매데이터 as
    select * from sales_products p join sales_orders o using(prodno)
    join sales_customers c using (cusid);

select prdname from 판매데이터 where cusid = 'banana';


-- 사원, 부서, 위치 테이블을 조인하고
-- empdeptloc 이라는 뷰를 만드세요
-- 또한, King 이라는 사원이 근무하는
-- 사무실의 도시를 조회하세요
create view departments2 (department_id, department_name, mgr_id, location_id) as select * from departments;

create view empdeptloc as
    select *
    from employees e join departments2 d
    using (department_id)
    join locations using (location_id);

select * from empdeptloc;