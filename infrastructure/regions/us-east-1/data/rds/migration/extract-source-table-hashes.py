#!/usr/bin/env python3

import hashlib
import re
import sys
from pathlib import Path

if len(sys.argv) != 2:
    print(
        "Usage: python extract-source-table-hashes.py <postgres-dump.sql>",
        file=sys.stderr,
    )
    sys.exit(1)

dump_path = Path(sys.argv[1])

if not dump_path.is_file():
    print(f"ERROR: dump not found: {dump_path}", file=sys.stderr)
    sys.exit(1)

target_tables = {
    "rider_service.riders",
    "rider_service.ride_requests",
    "trip_service.trips",
    "trip_service.driver_transactions",
}

copy_pattern = re.compile(
    r"^COPY\s+([A-Za-z_][A-Za-z0-9_]*)\.([A-Za-z_][A-Za-z0-9_]*)\s+\((.*)\)\s+FROM\s+stdin;$"
)

table_rows = {}

current_table = None
current_rows = []

with dump_path.open("r", encoding="utf-8") as dump:
    for raw_line in dump:
        line = raw_line.rstrip("\r\n")

        if current_table is None:
            match = copy_pattern.match(line)

            if match:
                schema, table, _columns = match.groups()
                full_name = f"{schema}.{table}"

                if full_name in target_tables:
                    current_table = full_name
                    current_rows = []

        else:
            if line == r"\.":
                table_rows[current_table] = current_rows
                current_table = None
                current_rows = []
            else:
                current_rows.append(line)

if current_table is not None:
    print(
        f"ERROR: unterminated COPY block for {current_table}",
        file=sys.stderr,
    )
    sys.exit(1)

missing = target_tables - table_rows.keys()

if missing:
    print(
        "ERROR: missing expected table(s): "
        + ", ".join(sorted(missing)),
        file=sys.stderr,
    )
    sys.exit(1)

for table in sorted(target_tables):
    rows = sorted(table_rows[table])

    canonical = "".join(row + "\n" for row in rows)

    digest = hashlib.sha256(
        canonical.encode("utf-8")
    ).hexdigest()

    print(f"{table}|{len(rows)}|{digest}")
