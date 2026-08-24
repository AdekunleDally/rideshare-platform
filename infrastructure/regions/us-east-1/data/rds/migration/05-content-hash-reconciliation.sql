\set ON_ERROR_STOP on

\pset tuples_only on
\pset format unaligned
\pset fieldsep '|'

WITH rows AS (
    SELECT
        row_to_json(t)::text AS row_text
    FROM rider_service.riders t
),
canonical AS (
    SELECT string_agg(row_text, E'\n' ORDER BY row_text) AS payload
    FROM rows
)
SELECT
    'rider_service.riders',
    (SELECT count(*) FROM rider_service.riders),
    encode(
        digest(
            COALESCE(payload, ''),
            'sha256'
        ),
        'hex'
    )
FROM canonical;

WITH rows AS (
    SELECT
        row_to_json(t)::text AS row_text
    FROM rider_service.ride_requests t
),
canonical AS (
    SELECT string_agg(row_text, E'\n' ORDER BY row_text) AS payload
    FROM rows
)
SELECT
    'rider_service.ride_requests',
    (SELECT count(*) FROM rider_service.ride_requests),
    encode(
        digest(
            COALESCE(payload, ''),
            'sha256'
        ),
        'hex'
    )
FROM canonical;

WITH rows AS (
    SELECT
        row_to_json(t)::text AS row_text
    FROM trip_service.trips t
),
canonical AS (
    SELECT string_agg(row_text, E'\n' ORDER BY row_text) AS payload
    FROM rows
)
SELECT
    'trip_service.trips',
    (SELECT count(*) FROM trip_service.trips),
    encode(
        digest(
            COALESCE(payload, ''),
            'sha256'
        ),
        'hex'
    )
FROM canonical;

WITH rows AS (
    SELECT
        row_to_json(t)::text AS row_text
    FROM trip_service.driver_transactions t
),
canonical AS (
    SELECT string_agg(row_text, E'\n' ORDER BY row_text) AS payload
    FROM rows
)
SELECT
    'trip_service.driver_transactions',
    (SELECT count(*) FROM trip_service.driver_transactions),
    encode(
        digest(
            COALESCE(payload, ''),
            'sha256'
        ),
        'hex'
    )
FROM canonical;