-- 연습문제 B5 - HR 데이터베이스

-- 사원 테이블에서 사원 이름을 소문자로 출력하세요
select lower(first_name) from employees;

-- 사원 테이블에서 사원 이름의 첫글자만 대문자로 출력하세요.
select first_name, left(first_name, 1), lower(substr(first_name, 2)) from employees;

-- 선생님 풀이
select 'STEVE', -- 원본
        left('STEVE', 1), -- 첫글자 (대문자)
        lower(substr('STEVE', 2)); -- 나머지글자 (소문자)

select 'steve', -- 원본
        upper(left('steve', 1)), --  첫글자 (대문자)
        substr('steve', 2); -- 나머지글자(소문자)

-- 사원 테이블에서 사원 이름의 길이를 출력하세요.
select first_name, char_length(first_name) from employees;

-- 사원 테이블에서 사원이름과 이름에 A가 몇번째 있는지 출력하세요.
select first_name, instr(first_name, 'a') A의위치 from employees;

-- 사원 테이블에서 사원이름의 세번째 자리가 R인 사원의 정보를 출력하세요.
select first_name, substr(first_name, 3, 1) from employees;

select * from employees where substr(first_name, 3, 1) = 'R';
select * from employees where instr(first_name, 'R') = 3;

-- 사원 테이블에서 이름의 끝자리가 N으로 끝나는 사원의 정보를 출력하세요.
select first_name, right(first_name, 1) from employees;

select * from employees where right(first_name, 1) = 'N';
select * from employees where instr(first_name, 'N') = char_length(first_name);

-- 사원들의 급여가 평균보다 큰 경우 '평균급여이상'이라 출력하고 아닌 경우 '평균급여이하' 라고 출력하세요
select round(avg(salary)) 평균급여 from employees;
-- 평균 6462

select salary, if(salary > 6462, '평균급여이상', '평균급여이하') 평가 from employees;

-- 사원의 급여에 대해 평균을 계산하고 정수로 변환해서 출력하세요
select floor(avg(salary)) from employees;

select cast(avg(salary) as ) from employees;

-- 사원들을 입사일자가 빠른 순으로 정렬한 뒤 본인보다 입사일자가 빠른
-- 사원의 급여를 본인의 급여와 함께 출력하세요
select first_name, salary, hire_date, lag(salary) over (order by hire_date) 선배사원급여 from employees;

-- AND나 BETWEEN을 사용하지 않고 2002 년도에 입사한 직원의 이름과 월급을 출력하세요.
select '2020-12-10', left('2020-12-10', 4);
select '2020-12-10', substr('2020-12-10', 1, 4);
select '2020-12-10', year('2020-12-10');

select first_name, salary, hire_date  from employees where left(hire_date, 4) = '2002';

select first_name, salary, hire_date  from employees where year(hire_date) = 2002;

-- 사원 테이블에서 사원의 이름이 5글자인 사원의 이름을 첫글자만 대문자로 출력하세요.
select first_name, upper(left(first_name, 1)) 첫글자 from employees
    where char_length(first_name) = 5;


-- 사원 테이블에서 이름과 입사일자
-- 그리고 현재날까지의 경과일을 산출하세요 (소숫점을 빼버리고 해딩이름을 경과일로 바꾸세요)
select left(hire_date, 10), curdate(), datediff(now(), hire_date) 경과일 from employees;

-- 이전문제에서 경과일을 개월수로 바꿔서 산출하세요.
-- 소숫점을 빼버리고 해당이름을 경과개월수로 바꾸세요
select left(hire_date, 10), curdate(), timestampdiff(MONTH, hire_date, now()) 경과개월수 from employees;

-- 사원 테이블에서 입사후 6개월이 지난날짜 바로 다음 일요일을 구하세요.
select dayofweek(curdate()) 오늘요일, date_add(curdate(),  interval 3 day) 다음주일요일,
       date_add(curdate(),interval 8 - dayofweek(curdate()) day);

select date_add(curdate(), interval 7 - dayofweek(curdate()) + 1 day);

select left(hire_date,10),
       left(date_add(date_add(hire_date, interval 6 month), interval 7 - dayofweek(date_add(hire_date, interval 6 month)) + 1 day), 10)
        입사후6개월경과다음주일요일
from employees;

-- 교육시작일이 2020-11-02인 경우,
-- 5개월(18주)이 지난후 돌아오는 첫번째 금요일은 언제인지 구하세요.
select '2020-11-02',
       date_add('2020-11-02', interval 18 week),
       date_add(date_add('2020-11-02', interval 18 week),
           interval 7 - dayofweek(date_add('2020-11-02', interval 18 week)) + 6 day);

-- select '2020-11-02',
--       date_add('2020-11-02', interval 129 day),
--       date_add(date_add('2020-11-02', interval 129 day), interval 129 + 6 day)


-- 사원 테이블에서 입사 후 첫 휴일(일요일)은 언제인지 구하세요
-- 일요일을 구하기 위에 dayofweek +1 이고 다른요일일 경우 일요일 기준으로 +를 더 해줘야 함
select first_name, hire_date from employees;

-- steven 사원의 입사일 기준 다음 첫 휴일
-- 그 외 다른 사원들은 동일식 적용 시 잘못된 결과 출력
select first_name, hire_date,date_add(hire_date, interval 4 day) 입사후첫휴일 from employees;

-- 모든 사원을 기준으로 조회할 경우
select first_name, hire_date,
       dayofweek(hire_date) 입사일요일명,
       7 - dayofweek(hire_date) 나머지요일수,
       date_add(hire_date, interval 7 - dayofweek(hire_date) + 1 day) 입사후첫휴일 from employees;

select first_name, hire_date,
    date_add(hire_date,
            interval 7 - dayofweek(hire_date) + 1 day) 입사후첫휴일
from employees;

select first_name, left(hire_date, 10) 입사일,
       left(date_add(hire_date,
                interval 7 - dayofweek(hire_date) + 1 day), 10) 입사후첫휴일
from employees;

-- 오늘날짜를 "xx년 xx월 xx일"  형식으로 출력하세요
select year(now()) 년, month(now()) 월, day(now()) 일;

-- 선생님 풀이
select date(now());
select date_format(date(now()), '%Y년%m월%d일');

-- 지금 현재 '몇시 몇분'인지 출력하세요.
select hour(now())시, minute(now())분;

-- 선생님 풀이
-- 한국 기준시로 변경하고 싶다면 서버설정변경(time-zone) 필요
-- 한국은 UTC 기준 9시간 추가 : KST = UTC + 9
select time(now());
select date_add(now(), interval 9 hour); -- AWS RDS의 시간은 미국 기준 시간이라 +9시간으로 맞춰줌
select @@global.time_zone; -- UTC
select @@session.time_zone;

set global time_zone = 'Asia/Seoul'; -- 관리자 권한 필요
set time_zone = 'Asia/Seoul';
select @@session.time_zone; -- 상기 명령문으로 아시아/서울로 변경됨 확인
select now(), time(now());
-- 다시 UTC 기준 시간으로 원복하려면 set time_zone = 'UTC'; 쓰면 됨

select now(), time(now()), date_format(time(now()), '%H시 %i분 %p');

-- 이번 년도 12월 31일까지 몇일이 남았는지 출력하세요.
select datediff('2020-12-31', '2020-12-11');
select datediff('2020-12-31', date(now())) 올해남은일수;

-- 사원들의 입사일에서 입사 년도와 입사 달을 조회하세요
select left(hire_date,10), date_format(hire_date, '%Y년 %m월') 입사년월 from employees;

-- 9월에 입사한 사원을 조회하세요
select left(hire_date,10), hire_date,
        substr(hire_date, 6, 2) 입사월추출1,
        month(hire_date) 입사월추출2,
       date_format(hire_date, '%m') 입사월추출3
from employees;

select first_name ,left(hire_date, 10) hire_date from employees where month(hire_date) = '9';


-- 사원들의 입사일을 출력하되, 요일까지 함께 조회하세요
select first_name ,left(hire_date, 10) hire_date,
       date_format(hire_date, '%W') 입사일_영어요일1,
       date_format(hire_date, '%a') 입사일_영어요일2,
       substr('일월화수목금토', dayofweek(hire_date), 1) 입사일_한글요일
from employees;

-- 사원들의 급여를 통화 기호를 앞에 붙이고 천 단위마다 콤마를 붙여서 조회하세요
-- format(값, 반올림 자릿수) : 숫자에 컴마를 붙여 출력 -- 이 경우 출력 시 문자로 변경됨
select first_name, format(salary, 0) 셀서식적용1,
       concat('￦ ',format(salary, 0)) 셀서식적용2
from employees;

-- 사원들의 급여를 10자리로 출력하되 자릿수가 남는 경우 빈칸으로 채워서 조회하세요
select first_name, salary,
       lpad(salary, 10, '_') 출력조정_급여
       from employees;

-- 각 사원들의 근무한 개월 수를 현재를 기준으로 구하세요
select first_name, left(hire_date, 10),
       timestampdiff(month, hire_date, now()) 근무개월수
from employees;

-- 각 사원들의 입사일에서 4개월을 추가한 날짜를 조회하세요
select first_name, left(hire_date, 10),
       left(date_add(hire_date, interval 4 month), 10) 입사후_4개월경과
from employees;

-- 각 사원들의 입사한 달의 마지막 날을 조회하세요
select first_name, left(hire_date, 10) 입사일,
       last_day(hire_date) 입사월_마지막날
from employees;


