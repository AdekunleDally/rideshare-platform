\set ON_ERROR_STOP on

\echo '========================================='
\echo 'RideShare Ownership Standardisation'
\echo '========================================='

ALTER DATABASE rideshare OWNER TO rideshare;

ALTER SCHEMA public OWNER TO rideshare;
ALTER SCHEMA driver_service OWNER TO rideshare;
ALTER SCHEMA rider_service OWNER TO rideshare;
ALTER SCHEMA trip_service OWNER TO rideshare;

DO $$
DECLARE
    obj record;
BEGIN
    FOR obj IN
        SELECT
            n.nspname AS schema_name,
            c.relname AS object_name
        FROM pg_class c
        JOIN pg_namespace n
          ON n.oid = c.relnamespace
        WHERE n.nspname IN (
            'public',
            'driver_service',
            'rider_service',
            'trip_service'
        )
        AND c.relkind IN ('r', 'p')
    LOOP
        EXECUTE format(
            'ALTER TABLE %I.%I OWNER TO rideshare',
            obj.schema_name,
            obj.object_name
        );
    END LOOP;
END
$$;

DO $$
DECLARE
    obj record;
BEGIN
    FOR obj IN
        SELECT
            sequence_schema,
            sequence_name
        FROM information_schema.sequences
        WHERE sequence_schema IN (
            'public',
            'driver_service',
            'rider_service',
            'trip_service'
        )
    LOOP
        EXECUTE format(
            'ALTER SEQUENCE %I.%I OWNER TO rideshare',
            obj.sequence_schema,
            obj.sequence_name
        );
    END LOOP;
END
$$;

\echo 'Ownership standardisation completed.'