#!/usr/bin/env python3
"""Builds the Play Store graphics from the raw emulator captures.

- tool/store/raw/*.png  (1080x2424 screencaps)  ->  tool/store/screenshots/
  framed onto a 1080x2160 canvas: Play rejects phone screenshots whose long
  side exceeds twice the short side, and 2424 > 2160.
- tool/store/feature_graphic.png (1024x500), same geometry as the launcher
  icon so the listing reads as one brand.
- tool/store/preview_grid.png, a contact sheet for eyeballing everything.
"""

from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter, ImageFont

ROOT = Path(__file__).resolve().parent
RAW = ROOT / "store" / "raw"
OUT = ROOT / "store" / "screenshots"

TEAL_DARK = (0, 77, 68)
TEAL = (0, 105, 92)
TEAL_LIGHT = (0, 137, 123)
GOLD = (230, 195, 106)
GOLD_DARK = (176, 140, 62)


def vertical_gradient(size, top, bottom):
    width, height = size
    img = Image.new("RGB", size)
    for y in range(height):
        t = y / max(height - 1, 1)
        img.paste(
            tuple(int(a + (b - a) * t) for a, b in zip(top, bottom)),
            (0, y, width, y + 1),
        )
    return img


def rounded(img, radius):
    mask = Image.new("L", img.size, 0)
    ImageDraw.Draw(mask).rounded_rectangle(
        [0, 0, img.size[0] - 1, img.size[1] - 1], radius=radius, fill=255
    )
    out = img.convert("RGBA")
    out.putalpha(mask)
    return out


def frame_screenshot(src: Path, dst: Path):
    shot = Image.open(src).convert("RGB")
    canvas = vertical_gradient((1080, 2160), TEAL, TEAL_DARK)

    target_h = 2020
    target_w = round(shot.width * target_h / shot.height)
    shot = shot.resize((target_w, target_h), Image.LANCZOS)
    shot = rounded(shot, 44)

    x = (1080 - target_w) // 2
    y = (2160 - target_h) // 2

    shadow = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
    ImageDraw.Draw(shadow).rounded_rectangle(
        [x - 8, y + 4, x + target_w + 8, y + target_h + 20],
        radius=52,
        fill=(0, 0, 0, 110),
    )
    shadow = shadow.filter(ImageFilter.GaussianBlur(18))

    out = canvas.convert("RGBA")
    out.alpha_composite(shadow)
    out.alpha_composite(shot, (x, y))
    out.convert("RGB").save(dst, "PNG")


def load_font(size):
    for candidate in [
        "/System/Library/Fonts/Supplemental/Arial Bold.ttf",
        "/System/Library/Fonts/Helvetica.ttc",
        "/Library/Fonts/Arial Bold.ttf",
    ]:
        try:
            return ImageFont.truetype(candidate, size)
        except OSError:
            continue
    return ImageFont.load_default()


def sim_art(draw, unit, ox, oy):
    """The launcher's SIM geometry, drawn at `unit` px per viewport unit."""
    def u(v):
        return v * unit

    # Card body with the cut corner (viewport coords from generate_icons.py).
    l, t, r, b, cut, rad = 37.0, 31.0, 71.0, 77.0, 11.0, 5.0
    draw.rounded_rectangle(
        [ox + u(l), oy + u(t), ox + u(r), oy + u(b)], radius=u(rad), fill="white"
    )
    draw.polygon(
        [
            (ox + u(r - cut), oy + u(t)),
            (ox + u(r), oy + u(t)),
            (ox + u(r), oy + u(t + cut)),
        ],
        fill=None,
    )
    # Chip.
    cl, ct, cr, cb = 45.0, 48.0, 63.0, 62.0
    draw.rounded_rectangle(
        [ox + u(cl), oy + u(ct), ox + u(cr), oy + u(cb)],
        radius=u(2.5),
        fill=GOLD,
    )
    w = max(int(u(0.8)), 1)
    for frac in (1 / 3, 2 / 3):
        x = ox + u(cl + (cr - cl) * frac)
        draw.line([(x, oy + u(ct)), (x, oy + u(cb))], fill=GOLD_DARK, width=w)
    mid = oy + u((ct + cb) / 2)
    draw.line([(ox + u(cl), mid), (ox + u(cr), mid)], fill=GOLD_DARK, width=w)


def feature_graphic():
    img = vertical_gradient((1024, 500), TEAL_LIGHT, TEAL_DARK)
    draw = ImageDraw.Draw(img)

    # Signal bars as a quiet background motif, right side.
    for i, (bar_h, alpha) in enumerate([(90, 40), (150, 55), (210, 70), (280, 90)]):
        x0 = 800 + i * 52
        overlay = Image.new("RGBA", img.size, (0, 0, 0, 0))
        ImageDraw.Draw(overlay).rounded_rectangle(
            [x0, 420 - bar_h, x0 + 36, 420], radius=12, fill=(255, 255, 255, alpha)
        )
        img = Image.alpha_composite(img.convert("RGBA"), overlay).convert("RGB")
        draw = ImageDraw.Draw(img)

    # The SIM from the launcher icon, left side. unit maps the 108-viewport
    # card (46 units tall) to ~280 px, kept clear of the text block.
    unit = 6.0
    art = Image.new("RGBA", (int(108 * unit), int(108 * unit)), (0, 0, 0, 0))
    art_draw = ImageDraw.Draw(art)
    sim_art(art_draw, unit, 0, 0)
    # Cut corner: overpaint with transparent triangle is messy in RGBA; redraw
    # via mask — simplest is to punch the triangle out of the alpha.
    alpha = art.split()[3]
    tri = ImageDraw.Draw(alpha)
    l, t, r, cut = 37.0, 31.0, 71.0, 11.0
    tri.polygon(
        [
            ((r - cut) * unit, t * unit),
            (r * unit, t * unit),
            (r * unit, (t + cut) * unit),
        ],
        fill=0,
    )
    art.putalpha(alpha)
    img = img.convert("RGBA")
    img.alpha_composite(art, (-130, -80))
    img = img.convert("RGB")
    draw = ImageDraw.Draw(img)

    title_font = load_font(82)
    sub_font = load_font(32)
    draw.text((330, 158), "SIM Card Info", font=title_font, fill="white")
    draw.text(
        (334, 272),
        "Carrier · Signal · Network · Data usage",
        font=sub_font,
        fill=(214, 238, 233),
    )
    img.save(ROOT / "store" / "feature_graphic.png", "PNG")


def contact_sheet(paths):
    thumbs = [Image.open(p).resize((270, 540), Image.LANCZOS) for p in paths]
    cols = len(thumbs)
    sheet = Image.new("RGB", (cols * 286 + 16, 572), (24, 26, 27))
    for i, thumb in enumerate(thumbs):
        sheet.paste(thumb, (16 + i * 286, 16))
    sheet.save(ROOT / "store" / "preview_grid.png", "PNG")


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    outs = []
    for src in sorted(RAW.glob("*.png")):
        dst = OUT / src.name
        frame_screenshot(src, dst)
        outs.append(dst)
        print(f"framed {src.name}")
    feature_graphic()
    contact_sheet(outs)
    print("done")


if __name__ == "__main__":
    main()
