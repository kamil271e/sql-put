-- statystyki dla optymalizatora:
BEGIN
DBMS_STATS.GATHER_TABLE_STATS(ownname => 'inf148121',
tabname => 'OPT_PRACOWNICY_148121');
DBMS_STATS.GATHER_TABLE_STATS(ownname => 'inf148121',
tabname => 'OPT_ZESPOLY_148121');
DBMS_STATS.GATHER_TABLE_STATS(ownname => 'inf148121',
tabname => 'OPT_ETATY_148121');
END;

SELECT index_name, index_type
FROM user_indexes
WHERE table_name = 'OPT_PRACOWNICY_148121';

SELECT blocks
FROM user_tables
WHERE table_name = 'OPT_PRACOWNICY_148121';

SELECT nazwisko, placa
FROM opt_pracownicy_148121
WHERE ROWID = 'AABYHYAAyAAAHm3AAs'; -- system odczytuje tylko 1 blok a nie wszystkie jak wczesniej


SELECT index_name, index_type, uniqueness
FROM user_indexes
WHERE table_name = 'OPT_PRACOWNICY_148121';

SELECT column_name, column_position
FROM user_ind_columns
WHERE index_name = 'OPT_PRAC_NAZW_IDX'
ORDER BY column_position;


-- predicates:
-- access - nie ma wymogu dodatkowe filtrowania - realizowane w trakcie odczytu - indeks
-- filter - dane poddane filtrowaniue - realizowane po odczycie danych z indeksu

-- operacja zakresowego przegladania indeksu

-- Zadanie samodzielne. Sprawdź, co się zmieni w planie, jeśli w naszym poleceniu zmienimy
-- warunek na nierównościowy, np. ID_PRAC < 10. Czy nadal jest używany indeks
-- OPT_PRAC_PK? Jakiej operacji system używa przy dostępie do niego?

CREATE INDEX opt_prac_nazw_idx ON opt_pracownicy(nazwisko);

SELECT * FROM opt_pracownicy WHERE nazwisko = 'Prac155'; -- ktore z polecen nie skorzysta z indeksu
SELECT * FROM opt_pracownicy WHERE nazwisko LIKE 'Prac155%';
SELECT * FROM opt_pracownicy WHERE nazwisko LIKE '%Prac155%'; -- szczelam ze to (nie no napiwno)

LNNVL("NAZWISKO" LIKE 'Prac155%');
-- do eliminacji ew. duplikatow


TABLE ACCESS FULL
TABLE ACCESS BY USER ROWID
TABLE ACCESS BY INDEX ROWID
INDEX RANGE SCAN -- zakres rekordów, odczytywany przez tą operację, jest uporządkowany wg wartości klucza, uporzadkowa wzgledem wartosci klucza - moze zastepowac order by czasem
INDEX RANGE SCAN DESCENDING
INDEX UNIQUE SCAN --PK
INDEX FULL SCAN -- tez cos tam z sortowaniem
INDEX FAST FULL SCAN --odczyt wszystkich lisci indeksu przy uzyciu odczytu wieloblokowego, dostep gdy odwolujemy sie do czesci niewiodacej klucza np
INDEX SKIP SCAN -- tworzenie nowych-tymczaoswych indeksow z oryginalnego indeksu, w przykladzie bylo odwolanie do czesci niewiodacej klucza a czesc wiodaca miala bardzo mala dziedzine (2 wartosci)
HASH JOIN -- i 2 razy index range scan przy operacji AND (nie ma indeksu zlozonego z argumentami operacji AND)
-- wykorzystuje sortowanie
HASH UNIQUE -- przy select distinct
HASH GROUP BY
--^ HASH'e wykorzystuja w jakis sposob sortowanie

BITMAP INDEX SINGLE VALUE
BITMAP AND
BITMAP OR
BITMAP CONVERSION COUNT
SORT AGGREGATE -- np SUM(placa)
BITMAP CONVERSION TO ROWIDS

