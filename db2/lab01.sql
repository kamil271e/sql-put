--ZAD1
--SET SERVEROUTPUT ON
DECLARE
 vTekst VARCHAR(40) := 'Witaj, świecie!';
 vLiczba NUMBER(7,3) := 1000.456;
BEGIN
 DBMS_OUTPUT.PUT_LINE('Zmienna vTekst: ' || vTekst);
 --DBMS_OUTPUT.NEW_LINE;
 DBMS_OUTPUT.PUT_LINE('Zmienna vLiczba: ' || vLiczba);
END;

--ZAD2
DECLARE
 vTekst VARCHAR(40) := 'Witaj, świecie!';
 vLiczba NUMBER := 1000.456;
BEGIN
 vTekst := CONCAT(vTekst, ' Witaj, nowy dniu!');
 vLiczba := vLiczba + POWER(10,15);
 DBMS_OUTPUT.PUT_LINE('Zmienna vTekst: ' || vTekst);
 DBMS_OUTPUT.PUT_LINE('Zmienna vLiczba: ' || vLiczba);
END;

--ZAD3
DECLARE
 v1 NUMBER := 10.2356000;
 v2 NUMBER := 0.0000001;
 v3 NUMBER;
BEGIN
    v3 := v1 + v2;
    DBMS_OUTPUT.PUT_LINE('Wynik dodawania ' || v1 || ' i ' || v2 || ' : ' || v3);
END;

--ZAD4
DECLARE
 cPi CONSTANT NUMBER(7,2) := 3.14;
 vR NUMBER(7,2);
 vL NUMBER(7,2);
 vP NUMBER(7,2);
BEGIN
 vR := 5;
 vL := 2*cPi*vR;
 vP := cPi*POWER(vR,2);
 DBMS_OUTPUT.PUT_LINE('Obwód koła o promieniu równym ' || vR || ': ' || vL);
 DBMS_OUTPUT.PUT_LINE('Pole koła o promieniu równym ' || vR || ': ' || vP);
END;

--ZAD5
DECLARE
 vNazwisko Pracownicy.nazwisko%TYPE;
 vEtat Pracownicy.etat%TYPE;
BEGIN
 SELECT nazwisko, etat
 INTO vNazwisko, vEtat
 FROM pracownicy
 WHERE placa_pod = (SELECT MAX(placa_pod) FROM Pracownicy) AND ROWNUM = 1;

 DBMS_OUTPUT.PUT_LINE('Najlepiej zarabia pracownik ' || vNazwisko);
 DBMS_OUTPUT.PUT_LINE('Pracuje on jako ' || vEtat);
END;

--ZAD6
DECLARE
 vPracownik Pracownicy%ROWTYPE;
BEGIN
 SELECT *
 INTO vPracownik
 FROM pracownicy
 WHERE placa_pod = (SELECT MAX(placa_pod) FROM Pracownicy) AND ROWNUM = 1;

 DBMS_OUTPUT.PUT_LINE('Najlepiej zarabia pracownik ' || vPracownik.nazwisko);
 DBMS_OUTPUT.PUT_LINE('Pracuje on jako ' || vPracownik.etat);
END;

--ZAD7
DECLARE
 SUBTYPE tPieniadze IS NUMBER(7,2);
 vZarobki tPieniadze;
BEGIN
 select placa_pod*12 + NVL(placa_dod,0)*12
 into vZarobki
 from pracownicy
 where nazwisko = 'SLOWINSKI';

 DBMS_OUTPUT.PUT_LINE('Pracownik SLOWINSKI zarabia rocznie ' || vZarobki);
END;

--ZAD8
DECLARE
 vSeconds VARCHAR(2) := TO_CHAR(current_date, 'ss');
BEGIN
    WHILE vSeconds != '25' LOOP
        DBMS_SESSION.SLEEP(1);
        vSeconds := TO_CHAR(current_date, 'ss');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Nadeszła ' || vSeconds || ' sekunda!');
END;

--ZAD9
DECLARE
 v0 NATURAL := 10;
 vN NATURAL := v0;
BEGIN
 FOR vIndeks IN 2..(v0-1) LOOP
    vN := vN * vIndeks;
 END LOOP;

 DBMS_OUTPUT.PUT_LINE('Silnia dla n=' || v0 || ': ' || vN);
END;

--ZAD10
DECLARE
 vStart DATE := TO_DATE('01-01-2001', 'dd.mm.yyyy');
 vStop DATE := TO_DATE('31-12-2100', 'dd.mm.yyyy');

BEGIN
 WHILE TO_CHAR(vStart,'D') != '5' LOOP
    vStart := vStart + 1;
 END LOOP;

 WHILE vStart < vStop LOOP
    IF TO_CHAR(vStart,'D') = '5'
    AND TO_CHAR(vStart,'dd') = '13' THEN
     DBMS_OUTPUT.PUT_LINE(TO_CHAR(vStart, 'dd-mm-yyyy'));
    END IF;
    vStart := vStart + 7;
 END LOOP;
END;
