-- 1
SELECT NAZWISKO, (SUBSTR(ETAT, 1, 2) || ID_PRAC) AS KOD FROM PRACOWNICY;

-- 2
SELECT NAZWISKO, (REGEXP_REPLACE(NAZWISKO,'K|L|M','X')) AS WOJNA_LITEROM FROM PRACOWNICY;

-- 3
SELECT NAZWISKO FROM PRACOWNICY WHERE INSTR(LOWER(SUBSTR(NAZWISKO, 0, LENGTH(NAZWISKO)/2)), 'l') > 0;

-- 4
SELECT NAZWISKO, ROUND(PLACA_POD * 1.15) AS PODWYZKA FROM PRACOWNICY;

-- 5
SELECT NAZWISKO, PLACA_POD, 0.2 * PLACA_POD AS INWESTYCJA, 0.2 * PLACA_POD * POWER(1.1, 10) AS KAPITAŁ, 0.2 * PLACA_POD * (POWER(1.1, 10) - 1) AS ZYSK FROM PRACOWNICY;

-- 6
SELECT NAZWISKO, TO_CHAR(ZATRUDNIONY, 'yy/mm/dd') ZATRUDNIONY, FLOOR((DATE '2000-01-01' - ZATRUDNIONY)/365) AS STAZ_W_2000 FROM PRACOWNICY;

-- 7
SELECT NAZWISKO, TO_CHAR(ZATRUDNIONY,'Month, MM YYYY') AS DATA_ZATRUDNIENIA FROM PRACOWNICY WHERE ID_ZESP = 20;

-- 8
SELECT TO_CHAR(CURRENT_DATE,'Day') AS DZIS FROM Dual;

-- 9
SELECT NAZWA, ADRES,
CASE
    WHEN ADRES LIKE 'MIELZYNSKIEGO%' OR ADRES LIKE 'STRZELECKA%' THEN 'STARE MIASTO'
    WHEN ADRES LIKE 'PIOTROWO%' THEN 'NOWE MIASTO'
    WHEN ADRES LIKE 'WLODKOWICA%' THEN 'GRUNWALD'
    ELSE '-'
END AS DZIELNICA
FROM ZESPOLY;

-- 10
SELECT NAZWISKO, PLACA_POD,
CASE
    WHEN PLACA_POD < 480 THEN 'Poniżej '
    WHEN PLACA_POD > 480 THEN 'Powyżej '
    ELSE 'Dokładnie '
END || '480' AS PRÓG
FROM PRACOWNICY ORDER BY PLACA_POD DESC;

-- 11
SELECT NAZWISKO, PLACA_POD,
    DECODE(sign(480-PLACA_POD),
    -1, 'Powyżej ',
    1, 'Poniżej ',
    'Dokładnie ' ) || '480' AS PRÓG
FROM PRACOWNICY ORDER BY PLACA_POD DESC;
