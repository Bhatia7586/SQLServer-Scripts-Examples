--Syntax : Rename: SP_RENAME 'old_table_name', 'nea_table_name'
SP_RENAME 'P', 'Persons'



--Syntax : Delete : DETETE FROM table_name
DELETE FROM Persons;

--Syntax : Rename : SP_RENAME 'oldtbalename', 'newtablename'
SP_RENAME 'Persons', 'per';

--Syntax : Truncate : TRUCATE TABLE table_name
TRUNCATE TABLE Persons;

--Syntax : Copy table : SELECT * INTO new_table FROM old_table
SELECT * INTO copyPersons FROM Persons;

--Syntax : Local temp Table : CREATE TABLE #table_name(columnname1 datatype...columnnamen datatype);
CREATE TABLE #LocalTempTable(
	UserId int,
	UserName varchar(50),
	UserAddress varchar(50));
INSERT INTO #LocalTempTable VALUES(1,'dcs','sfa');
SELECT * FROM #LocalTempTable;

--Syntax : Global Temp Table : CREATE TABLE ##table_name(columnname1 datatype...columnnamen datatype);
CREATE TABLE ##GlobalTempTable(
	UserId int,
	UserName varchar(50),
	UserAddress varchar(50));
INSERT INTO ##GlobalTempTable VALUES(1,'dcs','sfa');
SELECT * FROM ##GlobalTempTable;

--Syntax : Alter for Add Column : ALTER TABLE table_name ADD Column_name datatype
--Syntax : Alter for Drop Column : ALTER TABLE table_name DROP COLUMN Column_name
--Syntax : Alter for Modify Column : ALTER TABLE table_name ALTER COLUMN Column_name datatype

ALTER TABLE Persons1 ADD DOB Date;
ALTER TABLE Persons1 DROP COLUMN DOB;
ALTER TABLE Persons1 ALTER COLUMN ZipCode varchar(15);

--Syntax : Select Syntax : SELECT * FROM table-name; 
SELECT * FROM Persons1;
--SELECT Column_name1, ... FROM table_name
SELECT PersonID, City FROM Persons1;

--DISTINCT : Syntax : SELECT DISTINCT Column1,.. FROM table_name
SELECT DISTINCT * from Persons1;
SELECT DISTINCT LastName from Persons1;

--COUNT : Syntax : SELECT COUNT(column) FROM table _name;
SELECT COUNT(*) FROM Persons1;
SELECT COUNT(City) FROM Persons1;

--TOP : Syntax : SELECT TOP 2 Columnname1, .... FROM table_name
SELECT TOP 2 * FROM Persons1;
SELECT TOP 1 City FROM Persons1;

--FIRST : Syntax : SELECT TOP 1 column1,... FROM table_name ORDER BY Columnname ASC
SELECT * FROM Persons1 ORDER BY PersonID ASC;
SELECT TOP 1 * FROM Persons1 ORDER BY PersonID ASC;

--LAST : Syntax : SELECT TOP 1 Column1, ... FROM table_name ORDER BY Columnname DESC
SELECT * FROM Persons1 ORDER BY PersonID DESC;
SELECT TOP 1 * FROM Persons1 ORDER BY PersonID DESC;

--RANDOM : Syntax : SELECT RAND()
SELECT RAND();
SELECT abs(12.6679878) AS Absolute;
SELECT floor(12.6)
SELECT CEILING(12.6)

--AS : Syntax :  SELECT column_name AS alias_name,... from table_name;
select * from Persons1;

SELECT PersonID AS ID, LastName AS LName, FirstName AS FName, Address AS addr, City, ZipCode AS Zip FROM Persons1;

--IN Syntax :  SELECT * FROM table_name WHERE Column_name IN (value1, value2,...valuen)
select * from Persons1;
SELECT * from Persons1 WHERE PersonID IN(10, 11, 12, 1);

--DATE
select * from Persons1 where DOB>='2018-12-12';

--SUM : Syntax :  SELECT SUM(Column_name) FROM table_name
SELECT SUM(PersonID) AS Sumofids FROM Persons1;

--NULL : Syntax : SELECT column1,... FROM table_name WHERE Column1 IS NULL
SELECT * FROM Persons1 WHERE City IS NULL
--NULL : Syntax : SELECT column1,... FROM table_name WHERE Column1 IS NOT NULL
SELECT * FROM Persons1 WHERE City IS NOT NULL

--WHERE : Syntax : SELECT Column1, ... FROM Table_name WHERE Condition
SELECT * FROM Persons1 WHERE LastName = 'ghv';

--AND: Syntax: SELECT Column1, ... FROM table_name WHERE condition AND Condition ..
--T	T = T
--T	F = F
--F	T = F
--F	F = F
select * from Persons1 where DOB>='2018-12-12' AND ZipCode=12 AND Address = 'ss';

--OR: Syntax: SELECT Column1, ... FROM table_name WHERE condition OR Condition ..
--T	T = T
--T	F = T
--F	T = T
--F	F = F
select * from Persons1 where DOB>='2018-12-12' OR ZipCode=12 OR Address = 'ss';

--1. 4
--2. 4-1 = 3,	4*3=12
--3. 3-1 = 2, 12*2=24
--4. 2-1 = 1, 24*1=24
--5. 1-0 = 1, 24*1=24
--...
--[WITH<Common_label_expression>[...n]]
	--<Common_table_expression>::=
	--expression_name(Column1[...,n])]
	--AS
	--(CTE_query definition)

DECLARE @number INT=5;
WITH myCTE(fact, num)
AS
(
SELECT @number*(@number-1) AS fact, @number-1 AS num
UNION ALL
SELECT fact * (num-1), num-1 FROM myCTE where num>1
)
SELECT TOP 1 fact FROM myCTE ORDER BY fact DESC

--myCTE: fact		num
--	   20		3
--	   60		2
--	   120		1

DECLARE @limit INT=20;
WITH myCTE1(a,b,cnt)
AS
(
SELECT 0 AS a, 1 AS b, 1 UNION ALL
SELECT b, a+b, cnt+1 FROM myCTE1 WHERE cnt<@limit
)
SELECT a FROM myCTE1

--myCTE1
--a		b		cnt
--0		1		1
--1		1		2
--1		2		3
--2		3		4

--Order by clause
--Syntax : SELECT column1,.. FROM table_name where condition ORDER BY column_name [ASEC/DESC]
select * from Persons1;
select * from Persons1 where DOB>='2018-12-12' order by LastName ASC;
select * from Persons1 where DOB>='2018-12-12' order by LastName desc;

--LIMIT
select top 5 PersonID, LastName from Persons1;

--order by multiple
--Syntax : SELECT column1,.. FROM table_name where condition ORDER BY column_name1, ... [ASEC/DESC]
select * from Persons1
select * from Persons1 order by PersonID, ZipCode;


--like syntax : select coloumn1,.. from table_name where column_name like 'expression'; 
select * from Persons1;
select * from Persons1 where LastName like 'd_a';

--some: syntax : select  columnname1,.. from table_name where condition some (subquery)
select * from instructor;
select name, Salary from instructor where Salary>some(select Salary from instructor where Department='CS');
select name, Salary from instructor where Salary>some(1,78,67,12,54);
select Salary from instructor where Department='CS'
select name, Salary from instructor where 56>1 or 56>78 or 56>67 or 56>12 or 56>54

--INSERT syntxa: Insert into table_name(col1, col2...) values(vale1, vale2...)
		--syntax : insert into table_namne values(val1, val2...)
		--syntax: insert into table_name (col1, col2..) select col1, col2.. from tbale_name

insert into Persons1 (LastName, FirstName) values ('sada','issac');
insert into Persons1 values(1, 'sada','sada','dsvs','fdv',12,'2018-08-05');
insert into Persons1(PersonID, LastName, FirstName, Address, City) select * from Persons where PersonID=12;
insert into Persons1(LastName, FirstName) select LastName, FirstName from Persons;
insert into Persons1(City, ZipCode) values('sdas',23),('sdas',23),('sdas',23),('sdas',23)
insert into Persons1 values(10, 'sada','sada','dsvs','fdv',12,'2018-08-05'), 
							(11, 'sada','sada','dsvs','fdv',12,'2018-08-05'), 
							(12, 'sada','sada','dsvs','fdv',12,'2018-08-05'), 
							(13, 'sada','sada','dsvs','fdv',12,'2018-08-05'), 
							(14, 'sada','sada','dsvs','fdv',12,'2018-08-05');

--update tbale_name set col1=val1, col2=val2.. where condition
select * from Persons1 where PersonID=1;
update Persons1 set city='US',LastName='sada' where PersonID=1;


insert into table1(column1,column2,column3)
select 1, 11, 'FIRST'
union all
select 11, 12, 'SECOND'
union all
select 21, 13, 'THIRD'
union all
select 31, 14, 'FOURTH';

select * from table1;
select * from table2;
insert into table2(column1,column2,column3)
select 1, 21, 'TWO-ONE'
union all
select 11, 22, 'TWO-TWO'
union all
select 21, 23, 'TWO-THREE'
union all
select 31, 24, 'TWO-FOUR';

update table1 set column2 = t2.column2, column3=t2.column3 
	from table1 t1 inner join table2 t2 on t1.column1=t2.column1 
		where t1.column1 in (21, 31);

select * from Persons1 where LastName like 'a%';
update Persons1 set DOB='2018-10-30' where LastName like 'a%';

--delete: delete from table_name where condition
select * from Persons1 where LastName like 'a%';
delete from Persons1 where LastName like 'a%';
select * from dummy;

--delete command used to remove records from table temparary
delete from dummy;
--truncate is used to remove the records from table permenentley
truncate table dummy;

--drop is used to remove entaire table structure from DB
drop table dummy;

--drop database databasename
drop database sample;

--delete  target_table_name 
	--from table1 inner join table2 on table1.joincolumn=table2.joincolumn 
		--where condition
delete table1  
	from table1 t1 inner join table2 t2 on t1.column1=t2.column1 
		where t1.column1 in (21, 31);

select * from table1;
select * from table2;

--commit: syntax :  begin trans transName
						--command Operation
				--commit trans transName
begin tran inserttrans
	insert into Persons1 values(16,'sd','as','afa','fafs',12,'2018-12-13');
commit tran inserttrans

--rollback : syntax : begin tran tranName
						-- command for operations
					-- rollback tran transName
begin tran inserttrans
	insert into Persons1 values(17,'sd','as','afa','fafs',12,'2018-12-13');
rollback tran inserttrans

--savepoint
create table people(name varchar(20));

--Query starts
set nocount on
begin tran
insert into people values('Sada');

save tran savepoint1
insert into people values('Issac');
rollback tran savepoint1

insert into people values('Sadasiva');

save tran savepoint2
insert into people values('Issac');
rollback tran savepoint2

commit tran
--query ends

select * from people;

--Joins
select * from Employee;
select * from Departments;
--Natural Join
select 
	e1.Username, 
	e1.FirstName, 
	e1.LastName, 
	e1.DepartID,
	e2.DepartmentName 
	from Employee e1 
		inner join Departments e2;

--Equi Join
select * from Employee e1
	join Departments e2 
		on e1.DepartID=e2.id;

--Left Outer  Join
select * from Employee e1
	left outer join Departments e2
		on e1.DepartID=e2.id;

--Right Outer Join
select * from Employee e1
	right outer join Departments e2
		on e1.DepartID=e2.id;

--Full Outer join
select * from Employee e1
	full outer join Departments e2
		on e1.DepartID=e2.id;

--Cross Join
select * from Employee e1 
	cross join Departments e2;

--self join
select e1.Username, e1.FirstName, e1.LastName
	from Employee e1
		inner join Employee e2
			on e1.id=e2.DepartID;

syntax : 
select ref.col1...
	from tablename1 ref1
		joinname tablename2 ref2
			on ref1.col = ref2.col
				[cluases]
					[where condtion]


--Keys:
--Not null key
create table notNullExTab(
	id int not null,
	lastname varchar(30) not null,
	firstname varchar(20) not null,
	age int
);

select * from notNullExTab;
insert into notNullExTab values(1, 'ss','ss',10);
insert into notNullExTab values(2, 'ss','ss',null);

--default
create table defaultexTab(
	id int not null,
	lastname varchar(30) not null,
	firstname varchar(20) not null,
	age int,
	city varchar(25) default 'US'
);
select * from defaultexTab;
insert into defaultexTab (id, lastname,firstname, age, city) values(3, 'ss','ss',10, 'UK');

create table defaultextab1(
id int not null,
ordernumber int not null,
orderdate date default getdate()
);
insert into defaultextab1(id, ordernumber) values(1,23);
select * from defaultextab1;

--index:crete index syntax: create index indexName on tablename(col1, col2...)
--create unique index syntax: create unique index indexName on tableName (col1, col2..)
select * from Persons1
create index idx_lastname on Persons1(LastName);
create index idx_lastfirstname on Persons1(LastName, FirstName);
--drop indesx tableName.indexName
drop index Persons1.idx_lastfirstname;

--auto increament
create table autoincreextab(
	id int identity(1,1) primary key,
	lastname varchar(20),
	firstname varchar(20),
	age int
);

insert into autoincreextab(lastname, firstname) values('ss','s');
select * from autoincreextab;

--primarykey
create table primarykeyextab(
	id int not null ,
	lastname varchar(20) not null,
	firstname varchar(20),
	age int,
	constraint PK_tab primary key(id)
)

alter table primarykeyextab drop constraint PK_tab;
alter table primarykeyextab add constraint PK_tab1 primary key(id,lastname);

insert into primarykeyextab values(3, 'ss','ss',10);
select * from primarykeyextab
drop table primarykeyextab;

--synatx:
create table tableName(col1 datatype not null, col2..., constraint constraintName primary key(col1,col2..)


----Foreign key
create table foreignkeyextab(
	orderId int not null primary key, 
	orderNum int not null,
	personId int foreign key references primarykeyextab(id)
);

create table foreignkeyextab(
	orderId int not null,
	orderNum int not null,
	personId int,
	primary key(orderID),
	constraint fk_personID foreign key(personID) references primarykeyextab(id)
);

--derop foreign key
alter table foreignkeyextab drop constraint fk_personID;
--add foreign key
alter table foreignkeyextab add constraint fk_personID1 foreign key(personId) references primarykeyextab(id);

drop table foreignkeyextab;
insert into foreignkeyextab values(112, 2, 3);
select * from foreignkeyextab;

--composite key
create table primarykeyextab(
	id int not null ,
	lastname varchar(20) not null,
	firstname varchar(20),
	age int,
	constraint PK_tab primary key(id, lastname)
)
insert into primarykeyextab values(3, 'issac','ss',10);
select * from primarykeyextab;

--unique key
create table uniquekeyExtab(
	id int not null unique,
	lname varchar(10) not null,
	fname varchar(10),
	city varchar(10)
);
insert into uniquekeyExtab(id, lname) values(1, 'ss');
select * from uniquekeyExtab;

drop table uniquekeyExtab;

create table uniquekeyExtab(
	id int not null,
	lname varchar(10) not null,
	fname varchar(10),
	city varchar(10),
	constraint uc_idname unique (id)
);
insert into uniquekeyExtab(id, lname) values(2, 'ss');
select * from uniquekeyExtab;
delete uniquekeyExtab;

--drop unique key
alter table uniquekeyExtab drop constraint uc_idname;

--add unique constraint
alter table uniquekeyExtab add constraint uuniue_id unique(id);


--check
create table checksingleExtab(
	id int not null,
	lname varchar(15) not null,
	fname varchar(15),
	age int check (age>=18)
);

create table checksingleExtab(
	id int not null,
	lname varchar(15) not null,
	fname varchar(15),
	age int,
	constraint chk_person1 check (age>=18)
);
insert into checksingleExtab values(1, 'as','ss',19);
select * from checksingleExtab;
delete checksingleExtab;
drop table checksingleExtab;

--drop check constraint
alter table checksingleExtab drop constraint chk_person1;

--add check constraint
alter table checksingleExtab add constraint ch_peron check (age>18 or lname='ss')


--Date
Date - YYYY-MM-DD
dateTime - YYYY-MM-DD HH:MI:SS
SmallDateTime - YYYY-MM-DD HH:MI:SS
Timestamp : unique number

create table dateEx(
date1 date,
date2 datetime,
date3 SmallDateTime,
date4 timestamp
)
insert into dateEx (date1, date2, date3)values('2018-05-06','2018-06-01 07:02:10', '2018-06-01 07:02:10')
select * from dateEx order by date1 desc;


--views
--syntax: create view viewName as select col1, col2.. from tableName where condition
create view [current person list] as select LastName, FirstName from Persons1 where LastName like 'a%';
insert into Persons1 values(80, 'aa', 'aa', 'Us','d', 23, '2018-09-09');
select * from [current person list];
select * from Persons1;

--syntax For upadte : alter view viewName as select col1, col2... from tableName where condition
alter view [current person list] as select LastName from Persons1 where LastName like 's%';

--syntax: drop view viewName
drop view [current person list];

--SQL Server String function
ASCII
select ASCII('A');

CHAR
select CHAR(65);

CHARINDEX
select CHARINDEX('ca','issac')

CONCAT
select CONCAT('Sada', 'LearningHub',' Youtube', ' Channel')
select CONCAT(5,5)

+
select 'Sada' + 'LearningHub' + 'Youtube';
select 5+5;

DATALENGTH
select DATALENGTH('sadaissac')
select DATALENGTH('100')

LEFT
select LEFT('SQL SERVER Session',5)

LEN
select LEN('issac')

LOWER
select LOWER('SADALEARNINGHUB')

LTRIM
select LTRIM('   sada   nassub')

NCHAR
select NCHAR(65);

PATINDEX
select PATINDEX('%lear%','sadalearning');

REPLACE
select REPLACE('SadaLearningHub','a','issac');

RIGHT
select RIGHT('SadaLearningHub',4);
select LEFT('SadaLearningHub',4);

RTIRM
select RTRIM('  fbvj jsnv   ');
select LTRIM('  fbvj jsnv   ');


SPACE
select SPACE(10)

STR
select STR(123);

STUFF
select STUFF('SadaLearning',1,4,'issac')

UPPER
select UPPER('sadalearninghub');


--Numaric functions
ABS
select ABS(-243.5) as absnum

create table product (pid int, price int);
insert into product values(5,55);
select * from product;

avg
select AVG(price) as avgprice from product;

CEILING
select CEILING(25.45)

FLOOR
select FLOOR(25.45)

COUNT
select COUNT(price) from product;

MAX
select MAX(price) from product;

MIN
select MIN(price) from product;

RAND
select RAND()

ROUND
select ROUND(234.3455667778,2)

SIGN
select SIGN(-255.5)

SUM
select SUM(price) from product;

--Date functions
select CURRENT_TIMESTAMP

DATEADD
select DATEADD(year, 1, 1992/08/25)

DATEDIFF
select DATEDIFF(year, '2017/08/25','2011/08/25')

DATENAME
select DATENAME(MONTH, '2018/08/20')

DATEPART
select DATEPART(MONTH, '2018/08/20');

DAY
select DAY('2018/08/20');

GETDATE
select GETDATE();

GETUTDATE
select GETUTCDATE()

MONTH
select MONTH('2018/08/20');

YEAR
select YEAR('2018/08/20');


--conversion functions
CAST
select CAST(25.65 AS int);

select CAST('12' AS int);

select CAST(10 AS varchar);

CONVERT
select CONVERT(int,25.65);

--advanced functions:
COALESCE
select COALESCE(NULL,NULL,'sada','a',NULL);

CURRENT_USER
select CURRENT_USER;

ISDATE
select ISDATE('2018+08+20');

ISNULL
select ISNULL(NULL,'sada');
select ISNULL('issac','sada');

ISNUMERIC
select ISNUMERIC('-123dsvsd');

NULLIF
select NULLIF(25,30);
select NULLIF('sada','sada')

SESSION_USER
select SESSION_USER;

SESSIONPROPERTY
select SESSIONPROPERTY('ANSI_NULLS');

SYSTEM_USER
select SYSTEM_USER;

USER_NAME
select USER_NAME();


--variable
syntax : declare @variableName datatype[=initialvale];
		set @variableName = value;

declare @name varchar(20);
set @name='issac';
select @name;

declare @count int = 10
select @count
set @count = 15;
select @count

bulk insert [dbo].[emp]
from 'F:\Sada\SQL\emp.csv'
with (fieldterminator = ',', rowterminator = '\n')
go

select * from emp;

delete from emp;

--Constant
create function funconstant1() returns int
	as
	begin
		return 2;
	end

select dbo.funconstant1();

--if 
if condition
	statements
else
	statements

--simple if
declare @site_val int;
set @site_val = 15;
if @site_val < 25
	begin
		print 'sadalearninghub';
		print 'sada'
	end


--if else
declare @site_val int;
set @site_val = 15;
if @site_val < 25
	begin
		print 'sadalearninghub';
		print 'sada'
	end
else
	begin
		print 'Issac'
		print 'US'
	end

--Nested if
declare @count int;
declare @name varchar(10) ='Issac'
set @count = 15;
if @count < 10
	print 'sadalearninghub';
else
	begin
		if @count < 50
			print '@count is less than 50 '+ @name
		else
			print '@count is not less than 50'
		print 'This is main else block'
	end

--else if ladder
declare @a int = 5

if @a<1
	begin
		print '@a is less than 1'
		print 'Issac'
	end
else if @a<2
	print '@a is less than 2'
else if @a<4
	print '@a is less than 4',@a
else
	print '@a is not satisfing any conditions'

--case statement
case expression
	when value_1 then result_1
	when value_2 then result_2
	...
	when value_n then result_n
	else result

create table contacts (contact_id int, website_id int);
insert into contacts values(4, 4)
select * from contacts

drop table contacts;

select contact_id,website_id,case website_id
									when 1 then 'sada.com'
									when 2 then 'Issac.com'
							end
from contacts;

select contact_id,website_id,case
								when website_id = 1 then 'sada.com'
								when website_id = 2 then 'Issac.com'
							 end
from contacts;

select contact_id,website_id,case
								when contact_id < 0 then 'sada.com'
								when website_id = 2 then 'Issac.com'
								else 'else.com'
							 end
from contacts;

--while loop
while condition
	begin
		statements
	end;

--example
declare @count int;
set @count = 0;
while @count<=10
	begin
		print 'Inside while loop on sadalearninghub : '+str(@count);
		set @count = @count+1
	end;
print 'Done while loop on sadalearninghub'


--continue
declare @count int;
set @count=0;
while @count <=10
	begin
		if @count=2
			break
		else
			begin
				set @count=@count+1;
				print 'inside while loop on sadalearninghub : '+str(@count);
				continue;
			end
	end
print 'Done while loop on sadalearninghub'


--GOTO label_name
--label_name;
---{statements..}
declare @count int;
set @count=0;
label1:
	print 'goto statement' + STR(@count)
while @count<=10
begin
	if @count = 3
		begin
			set @count=@count+1;
			GOTO label1
		end
	else
		begin
			print 'In Side loop' +STR(@count)
			set @count=@count+1;
		end
	end

print 'End Program'


--procedure
create procedure <procedure_name> <params.. datatypes..> as
begin
	<statement>
end

create procedure findCountries1 @countryId [int], @countryName varchar(10)
as
begin
	set NOCOUNT ON;
	select CountryName, LatestRecordedPopulation from Countries where [CountryID]=@countryId and CountryName=@countryName;
end

declare @country table(CountryName varchar(10), LatestRecordedPopulation varchar(10));

insert @country(CountryName, LatestRecordedPopulation) execute findCountries1 2,'jk'

select * from @country

execute findCountries1 2,'jk'

=================================================

create procedure calarea3 @area float output, @hight float, @width float
as
begin
	begin try
		select @area = @hight/@width;
		if @area <=10
			return 20;
		else
			return 30;
	end try
	begin catch
		return 1;
	end catch

end

declare @a float;
execute calarea3 10,2,@a output
execute calarea3 @a output, 10, 2
select @a





create procedure calarea @hight float, @width float, @area float output
as
begin
	select @area = @hight/@width;
	print 'sada'
	print 'Issac'
end

##Functions

create procedure rocedure_name inputparameterlist datatypes, outputparameter datatype output
as
begin
 logic
end

create function function_name inputparameterlist datatypes return datatype
as
begin
	logic
	return value;
end


create function getonlydate1() returns datetime
as
begin
	return (select CONVERT(datetime, convert(date,getdate())))
end

select dbo.getonlydate1()

select * from orders;
update Orders set ShippedDate=dbo.getonlydate() where OrderID=1 
select OrderDate, RequiredDate, ShippedDate from Orders where OrderDate=dbo.getonlydate()

select * from titles;

create function AvgBookPrice1(@booktype varchar(10) = '%') returns money
as
begin
	declare @Avg money
	select @Avg = AVG(price) from titles where booktype = @booktype
	return @Avg
end

insert into titles values('a',10);

select dbo.AvgBookPrice1('a');
select price from titles where price < dbo.AvgBookPrice('a')
select AVG(price) from titles where booktype='a'
select * from titles;


select * from Employee1
-------
set nocount on
declare @id int
declare @name varchar(20)
declare @salary int
declare cur_emp cursor static for select EmpID, EMpName, Salary from Employee1
open cur_emp
if @@CURSOR_ROWS > 0
	begin
		fetch next from cur_emp into @id, @name, @salary
		while @@FETCH_STATUS = 0
		begin
			print 'ID : '+convert(varchar(20), @id)+ ', Name : '+@name+', salary : '+convert(varchar(20),@salary)
			fetch next from cur_emp into @id, @name,@salary
		end
	end
	close cur_emp
	deallocate cur_emp
	set nocount off

select * from Employee_Test;

create table Employee_Test(
Emp_ID int identity,
Emp_name varchar(20),
Emp_sal decimal(10,2)
)
insert  into Employee_Test values('BB',200);
create table Employee_Test_Audit(
Emp_ID int,
Emp_name varchar(20),
Emp_sal decimal(10,2),
Audit_Action varchar(20),
Audit_Timestamp datetime
)

select * from Employee_Test;
select * from Employee_Test_Audit

--After insert tigger
create trigger trgAfterInsert on [dbo].[Employee_Test] for insert
as
	declare @empid int;
	declare @empname varchar(20);
	declare @empsal decimal(10,2);
	declare @audit_action varchar(20);
	select @empid=i.Emp_ID from inserted i;
	select @empname=i.Emp_name from inserted i;
	select @empsal=i.Emp_sal from inserted i;
	select @audit_action='inserted';
	insert into Employee_Test_Audit(Emp_ID, Emp_name, Emp_sal, Audit_Action,Audit_Timestamp)values(@empid, @empname, @empsal, @audit_action, getdate());
	print 'After insert Trigger fired'

	--After update tigger
create trigger trgAfterupdate on [dbo].[Employee_Test] for update
as
	declare @empid int;
	declare @empname varchar(20);
	declare @empsal decimal(10,2);
	declare @audit_action varchar(20);
	select @empid=i.Emp_ID from inserted i;
	select @empname=i.Emp_name from inserted i;
	select @empsal=i.Emp_sal from inserted i;
	if update(Emp_name)
		set @audit_action='updateed name';
	if update(Emp_sal)
		set @audit_action='updated sal';

	insert into Employee_Test_Audit(Emp_ID, Emp_name, Emp_sal, Audit_Action,Audit_Timestamp)values(@empid, @empname, @empsal, @audit_action, getdate());
	print 'After update Trigger fired'

	select * from Employee_Test;
select * from Employee_Test_Audit
update Employee_Test set Emp_name='sada' where Emp_ID=6
delete from Employee_Test where Emp_ID=4;

--instead of trigger delete
create trigger tigetInsteadOfDelete on [dbo].[Employee_Test] instead of delete
as
	declare @emp_id int;
	declare @emp_name varchar(20);
	declare @emp_sal decimal(10,2);
	select @emp_id=d.Emp_ID from deleted d;
	select @emp_name=d.Emp_name from deleted d;
	select @emp_sal=d.Emp_sal from deleted d;
	begin
		if(@emp_sal>1200)
			begin
				raiserror('can not delete where salary >1200',16,1);
				rollback;
			end
		else
			begin
				delete from Employee_Test where Emp_ID=@emp_id;
				commit;
				insert into Employee_Test_Audit(Emp_ID, Emp_name, Emp_sal, Audit_Action, Audit_Timestamp) values(@emp_id, @emp_name, @emp_sal,'Instead delete', getdate());
				print 'record deleted'
			end
		end








