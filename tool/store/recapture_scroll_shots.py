#!/usr/bin/env python3
"""Re-captures the two scroll-dependent Network shots per language.

03 (serving cell) drifts only by the height of the one card above it, so a
single 1500px slow scroll from the top lands it for every language. 04 (data
usage) is anchored from the list bottom instead — the cards below it are the
same in every language, so bottom + 500px up is stable where a cumulative
top-anchored scroll was not (Japanese overshot it).
"""

import subprocess
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from capture_localized import (  # noqa: E402
    LOCALES, OUT, PACKAGE, RTL, SERIAL, TAB_Y, TABS, adb, cap, fling_to_bottom,
    slow_scroll, tap,
)


def scroll_up(distance):
    adb("input", "swipe", "540", "700", "540", str(700 + distance), "700")


def main():
    for tag in LOCALES:
        rtl = tag in RTL
        out = OUT / tag
        adb("cmd", "locale", "set-app-locales", PACKAGE, "--user", "0",
            "--locales", tag)
        adb("am", "force-stop", PACKAGE)
        adb("am", "start", "-n", f"{PACKAGE}/.MainActivity")
        time.sleep(4.5)

        tap(TABS["network"], TAB_Y, rtl)
        time.sleep(2.5)

        slow_scroll(1500)
        time.sleep(1)
        cap(out / "03_cells.png")

        fling_to_bottom()
        time.sleep(0.5)
        scroll_up(500)
        time.sleep(1)
        cap(out / "04_usage.png")
        print(f"redone {tag}", flush=True)

    adb("cmd", "locale", "set-app-locales", PACKAGE, "--user", "0",
        "--locales", "")
    print("all done", flush=True)


if __name__ == "__main__":
    main()
