-- Zad samodzielne 1

--1
SELECT *
FROM TABLE(dbms_xplan.display(statement_id => 'zap_2_inf148121'));

--2
SELECT *
FROM TABLE(dbms_xplan.display(
statement_id => 'zap_2_inf148121',
format => 'ALL'));

--3
explain plan
SET STATEMENT_ID = 'zap_1_inf148121' FOR
Select etat, count(etat) from opt_pracownicy group by etat;

SELECT * FROM TABLE(dbms_xplan.display(statement_id => 'zap_1_inf148121',format=>'ALL'));

----------------------------------------------------------------------------------------------------

-- Zad samodzielne 2

--1
select /* z1_148121 */ * from (select nazwisko from opt_pracownicy order by placa desc) where rownum=1;

select /* z2_148121 */ plec, count(plec), avg(placa) from OPT_PRACOWNICY group by plec;


--2
SELECT sql_id
FROM v$sql
WHERE sql_text LIKE '%z1_148121%'
AND sql_text NOT LIKE '%v$sql%';
--3dnf8jd1hwhvy

SELECT sql_id
FROM v$sql
WHERE sql_text LIKE '%z2_148121%'
AND sql_text NOT LIKE '%v$sql%';
-- 54zk5stuwh7xb

--3
SELECT * FROM TABLE(dbms_xplan.display_cursor(sql_id => '3dnf8jd1hwhvy'));
SELECT * FROM TABLE(dbms_xplan.display_cursor(sql_id => '3dnf8jd1hwhvy', format=>'BASIC'));
SELECT * FROM TABLE(dbms_xplan.display_cursor(sql_id => '3dnf8jd1hwhvy', format=>'ALL'));
SELECT * FROM TABLE(dbms_xplan.display_cursor(sql_id => '3dnf8jd1hwhvy', format=>'ALLSTATS LAST'));
SELECT * FROM TABLE(dbms_xplan.display_cursor(sql_id => '3dnf8jd1hwhvy', format=>'IOSTATS ALL LAST'));

-- dodatkowo format => 'ALL -ALIAS', format => 'BASIC +ROWS +BYTES +PREDICATE', format=>'BASIC +ROWS +BYTES'

SELECT * FROM TABLE(dbms_xplan.display_cursor(sql_id => '54zk5stuwh7xb'));

--4
insert /* i1_148121 */ into opt_pracownicy (id_prac, nazwisko) values (11111,'1111');
delete /* d1_148121 */ from opt_pracownicy where id_prac=11111;

--5
commit;

--6
SELECT sql_id
FROM v$sql
WHERE sql_text LIKE '%i1_148121%'
AND sql_text NOT LIKE '%v$sql%';
-- f457mmqh7dqd5
SELECT * FROM TABLE(dbms_xplan.display_cursor(sql_id => 'f457mmqh7dqd5'));

SELECT sql_id
FROM v$sql
WHERE sql_text LIKE '%d1_148121%'
AND sql_text NOT LIKE '%v$sql%';
-- 1g8qywr0ptpba
SELECT * FROM TABLE(dbms_xplan.display_cursor(sql_id => '1g8qywr0ptpba'));


