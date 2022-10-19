-- Zad1 TODO
CREATE OR REPLACE PROCEDURE NowyPracownik
(vName PRACOWNICY.NAZWISKO%TYPE,
 vTeam PRACOWNICY.ZESPOL%TYPE,
 vBoss PRACOWNICY.NAZWISKO%TYPE,
 vSalary PRACOWNICY.PLACA_POD%TYPE,
 vPosition PRACOWNICY.ETAT%TYPE DEFAULT 'STAZYSTA',
 vDate PRACOWNICY.ZATRUDNIONY%TYPE DEFAULT CURRENT_DATE) IS
DECLARE
 vID PRACOWNICY.ID_PRAC%TYPE;
 vBossID PRACOWNICY.ID_PRAC%TYPE;
 vTeamID ZESPOLY.ID_ZESP%TYPE;
BEGIN
 SELECT MAX(ID_PRAC)+10 INTO vID FROM PRACOWNICY;
 SELECT ID_PRAC FROM PRACOWNICY WHERE NAZWISKO=vBoss;
 SELECT ID_ZESP INTO vTeamID FROM ZESPOLY WHERE NAZWA=vTeam;
 INSERT INTO PRACOWNICY(ID_PRAC, NAZWISKO, ETAT, ID_SZEFA, ZATRUDNIONY, PLACA_POD, ID_ZESP) VALUES(vID, vName, vPosition, vBossID, vDate, vSalary, vTeamID);
END NowyPracownik;

INSERT INTO PRACOWNICY(NAZWISKO, ETAT, ID_SZEFA, ZATRUDNIONY, PLACA_POD, ID_ZESP) VALUES('CHORY','ASYSTENT',100,'02-12-09',500, 20);

--Zad2
CREATE OR REPLACE FUNCTION PlacaNetto(
    vSalary IN NUMBER,
    vTax IN NATURAL DEFAULT 20)
    RETURN NUMBER IS
BEGIN
    RETURN vSalary*((100-vTax)/100);
END PlacaNetto;

--Zad3
CREATE OR REPLACE FUNCTION Silnia(
    vN IN NUMBER)
    RETURN VARCHAR IS
    vTemp NUMBER := vN;
    vRes NUMBER := vN;
BEGIN
    IF vN < 0 THEN
        RETURN 'Error';
    ELSIF vN < 2 THEN
        RETURN 1;
    ELSE
        WHILE vTemp != 1 LOOP
            vTemp := vTemp - 1;
            vRes := vRes * vTemp;
        END LOOP;
        RETURN vRes;
    END IF;
END Silnia;

--Zad4
CREATE OR REPLACE FUNCTION SilniaRek(
    vN IN NUMBER)
    RETURN VARCHAR IS
BEGIN
    IF vN < 0 THEN
        RETURN 'Error';
    ELSIF vN < 2 THEN
        RETURN 1;
    ELSE
        RETURN vN*SilniaRek(vN-1);
    END IF;
END SilniaRek;

--Zad5
CREATE OR REPLACE FUNCTION IleLat(
    vDate IN DATE)
    RETURN NUMBER IS
BEGIN
    RETURN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM vDate);
END IleLat;

--Zad6
CREATE OR REPLACE PACKAGE Konwersja IS
    FUNCTION Cels_To_Fahr(Tc NUMBER)
        RETURN NUMBER;
    FUNCTION Fahr_To_Cels(Tf NUMBER)
        RETURN NUMBER;
END Konwersja;

CREATE OR REPLACE PACKAGE BODY Konwersja IS
    FUNCTION Cels_To_Fahr(Tc NUMBER) RETURN NUMBER IS
        BEGIN
            RETURN Tc*9/5+ 32;
        END Cels_To_Fahr;
    FUNCTION Fahr_To_Cels(Tf NUMBER) RETURN NUMBER IS
        BEGIN
            RETURN (Tf-32)*5/9;
        END Fahr_To_Cels;
END Konwersja;

--Zad7
CREATE OR REPLACE PACKAGE Zmienne IS
    vLicznik NUMBER := 0;
    PROCEDURE ZwiekszLicznik;
    PROCEDURE ZmniejszLicznik;
    FUNCTION PokazLicznik
        RETURN NATURAL;
END Zmienne;

CREATE OR REPLACE PACKAGE BODY Zmienne IS
    PROCEDURE ZwiekszLicznik IS
        BEGIN
            vLicznik := vLicznik +1;
            DBMS_OUTPUT.PUT_LINE('Zwiekszono');
        END ZwiekszLicznik;
    PROCEDURE ZmniejszLicznik IS
        BEGIN
            vLicznik := vLicznik - 1;
            DBMS_OUTPUT.PUT_LINE('Zmniejszono');
        END ZmniejszLicznik;
    FUNCTION PokazLicznik RETURN NATURAL IS
        BEGIN
            RETURN vLicznik;
        END PokazLicznik;
    BEGIN
        vLicznik := 1;
        DBMS_OUTPUT.PUT_LINE('Zainicjalizowano');
END Zmienne;

--Zad8
