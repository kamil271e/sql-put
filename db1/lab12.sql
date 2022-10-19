--1
CREATE VIEW ASYSTENCI (NAZWISKO, PLACA, STAZ) AS
SELECT NAZWISKO, PLACA_POD+NVL(PLACA_DOD, 0) AS PLACA,
EXTRACT(YEAR FROM(TO_DATE('2022-01-01','YYYY-MM-DD') - ZATRUDNIONY) YEAR TO MONTH) AS STAZ
FROM PRACOWNICY WHERE ETAT = 'ASYSTENT';

--2
CREATE VIEW PLACE AS
SELECT ID_ZESP, AVG(PLACA_POD + NVL(PLACA_DOD, 0)) AS SREDNIA,
MIN(PLACA_POD + NVL(PLACA_DOD,0)) AS MINIMUM,
MAX(PLACA_POD + NVL(PLACA_DOD,0)) AS MAXIMUM,
SUM(PLACA_POD + NVL(PLACA_DOD,0)) AS FUNDUSZ,
COUNT(PLACA_POD) AS L_PENSJI, COUNT(PLACA_DOD) AS L_DODATKOW
FROM PRACOWNICY GROUP BY ID_ZESP ORDER BY ID_ZESP;

--3
SELECT PR.NAZWISKO, PR.PLACA_POD FROM PRACOWNICY PR JOIN PLACE PL USING(ID_ZESP)
WHERE (PR.PLACA_POD+NVL(PR.PLACA_DOD,0)) < PL.SREDNIA;

--4
CREATE VIEW PLACE_MINIMALNE AS
SELECT ID_PRAC, NAZWISKO, ETAT, PLACA_POD FROM PRACOWNICY WHERE PLACA_POD < 700
WITH CHECK OPTION CONSTRAINT POWYZEJ_700;

--5
UPDATE PLACE_MINIMALNE SET PLACA_POD = 800 WHERE NAZWISKO='HAPKE';

--6
CREATE VIEW PRAC_SZEF AS
SELECT P1.ID_PRAC, P1.ID_SZEFA, P1.NAZWISKO AS PRACOWNIK, P1.ETAT, P2.NAZWISKO AS SZEF
FROM PRACOWNICY P1 LEFT JOIN PRACOWNICY P2 ON P1.ID_SZEFA = P2.ID_PRAC;

--7
CREATE VIEW ZAROBKI (ID_PRAC, NAZWISKO, ETAT, PLACA_POD) AS
SELECT P1.ID_PRAC, P1.NAZWISKO, P1.ETAT, P1.PLACA_POD FROM PRACOWNICY P1 LEFT JOIN PRACOWNICY P2 ON P1.ID_SZEFA = P2.ID_PRAC WHERE P1.PLACA_POD < P2.PLACA_POD
WITH CHECK OPTION CONSTRAINT WIECEJ_NIZ_SZEF;

--8
SELECT COLUMN_NAME, UPDATABLE, INSERTABLE, DELETABLE FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME = 'PRAC_SZEF';
