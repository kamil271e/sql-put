--SET SERVEROUTPUT ON

--Zad1
DECLARE
    CURSOR cDane IS
        SELECT NAZWISKO, ZATRUDNIONY
        FROM PRACOWNICY WHERE ETAT='ASYSTENT';
    --vPracownik cDane%ROWTYPE;
    vNazwisko Pracownicy.nazwisko%TYPE;
    vZatrudnienie Pracownicy.zatrudniony%TYPE;
BEGIN
    OPEN cDane;
    LOOP
        FETCH cDane INTO vNazwisko, vZatrudnienie;
        EXIT WHEN cDane%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(vNazwisko || ' pracuje od ' || TO_CHAR(vZatrudnienie, 'dd-mm-yyyy'));
    END LOOP;
    CLOSE cDane;
END;

--Zad2
DECLARE
    CURSOR cNajZarobki IS
        SELECT NAZWISKO
        FROM PRACOWNICY ORDER BY PLACA_POD DESC;
    vNazwisko Pracownicy.nazwisko%TYPE;
BEGIN
    OPEN cNajZarobki;
    LOOP
        FETCH cNajZarobki INTO vNazwisko;
        EXIT WHEN cNajZarobki%ROWCOUNT > 3;
        DBMS_OUTPUT.PUT_LINE(cNajZarobki%ROWCOUNT || ' : ' || vNazwisko);
    END LOOP;
    CLOSE cNajZarobki;
END;

--Zad3
DECLARE
    CURSOR cPodwyzka IS
        SELECT NAZWISKO, PLACA_POD FROM PRACOWNICY
        WHERE TO_CHAR(ZATRUDNIONY, 'D') = 2 FOR UPDATE;
BEGIN
    FOR vPracownik IN cPodwyzka LOOP
        UPDATE PRACOWNICY SET PLACA_POD = PLACA_POD * 1.2
        WHERE CURRENT OF cPodwyzka;
    END LOOP;
END;

--Zad4
DECLARE
    CURSOR cMod IS
        SELECT NAZWISKO, PLACA_POD, PLACA_DOD, ID_ZESP FROM PRACOWNICY;
BEGIN
    vAlgo .ID_ZESP%TYPE;
    vAdm
    FOR vPracownik IN cMod LOOP
        IF vPracownik.ID_ZESP =
        (SELECT ID_ZESP FROM ZESPOLY WHERE NAZWA='ALGORYTMY') THEN
            UPDATE PRACOWNICY SET PLACA_DOD = NVL(PLACA_DOD,0)+100
            WHERE CURRENT OF cMod;
        ELSIF vPracownik.ID_ZESP =
        (SELECT ID_ZESP FROM ZESPOLY WHERE NAZWA='ADMINISTRACJA') THEN
            UPDATE PRACOWNICY SET PLACA_DOD = NVL(PLACA_DOD,0)+150
            WHERE CURRENT OF cMod;
        ELSE
            UPDATE PRACOWNICY SET ID_ZESP = NULL WHERE ETAT='STAŻYSTA' ;
        END IF;
    END LOOP;
END;
