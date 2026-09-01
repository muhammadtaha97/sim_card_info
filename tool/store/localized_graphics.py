#!/usr/bin/env python3
"""Feature graphics (1024x500) for every Play locale.

Reuses the layout from compose_store_assets.py; the title comes straight from
each language's ARB (appTitle), so the graphic always matches the app. Needs
Pillow built with raqm (checked at startup) — without it Arabic, Urdu, Hindi
and Bengali would render as disconnected letters.
"""

import json
import sys
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont, features

TOOL = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(TOOL))
from compose_store_assets import (  # noqa: E402
    GOLD_DARK, TEAL_DARK, TEAL_LIGHT, sim_art, vertical_gradient,
)

ARB_DIR = TOOL.parent / "lib" / "l10n"
OUT = TOOL / "store" / "feature_graphics"

PLAY_LOCALE = {
    "en": "en-US", "ar": "ar", "bn": "bn-BD", "de": "de-DE", "es": "es-ES",
    "fr": "fr-FR", "hi": "hi-IN", "it": "it-IT", "ja": "ja-JP", "ko": "ko-KR",
    "pt": "pt-BR", "ru": "ru-RU", "tr": "tr-TR", "ur": "ur", "zh": "zh-CN",
}

TAGLINE = {
    "en": "Carrier · Signal · Network · Data usage",
    "ar": "المشغّل · الإشارة · الشبكة · البيانات",
    "bn": "ক্যারিয়ার · সিগন্যাল · নেটওয়ার্ক · ডেটা",
    "de": "Anbieter · Signal · Netz · Datenverbrauch",
    "es": "Operador · Señal · Red · Datos",
    "fr": "Opérateur · Signal · Réseau · Données",
    "hi": "कैरियर · सिग्नल · नेटवर्क · डेटा",
    "it": "Operatore · Segnale · Rete · Dati",
    "ja": "キャリア · 電波 · ネットワーク · データ",
    "ko": "통신사 · 신호 · 네트워크 · 데이터",
    "pt": "Operadora · Sinal · Rede · Dados",
    "ru": "Оператор · Сигнал · Сеть · Трафик",
    "tr": "Operatör · Sinyal · Ağ · Veri",
    "ur": "کیریئر · سگنل · نیٹ ورک · ڈیٹا",
    "zh": "运营商 · 信号 · 网络 · 流量",
}

RTL = {"ar", "ur"}

# Per-script font candidates, best first; every list ends in Arial Unicode,
# which covers everything at lower typographic quality.
ARIAL_UNICODE = "/System/Library/Fonts/Supplemental/Arial Unicode.ttf"
FONTS = {
    "default": ["/System/Library/Fonts/Supplemental/Arial Bold.ttf", ARIAL_UNICODE],
    # Not GeezaPro: it lacks Latin ("SIM") and the middot, which render as
    # tofu boxes. Arial Unicode has all three scripts and shapes fine.
    "ar": [ARIAL_UNICODE],
    "ur": [ARIAL_UNICODE],
    "hi": ["/System/Library/Fonts/Kohinoor.ttc",
           "/System/Library/Fonts/Supplemental/DevanagariMT.ttc", ARIAL_UNICODE],
    "bn": ["/System/Library/Fonts/KohinoorBangla.ttc",
           "/System/Library/Fonts/Supplemental/Bangla MN.ttc", ARIAL_UNICODE],
    "ja": ["/System/Library/Fonts/ヒラギノ角ゴシック W6.ttc",
           "/System/Library/Fonts/ヒラギノ角ゴシック W3.ttc", ARIAL_UNICODE],
    "ko": ["/System/Library/Fonts/AppleSDGothicNeo.ttc", ARIAL_UNICODE],
    "zh": ["/System/Library/Fonts/Hiragino Sans GB.ttc", ARIAL_UNICODE],
}


def font_for(code, size):
    for candidate in FONTS.get(code, FONTS["default"]):
        try:
            return ImageFont.truetype(candidate, size)
        except OSError:
            continue
    return ImageFont.load_default()


def fitted(draw, code, text, start_size, max_width, direction):
    size = start_size
    while size > 24:
        font = font_for(code, size)
        if draw.textlength(text, font=font, direction=direction) <= max_width:
            return font
        size -= 2
    return font_for(code, size)


def graphic(code):
    arb = json.loads((ARB_DIR / f"app_{code}.arb").read_text(encoding="utf-8"))
    title = arb["appTitle"]
    tagline = TAGLINE[code]
    direction = "rtl" if code in RTL else "ltr"

    img = vertical_gradient((1024, 500), TEAL_LIGHT, TEAL_DARK)
    draw = ImageDraw.Draw(img)

    for i, (bar_h, alpha) in enumerate([(90, 40), (150, 55), (210, 70), (280, 90)]):
        x0 = 800 + i * 52
        overlay = Image.new("RGBA", img.size, (0, 0, 0, 0))
        ImageDraw.Draw(overlay).rounded_rectangle(
            [x0, 420 - bar_h, x0 + 36, 420], radius=12,
            fill=(255, 255, 255, alpha),
        )
        img = Image.alpha_composite(img.convert("RGBA"), overlay).convert("RGB")
        draw = ImageDraw.Draw(img)

    unit = 6.0
    art = Image.new("RGBA", (int(108 * unit), int(108 * unit)), (0, 0, 0, 0))
    sim_art(ImageDraw.Draw(art), unit, 0, 0)
    alpha_channel = art.split()[3]
    l, t, r, cut = 37.0, 31.0, 71.0, 11.0
    ImageDraw.Draw(alpha_channel).polygon(
        [((r - cut) * unit, t * unit), (r * unit, t * unit),
         (r * unit, (t + cut) * unit)],
        fill=0,
    )
    art.putalpha(alpha_channel)
    img = img.convert("RGBA")
    img.alpha_composite(art, (-130, -80))
    img = img.convert("RGB")
    draw = ImageDraw.Draw(img)

    # 660px of clear space between the SIM art and the signal-bar motif.
    max_width = 660
    title_font = fitted(draw, code, title, 82, max_width, direction)
    sub_font = fitted(draw, code, tagline, 32, max_width, direction)
    draw.text((330, 158), title, font=title_font, fill="white",
              direction=direction)
    draw.text((334, 282), tagline, font=sub_font, fill=(214, 238, 233),
              direction=direction)

    OUT.mkdir(parents=True, exist_ok=True)
    img.save(OUT / f"{PLAY_LOCALE[code]}.png", "PNG")
    print(f"feature graphic {PLAY_LOCALE[code]}")


def contact_sheet():
    paths = sorted(OUT.glob("*.png"))
    cols = 5
    rows = (len(paths) + cols - 1) // cols
    sheet = Image.new("RGB", (cols * 522 + 10, rows * 265 + 10), (24, 26, 27))
    for i, path in enumerate(paths):
        thumb = Image.open(path).resize((512, 250), Image.LANCZOS)
        sheet.paste(thumb, (10 + (i % cols) * 522, 10 + (i // cols) * 265))
    sheet.save(TOOL / "store" / "feature_graphics_preview.png")


def main():
    if not features.check("raqm"):
        sys.exit("Pillow lacks raqm: Arabic/Indic text would render broken.")
    for code in PLAY_LOCALE:
        graphic(code)
    contact_sheet()
    print("done")


if __name__ == "__main__":
    main()
