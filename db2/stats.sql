set autotrace off;

SELECT num_rows, blocks, last_analyzed, sample_size
FROM USER_TAB_STATISTICS
WHERE table_name = 'PRACOWNICY';

BEGIN
DBMS_STATS.DELETE_TABLE_STATS(ownname => 'inf148121',
tabname => 'OPT_PRACOWNICY_148121');
END;

SELECT num_rows, last_analyzed, avg_row_len, blocks
FROM user_tables
WHERE table_name = 'OPT_PRACOWNICY_148121';

SELECT column_name, num_distinct, low_value, high_value
FROM user_tab_col_statistics
WHERE table_name = 'OPT_PRACOWNICY_148121';

SELECT index_name, num_rows, leaf_blocks, last_analyzed
FROM user_indexes
WHERE table_name = 'OPT_PRACOWNICY_148121';


BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname=>'inf148121', tabname => 'OPT_PRACOWNICY_148121');
END;

BEGIN
DBMS_STATS.GATHER_TABLE_STATS(
ownname=>'inf148121', tabname => 'OPT_PRACOWNICY_148121',
estimate_percent => 40);
END;

BEGIN
DBMS_STATS.DELETE_TABLE_STATS(
ownname=>'inf148121', tabname => 'OPT_PRACOWNICY_148121');
END;

set AUTOTRACE on;

SELECT * FROM opt_pracownicy_148121 WHERE nazwisko LIKE 'Prac155%';

BEGIN
DBMS_STATS.GATHER_TABLE_STATS(
ownname=>'inf148121', tabname => 'OPT_PRACOWNICY_148121',
cascade => TRUE);
END;

SELECT column_name, num_distinct, low_value, high_value,
num_buckets, histogram
FROM user_tab_col_statistics
WHERE table_name = 'OPT_PRACOWNICY_148121'
ORDER BY column_name;

SELECT endpoint_number, endpoint_value, endpoint_repeat_count
FROM user_histograms
WHERE table_name = 'OPT_PRACOWNICY_148121'
AND column_name = 'ETAT'
ORDER BY endpoint_number;

SELECT num_distinct, num_buckets, histogram
FROM user_tab_col_statistics
WHERE table_name = 'OPT_PRACOWNICY_148121'
AND column_name = 'PLACA_DOD';

SELECT placa_dod, COUNT(*)
FROM opt_pracownicy_148121
GROUP BY placa_dod;

CREATE BITMAP INDEX opt_prac_placa_dod_bmp_idx
ON opt_pracownicy_148121(placa_dod);

SELECT index_name, num_rows, leaf_blocks, last_analyzed
FROM user_indexes
WHERE table_name = 'OPT_PRACOWNICY_148121';

SELECT * FROM opt_pracownicy_148121 WHERE placa_dod = 100;
SELECT * FROM opt_pracownicy_148121 WHERE placa_dod = 999;

BEGIN
DBMS_STATS.GATHER_TABLE_STATS(
ownname => 'inf148121', tabname => 'OPT_PRACOWNICY_148121',
method_opt => 'FOR COLUMNS placa_dod SIZE AUTO');
END;

SELECT * FROM opt_pracownicy_148121 WHERE placa_dod = 100;
SELECT * FROM opt_pracownicy_148121 WHERE placa_dod = 999;
