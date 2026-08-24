\set ON_ERROR_STOP on

\echo '========================================='
\echo 'RideShare RDS Pre-Restore Validation'
\echo '========================================='

SELECT
    current_database() AS database,
    current_user AS connected_as;

DO $$
BEGIN
    IF current_database() <> 'rideshare' THEN
        RAISE EXCEPTION
            'Wrong database. Expected rideshare, connected to %',
            current_database();
    END IF;

    IF current_user <> 'rideshare' THEN
        RAISE EXCEPTION
            'Wrong migration identity. Expected rideshare, connected as %',
            current_user;
    END IF;
END
$$;

\echo 'Checking target for existing application objects...'

DO $$
DECLARE
    object_count integer;
BEGIN
    SELECT count(*)
    INTO object_count
    FROM pg_class c
    JOIN pg_namespace n
      ON n.oid = c.relnamespace
    WHERE n.nspname IN (
        'driver_service',
        'rider_service',
        'trip_service',
        'public'
    )
    AND c.relkind IN (
        'r',
        'p',
        'S',
        'v',
        'm'
    );

    IF object_count > 0 THEN
        RAISE EXCEPTION
            'Target database is not clean. Found % application objects.',
            object_count;
    END IF;
END
$$;

\echo 'Pre-restore validation passed.'