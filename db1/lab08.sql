--1
SELECT NAZWISKO, PLACA_POD FROM PRACOWNICY ORDER BY PLACA_POD DESC FETCH FIRST 3 ROWS ONLY;
SELECT * FROM (SELECT NAZWISKO, PLACA_POD FROM PRACOWNICY ORDER BY PLACA_POD DESC) WHERE ROWNUM <= 3;

--2
SELECT NAZWISKO, PLACA_POD FROM PRACOWNICY ORDER BY PLACA_POD DESC OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;
SELECT NAZWISKO, PLACA_POD FROM
    (SELECT NAZWISKO, PLACA_POD FROM PRACOWNICY ORDER BY PLACA_POD DESC)
WHERE NAZWISKO NOT IN
    (SELECT NAZWISKO FROM
    (SELECT NAZWISKO, PLACA_POD FROM PRACOWNICY ORDER BY PLACA_POD DESC) WHERE ROWNUM <= 5)
AND ROWNUM <= 5;

--3
WITH ZESP (ID_ZESP, SREDNIA) AS (SELECT ID_ZESP, AVG(PLACA_POD) AS SREDNIA FROM
 PRACOWNICY GROUP BY ID_ZESP)
SELECT NAZWISKO, PLACA_POD, PLACA_POD-SREDNIA AS ROZNICA FROM PRACOWNICY P
 JOIN ZESP Z USING(ID_ZESP) WHERE PLACA_POD-SREDNIA > 0;

--4
WITH LATA AS (SELECT TO_CHAR(ZATRUDNIONY,'YYYY') AS ROK, COUNT(*) AS LICZBA FROM PRACOWNICY GROUP BY TO_CHAR(ZATRUDNIONY,'YYYY')) SELECT * FROM LATA ORDER BY LICZBA DESC;

--5
WITH LATA AS (SELECT TO_CHAR(ZATRUDNIONY,'YYYY') AS ROK, COUNT(*) AS LICZBA FROM PRACOWNICY GROUP BY TO_CHAR(ZATRUDNIONY,'YYYY') ORDER BY LICZBA DESC) SELECT * FROM LATA FETCH FIRST 1 ROWS ONLY;

--6
WITH ASYSTENCI(NAZWISKO, ETAT, ID_ZESP) AS (SELECT NAZWISKO, ETAT, ID_ZESP FROM PRACOWNICY P WHERE ETAT='ASYSTENT'),
PIOTROWO(ID_ZESP, NAZWA, ADRES) AS (SELECT ID_ZESP, NAZWA, ADRES FROM ZESPOLY WHERE ADRES LIKE '%PIOTROWO%')
SELECT NAZWISKO, ETAT, NAZWA, ADRES FROM ASYSTENCI A JOIN PIOTROWO P USING(ID_ZESP);

--7
WITH ZESP(NAZWA, SUMA_PLAC) AS (SELECT Z.NAZWA, X.SUMA_PLAC FROM ZESPOLY Z JOIN (SELECT ID_ZESP, SUM(PLACA_POD) AS SUMA_PLAC FROM PRACOWNICY GROUP BY ID_ZESP ORDER BY SUMA_PLAC DESC) X USING(ID_ZESP))
SELECT * FROM ZESP FETCH FIRST 1 ROWS ONLY;

--8
WITH PODWLADNI(ID_PRAC, ID_SZEFA, NAZWISKO, POZIOM) AS
(SELECT ID_PRAC, ID_SZEFA, NAZWISKO, 1 FROM PRACOWNICY WHERE NAZWISKO='BRZEZINSKI'
UNION ALL SELECT P.ID_PRAC, P.ID_SZEFA, P.NAZWISKO, POZIOM+1
FROM PODWLADNI S JOIN PRACOWNICY P ON S.ID_PRAC = P.ID_SZEFA)
SEARCH DEPTH FIRST BY NAZWISKO SET PORZADEK_POTOMKOW
SELECT NAZWISKO, POZIOM AS POZYCJA_W_HIERARCHII FROM PODWLADNI
ORDER BY PORZADEK_POTOMKOW;

SELECT NAZWISKO, LEVEL AS POZIOM FROM PRACOWNICY
CONNECT BY ID_SZEFA = PRIOR ID_PRAC
START WITH NAZWISKO = 'BRZEZINSKI'
ORDER SIBLINGS BY NAZWISKO;

--9
SELECT LPAD(NAZWISKO, LENGTH(NAZWISKO)+LEVEL-1, ' ') AS "NAZWISKO ", LEVEL AS POZIOM FROM PRACOWNICY
CONNECT BY ID_SZEFA = PRIOR ID_PRAC
START WITH NAZWISKO = 'BRZEZINSKI'
ORDER SIBLINGS BY NAZWISKO;

WITH PODWLADNI(ID_PRAC, ID_SZEFA, NAZWISKO, POZIOM) AS
(SELECT ID_PRAC, ID_SZEFA, NAZWISKO, 1 FROM PRACOWNICY WHERE NAZWISKO='BRZEZINSKI'
UNION ALL SELECT P.ID_PRAC, P.ID_SZEFA, P.NAZWISKO, POZIOM+1
FROM PODWLADNI S JOIN PRACOWNICY P ON S.ID_PRAC = P.ID_SZEFA)
SEARCH DEPTH FIRST BY NAZWISKO SET PORZADEK_POTOMKOW
SELECT LPAD(NAZWISKO, LENGTH(NAZWISKO)+POZIOM-1, ' ') AS "NAZWISKO ", POZIOM AS POZYCJA_W_HIERARCHII FROM PODWLADNI
ORDER BY PORZADEK_POTOMKOW;