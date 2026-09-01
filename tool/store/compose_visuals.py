#!/usr/bin/env python3
"""Builds the final store visuals: 8 per language, 1080x2160.

Each visual = branded gradient + localized headline + the framed screenshot.
Input comes from capture_localized.py (raw_localized/<code>/NN_*.png);
output lands in store/visuals/<play-locale>/. Captions are keyed by the
shot's NN prefix so the two scripts stay in step.
"""

import sys
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter

TOOL = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(TOOL))
from compose_store_assets import TEAL, TEAL_DARK, rounded, vertical_gradient  # noqa: E402
from localized_graphics import PLAY_LOCALE, RTL, fitted  # noqa: E402

RAW = TOOL / "store" / "raw_localized"
OUT = TOOL / "store" / "visuals"

CAPTIONS = {
    "en": ["Every SIM at a glance", "Live signal strength",
           "Cell tower details", "Track your data usage",
           "Test your connection", "Know your device",
           "Your language, your theme", "Beautiful in the dark"],
    "ar": ["كل الشرائح في لمحة", "قوة الإشارة مباشرة",
           "تفاصيل أبراج الاتصال", "تابع استهلاك بياناتك",
           "اختبر اتصالك", "اعرف جهازك",
           "لغتك وسمتك", "جميل في الوضع الداكن"],
    "bn": ["এক নজরে সব সিম", "লাইভ সিগন্যাল শক্তি",
           "সেল টাওয়ারের বিবরণ", "ডেটা ব্যবহারে নজর রাখুন",
           "সংযোগ পরীক্ষা করুন", "আপনার ডিভাইস জানুন",
           "আপনার ভাষা, আপনার থিম", "ডার্ক মোডে অপরূপ"],
    "de": ["Jede SIM auf einen Blick", "Signalstärke live",
           "Funkmast-Details", "Datenverbrauch im Blick",
           "Verbindung testen", "Kenne dein Gerät",
           "Deine Sprache, dein Design", "Schön im Dunkeln"],
    "es": ["Cada SIM de un vistazo", "Señal en tiempo real",
           "Detalles de las torres", "Controla tus datos",
           "Prueba tu conexión", "Conoce tu dispositivo",
           "Tu idioma, tu tema", "Precioso en oscuro"],
    "fr": ["Chaque SIM en un coup d'œil", "Signal en temps réel",
           "Détails des antennes", "Suivez vos données",
           "Testez votre connexion", "Connaissez votre appareil",
           "Votre langue, votre thème", "Superbe en sombre"],
    "hi": ["हर सिम एक नज़र में", "लाइव सिग्नल ताक़त",
           "सेल टावर विवरण", "डेटा उपयोग पर नज़र",
           "कनेक्शन जाँचें", "अपना डिवाइस जानें",
           "आपकी भाषा, आपका थीम", "डार्क मोड में शानदार"],
    "it": ["Ogni SIM a colpo d'occhio", "Segnale in tempo reale",
           "Dettagli delle celle", "Controlla i tuoi dati",
           "Testa la connessione", "Conosci il tuo dispositivo",
           "La tua lingua, il tuo tema", "Bella al buio"],
    "ja": ["すべてのSIMをひと目で", "電波強度をリアルタイムで",
           "基地局の詳細", "データ使用量を把握",
           "接続をテスト", "端末を知る",
           "あなたの言語とテーマ", "ダークモードも美しく"],
    "ko": ["모든 SIM을 한눈에", "실시간 신호 세기",
           "기지국 상세 정보", "데이터 사용량 관리",
           "연결 테스트", "내 기기 알기",
           "나의 언어, 나의 테마", "다크 모드도 아름답게"],
    "pt": ["Cada SIM num relance", "Sinal em tempo real",
           "Detalhes das torres", "Acompanhe seus dados",
           "Teste sua conexão", "Conheça seu aparelho",
           "Seu idioma, seu tema", "Lindo no escuro"],
    "ru": ["Все SIM как на ладони", "Сигнал в реальном времени",
           "Данные базовых станций", "Следите за трафиком",
           "Проверьте соединение", "Знайте своё устройство",
           "Ваш язык, ваша тема", "Красиво в тёмной теме"],
    "tr": ["Tüm SIM'ler bir bakışta", "Canlı sinyal gücü",
           "Baz istasyonu ayrıntıları", "Veri kullanımını izleyin",
           "Bağlantınızı test edin", "Cihazınızı tanıyın",
           "Kendi diliniz, kendi temanız", "Karanlıkta da güzel"],
    "ur": ["ہر سم ایک نظر میں", "لائیو سگنل کی طاقت",
           "سیل ٹاور کی تفصیلات", "ڈیٹا استعمال پر نظر",
           "اپنا کنکشن جانچیں", "اپنا آلہ جانیں",
           "آپ کی زبان، آپ کی تھیم", "ڈارک موڈ میں خوبصورت"],
    "zh": ["所有SIM卡一目了然", "实时信号强度",
           "基站详细信息", "掌握流量使用",
           "测试您的连接", "了解您的设备",
           "你的语言，你的主题", "深色模式同样精彩"],
}


def visual(code, index, src: Path, dst: Path):
    caption = CAPTIONS[code][index]
    direction = "rtl" if code in RTL else "ltr"

    canvas = vertical_gradient((1080, 2160), TEAL, TEAL_DARK)
    draw = ImageDraw.Draw(canvas)

    font = fitted(draw, code, caption, 72, 980, direction)
    width = draw.textlength(caption, font=font, direction=direction)
    # Vertically centred in the 250px headline strip regardless of script
    # ascender/descender quirks.
    box = draw.textbbox((0, 0), caption, font=font, direction=direction)
    text_h = box[3] - box[1]
    draw.text(((1080 - width) / 2, 125 - text_h / 2 - box[1]), caption,
              font=font, fill="white", direction=direction)

    shot = Image.open(src).convert("RGB")
    target_h = 1810
    target_w = round(shot.width * target_h / shot.height)
    shot = shot.resize((target_w, target_h), Image.LANCZOS)
    shot = rounded(shot, 44)

    x = (1080 - target_w) // 2
    y = 265
    shadow = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
    ImageDraw.Draw(shadow).rounded_rectangle(
        [x - 8, y + 4, x + target_w + 8, y + target_h + 20],
        radius=52, fill=(0, 0, 0, 110),
    )
    shadow = shadow.filter(ImageFilter.GaussianBlur(18))

    out = canvas.convert("RGBA")
    out.alpha_composite(shadow)
    out.alpha_composite(shot, (x, y))
    out.convert("RGB").save(dst, "PNG")


def main():
    rows = []
    for code in CAPTIONS:
        raw_dir = RAW / code
        sources = sorted(raw_dir.glob("*.png"))
        if len(sources) != 8:
            sys.exit(f"{code}: expected 8 captures, found {len(sources)}")
        play = PLAY_LOCALE[code]
        out_dir = OUT / play
        out_dir.mkdir(parents=True, exist_ok=True)
        row = []
        for index, src in enumerate(sources):
            dst = out_dir / src.name
            visual(code, index, src, dst)
            row.append(dst)
        rows.append((play, row))
        print(f"visuals {play}", flush=True)

    # Contact sheet: a row per language for one eyeball pass.
    thumb_w, thumb_h, pad, label_w = 150, 300, 6, 86
    sheet = Image.new(
        "RGB",
        (label_w + 8 * (thumb_w + pad) + pad, len(rows) * (thumb_h + pad) + pad),
        (24, 26, 27),
    )
    from PIL import ImageFont
    draw = ImageDraw.Draw(sheet)
    try:
        font = ImageFont.truetype(
            "/System/Library/Fonts/Supplemental/Arial Bold.ttf", 20)
    except OSError:
        font = ImageFont.load_default()
    for r, (play, row) in enumerate(rows):
        y = pad + r * (thumb_h + pad)
        draw.text((6, y + thumb_h // 2 - 12), play, font=font, fill="white")
        for c, path in enumerate(row):
            thumb = Image.open(path).resize((thumb_w, thumb_h), Image.LANCZOS)
            sheet.paste(thumb, (label_w + pad + c * (thumb_w + pad), y))
    sheet.save(TOOL / "store" / "visuals_preview.png")
    print("done")


if __name__ == "__main__":
    main()
