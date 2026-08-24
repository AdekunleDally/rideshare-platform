\set ON_ERROR_STOP on

\echo '========================================='
\echo 'RideShare RDS Migration Validation'
\echo '========================================='

\echo '1. Database identity'

SELECT
    current_database() AS database,
    current_user AS connected_as,
    pg_get_userbyid(datdba) AS database_owner
FROM pg_database
WHERE datname = current_database();

\echo '2. Application schemas'

SELECT
    nspname AS schema_name,
    pg_get_userbyid(nspowner) AS owner
FROM pg_namespace
WHERE nspname IN (
    'public',
    'driver_service',
    'rider_service',
    'trip_service'
)
ORDER BY nspname;

\echo '3. PostgreSQL extensions'

SELECT
    extname,
    extversion,
    extnamespace::regnamespace AS schema
FROM pg_extension
ORDER BY extname;

\echo '4. Tables and owners'

SELECT
    schemaname,
    tablename,
    tableowner
FROM pg_tables
WHERE schemaname IN (
    'public',
    'driver_service',
    'rider_service',
    'trip_service'
)
ORDER BY schemaname, tablename;

\echo '5. Sequences and owners'

SELECT
    n.nspname AS schema_name,
    c.relname AS sequence_name,
    pg_get_userbyid(c.relowner) AS owner
FROM pg_class c
JOIN pg_namespace n
    ON n.oid = c.relnamespace
WHERE c.relkind = 'S'
AND n.nspname IN (
    'public',
    'driver_service',
    'rider_service',
    'trip_service'
)
ORDER BY n.nspname, c.relname;


\echo '6. Objects not owned by rideshare'

SELECT
    n.nspname AS schema_name,
    c.relname AS object_name,
    c.relkind AS object_type,
    pg_get_userbyid(c.relowner) AS owner
FROM pg_class c
JOIN pg_namespace n
  ON n.oid = c.relnamespace
WHERE n.nspname IN (
    'public',
    'driver_service',
    'rider_service',
    'trip_service'
)
AND c.relkind IN (
    'r',
    'p',
    'S',
    'v',
    'm'
)
AND pg_get_userbyid(c.relowner) <> 'rideshare'
ORDER BY n.nspname, c.relname;

\echo '7. Exact row counts'

SELECT format(
    'SELECT %L AS table_name, count(*) AS row_count FROM %I.%I;',
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

\echo '8. Unvalidated constraints'

SELECT
    n.nspname AS schema_name,
    c.relname AS table_name,
    con.conname AS constraint_name,
    con.contype AS constraint_type
FROM pg_constraint con
JOIN pg_class c
  ON c.oid = con.conrelid
JOIN pg_namespace n
  ON n.oid = c.relnamespace
WHERE n.nspname IN (
    'public',
    'driver_service',
    'rider_service',
    'trip_service'
)
AND con.convalidated = false;

\echo 'Migration validation completed.'