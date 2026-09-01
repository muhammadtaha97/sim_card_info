#!/usr/bin/env python3
"""Captures the 8-shot store set per language from a running emulator.

Prerequisites: the SCREENSHOT_MODE build installed (no ads can appear), the
phone permission and Usage Access granted, cell towers opted in, location
granted. Per language: switch the per-app locale with `cmd locale`, restart,
and capture:

  01 SIMs (light)          05 latency, run at the bottom of Network
  02 Network top (light)   06 Device
  03 serving cell (scroll) 07 Settings
  04 data usage (scroll)   08 SIMs (dark)

Scroll-dependent shots use slow swipes (no fling momentum), so the offset is
the swipe distance; translated card heights only shift content by ~±150 px,
which these frames tolerate. Tap coordinates are for 1080x2424 and mirror
for RTL languages.

Usage: python3 tool/store/capture_localized.py [serial]
"""

import subprocess
import sys
import time
from pathlib import Path

SERIAL = sys.argv[1] if len(sys.argv) > 1 else "emulator-5554"
PACKAGE = "com.tahatec.sim_card_info"
OUT = Path(__file__).resolve().parent / "raw_localized"

LOCALES = [
    "en", "ar", "bn", "de", "es", "fr", "hi", "it", "ja",
    "ko", "pt", "ru", "tr", "ur", "zh",
]
RTL = {"ar", "ur"}

TAB_Y = 2297
TABS = dict(sims=133, network=404, device=673, settings=943)
THEME_Y = 508
THEME = dict(light=271, dark=803)
# "Run test" sits at the right of the latency card header; with the list
# scrolled to its end the card is bottom-anchored, so this lands on the
# button within the explainer's one-line-of-translation wiggle room.
RUN_TEST = (900, 2080)


def adb(*args):
    subprocess.run(["adb", "-s", SERIAL, "shell", *args], check=True,
                   capture_output=True)


def tap(x, y, rtl):
    adb("input", "tap", str(1080 - x if rtl else x), str(y))


def slow_scroll(distance):
    """Scrolls by ~`distance` px without fling momentum."""
    adb("input", "swipe", "540", "2000", "540", str(2000 - distance), "700")


def fling_to_bottom():
    for _ in range(3):
        adb("input", "swipe", "540", "2000", "540", "300", "80")
        time.sleep(0.7)


def cap(path: Path):
    png = subprocess.run(
        ["adb", "-s", SERIAL, "exec-out", "screencap", "-p"],
        check=True, capture_output=True,
    ).stdout
    path.write_bytes(png)


def capture_locale(tag: str):
    rtl = tag in RTL
    out = OUT / tag
    out.mkdir(parents=True, exist_ok=True)

    adb("cmd", "locale", "set-app-locales", PACKAGE, "--user", "0",
        "--locales", tag)
    adb("am", "force-stop", PACKAGE)
    adb("am", "start", "-n", f"{PACKAGE}/.MainActivity")
    time.sleep(4.5)

    # Start every language in light mode whatever the last state was.
    tap(TABS["settings"], TAB_Y, rtl)
    time.sleep(1.2)
    tap(THEME["light"], THEME_Y, rtl)
    time.sleep(1.2)

    tap(TABS["sims"], TAB_Y, rtl)
    time.sleep(1.5)
    cap(out / "01_sims.png")

    tap(TABS["network"], TAB_Y, rtl)
    time.sleep(8)  # two 3 s signal polls so the sparkline has a line
    cap(out / "02_network.png")

    slow_scroll(1750)
    time.sleep(1)
    cap(out / "03_cells.png")

    slow_scroll(1500)
    time.sleep(1)
    cap(out / "04_usage.png")

    fling_to_bottom()
    time.sleep(0.5)
    tap(*RUN_TEST, rtl)
    time.sleep(7)
    fling_to_bottom()  # results grew the card; re-anchor to the bottom
    time.sleep(0.5)
    cap(out / "05_latency.png")

    tap(TABS["device"], TAB_Y, rtl)
    time.sleep(1.5)
    cap(out / "06_device.png")

    tap(TABS["settings"], TAB_Y, rtl)
    time.sleep(1.2)
    cap(out / "07_settings.png")

    tap(THEME["dark"], THEME_Y, rtl)
    time.sleep(1)
    tap(TABS["sims"], TAB_Y, rtl)
    time.sleep(1.5)
    cap(out / "08_sims_dark.png")

    # Restore light for the next language.
    tap(TABS["settings"], TAB_Y, rtl)
    time.sleep(1)
    tap(THEME["light"], THEME_Y, rtl)
    time.sleep(0.8)
    print(f"captured {tag}", flush=True)


def main():
    for tag in LOCALES:
        capture_locale(tag)
    # Clear the per-app override so the app follows the device again.
    adb("cmd", "locale", "set-app-locales", PACKAGE, "--user", "0",
        "--locales", "")
    print("all done", flush=True)


if __name__ == "__main__":
    main()
