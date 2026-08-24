#!/usr/bin/env python3

import re
import sys
from pathlib import Path

if len(sys.argv) != 2:
    print(
        "Usage: python extract-source-row-counts.py <postgres-dump.sql>",
        file=sys.stderr,
    )
    sys.exit(1)

dump_path = Path(sys.argv[1])

if not dump_path.is_file():
    print(f"ERROR: dump not found: {dump_path}", file=sys.stderr)
    sys.exit(1)

application_schemas = {
    "public",
    "driver_service",
    "rider_service",
    "trip_service",
}

copy_pattern = re.compile(
    r"^COPY\s+([A-Za-z_][A-Za-z0-9_]*)\.([A-Za-z_][A-Za-z0-9_]*)\s+\(.*\)\s+FROM\s+stdin;$"
)

counts = {}

current_table = None
current_count = 0

with dump_path.open("r", encoding="utf-8") as dump:
    for line_number, raw_line in enumerate(dump, start=1):
        line = raw_line.rstrip("\r\n")

        if current_table is None:
            match = copy_pattern.match(line)

            if match:
                schema, table = match.groups()

                if schema in application_schemas:
                    current_table = f"{schema}.{table}"
                    current_count = 0

        else:
            if line == r"\.":
                if current_table in counts:
                    print(
                        f"ERROR: duplicate COPY block for {current_table}",
                        file=sys.stderr,
                    )
                    sys.exit(1)

                counts[current_table] = current_count
                current_table = None
                current_count = 0

            else:
                current_count += 1

if current_table is not None:
    print(
        f"ERROR: unterminated COPY block for {current_table}",
        file=sys.stderr,
    )
    sys.exit(1)

for table in sorted(counts):
    print(f"{table}|{counts[table]}")