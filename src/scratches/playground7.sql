-- mariadb 내장함수
-- 사용자의 편의를 위해 미리 작성해둔 함수
-- 숫자/문자/날짜/시간/변환/집계/분석 함수등이 제공

-- 숫자함수
-- 절대값 계산 : abs(값)
select abs(-4.5), abs(4.5);

-- 반올림 : round(값, 자리수)
select round(4.1), round(4.5);
select round(123.456, 1), round(123.456, 2);

-- 무조건 내림 : floor(값)
select floor(4.1), floor(4.5);
select floor(-4.1), floor(-4.5);

-- 무조건 올림 : ceil(값)
select ceil(4.1), ceil(4.5);
select ceil(-4.1), ceil(-4.5);

-- -78과 +78의 절댓값을 구하시오
select abs(78), abs(-78);

-- 4.875를 소수 첫째 자리까지 반올림한 값을 구하시오
select round(4.875, 1);

-- 고객별 평균 주문 금액을 백 원 단위로 반올림한 값을 구하시오.
select round(avg(saleprice), -2) '고객별 평균 주문금액' from book_orders group by custid;

-- 나머지 연산 : mod(분자, 분모)
select mod(10, 5), mod(10, 3);

-- 난수 생성 : rand (0~1사이 실수값 출력)
select rand(), rand() * 10, rand() * 100;

-- 0~9 사이 임의의 정수 생성
select rand() * 10, round(rand() * 10);
select rand() * 10, ceil(rand() * 10);
select rand() * 10, floor(rand() * 10);

-- n ~ m 사이 임의의 정수 생성
-- n + rand() * (m - n + 1)
-- n + rand() * m

-- 1 ~ 45 사이 임의의 정수 생성
select floor(1 + rand() * (45 - 1 + 1));

-- 문자함수
-- 문자의 ASCII 코드 출력 : ascii(문자)
select ascii('a'), ascii('A'), ascii('0');

-- ASCII 코드의 문자 출력 : char(숫자)
select char(48), char(65), char(97);

-- 문자열 길이 : length(문자열)
-- 영문자 : 1byte
-- 윈도우코드 (완성형, 조합형, euc-kr, win949) : 2byte
-- 유니코드 : 3byte
select length('Hello, World!!');
select length('가나다라마바');

-- 문자열 연결 : concat(문자열1, 문자열2, ...)
select concat('Hello', ',', 'World!');

-- 고객테이블의 이름과 주소, 전화번호 등을 다음과 같은 형식으로 출력되도록 작성하세요
-- 홍길동 고객의 주소는 ??? 이고, 전화번호는 !!! 입니다.
select concat(name,' 고객의 주소는 ', address,'이고, 전화번호는 ',phone,' 입니다.') 회원정보 from book_members;

-- 문자열 추출 : left(문자열, 길이), right(문자열, 길이), mid(문자열, 시작, 길이)
--              substring, substr 도 나중에 확인해볼 것
select left('Hello, World', 5);
select right('Hello, World', 5);
select mid('123456-1234567', 8, 1);

select left('가나다라마바', 3);
select right('가나다라마바', 3);
select mid('가나다라마바', 3, 1);

-- 고급 문자열 추출 : substring(문자열, 시작, 길이)
--                  substring(문자열, 시작)
select substring('Quadratically', 5);
select substring('Quadratically'from 5);
select substring('Quadratically', 5, 6);
select substring('Quadratically', -5);
select substring('Quadratically', -5, 3);
select substring('Quadratically' from -5 for 3);

-- 대소문자 변환 : upper, lower, ucase, lcase
select upper('abc'), lower('ABC');
select ucase('abc'), lcase('ABC');

-- 공백처리 : trim, ltrim, rtrim
select trim('   abc   '), rtrim('abc   '), ltrim('   abc');

-- 문자열 채움 : pad(문자열, 총길이, 채움문자)
-- 숫자는 lpad, 문자는 rpad 함수를 이용
select lpad('1234567890', 10, '_'), lpad('12345', 10, '_');

select rpad('가나다라마', 10, '_'), rpad('가나다', 10, '_'); -- 한글도 동일하게 1글자로 인식됨

-- 문자열 바꾸기 : replace(문자열, 찾을문자, 바꿀문자)
select replace('Hello, World', 'World', 'mariadb'); -- World가 mariadb 로 바뀜
select replace('Hello, World', 'World', ''); -- 공백으로 비워두면 World 지워짐

-- 문자열 뒤집기 : reverse
select reverse('12345'), reverse('가나다라마');

-- 문자열 위치찾기 : instr(문자열, 찾을문자열)
-- 존재하지 않는 경우 : 0으로 출력
select instr('Hello, World', 'W'),
       instr('Hello, World', 'H'),
       instr('Hello, World', '!');

-- 'Hello_World_!!' 에서 2번째 _의 위치를 알고 싶음
-- 이에 적절한 질의문은 ? (실제값 : 12)

-- instr 사용 : 첫번째 _의 위치 출력
select instr('Hello_World_!!', '_');

-- reverse로 문자열 반전 후 instr 사용 : 두번째 _의 위치 출력
select instr(reverse('Hello_World_!!'), '_');

-- 전체글자 길이에서 반전후 instr로 _위치를 빼줌
select length('Hello_World_!!') -
       instr(reverse('Hello_World_!!'), '_')+1;

select length('가나다_마바사_아자차!') -
       instr(reverse('가나다_마바사_아자차!'), '_')+1;
-- 한글은 3바이트 이므로 length로 문자 길이를 계산하면 안됨
select char_length('가나다_마바사_아자차!') -
       instr(reverse('가나다_마바사_아자차!'), '_')+1;
-- length 대신 char_length를 사용하면 됨

-- substring_index 함수를 이용하면 편하게 할 수 있음
select substring_index('Hello_World_!!', '_', 1);
-- 첫번째 _를 기준으로 분리한 문자열을 출력
select substring_index('Hello_World_!!', '_', 2);
-- 두번째 _를 기준으로 분리한 문자열을 출력

select length(substring_index('Hello_World_!!', '_', 2))+1;

-- 'World_Of_Warchaft_Shadow_Land'에서 3번째 _의 위치는 ?
select length(substring_index('World_Of_Warchaft_Shadow_Land', '_', 3))+1;

-- 도서제목에 야구가 포함된 도서를 농구로 변경한 뒤 변경결과를 확인하세요
select bookname from books where bookname like '%야구%';
select replace('야구의 추억', '야구', '농구');
select replace('야구를 부탁해', '야구', '농구');
select bookname from books;

-- 선생님 풀이
select bookid, bookname 변경전제목, replace(bookname, '야구', '농구') 변경후제목, publisher, price from books;

-- 굿스포츠에서 출판한 도서의 제목과 제목의 글자수를 조회하세요
select bookname, char_length(bookname) 문자수, length(bookname) 바이트수,
       char_length(replace(bookname, ' ', '')) 공백제거문자수
from books where publisher = '굿스포츠';

-- 고객 중 같은 성을 가진 고객의 수를 조회하세요
select name, left(name, 1) 성,right(name, 2) 이름 from book_members;

select left(name, 1) 성, count(custid) 고객수 from book_members group by 성;