-- 1
SELECT * FROM ZESPOLY;

--2
SELECT * FROM PRACOWNICY ORDER BY ID_PRAC ASC;

--3
SELECT nazwisko, placa_pod * 12 AS roczna_placa FROM PRACOWNICY ORDER BY nazwisko ASC;

--4
SELECT nazwisko, etat, placa_pod+NVL(placa_dod, 0) AS miesieczne_zarobki FROM PRACOWNICY ORDER BY miesieczne_zarobki DESC;

--5
SELECT * FROM zespoly ORDER BY nazwa ASC;

--6
SELECT DISTINCT etat FROM pracownicy ORDER BY etat ASC;

--7
SELECT * FROM PRACOWNICY WHERE ETAT='ASYSTENT' ORDER BY nazwisko;

--8
SELECT id_prac, nazwisko, etat, placa_pod, id_zesp FROM PRACOWNICY WHERE ID_ZESP=30 or ID_ZESP=40 ORDER BY placa_pod DESC;

--9
SELECT nazwisko, id_zesp, placa_pod FROM PRACOWNICY WHERE placa_pod BETWEEN 300 AND 800 ORDER BY nazwisko;

--10
SELECT nazwisko, etat, id_zesp FROM PRACOWNICY WHERE nazwisko LIKE '%SKI' ORDER BY nazwisko;

--11
SELECT id_prac, id_szefa, nazwisko, placa_pod FROM PRACOWNICY WHERE PLACA_POD > 1000 AND ID_SZEFA IS NOT NULL;

--12
SELECT nazwisko, id_zesp FROM PRACOWNICY WHERE ID_ZESP=20 AND NAZWISKO LIKE 'M%' OR NAZWISKO LIKE '%SKI' ORDER BY nazwisko;

--13
SELECT nazwisko, etat, (placa_pod / (20 * 8)) AS stawka FROM PRACOWNICY WHERE (placa_pod NOT BETWEEN 400 AND 800) AND ETAT <> 'STAZYSTA' AND ETAT <> 'ADIUNKT' AND ETAT <> 'ASYSTENT' ORDER BY stawka;

--14
SELECT nazwisko, etat, placa_pod, placa_dod FROM PRACOWNICY WHERE placa_pod + NVL(placa_dod, 0) > 1000 ORDER BY etat, nazwisko;

--15
SELECT nazwisko||' pracuje od '||zatrudniony||' i zarabia '||placa_pod AS profesorowie from PRACOWNICY WHERE ETAT='PROFESOR' ORDER BY placa_pod desc;
