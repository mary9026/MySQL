-- northwind 데이터셋 이용

-- 1. 고객 테이블을 조회하세요
select * from Customers;

-- 2. 고객테이블에서 고객이름과 도시를 조회하세요
select ContactName, City from Customers;

-- 3. 고객 테이블에서 도시를 조회하세요
-- (중복은 제외한다)
select DISTINCT city from Customers;

-- 4. 고객 테이블에서 국가 수를 조회하세요
select count(distinct Country) from Customers;

-- 5. 고객 테이블에서 국가가 'Mexico'인 고객을 조회하세요
select CustomerID from Customers where Country = 'Mexico';

-- 6. 사원 테이블에서 ID가 5인 사원을 조회하세요
select * from Employees where EmployeeID = 5;

-- 7. 고객 테이블에서 국가가 'Germany'이고 도시가 'Berlin'인 고객을 조회하세요
select * from Customers where Country = 'Germany' and City = 'Berlin';

-- 8. 고객 테이블에서 도시가 'Berlin' 이거나 'M?nchen'인 고객을 조회하세요
select CustomerID from Customers where City in ('Berlin', 'M?chen');

-- 9. 고객 테이블에서 국가가 'Germany' 또는 'Spain' 인 고객을 조회하세요
select CustomerID from Customers where Country in ('Germany', 'Spain');

-- 10. 고객 테이블에서 국가가 'Germany' 이 아닌 고객을 조회하세요
select CustomerID from Customers where Country <> 'Germany';

-- 11. 고객 테이블에서 국가가 'Germany' 이고 도시가 'Berlin' 이거나 'M?nchen'인 고객을 조회하세요
select CustomerID from Customers where Country = 'Germany' and city in ('Berlin', 'M?nchen');

-- 12. 고객 테이블에서 국가가 'Germany' 아니고  'USA'도 아닌 고객을 조회하세요
select CustomerID, Country from Customers where Country not in ('Germany','USA');

-- 13. 고객 테이블에서 국가순으로 A-Z로 정렬해서 조회하세요
select * from Customers order by Country;

-- 14. 고객 테이블에서 국가순으로 Z-A로 정렬해서 조회하세요
select * from Customers order by Country desc;

-- 15. 고객 테이블에서 국가순으로 A-Z로 정렬하되, 같은 경우 고객이름으로 A-Z로 정렬해서 조회하세요
select * from Customers order by Country, ContactName;

-- 16. 고객 테이블에서 국가순으로 A-Z로 정렬하되,
-- 같은 경우 고객이름으로 Z-A로 정렬해서 조회하세요
select * from Customers order by Country, ContactName desc;

-- 17. 다음의 고객정보를 고객 테이블에 입력하세요
-- 회사이름, 연락처이름, 주소, 도시, 우편번호, 국가 =>
-- 'Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway'
insert into Customers (CompanyName, ContactName, Address, City, PostalCode, Country)
values ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway');
-- CustomerID가 디폴트값 들어가야해서 안됨 -> 데이터베이스 내 CustomerID 오른쪽마우스 > 열수정 > 기본값에 '' 넣고 실행

-- 18. 다음의 고객정보를 고객 테이블에 입력하세요
-- 회사이름, 도시, 국가 => 'Cardinal', 'Stavanger', 'Norway'
insert into Customers (CompanyName, City, Country) values ('Cardinal', 'Stavanger', 'Norway');

-- 19. 고객 테이블에서 주소가 입력되지 않은
-- 고객이름, 연락처이름, 주소를 조회하세요
select CompanyName, Phone, Address from Customers where Address is null;

-- 20. 고객 테이블에서 주소가 입력된 고객이름, 연락처이름, 주소를 조회하세요
select CompanyName, Phone, Address from Customers where Address is not null;

-- 21. 고객 테이블에서 1번 고객의 연락처 이름을 'Alfred Schmidt'로, 도시를 'Frankfurt'로 수정하세요 (1번 고객 id : ALFKI)
update Customers
    set ContactName = 'Alfred Schmidt', City = 'Frankfurt'
    where CustomerID = 'ALFKI';

-- 22. 고객 테이블에서 국가가 Mexico인 고객들의 연락처 이름을 'Juan'으로 변경하세요
update Customers set ContactName = 'Juan' where Country = 'Mexico';

-- 23. 고객 테이블에서 연락처 이름이 'Alfreds Futterkiste'인 고객들을 삭제하세요
delete from Customers where ContactName = 'Alfreds Futterkiste';

-- 24. 고객 테이블에서 3번째부터 7번째 고객을 조회하세요
-- 단, 고객이름은 A-Z로 정렬한다 (페이징)
-- marinaDB에서 페이징은 limit x, y 절을 이용
-- x : 시작위치, y : 읽어올 행수 (첫행은 0)
-- limit 0, 5 : 0번째 위치에서 5개의 행을 읽어옴 (1번부터 5번까지)
-- limit 5, 5 : 5번째 위치에서 5개의 행을 읽어옴 (6번부터 10번까지)

select * from Customers limit 2, 5;

-- 25. 고객 테이블에서 국가가 'Germany' 인 고객들 중
-- 3번째부터 7번째 고객을 조회하세요
select * from Customers where Country = 'Germany' limit 2, 5;

-- 26. 제품테이블에서 최대, 최소 가격을 조회하세요
select max(UnitPrice) 최대가격, min(UnitPrice) 최소가격 from Products;

-- 27. 제품테이블에서 제품수, 평균가격을 조회하세요
select count(ProductID) 제품수, avg(UnitPrice) 평균가격 from Products;

-- 28. 제품테이블에서 가격이 20달러 이상인 제품수를 조회하세요
select ProductID, ProductName, UnitPrice from Products where UnitPrice >= 20;

select count(ProductID) 제품수 from Products where UnitPrice >= 20;

-- 29. 제품상세테이블에서 주문수, 총 주문수량을 조회하세요
select count(OrderID) 주문건수, sum(Quantity) 총주문수량 from Order_Details;

-- 30. 고객 테이블에서 고객이름이 'A'로 시작하는 고객을 조회하세요
select ContactName from Customers where ContactName like 'A%';

-- 함수버젼
select ContactName from Customers where left(ContactName, 1) = 'A';

-- 31. 고객 테이블에서 고객이름이 'a'로 끝나는 고객을 조회하세요
select ContactName from Customers where ContactName like '%a';

-- 함수버젼
select ContactName from Customers where right(ContactName, 1) = 'a';

-- 32. 고객 테이블에서 고객이름에 'or'을 포함하는 고객을 조회하세요
select ContactName from Customers where ContactName like '%or%';

-- 문장 내에 오른쪽에 있는 문자가 있는지 검색 (있으면 위치값. 없으면 0)
select instr('abc123', '1'), instr('987xyz', 's');

select ContactName from Customers where instr(ContactName, 'or') > 0;

-- 32. 고객 테이블에서 고객이름의 2번째 글자가 'r'로 시작하는 고객을 조회하세요
select ContactName from Customers where ContactName like '_r%';

select ContactName from Customers where instr(ContactName, 'r') = 2;
select ContactName from Customers where substr(ContactName, 2, 1) = 'r';
select ContactName from Customers where mid(ContactName, 2, 1) = 'r';

-- 32. 고객 테이블에서 고객이름이 'A'로 시작하고 최소 3자 이상인 고객을 조회하세요
select ContactName from Customers where ContactName like 'A__%';

select ContactName from Customers
    where left(ContactName, 1) = 'A' and char_length(ContactName) >= 3;

-- 33. 고객 테이블에서 연락처이름이 'a'로 시작하고 'o'로 끝나는 고객을 조회하세요
select ContactName from Customers where ContactName like 'A%o';

select ContactName from Customers
    where left(ContactName, 1) = 'a'
    and right(ContactName, 1) = 'o';

-- 34. 고객 테이블에서 고객이름이 'A'로 시작하지 않는 고객을 조회하세요
select ContactName from Customers where ContactName not like 'A%';

select ContactName from Customers where left(ContactName,1) <> 'A';

-- 35. 고객 테이블에서 도시이름이 'ber'로 시작하는 도시를 조회하세요
select City from Customers where City like 'ber%';

select City from Customers where left(City, 3) = 'ber';

-- 36. 고객 테이블에서 도시이름에 'es'를 포함하는 도시를 조회하세요
select City from Customers where City like '%es%';

select City from Customers where instr(City, 'es') > 0;

-- 37. 고객 테이블에서 도시이름이 6자이며 'erlin'로 끝나는 도시를 조회하세요
select City from Customers where City like '_erlin';

select City from Customers
    where right(City, 5) = 'erlin' and char_length(city) = 6;

-- 38. 고객 테이블에서 도시이름이 6자이며 'L'로 시작하고 on으로 끝나며,
-- 3번째 글자가 n인 도시를 조회하세요
select City from Customers where City like 'L_n_on';

select City from Customers
    where left(City, 1) = 'L' and mid(City, 3, 1) = 'n' and right(City, 2) = 'on' and char_length(City) = 6;

select City from Customers
    where char_length(City) = 6 and
    left(City, 1) = 'L' and
    right(City, 2) = 'on' and
    instr(city, 'n') = 3;

-- 39. 고객 테이블에서 도시이름이 b, s, p등으로 시작하는 도시를 조회하세요
select City from Customers
    where City like 'p%' or
          city like 's%' or
          city like 'b%';

-- 정규표현식
-- ^ : 문자열 시작 (like 가% : ^가)
-- $ : 문자열 끝 (like %가 : 가$)
-- [...] : 어떤 문자들 중 하나를 포함 ([1aA] => 1 또는 a 또는 A를 포함)
-- [^...] : 어떤 문자들 중 하나를 제외 ([1aA] => 1 또는 a 또는 A를 제외)
-- | : 선택을 의미 (or)

select City from Customers
    where City like '[bsp]%'; -- ansi sql, 지원 안되서 실행 안됨

select City from Customers
where City regexp '^[bsp]'; -- mariadb 전용


-- 40. 고객 테이블에서 도시이름이 a에서 c사이로(a,b,c) 시작하는 도시를 조회하세요
-- 정규식
select City from Customers where City regexp '^[abc]';

select City from Customers where City regexp '^[a-c]';

-- 41. 고객 테이블에서 도시이름이 b, s, p등으로 시작하지 않는 도시를 조회하세요
select City from Customers
    where City regexp '^[^bsp]';

-- 42. 고객 테이블에서 국가이름이 'Germany', 'France', 'UK'인 고객을 조회하세요
select ContactName, Country from Customers where Country in ('Germany', 'France', 'UK');

select ContactName, Country from Customers
    where Country regexp 'Germany|France|UK';

-- 43. 고객 테이블에서 도시이름이 'Germany', 'France', 'UK'가 아닌 고객을 조회하세요
select ContactName, Country from Customers where Country not in ('Germany', 'France', 'UK');

select ContactName, Country from Customers
    where Country not regexp 'Germany|France|UK';

-- 44. 상품 테이블에서 가격이 10 ~ 20사이인 제품을 조회하세요
select UnitPrice from Products
    where UnitPrice between 10 and 20;

-- 45. 상품 테이블에서 가격이 10 ~ 20사이인 제품을 조회하세요
-- 단, 제품분류코드가 1,2,3인 제품은 제외한다
select UnitPrice from Products
    where UnitPrice between 10 and 20
    and CategoryID not in (1,2,3);

-- 46. 상품 테이블에서 제품이름이 'Carnarvon Tigers' 에서 'Mozzarella di Giovanni' 사이인 제품을 조회하세요
select ProductName from Products
    where ProductName between '' and '';

select ProductName from Products
    where ProductName between 'Carnarvon Tigers'
        and 'Mozzarella di Giovanni';

-- 47. 상품 테이블에서 제품이름이 'Carnarvon Tigers' 에서
-- 'Mozzarella di Giovanni' 이외의 제품을 조회하세요
select ProductName from Products
    where ProductName not between 'Carnarvon Tigers'
    and 'Mozzarella di Giovanni';

-- 48. 주문 테이블에서 주문날짜가 '01-July-1996' 에서 '31-July-1996'사이인
-- 주문을 조회하세요
select OrderDate from Orders
    where OrderDate between '01-July-1996'
    and '31-July-1996';

select OrderDate from Orders
where instr(OrderDate, 4) = 'July-1996';


select OrderDate from Orders
where mid(OrderDate, 'July-1996') = 'July-1996';

select OrderDate from Orders
    where OrderDate between '1996-July-01'
    and '1996-July-31';

select OrderDate from Orders
    where mid(OrderDate, 4) = 'July-1996';

select OrderDate from Orders
    where left(OrderDate, 7) = '1996-07';

select OrderDate from Orders
WHERE INSTR(OrderDate, 'July-1996') = 4;

select OrderDate from Orders
    WHERE INSTR(OrderDate, '1996-07') = 1;

-- 49. 고객 테이블에서 고객번호, 고객이름을 조회하세요
-- 단, 고객번호는 ID로,고객이름은 Customer라는 별칭을 사용한다
select CustomerID ID, ContactName Customer from Customers;

-- 50. 고객 테이블에서 고객번호, 주소, 우편번호,
-- 도시, 국가등을 조회하세요 단, 주소, 우편번호,
-- 도시, 국가등은 쉼표로 연결해서 Address라는 별칭을 사용한다
select CustomerID, concat(Address, ',', PostalCode, ',', City,',', Country) Address from Customers;

-- 51. 고객 테이블을 이용해서 국가별 고객수를 조회하세요
select Country ,count(CustomerID) 고객수 from Customers group by Country;

-- 52. 고객 테이블을 이용해서 국가별 고객수가 5명 이상인 국가를 조회하세요
select Country ,count(CustomerID) 고객수 from Customers
    group by Country having 고객수 >= 5
    order by 고객수;

-- 53. 고객/주문 테이블을 이용해서 주문번호, 고객이름, 주문일자를 조회하세요
select CustomerID, ContactName, left(OrderDate, 10) -- 또는 date(OrderDate)
    from Customers c join Orders o
    using(CustomerID);

-- 54. 고객/주문/배송자 테이블을 이용해서 주문번호, 고객이름, 배송업체명을 조회하세요
select CustomerID, ContactName, ShipName
    from Customers c join Orders o
    using (CustomerID)
    join Shippers s on o.ShipVia = s.ShipperID;

-- 55. 주문/배송자 테이블을 이용해서 배송업체별 주문건수를 조회하세요
select ShipperID, CompanyName,count(OrderID) 주문건수 from Orders o join Shippers s
    on o.ShipVia = s.ShipperID
    group by ShipperID;

-- 56. 주문/배송자 테이블을 이용해서 배송업체별 주문건수가 300건 이상인 배송업체를 조회하세요
select ShipperID, CompanyName,count(OrderID) 주문건수
    from Orders o join Shippers s on o.ShipVia = s.ShipperID
    group by ShipperID having 주문건수 >= 300;

-- 57. 주문/사원 테이블을 이용해서 사원 'Davolio' 또는 'Fuller' 가
-- 맡은 총 주문건수 중 100건 이상인 사원은 누구인가?
select LastName, count(OrderID) 주문건수
    from Orders o join Employees using(EmployeeID)
    where LastName in ('Davolio', 'Fuller')
    group by LastName having  주문건수 >= 100;

-- 58. 고객/주문 테이블을 이용해서 주문번호가 없는 고객을 조회하세요
select CustomerID , OrderID from Customers s left join Orders o
    using (CustomerID)
    where OrderID is null;

-- 59. 사원/주문 테이블을 이용해서 주문번호가 없는 사원을 조회하세요
select e.EmployeeID, OrderID from Employees e left join Orders o
    using(EmployeeID)
    where OrderID is null;

-- 60. 고객 테이블을 이용해서 같은 도시에서 온 고객들을 조회하세요
-- 고객이름은 다르면서 도시이름이 같은 데이터를 찾으면 됨
-- self 조인 사용
select c1.City, c2.City, c1.ContactName, c2.ContactName from Customers c1 join Customers c2
    using (City)
    where c1.City = c2.City
    and c1.ContactName <> c2.ContactName;


-- 61. 제품/상세주문 테이블을 이용해서 주문수량이 99 이상인 제품이름을 조회하세요
select ProductName, Quantity from Products p join Order_Details o
    using(ProductID)
    where Quantity >= 99;


-- 62. 제품 테이블을 이용해서 제품분류코드가 2인 제품의 가격보다
-- 높은 제품의 이름과 가격을 조회하세요
select UnitPrice from Products
    where CategoryID = 2 order by UnitPrice;

select ProductName, UnitPrice from Products
    where UnitPrice > all (select UnitPrice from Products
    where CategoryID = 2 order by UnitPrice);

-- 64. 제품 테이블을 이용해서 제품이름, 1개당가격 * 재고량, 1개당가격 * 주문량을 조회하세요
select UnitPrice, UnitsInStock, UnitsOnOrder,
       round(UnitPrice * UnitsInStock) 재고총가격,
       round(UnitPrice * UnitsOnOrder) 주문총가격
from Products;