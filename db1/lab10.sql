--1
ALTER TABLE PROJEKTY ADD(
    CONSTRAINT PK_PROJEKTY PRIMARY KEY(ID_PROJEKTU),
    CONSTRAINT UK_PROJEKTY UNIQUE(OPIS_PROJEKTU),
    CHECK(DATA_ZAKONCZENIA  > DATA_ROZPOCZECIA),
    CHECK(FUNDUSZ > 0)
);

ALTER TABLE PROJEKTY MODIFY (OPIS_PROJEKTU NOT NULL);

SELECT UC.CONSTRAINT_NAME, UC.CONSTRAINT_TYPE AS C_TYPE, UC.SEARCH_CONDITION, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC ON UC.TABLE_NAME = UCC.TABLE_NAME WHERE UCC.TABLE_NAME = 'PROJEKTY';

--2
INSERT INTO PROJEKTY (OPIS_PROJEKTU, DATA_ROZPOCZECIA, DATA_ZAKONCZENIA, FUNDUSZ)
    VALUES('Indeksy bitmapowe','2015-04-12','2016-09-30', 40000);
-- POLECENIE ZAKONCZYLO SIE NIEPOWODZENIEM ZE WZGLEDU NA PROBE NARUSZENIA OGRANICZENIA ZWIAZANEGO Z UNIKALNOSCIA ATRYBUTU O NAZWIE OPIS_PROJEKTU

--3
CREATE TABLE PRZYDZIALY(
    ID_PROJEKTU NUMBER(4) CONSTRAINT FK_PRZYDZIALY_01 REFERENCES PROJEKTY(ID_PROJEKTU) NOT NULL,
    NR_PRACOWNIKA NUMBER(6) CONSTRAINT FK_PRZYDZIALY_02 REFERENCES PRACOWNICY(ID_PRAC) NOT NULL,
    OD DATE DEFAULT CURRENT_DATE,
    DO DATE, CONSTRAINT CHK_PRZYDZIALY_DATY CHECK(OD < DO),
    STAWKA NUMBER(7,2), CONSTRAINT CHK_PRZYDZIALY_STAWKA CHECK(STAWKA>0),
    ROLA VARCHAR(20), CONSTRAINT CHK_PRZYDZIALY_ROLA CHECK(ROLA IN('ANALITYK', 'KIERUJĄCY', 'PROGRAMISTA')),
    CONSTRAINT PK_PRZYDZIALY PRIMARY KEY(ID_PROJEKTU, NR_PRACOWNIKA)
);

--4
INSERT INTO PRZYDZIALY (ID_PROJEKTU, NR_PRACOWNIKA, OD, DO, STAWKA, ROLA)
    VALUES((SELECT ID_PROJEKTU FROM PROJEKTY WHERE OPIS_PROJEKTU='Indeksy bitmapowe'),
    170, '1999-04-10','1999-05-10', 1000, 'KIERUJĄCY');

INSERT INTO PRZYDZIALY (ID_PROJEKTU, NR_PRACOWNIKA, OD, STAWKA, ROLA)
    VALUES((SELECT ID_PROJEKTU FROM PROJEKTY WHERE OPIS_PROJEKTU='Indeksy bitmapowe'),
    140, '2000-12-01', 1500, 'ANALITYK');

INSERT INTO PRZYDZIALY (ID_PROJEKTU, NR_PRACOWNIKA, OD, STAWKA, ROLA)
    VALUES((SELECT ID_PROJEKTU FROM PROJEKTY WHERE OPIS_PROJEKTU='Sieci kręgosłupowe'),
    140, '2015-09-14', 2500, 'KIERUJĄCY');

SELECT * FROM PRZYDZIALY;

--5
ALTER TABLE PRZYDZIALY ADD (GODZINY NUMBER(4) NOT NULL);
-- POLECENIE ZAKONCZYLO SIE NIEPOWODZENIEM ZE WZGLEDU NA PROBE DODANIA ATRYBUTU NIE MOGACEGO PRZYJMOWAC WARTOSCI NULL DO NIEPUSTEJ TABELI

--6
ALTER TABLE PRZYDZIALY ADD(GODZINY NUMBER(4));
UPDATE PRZYDZIALY SET GODZINY = 1000;
ALTER TABLE PRZYDZIALY MODIFY (GODZINY NOT NULL);

--7
ALTER TABLE PROJEKTY DISABLE CONSTRAINT UK_PROJEKTY;
SELECT CONSTRAINT_NAME, STATUS FROM USER_CONSTRAINTS WHERE CONSTRAINT_NAME = 'UK_PROJEKTY';

--8
INSERT INTO PROJEKTY(OPIS_PROJEKTU, DATA_ROZPOCZECIA, DATA_ZAKONCZENIA, FUNDUSZ)
    VALUES('Indeksy bitmapowe', '2015-04-12', '2016-09-30', 40000);
SELECT * FROM PROJEKTY;
-- POLECENIE ZAKONCZYLO SIE POWODZENIEM

--9
ALTER TABLE PROJEKTY ENABLE CONSTRAINT UK_PROJEKTY;
-- POLECENIE ZAKONCZYLO SIE NIEPOWODZENIEM - W RELACJI ZNALEZIONO ZDUPLIKOWANE KLUCZE

--10
UPDATE PROJEKTY SET OPIS_PROJEKTU='Inne indeksy' WHERE ID_PROJEKTU=5;
ALTER TABLE PROJEKTY ENABLE CONSTRAINT UK_PROJEKTY;
-- TYM RAZEM UDALO SIE WLACZYC OGRANICZENIE - BRAK ZDUPLIKOWANYCH KLUCZY

--11
ALTER TABLE PROJEKTY MODIFY(OPIS_PROJEKTU VARCHAR(10));
-- POLECENIE ZAKONCZYLO SIE NIEPOWODZENIEM PONIEWAZ NIEKTORE WARTOSCI REKORDOW W RELACJI SA DLUZSZE OD 10

--12
DELETE FROM PROJEKTY WHERE OPIS_PROJEKTU='Sieci kręgosłupowe';
-- POLECENIE ZAKONCZYLO SIE NIEPOWODZENIEM - ZNALEZIONO REKORD PODRZEDNY W RELACJI PRZYDZIALY

--13
ALTER TABLE PRZYDZIALY DROP CONSTRAINT FK_PRZYDZIALY_01;
ALTER TABLE PRZYDZIALY ADD CONSTRAINT FK_PRZYDZIALY_01 FOREIGN KEY(ID_PROJEKTU) REFERENCES PROJEKTY(ID_PROJEKTU) ON DELETE CASCADE;
DELETE FROM PROJEKTY WHERE OPIS_PROJEKTU='Sieci kręgosłupowe';
SELECT * FROM PROJEKTY;
SELECT * FROM PRZYDZIALY;

--14
DROP TABLE PROJEKTY CASCADE CONSTRAINTS;
SELECT CONSTRAINT_NAME, SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'PRZYDZIALY';

--15
DROP TABLE PROJEKTY_KOPIA;
DROP TABLE PRZYDZIALY CASCADE CONSTRAINTS;
SELECT TABLE_NAME FROM USER_TABLES;