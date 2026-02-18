#!/usr/bin/env python3
"""
Prune Raycast backup files with tiered retention.

Policy:
- 1 per day for the past 7 days
- 1 per week for the prior 4 weeks
- 1 per month for the prior 12 months
- 1 per year for anything older

Default mode is dry-run. Pass --apply to delete files.
"""

from __future__ import annotations

import argparse
import calendar
import datetime as dt
import re
from pathlib import Path


FILENAME_RE = re.compile(
    r"^Raycast (\d{4})-(\d{2})-(\d{2}) (\d{2})\.(\d{2})\.(\d{2})\.rayconfig$"
)


def subtract_months(value: dt.date, months: int) -> dt.date:
    total = (value.year * 12 + (value.month - 1)) - months
    year = total // 12
    month = total % 12 + 1
    # Clamp day to month-end
    day = min(value.day, calendar.monthrange(year, month)[1])
    return dt.date(year, month, day)


def parse_backup_timestamp(path: Path) -> dt.datetime | None:
    match = FILENAME_RE.match(path.name)
    if not match:
        return None
    y, m, d, hh, mm, ss = map(int, match.groups())
    return dt.datetime(y, m, d, hh, mm, ss)


def retention_bucket(ts: dt.datetime, today: dt.date) -> tuple[str, str]:
    day_window_start = today - dt.timedelta(days=6)
    week_window_start = today - dt.timedelta(days=34)
    month_window_start = subtract_months(today, 12)
    file_day = ts.date()

    if file_day >= day_window_start:
        return ("day", file_day.isoformat())
    if file_day >= week_window_start:
        iso = file_day.isocalendar()
        return ("week", f"{iso.year:04d}-W{iso.week:02d}")
    if file_day >= month_window_start:
        return ("month", f"{file_day.year:04d}-{file_day.month:02d}")
    return ("year", f"{file_day.year:04d}")


def collect_backups(backup_dir: Path) -> list[tuple[Path, dt.datetime]]:
    backups: list[tuple[Path, dt.datetime]] = []
    for path in backup_dir.glob("*.rayconfig"):
        ts = parse_backup_timestamp(path)
        if ts is None:
            continue
        backups.append((path, ts))
    backups.sort(key=lambda item: item[1], reverse=True)
    return backups


def plan_retention(backups: list[tuple[Path, dt.datetime]]) -> tuple[list[Path], list[Path]]:
    if not backups:
        return ([], [])

    today = dt.datetime.now().date()
    seen: set[tuple[str, str]] = set()
    keep: list[Path] = []
    delete: list[Path] = []

    # Always keep the newest snapshot.
    newest_path, newest_ts = backups[0]
    keep.append(newest_path)
    seen.add(retention_bucket(newest_ts, today))

    for path, ts in backups[1:]:
        bucket = retention_bucket(ts, today)
        if bucket in seen:
            delete.append(path)
            continue
        seen.add(bucket)
        keep.append(path)

    return (sorted(keep), sorted(delete))


def main() -> int:
    parser = argparse.ArgumentParser(description="Prune Raycast backup files with tiered retention.")
    parser.add_argument(
        "--dir",
        default=str(Path(__file__).resolve().parent / "backup"),
        help="Backup directory (default: apps/raycast/backup)",
    )
    parser.add_argument("--apply", action="store_true", help="Delete files instead of dry-run output.")
    args = parser.parse_args()

    backup_dir = Path(args.dir).expanduser().resolve()
    if not backup_dir.is_dir():
        print(f"[error] backup dir not found: {backup_dir}")
        return 1

    backups = collect_backups(backup_dir)
    keep, delete = plan_retention(backups)

    print(f"[info] backup dir: {backup_dir}")
    print(f"[info] total backups: {len(backups)}")
    print(f"[info] keep: {len(keep)}")
    print(f"[info] delete: {len(delete)}")

    if delete:
        action = "deleting" if args.apply else "would delete"
        print(f"[info] files {action}:")
        for path in delete:
            print(path.name)
    else:
        print("[info] nothing to delete")

    if not args.apply:
        print("[info] dry-run complete (pass --apply to delete)")
        return 0

    for path in delete:
        path.unlink(missing_ok=True)
    print("[info] cleanup complete")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
