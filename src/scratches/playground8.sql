-- Null 처리함수
-- null 처리 : coalesce (문자열, 널일때 대체값)
select NULL, coalesce(NULL, '널임'), coalesce('Hello', '널임');

-- null 처리 2 : ifnull (문자열, 널일때대체값)
select NULL, ifnull(NULL, '널임'), ifnull('Hello', '널임');

-- coalease vs ifnull
-- if문이나 case 문으로 null값 여부에 따라
-- 다른 값으로 대체하는 경우 ifnull이나 coalease를 사용하는 것이 좋음

select ifnull('abc', 'xyz');
select ifnull(null, 'xyz');

select coalesce(null, 'xyz'); -- ifnull과 기능유사, SQL표준
select coalesce(null, 'abc', 'xyz');
select coalesce(null, null, 'xyz');

-- null 처리 : nullif(문자열1, 문자열2)
-- 두 값이 일치하면 null 출력
-- 두 값이 다르면 문자열1 출력
-- oracle : NVL
select nullif(null, '널임'),
       nullif('hello', '널임'),
       nullif('hello', 'hello');

-- 사원테이블에서 수당을 받지않는 사원들의 수당은 0으로 설정하세요
select commission_pct, ifnull(commission_pct, 0) from employees;

-- 조건판단 : if(조건식, 참일때값, 거짓일때값)
select if(5>3, '크다', '작다');

-- 다중조건 : case when 조건식 then 처리값 else 처리값 end

-- 날짜/시간 함수
-- 현재 날짜/시간
-- now, current_timestamp, stsdate
select now(), current_timestamp(), sysdate();

-- 현재 날짜
-- curdate, current_date
select curdate(), current_date();

-- 현재 시간
-- curtime, current_time();
select curtime(), current_time();

-- 날짜계산
-- adddate(날짜, 날짜간격), subdate(날짜, 날짜간격)
-- date_add(날짜, 날짜간격), date_sub(날짜, 날짜간격)
-- 간결 식별문자열 : second, minute, hour, day, month, year
select date_add('2020-12-10', interval 15 day);
select date_add('2020-12-10', interval 1 year);
select date_sub('2020-12-10', interval 6 month);
select date_add('2020-12-10', interval 100 day);

-- 날짜/시간 추출 :  year, month, day, week, hour, minute, second
select year(now()) 년, month(now()) 월, day(now()) 일;

-- 날짜/시간 추출 : dayofmonth, dayofweek(1:일요일), dayofyear, dayname, monthname
select dayofyear(now())  총일수, dayofmonth(now()) 개월, dayofweek(now()) 숫자표기요일
       , dayname(now()) 요일이름, monthname(now()) 월이름;

select dayofmonth('2020-12-10'), dayname('2020-12-10'), monthname('2020-12-10');

-- dayofweek를 이용해서 요일을 한글로 출력해보세요
select concat(substring('일월화수목금토', dayofweek('2020-12-10'),1), '요일');

-- 날짜 계산 : datediff(날짜1, 날짜2)
-- 오늘기준 크리스마스가 몇일남았는지 계산
select datediff('2020-12-25', '2020-12-10');

-- 오늘기준 2021-03-21이 얼마나 남았는지 계산
select datediff('2021-03-11', '2020-12-10');

-- 날짜/시간 계산
-- timestampdiff(유형, 날짜1, 날짜2)
-- 오늘기준 크리스마스가 몇일, 몇시간, 몇분 남았는지 계산
select timestampdiff(DAY, '2020-12-10', '2020-12-25'),
       timestampdiff(HOUR, '2020-12-10', '2020-12-25'),
       timestampdiff(MINUTE, '2020-12-10', '2020-12-25');

-- 달의 마지막 일 출력 : last_day(날짜)
select last_day('2020-12-10');



-- 변환함수
-- 각 나라별로 날짜, 시간을 표시하는 방법이 제각각임
-- 이러한 제각각인 날짜/시간 데이터를 적절한 날짜형식 데이터로 인식하기 위해 변환함수 사용
-- 한국 : 년-월-일
-- 미국 : 월/일/년

-- 날짜변환함수 : str_to_date (문자열, 형식문자열)
-- 형식문자열 : %H/%h, %i, %s (시간관련)
--             %Y/%y, %m, %d, %w, %M (날짜관련)
select str_to_date('2020-12-10', '%Y-%m-%d'),
       str_to_date('12/10/2020', '%m/%d/%Y'),
       str_to_date('12/10/20', '%m/%d/%y');

-- 날짜 변환 함수 : date_format
-- 시스템의 locale 설정에 따라 변환가능
select date_format('2020-12-10', '%Y-%m-%d'),
       date_format('12/10/2020', '%m/%d/%Y'),
       date_format('12/10/20', '%m/%d/%y');

-- 사용중인 윈도우의 locale이 korea이기 때문에
-- 미국식 날짜 표기는 제대로 인식되지 않음
select date_format('2020-12-10', '%W %M'),
       date_format('2020-12-10', '%a %b %j'),
       date_format('2020-12-10 12:14:12', '%p %h:%i:%s');

-- 숫자문자변환 : cast(대상 as 자료형)
-- 자료형 : char, date/time, decimal, float
-- 묵시적(자동) 형변환, 명시적(수동) 형변환

select substr(123456789, 5, 1);
-- 숫자형 데이터가 자동으로 문자형으로 변환되어 추출

select 1234567890, cast(1234567890 as char);
-- 숫자형은 기본적으로 오른쪽 정렬, 문자형은 왼쪽으로 정렬

select 10/3, 10/'3';
-- 문자가 실수(float)로 자동형변환

select 10/cast(3 as unsigned ), 10/'3';

select cast(124035 as time), cast(201210 as time);
-- 시간, 날짜 변환가능

-- 분석함수 (윈도우함수) - OLAP
-- 윈도우 함수 : 행과 행간의 관계를 정의하기 위해 사용하는 함수
-- 복잡한 기능을 함수로 구현해서 사용하기 편리하게 만들어 둠
-- 경우에 따라 over 절을 사용해야 할 필요가 있음
-- 집계함수 : max, min, avg, sum, count
-- 순위함수 : rank, dense, row_number
-- 통계, 회귀분석 : stddev, variance, covar, corr
-- 순서함수 : lag, lead, first_value, last_value

-- 현재 행을 기준으로 이전/이후 값 출력 : 이후 lead, 이전 lag
-- mariadb는 10이상 지원하기 시작
-- 분석함수를 적용하기 위해서는 먼저 대상 컬럼이 정렬되어 있어야 함

-- 상품 테이블에서 현재 상품명을 기준으로 이전 상품명과 이후 상품명을 조회하세요
select prdname 현재상품명,
       lag(prdname) over(order by prdname) 이전상품명,
       lead(prdname) over(order by prdname) 이후상품명
from sales_products;

-- 주문테이블에서 주문일자가 빠른순으로 정렬한 후
-- 자신보다 주문일자가 빠른 고객의 이름과 주문일자를 조회하세요
select cusid, orddate, lag(cusid) over (order by orddate)  빠른주문자,
       lag(orddate) over (order by orddate) 빠른주문일자
from sales_orders;

-- 정렬된 데이터를 기준으로 맨처음/맨마지막 값 출력 :
-- first_value(컬럼명), last_value(컬럼명)

-- 상품을 주문한 고객중에서 가장 많은/적은 수량으로 주문한 고객을 조회하세요
select cusid, qty from sales_orders;

select cusid, qty from sales_orders order by qty desc;

select first_value(qty) over(order by qty) 가장적은주문수량,
       last_value(qty) over(order by qty) 가장많은주문수량 from sales_orders;

select first_value(qty) over(order by qty) 가장적은주문수량,
       last_value(qty) over(order by qty) 가장많은주문수량 from sales_orders limit 8,1;

select distinct first_value(qty) over(order by qty) 가장적은주문수량,
       first_value(qty) over(order by qty desc) 가장많은주문수량 from sales_orders;