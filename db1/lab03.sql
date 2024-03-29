--1
SELECT MIN(PLACA_POD) AS MINIMUM, MAX(PLACA_POD) AS MAKSIMUM, MAX(PLACA_POD)-MIN(PLACA_POD) AS RÓŻNICA FROM PRACOWNICY;

--2
SELECT ETAT, AVG(PLACA_POD) AS ŚREDNIA FROM PRACOWNICY GROUP BY ETAT ORDER BY ŚREDNIA DESC;

--3
SELECT COUNT(*) AS PROFESOROWIE FROM PRACOWNICY WHERE ETAT='PROFESOR';

--4
SELECT ID_ZESP, SUM(PLACA_POD) + SUM(PLACA_DOD) AS SUMARYCZNE_PLACE FROM PRACOWNICY GROUP BY ID_ZESP ORDER BY ID_ZESP;

--5  DA SIE JAKOS INACZEJ?
SELECT MAX(PLACA) AS MAKS_SUM_PLACA FROM (SELECT ID_ZESP, SUM(PLACA_POD) + SUM(PLACA_DOD) AS PLACA FROM PRACOWNICY GROUP BY ID_ZESP); 

--6
SELECT ID_SZEFA, MIN(PLACA_POD) AS MINIMALNA FROM PRACOWNICY WHERE ID_SZEFA IS NOT NULL GROUP BY ID_SZEFA ORDER BY MINIMALNA;

--7
SELECT COUNT(*) AS ILU_PRACUJE FROM PRACOWNICY GROUP BY ID_ZESP ORDER BY ILU_PRACUJE;

--8
SELECT COUNT(*) AS ILU_PRACUJE FROM PRACOWNICY GROUP BY ID_ZESP HAVING COUNT(*) > 3 ORDER BY ILU_PRACUJE;

--9
SELECT COUNT(*) FROM PRACOWNICY GROUP BY ID_PRAC HAVING COUNT(*) > 1;

--10
SELECT ETAT, AVG(PLACA_POD) AS ŚREDNIA, COUNT(*) AS LICZBA FROM PRACOWNICY WHERE ZATRUDNIONY < DATE '1990-01-01' GROUP BY ETAT;

--11  NA PEWNO MOZNA LEPIEJ
SELECT ID_ZESP, ETAT, ROUND(AVG(PLACA_POD + NVL(PLACA_DOD,0))) AS ŚREDNIA, ROUND(MAX(PLACA_POD + NVL(PLACA_DOD,0))) AS MAKSYMALNA FROM PRACOWNICY WHERE ETAT='ASYSTENT' OR ETAT='PROFESOR' GROUP BY ID_ZESP, ETAT ORDER BY ID_ZESP, ETAT;

--12
SELECT TO_CHAR(ZATRUDNIONY,'YYYY') AS ROK, COUNT(*) AS ILU_PRACOWNIKOW FROM PRACOWNICY GROUP BY TO_CHAR(ZATRUDNIONY,'YYYY') ORDER BY ROK;

--13
SELECT LENGTH(NAZWISKO) AS "ILE LITER", COUNT(*) AS "W ILU NAZWISKACH" FROM PRACOWNICY GROUP BY LENGTH(NAZWISKO) ORDER BY "ILE LITER" ASC;

--14
SELECT COUNT(*) AS "Ile nazwisk z A" FROM PRACOWNICY WHERE NAZWISKO LIKE '%A%';

--15
SELECT DISTINCT (SELECT COUNT(*) FROM PRACOWNICY WHERE NAZWISKO LIKE '%A%') AS "Ile nazwisk z A", (SELECT COUNT(*) FROM PRACOWNICY WHERE NAZWISKO LIKE '%E%') AS "Ile nazwisk z B" FROM  PRACOWNICY

--16
SELECT ID_ZESP, SUM(PLACA_POD) AS "Suma plac", LISTAGG(NAZWISKO || ':' || PLACA_POD,';')  AS PRACOWNICY FROM PRACOWNICY GROUP BY ID_ZESP ORDER BY ID_ZESP;
