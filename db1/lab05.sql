--1
SELECT P.NAZWISKO, ID_ZESP, Z.NAZWA FROM PRACOWNICY P LEFT JOIN ZESPOLY Z USING(ID_ZESP) ORDER BY P.NAZWISKO;

--2
SELECT Z.NAZWA, ID_ZESP, NVL(P.NAZWISKO,'BRAK PRACOWNIKÓW') AS PRACOWNIK FROM ZESPOLY Z LEFT JOIN PRACOWNICY P USING(ID_ZESP) ORDER BY Z.NAZWA, P.NAZWISKO;

--3
SELECT NVL(Z.NAZWA,'BRAK ZESPOŁU') AS ZESPOL, NVL(P.NAZWISKO, 'BRAK PRACOWNIKÓW') AS PRACOWNIK FROM ZESPOLY Z FULL JOIN PRACOWNICY P USING(ID_ZESP) ORDER BY Z.NAZWA, P.NAZWISKO;

--4
SELECT Z.NAZWA AS ZESPOL, COUNT(P.ID_PRAC) AS LICZBA, SUM(P.PLACA_POD) AS SUMA_PLAC FROM ZESPOLY Z FULL JOIN PRACOWNICY P USING(ID_ZESP) GROUP BY Z.NAZWA;

--5
SELECT Z.NAZWA FROM ZESPOLY Z FULL JOIN PRACOWNICY P USING(ID_ZESP) GROUP BY Z.NAZWA HAVING COUNT(P.ID_PRAC) = 0;

--6
SELECT P1.NAZWISKO AS PRACOWNIK, P1.ID_PRAC, P2.NAZWISKO AS SZEF, P2.ID_PRAC AS ID_SZEFA FROM PRACOWNICY P1 LEFT JOIN PRACOWNICY P2 ON P1.ID_SZEFA = P2.ID_PRAC ORDER BY PRACOWNIK;

--7
SELECT P2.NAZWISKO AS PRACOWNIK, COUNT(P1.ID_SZEFA) AS LICZBA_PODWLADNYCH FROM PRACOWNICY P1 RIGHT JOIN PRACOWNICY P2 ON P1.ID_SZEFA = P2.ID_PRAC GROUP BY P2.NAZWISKO ORDER BY PRACOWNIK;

--8
SELECT P1.NAZWISKO, P1.ETAT, P1.PLACA_POD, Z.NAZWA, P2.NAZWISKO AS SZEF FROM PRACOWNICY P1 LEFT JOIN ZESPOLY Z USING(ID_ZESP) LEFT JOIN PRACOWNICY P2 ON P1.ID_SZEFA = P2.ID_PRAC ORDER BY P1.NAZWISKO;

--9
SELECT P.NAZWISKO, Z.NAZWA FROM PRACOWNICY P CROSS JOIN ZESPOLY Z ORDER BY P.NAZWISKO;

--10
SELECT COUNT(*) FROM PRACOWNICY CROSS JOIN ETATY CROSS JOIN ZESPOLY;

--11
SELECT E.NAZWA FROM ETATY E JOIN PRACOWNICY P ON E.NAZWA = P.ETAT WHERE TO_CHAR(P.ZATRUDNIONY,'YYYY') = 1993
INTERSECT
SELECT E.NAZWA FROM ETATY E JOIN PRACOWNICY P ON E.NAZWA = P.ETAT WHERE TO_CHAR(P.ZATRUDNIONY,'YYYY') = 1992 ORDER BY NAZWA;

--12
SELECT Z.ID_ZESP FROM ZESPOLY Z LEFT JOIN PRACOWNICY P ON Z.ID_ZESP = P.ID_ZESP GROUP BY Z.ID_ZESP HAVING COUNT(P.ID_ZESP) = 0;

--13 WYPADALOBY ZROBIC INACZEJ
SELECT ID_ZESP, NAZWA FROM ZESPOLY WHERE ID_ZESP=(SELECT Z.ID_ZESP FROM ZESPOLY Z LEFT JOIN PRACOWNICY P ON Z.ID_ZESP = P.ID_ZESP GROUP BY Z.ID_ZESP HAVING COUNT(P.ID_ZESP) = 0);

--14
SELECT NAZWISKO, PLACA_POD, 'PONIŻEJ 480 ZŁOTYCH' AS PROG FROM PRACOWNICY WHERE PLACA_POD < 480
UNION
SELECT NAZWISKO, PLACA_POD, 'DOKŁADNIE 480 ZŁOTYCH' AS PROG FROM PRACOWNICY WHERE PLACA_POD = 480
UNION
SELECT NAZWISKO, PLACA_POD, 'POWYŻEJ 480 ZŁOTYCH' AS PROG FROM PRACOWNICY WHERE PLACA_POD > 480;