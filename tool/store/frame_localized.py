#!/usr/bin/env python3
"""Frames the per-language raw captures onto the 1080x2160 Play canvas.

raw_localized/<code>/*.png -> screenshots_localized/<play-locale>/*.png,
using the same framing as the English set. Also emits one contact sheet per
language for a quick eyeball pass.
"""

import sys
from pathlib import Path

from PIL import Image

TOOL = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(TOOL))
from compose_store_assets import frame_screenshot  # noqa: E402
from localized_graphics import PLAY_LOCALE  # noqa: E402

RAW = TOOL / "store" / "raw_localized"
OUT = TOOL / "store" / "screenshots_localized"


def main():
    sheets = []
    for raw_dir in sorted(RAW.iterdir()):
        if not raw_dir.is_dir():
            continue
        play = PLAY_LOCALE[raw_dir.name]
        out_dir = OUT / play
        out_dir.mkdir(parents=True, exist_ok=True)
        row = []
        for src in sorted(raw_dir.glob("*.png")):
            dst = out_dir / src.name
            frame_screenshot(src, dst)
            row.append(dst)
        sheets.append((play, row))
        print(f"framed {play} ({len(row)} shots)", flush=True)

    # Contact sheet: one row per language, five thumbs each.
    thumb_w, thumb_h, pad = 160, 320, 8
    cols = max(len(row) for _, row in sheets)
    sheet = Image.new(
        "RGB",
        (cols * (thumb_w + pad) + pad + 90, len(sheets) * (thumb_h + pad) + pad),
        (24, 26, 27),
    )
    from PIL import ImageDraw, ImageFont
    draw = ImageDraw.Draw(sheet)
    try:
        font = ImageFont.truetype(
            "/System/Library/Fonts/Supplemental/Arial Bold.ttf", 22)
    except OSError:
        font = ImageFont.load_default()
    for r, (play, row) in enumerate(sheets):
        y = pad + r * (thumb_h + pad)
        draw.text((8, y + thumb_h // 2 - 12), play, font=font, fill="white")
        for c, path in enumerate(row):
            thumb = Image.open(path).resize((thumb_w, thumb_h), Image.LANCZOS)
            sheet.paste(thumb, (90 + pad + c * (thumb_w + pad), y))
    sheet.save(TOOL / "store" / "screenshots_localized_preview.png")
    print("done")


if __name__ == "__main__":
    main()
