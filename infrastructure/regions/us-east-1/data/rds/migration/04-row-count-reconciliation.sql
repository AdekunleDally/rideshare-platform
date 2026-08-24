\set ON_ERROR_STOP on

\pset tuples_only on
\pset format unaligned
\pset fieldsep '|'

SELECT format(
    'SELECT %L, count(*) FROM %I.%I;',
    schemaname || '.' || tablename,
    schemaname,
    tablename
)
FROM pg_tables
WHERE schemaname IN (
    'public',
    'driver_service',
    'rider_service',
    'trip_service'
)
ORDER BY schemaname, tablename
\gexec