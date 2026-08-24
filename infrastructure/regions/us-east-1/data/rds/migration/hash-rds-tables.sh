#!/usr/bin/env bash

set -euo pipefail

tables=(
  "rider_service.riders"
  "rider_service.ride_requests"
  "trip_service.trips"
  "trip_service.driver_transactions"
)

for table in "${tables[@]}"; do
  tmpfile=$(mktemp)

  MSYS_NO_PATHCONV=1 kubectl exec \
    -n database-migration \
    rideshare-client \
    -- psql \
      --quiet \
      --command="COPY ${table} TO STDOUT;" \
    | sed 's/\r$//' \
    | sort \
    > "$tmpfile"

  count=$(wc -l < "$tmpfile" | tr -d ' ')
  hash=$(sha256sum "$tmpfile" | awk '{print $1}')

  printf '%s|%s|%s\n' \
    "$table" \
    "$count" \
    "$hash"

  rm -f "$tmpfile"
done