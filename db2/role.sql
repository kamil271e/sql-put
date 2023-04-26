--ZAD1
select * from inf148327.pracownicy;

--ZAD2
grant select on pracownicy to inf148327;

--ZAD3
select * from inf148327.pracownicy;

--ZAD4
grant update (placa_pod, placa_dod) on pracownicy to inf148327;
-- REVOKE update (placa_pod, placa_dod) from pracownicy to inf148327;

--ZAD5
-- update inf1..pracownicy set placa_pod = 700

--ZAD6
-- create synonym syn for inf148..pracownicy
-- UPDATE
-- commit

--ZAD7
select * from pracownicy;

--ZAD8
select owner, table_name, grantee, grantor, privilege
from user_tab_privs;
select role, owner, table_name, column_name, privilege
from role_tab_privs

--ZAD9
revoke UPDATE (placa_pod, placa_dod) on pracownicy from inf148327;
revoke SELECT on pracownicy from inf148327;

--ZAD10
create role rola_148327 identified by "ziemniak7";

--ZAD11
grant select, update on pracownicy to rola_148327;
grant rola_148327 to inf148327;

--ZAD12
--ZAD13
REVOKE rola_148327 FROM inf148327;

--ZAD14
--ZAD15
UPDATE inf14827.pracownicy set placa_pod = 700;

--ZAD16
--ZAD17
--ZAD18
--ZAD19
DROP ROLE rola_148327;
REVOKE SELECT ON pracownicy from inf148327;

--ZAD20
grant select on pracownicy to inf148327 with grant option;

--ZAD21
--ZAD22
-- owner (A), grantor (B), grantee(C)
-- A nie moze odebrac uprawnien C

--ZAD23
create or replace view prac20 (nazwisko, placa_pod) as
select nazwisko, placa_pod from pracownicy where id_zesp=20;

grant select, update on prac20 to inf148327;

--ZAD24
create or replace function funLiczEtaty return number authid current_user is
vrekordy number;
begin
    select count(*) into vrekordy from inf148121.prac20; -- bez 148121 nie dziala dla authid
    return vrekordy;
end funLiczEtaty;
--revoke execute on funLiczEtaty from inf148327;
grant execute on funLiczEtaty to inf148327;

--ZAD25
--ZAD26
--^24
--ZAD27
--ZAD28
insert into etaty(placa_max, placa_min, nazwa) values(2000,1000,'WYKLADOWCA');
commit;

--ZAD29
--ZAD30

--select funLiczEtaty from dual;

--exec inf148327.procPokazTest;
--select * from inf148327.test;

--select text from all_source order by line;
--cos z synonimem
