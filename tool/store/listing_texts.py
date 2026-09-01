#!/usr/bin/env python3
"""Writes the Play listing texts for every supported language.

Output: tool/store/listing/<play-locale>/{title,short_description,
full_description,whats_new}.txt — copy-paste into Play Console. The script
enforces Play's limits (title 30, short 80, full 4000, release notes 500
characters) so an over-long translation fails here, not in the Console.

Translations are machine-written and unreviewed, same caveat as the in-app
strings.
"""

import sys
from pathlib import Path

OUT = Path(__file__).resolve().parent / "listing"

L = {}

L["en-US"] = dict(
    title="SIM Card Info: Signal & Data",
    short="Carrier, signal strength, network type, cell towers & data usage for every SIM",
    full="""Everything about your SIM cards, network and signal — in one clean, fast app.

SIM Card Info reads the details Android hides behind menus and shows them in one place: which carrier each SIM uses, how strong your signal really is, what network you are on, and how much data you have used.

■ SIM CARDS
• One card for every SIM and eSIM, styled like the real thing
• Carrier, phone number, country, MCC-MNC (PLMN), carrier ID
• SIM state, slot and port, physical SIM or eSIM
• See which SIM handles mobile data, calls and SMS

■ LIVE SIGNAL
• Signal strength in dBm and ASU, refreshed every 3 seconds
• Live chart of the last minutes — walk around and find the strong spots
• Network type and generation: 2G, 3G, 4G LTE, 5G NR
• Roaming, mobile data state and voice network

■ CELL TOWERS (optional)
• The tower you are connected to: Cell ID, TAC/LAC, PCI
• Frequency channel (EARFCN/NRARFCN), band and bandwidth
• RSRP, RSRQ, SINR, timing advance, plus neighbouring cells
• Uses the location permission only if you switch this section on

■ DATA USAGE (optional)
• Mobile and Wi-Fi usage, today and this month
• Enabled through Android's Usage Access setting — only if you opt in

■ CONNECTION & TOOLS
• Active connection: link speed, DNS servers, private DNS, IP addresses
• One-tap latency test to Cloudflare, Google DNS and google.com
• Shortcuts to mobile network, data usage, Wi-Fi and airplane settings

■ MORE
• Home screen widget: carrier, network and signal for each SIM
• Tap any value to copy it; share a full report as text or JSON
• Light, dark and system themes · 15 languages
• Full dual SIM and eSIM support

PRIVACY
Everything is read directly from Android on your device. The app has no accounts and uploads nothing anywhere.

Note: Android does not allow apps to show data usage per individual SIM, and phone numbers appear only when the carrier stores them on the SIM.""",
    whatsnew="""First release 🎉
• Details for every SIM and eSIM — carrier, number, PLMN, slot, roles
• Live signal meter with history chart
• Optional cell tower details and data usage
• Latency test, IP addresses and DNS info
• Home screen widget
• Light & dark themes, 15 languages""",
)

L["ar"] = dict(
    title="معلومات الشريحة والشبكة",
    short="المشغّل وقوة الإشارة ونوع الشبكة وأبراج الاتصال واستهلاك البيانات لكل شريحة",
    full="""كل شيء عن شرائح SIM والشبكة والإشارة — في تطبيق واحد سريع وأنيق.

يقرأ التطبيق التفاصيل التي يخفيها أندرويد خلف القوائم ويعرضها في مكان واحد: مشغّل كل شريحة، وقوة الإشارة الحقيقية، ونوع الشبكة، وكمية البيانات المستهلكة.

■ شرائح SIM
• بطاقة لكل شريحة SIM أو eSIM بتصميم يشبه البطاقة الحقيقية
• المشغّل ورقم الهاتف والدولة وMCC-MNC ‏(PLMN) ومعرّف المشغّل
• حالة الشريحة والفتحة والمنفذ، وهل هي فعلية أم eSIM
• اعرف أي شريحة تتولى البيانات والمكالمات والرسائل

■ الإشارة المباشرة
• قوة الإشارة بوحدة dBm وASU، تتحدث كل 3 ثوانٍ
• رسم مباشر لآخر دقائق — تجوّل واعثر على أماكن الإشارة القوية
• نوع الشبكة وجيلها: 2G و3G و4G LTE و5G NR
• التجوال وحالة بيانات الهاتف وشبكة الصوت

■ أبراج الاتصال (اختياري)
• البرج المتصل به: معرّف الخلية وTAC/LAC وPCI
• قناة التردد (EARFCN/NRARFCN) والنطاق وعرض النطاق
• RSRP وRSRQ وSINR والأبراج المجاورة
• يستخدم إذن الموقع فقط إذا فعّلت هذا القسم

■ استهلاك البيانات (اختياري)
• بيانات الهاتف وWi-Fi، اليوم وهذا الشهر
• يُفعَّل عبر إعداد الوصول إلى الاستخدام — فقط إذا اخترت ذلك

■ الاتصال والأدوات
• الاتصال النشط: السرعة وخوادم DNS وعناوين IP
• اختبار زمن الاستجابة بلمسة واحدة
• اختصارات لإعدادات الشبكة والبيانات وWi-Fi ووضع الطيران

■ المزيد
• أداة شاشة رئيسية: المشغّل والشبكة والإشارة لكل شريحة
• انسخ أي قيمة بلمسة، وشارك تقريرًا كاملًا كنص أو JSON
• سمات فاتحة وداكنة وتلقائية · 15 لغة
• دعم كامل للشريحتين وeSIM

الخصوصية
تُقرأ كل البيانات مباشرة من أندرويد على جهازك. لا حسابات ولا يُرفع أي شيء إلى أي مكان.""",
    whatsnew="""الإصدار الأول 🎉
• تفاصيل كل شريحة SIM وeSIM — المشغّل والرقم وPLMN والفتحة
• مقياس إشارة مباشر مع رسم بياني
• أبراج الاتصال واستهلاك البيانات (اختياري)
• اختبار زمن الاستجابة وعناوين IP وDNS
• أداة شاشة رئيسية
• سمات فاتحة وداكنة و15 لغة""",
)

L["bn-BD"] = dict(
    title="সিম কার্ড তথ্য ও সিগন্যাল",
    short="প্রতিটি সিমের ক্যারিয়ার, সিগন্যাল, নেটওয়ার্ক, সেল টাওয়ার ও ডেটা ব্যবহার",
    full="""আপনার সিম কার্ড, নেটওয়ার্ক ও সিগন্যালের সবকিছু — একটি পরিচ্ছন্ন, দ্রুত অ্যাপে।

অ্যান্ড্রয়েড যে তথ্য মেনুর আড়ালে রাখে, এই অ্যাপ তা এক জায়গায় দেখায়: প্রতিটি সিমের ক্যারিয়ার, আসল সিগন্যাল শক্তি, নেটওয়ার্কের ধরন এবং ডেটা ব্যবহার।

■ সিম কার্ড
• প্রতিটি সিম ও eSIM-এর জন্য বাস্তব কার্ডের মতো ডিজাইন
• ক্যারিয়ার, ফোন নম্বর, দেশ, MCC-MNC (PLMN), ক্যারিয়ার আইডি
• সিমের অবস্থা, স্লট ও পোর্ট, ফিজিক্যাল সিম নাকি eSIM
• কোন সিম ডেটা, কল ও SMS সামলায় তা দেখুন

■ লাইভ সিগন্যাল
• dBm ও ASU-তে সিগন্যাল শক্তি, প্রতি ৩ সেকেন্ডে আপডেট
• শেষ কয়েক মিনিটের লাইভ চার্ট — ঘুরে ঘুরে শক্তিশালী জায়গা খুঁজুন
• নেটওয়ার্কের ধরন ও প্রজন্ম: 2G, 3G, 4G LTE, 5G NR
• রোমিং, মোবাইল ডেটার অবস্থা ও ভয়েস নেটওয়ার্ক

■ সেল টাওয়ার (ঐচ্ছিক)
• সংযুক্ত টাওয়ার: সেল আইডি, TAC/LAC, PCI
• ফ্রিকোয়েন্সি চ্যানেল (EARFCN/NRARFCN), ব্যান্ড ও ব্যান্ডউইথ
• RSRP, RSRQ, SINR এবং প্রতিবেশী সেল
• এই অংশ চালু করলেই কেবল অবস্থানের অনুমতি ব্যবহৃত হয়

■ ডেটা ব্যবহার (ঐচ্ছিক)
• মোবাইল ও Wi-Fi ব্যবহার, আজ ও এই মাসে
• কেবল আপনি চাইলে, ব্যবহার অ্যাক্সেস সেটিং দিয়ে চালু হয়

■ সংযোগ ও টুল
• সক্রিয় সংযোগ: গতি, DNS সার্ভার, IP ঠিকানা
• এক ট্যাপে লেটেন্সি টেস্ট
• নেটওয়ার্ক, ডেটা, Wi-Fi ও এরোপ্লেন সেটিংসের শর্টকাট

■ আরও
• হোম স্ক্রিন উইজেট: প্রতিটি সিমের ক্যারিয়ার, নেটওয়ার্ক ও সিগন্যাল
• যেকোনো মান ট্যাপ করে কপি করুন; টেক্সট বা JSON রিপোর্ট শেয়ার করুন
• হালকা, গাঢ় ও সিস্টেম থিম · ১৫টি ভাষা
• ডুয়াল সিম ও eSIM সমর্থন

গোপনীয়তা
সবকিছু আপনার ডিভাইসের অ্যান্ড্রয়েড থেকে সরাসরি পড়া হয়। কোনো অ্যাকাউন্ট নেই, কিছুই কোথাও আপলোড হয় না।""",
    whatsnew="""প্রথম রিলিজ 🎉
• প্রতিটি সিম ও eSIM-এর বিবরণ — ক্যারিয়ার, নম্বর, PLMN, স্লট
• ইতিহাস চার্টসহ লাইভ সিগন্যাল মিটার
• ঐচ্ছিক সেল টাওয়ার ও ডেটা ব্যবহার
• লেটেন্সি টেস্ট, IP ঠিকানা ও DNS তথ্য
• হোম স্ক্রিন উইজেট
• হালকা ও গাঢ় থিম, ১৫টি ভাষা""",
)

L["de-DE"] = dict(
    title="SIM-Karten-Info: Signal",
    short="Anbieter, Signalstärke, Netztyp, Funkmasten & Datenverbrauch für jede SIM",
    full="""Alles über deine SIM-Karten, dein Netz und dein Signal — in einer schnellen, aufgeräumten App.

SIM-Karten-Info zeigt die Details, die Android hinter Menüs versteckt, an einem Ort: welchen Anbieter jede SIM nutzt, wie stark dein Signal wirklich ist, in welchem Netz du bist und wie viel Daten du verbraucht hast.

■ SIM-KARTEN
• Eine Karte für jede SIM und eSIM, gestaltet wie das Original
• Anbieter, Telefonnummer, Land, MCC-MNC (PLMN), Anbieter-ID
• SIM-Status, Steckplatz und Port, physische SIM oder eSIM
• Sieh, welche SIM Daten, Anrufe und SMS übernimmt

■ LIVE-SIGNAL
• Signalstärke in dBm und ASU, alle 3 Sekunden aktualisiert
• Live-Diagramm der letzten Minuten — finde die starken Ecken
• Netztyp und Generation: 2G, 3G, 4G LTE, 5G NR
• Roaming, Datenstatus und Sprachnetz

■ FUNKMASTEN (optional)
• Der Mast, mit dem du verbunden bist: Zell-ID, TAC/LAC, PCI
• Frequenzkanal (EARFCN/NRARFCN), Band und Bandbreite
• RSRP, RSRQ, SINR, Timing Advance und Nachbarzellen
• Nutzt die Standortberechtigung nur, wenn du diesen Bereich aktivierst

■ DATENVERBRAUCH (optional)
• Mobil- und WLAN-Verbrauch, heute und diesen Monat
• Aktivierung über Androids Nutzungszugriff — nur wenn du zustimmst

■ VERBINDUNG & TOOLS
• Aktive Verbindung: Geschwindigkeit, DNS-Server, privates DNS, IP-Adressen
• Latenztest zu Cloudflare, Google DNS und google.com mit einem Tipp
• Schnellzugriffe auf Mobilfunk-, Daten-, WLAN- und Flugmodus-Einstellungen

■ MEHR
• Widget für den Startbildschirm: Anbieter, Netz und Signal je SIM
• Jeden Wert antippen und kopieren; Bericht als Text oder JSON teilen
• Helles, dunkles und System-Design · 15 Sprachen
• Volle Dual-SIM- und eSIM-Unterstützung

DATENSCHUTZ
Alles wird direkt von Android auf deinem Gerät gelesen. Keine Konten, nichts wird irgendwohin hochgeladen.""",
    whatsnew="""Erste Version 🎉
• Details zu jeder SIM und eSIM — Anbieter, Nummer, PLMN, Steckplatz
• Live-Signalmesser mit Verlaufsdiagramm
• Optionale Funkmast-Details und Datenverbrauch
• Latenztest, IP-Adressen und DNS-Infos
• Startbildschirm-Widget
• Helles & dunkles Design, 15 Sprachen""",
)

L["es-ES"] = dict(
    title="Info SIM: señal y datos",
    short="Operador, intensidad de señal, tipo de red, torres y uso de datos por SIM",
    full="""Todo sobre tus tarjetas SIM, tu red y tu señal — en una app rápida y ordenada.

Info SIM muestra en un solo lugar los detalles que Android esconde entre menús: el operador de cada SIM, la intensidad real de la señal, la red en la que estás y cuántos datos has usado.

■ TARJETAS SIM
• Una tarjeta por cada SIM y eSIM, con el aspecto de la real
• Operador, número, país, MCC-MNC (PLMN), ID del operador
• Estado de la SIM, ranura y puerto, SIM física o eSIM
• Ve qué SIM lleva los datos, las llamadas y los SMS

■ SEÑAL EN VIVO
• Intensidad en dBm y ASU, actualizada cada 3 segundos
• Gráfica en vivo de los últimos minutos — encuentra las zonas con mejor cobertura
• Tipo de red y generación: 2G, 3G, 4G LTE, 5G NR
• Itinerancia, estado de los datos y red de voz

■ TORRES DE TELEFONÍA (opcional)
• La torre a la que estás conectado: Cell ID, TAC/LAC, PCI
• Canal de frecuencia (EARFCN/NRARFCN), banda y ancho de banda
• RSRP, RSRQ, SINR, timing advance y celdas vecinas
• Usa el permiso de ubicación solo si activas esta sección

■ USO DE DATOS (opcional)
• Datos móviles y Wi-Fi, hoy y este mes
• Se activa con el acceso al uso de Android — solo si tú quieres

■ CONEXIÓN Y HERRAMIENTAS
• Conexión activa: velocidad, servidores DNS, DNS privado, direcciones IP
• Prueba de latencia con un toque
• Atajos a los ajustes de red móvil, datos, Wi-Fi y modo avión

■ MÁS
• Widget de pantalla de inicio: operador, red y señal por SIM
• Toca cualquier valor para copiarlo; comparte el informe como texto o JSON
• Temas claro, oscuro y del sistema · 15 idiomas
• Compatibilidad total con SIM dual y eSIM

PRIVACIDAD
Todo se lee directamente de Android en tu dispositivo. Sin cuentas; nada se sube a ninguna parte.""",
    whatsnew="""Primera versión 🎉
• Detalles de cada SIM y eSIM — operador, número, PLMN, ranura
• Medidor de señal en vivo con gráfica
• Torres de telefonía y uso de datos opcionales
• Prueba de latencia, direcciones IP y DNS
• Widget de pantalla de inicio
• Temas claro y oscuro, 15 idiomas""",
)

L["fr-FR"] = dict(
    title="Info SIM : signal et données",
    short="Opérateur, signal, type de réseau, antennes et consommation pour chaque SIM",
    full="""Tout sur vos cartes SIM, votre réseau et votre signal — dans une app rapide et soignée.

Info SIM rassemble les détails qu'Android cache dans ses menus : l'opérateur de chaque SIM, la vraie force du signal, le réseau utilisé et la quantité de données consommée.

■ CARTES SIM
• Une carte pour chaque SIM et eSIM, dessinée comme la vraie
• Opérateur, numéro, pays, MCC-MNC (PLMN), ID opérateur
• État de la SIM, emplacement et port, SIM physique ou eSIM
• Voyez quelle SIM gère les données, les appels et les SMS

■ SIGNAL EN DIRECT
• Force du signal en dBm et ASU, rafraîchie toutes les 3 secondes
• Graphique en direct des dernières minutes — trouvez les zones bien couvertes
• Type de réseau et génération : 2G, 3G, 4G LTE, 5G NR
• Itinérance, état des données et réseau voix

■ ANTENNES-RELAIS (optionnel)
• L'antenne à laquelle vous êtes connecté : Cell ID, TAC/LAC, PCI
• Canal de fréquence (EARFCN/NRARFCN), bande et largeur de bande
• RSRP, RSRQ, SINR, timing advance et cellules voisines
• N'utilise la localisation que si vous activez cette section

■ CONSOMMATION DE DONNÉES (optionnel)
• Données mobiles et Wi-Fi, aujourd'hui et ce mois-ci
• Activée via l'accès à l'utilisation d'Android — seulement si vous le voulez

■ CONNEXION ET OUTILS
• Connexion active : débit, serveurs DNS, DNS privé, adresses IP
• Test de latence en un geste
• Raccourcis vers les réglages réseau, données, Wi-Fi et mode avion

■ ET AUSSI
• Widget d'écran d'accueil : opérateur, réseau et signal par SIM
• Touchez une valeur pour la copier ; partagez un rapport en texte ou JSON
• Thèmes clair, sombre et système · 15 langues
• Prise en charge complète du double SIM et de l'eSIM

CONFIDENTIALITÉ
Tout est lu directement depuis Android sur votre appareil. Pas de compte, rien n'est envoyé nulle part.""",
    whatsnew="""Première version 🎉
• Détails de chaque SIM et eSIM — opérateur, numéro, PLMN, emplacement
• Mesure du signal en direct avec graphique
• Antennes-relais et consommation en option
• Test de latence, adresses IP et DNS
• Widget d'écran d'accueil
• Thèmes clair et sombre, 15 langues""",
)

L["hi-IN"] = dict(
    title="सिम कार्ड जानकारी: सिग्नल",
    short="हर सिम का कैरियर, सिग्नल, नेटवर्क प्रकार, सेल टावर और डेटा उपयोग",
    full="""आपके सिम कार्ड, नेटवर्क और सिग्नल की हर जानकारी — एक तेज़, साफ़ ऐप में।

Android जो जानकारी मेनू के पीछे छिपाता है, यह ऐप उसे एक जगह दिखाता है: हर सिम का कैरियर, असली सिग्नल ताक़त, नेटवर्क का प्रकार और डेटा उपयोग।

■ सिम कार्ड
• हर सिम और eSIM के लिए असली जैसा कार्ड
• कैरियर, फ़ोन नंबर, देश, MCC-MNC (PLMN), कैरियर आईडी
• सिम स्थिति, स्लॉट और पोर्ट, भौतिक सिम या eSIM
• देखें कौन सी सिम डेटा, कॉल और SMS संभालती है

■ लाइव सिग्नल
• dBm और ASU में सिग्नल ताक़त, हर 3 सेकंड में ताज़ा
• पिछले मिनटों का लाइव चार्ट — घूमकर अच्छे सिग्नल की जगह खोजें
• नेटवर्क प्रकार और पीढ़ी: 2G, 3G, 4G LTE, 5G NR
• रोमिंग, मोबाइल डेटा स्थिति और वॉइस नेटवर्क

■ सेल टावर (वैकल्पिक)
• जुड़ा हुआ टावर: सेल आईडी, TAC/LAC, PCI
• फ़्रीक्वेंसी चैनल (EARFCN/NRARFCN), बैंड और बैंडविड्थ
• RSRP, RSRQ, SINR और पड़ोसी सेल
• स्थान अनुमति केवल तभी, जब आप यह भाग चालू करें

■ डेटा उपयोग (वैकल्पिक)
• मोबाइल और Wi-Fi उपयोग, आज और इस महीने
• Android की उपयोग एक्सेस सेटिंग से — केवल आपकी मर्ज़ी से

■ कनेक्शन और टूल
• सक्रिय कनेक्शन: गति, DNS सर्वर, IP पते
• एक टैप में लेटेंसी टेस्ट
• नेटवर्क, डेटा, Wi-Fi और हवाई जहाज़ सेटिंग्स के शॉर्टकट

■ और भी
• होम स्क्रीन विजेट: हर सिम का कैरियर, नेटवर्क और सिग्नल
• किसी भी मान को टैप कर कॉपी करें; टेक्स्ट या JSON रिपोर्ट साझा करें
• हल्का, गहरा और सिस्टम थीम · 15 भाषाएँ
• डुअल सिम और eSIM समर्थन

निजता
सब कुछ आपके डिवाइस पर Android से सीधे पढ़ा जाता है। कोई खाता नहीं, कुछ भी कहीं अपलोड नहीं होता।""",
    whatsnew="""पहला संस्करण 🎉
• हर सिम और eSIM का विवरण — कैरियर, नंबर, PLMN, स्लॉट
• इतिहास चार्ट के साथ लाइव सिग्नल मीटर
• वैकल्पिक सेल टावर और डेटा उपयोग
• लेटेंसी टेस्ट, IP पते और DNS जानकारी
• होम स्क्रीन विजेट
• हल्का और गहरा थीम, 15 भाषाएँ""",
)

L["it-IT"] = dict(
    title="Info SIM: segnale e dati",
    short="Operatore, segnale, tipo di rete, celle e utilizzo dati per ogni SIM",
    full="""Tutto sulle tue SIM, sulla rete e sul segnale — in un'app veloce e ordinata.

Info SIM mostra in un unico posto i dettagli che Android nasconde nei menu: l'operatore di ogni SIM, la vera forza del segnale, la rete in uso e quanti dati hai consumato.

■ SCHEDE SIM
• Una scheda per ogni SIM ed eSIM, disegnata come quella vera
• Operatore, numero, paese, MCC-MNC (PLMN), ID operatore
• Stato della SIM, slot e porta, SIM fisica o eSIM
• Scopri quale SIM gestisce dati, chiamate e SMS

■ SEGNALE IN DIRETTA
• Intensità in dBm e ASU, aggiornata ogni 3 secondi
• Grafico in diretta degli ultimi minuti — trova i punti con più campo
• Tipo di rete e generazione: 2G, 3G, 4G LTE, 5G NR
• Roaming, stato dei dati e rete voce

■ CELLE TELEFONICHE (opzionale)
• La cella a cui sei connesso: Cell ID, TAC/LAC, PCI
• Canale di frequenza (EARFCN/NRARFCN), banda e larghezza di banda
• RSRP, RSRQ, SINR, timing advance e celle vicine
• Usa la posizione solo se attivi questa sezione

■ UTILIZZO DATI (opzionale)
• Dati mobili e Wi-Fi, oggi e questo mese
• Attivato con l'accesso all'utilizzo di Android — solo se lo scegli tu

■ CONNESSIONE E STRUMENTI
• Connessione attiva: velocità, server DNS, DNS privato, indirizzi IP
• Test di latenza con un tocco
• Scorciatoie per rete mobile, dati, Wi-Fi e modalità aereo

■ E ANCORA
• Widget per la schermata iniziale: operatore, rete e segnale per SIM
• Tocca un valore per copiarlo; condividi il rapporto come testo o JSON
• Tema chiaro, scuro e di sistema · 15 lingue
• Pieno supporto a dual SIM ed eSIM

PRIVACY
Tutto viene letto direttamente da Android sul tuo dispositivo. Nessun account, nulla viene caricato da nessuna parte.""",
    whatsnew="""Prima versione 🎉
• Dettagli di ogni SIM ed eSIM — operatore, numero, PLMN, slot
• Misuratore del segnale in diretta con grafico
• Celle telefoniche e utilizzo dati opzionali
• Test di latenza, indirizzi IP e DNS
• Widget per la schermata iniziale
• Tema chiaro e scuro, 15 lingue""",
)

L["ja-JP"] = dict(
    title="SIMカード情報：電波とデータ",
    short="各SIMのキャリア・電波強度・ネットワーク種別・基地局・データ使用量を確認",
    full="""SIMカード、ネットワーク、電波のすべてを、速くてすっきりした1つのアプリで。

Androidがメニューの奥に隠している情報をひとつの画面にまとめます。各SIMのキャリア、本当の電波強度、接続中のネットワーク、そしてデータ使用量。

■ SIMカード
• SIM・eSIMごとに、本物のカードのようなデザインで表示
• キャリア、電話番号、国、MCC-MNC（PLMN）、キャリアID
• SIMの状態、スロットとポート、物理SIMかeSIMか
• データ・通話・SMSをどのSIMが担当しているかを確認

■ ライブ電波
• dBmとASUで電波強度を3秒ごとに更新
• 直近数分間のライブチャート — 歩き回って電波の良い場所を発見
• ネットワーク種別と世代：2G、3G、4G LTE、5G NR
• ローミング、モバイルデータの状態、音声ネットワーク

■ 基地局（オプション）
• 接続中の基地局：セルID、TAC/LAC、PCI
• 周波数チャネル（EARFCN/NRARFCN）、バンド、帯域幅
• RSRP、RSRQ、SINR、隣接セル
• このセクションを有効にしたときだけ位置情報権限を使用

■ データ使用量（オプション）
• モバイルとWi-Fiの使用量を今日・今月で表示
• Androidの使用状況アクセスで有効化 — 選んだ場合のみ

■ 接続とツール
• アクティブな接続：速度、DNSサーバー、プライベートDNS、IPアドレス
• ワンタップのレイテンシテスト
• モバイル・データ・Wi-Fi・機内モード設定へのショートカット

■ その他
• ホーム画面ウィジェット：SIMごとのキャリア・ネットワーク・電波
• 値をタップしてコピー、レポートをテキストまたはJSONで共有
• ライト・ダーク・システムテーマ · 15言語
• デュアルSIMとeSIMに完全対応

プライバシー
すべて端末上のAndroidから直接読み取ります。アカウント不要、どこにも何もアップロードしません。""",
    whatsnew="""初回リリース 🎉
• SIM・eSIMごとの詳細 — キャリア、番号、PLMN、スロット
• 履歴チャート付きライブ電波メーター
• 基地局情報とデータ使用量（オプション）
• レイテンシテスト、IPアドレス、DNS情報
• ホーム画面ウィジェット
• ライト＆ダークテーマ、15言語""",
)

L["ko-KR"] = dict(
    title="SIM 카드 정보: 신호와 데이터",
    short="SIM별 통신사, 신호 세기, 네트워크 유형, 기지국, 데이터 사용량 확인",
    full="""SIM 카드, 네트워크, 신호의 모든 것을 빠르고 깔끔한 앱 하나로.

Android가 메뉴 깊숙이 숨겨 둔 정보를 한곳에 보여줍니다. 각 SIM의 통신사, 실제 신호 세기, 접속 중인 네트워크, 데이터 사용량까지.

■ SIM 카드
• SIM과 eSIM마다 실물 카드 같은 디자인
• 통신사, 전화번호, 국가, MCC-MNC(PLMN), 통신사 ID
• SIM 상태, 슬롯과 포트, 물리 SIM 또는 eSIM
• 데이터·통화·SMS를 어느 SIM이 맡는지 확인

■ 실시간 신호
• dBm과 ASU로 3초마다 갱신되는 신호 세기
• 최근 몇 분의 실시간 차트 — 돌아다니며 신호 좋은 곳 찾기
• 네트워크 유형과 세대: 2G, 3G, 4G LTE, 5G NR
• 로밍, 모바일 데이터 상태, 음성 네트워크

■ 기지국 (선택)
• 접속 중인 기지국: 셀 ID, TAC/LAC, PCI
• 주파수 채널(EARFCN/NRARFCN), 밴드, 대역폭
• RSRP, RSRQ, SINR, 인접 셀
• 이 기능을 켤 때만 위치 권한 사용

■ 데이터 사용량 (선택)
• 모바일·Wi-Fi 사용량을 오늘과 이번 달로 표시
• Android 사용 정보 접근으로 활성화 — 원할 때만

■ 연결과 도구
• 활성 연결: 속도, DNS 서버, 비공개 DNS, IP 주소
• 원탭 지연 시간 테스트
• 모바일 네트워크·데이터·Wi-Fi·비행기 모드 설정 바로가기

■ 더 보기
• 홈 화면 위젯: SIM별 통신사, 네트워크, 신호
• 값을 탭해 복사, 보고서를 텍스트나 JSON으로 공유
• 라이트·다크·시스템 테마 · 15개 언어
• 듀얼 SIM과 eSIM 완벽 지원

개인정보 보호
모든 정보는 기기의 Android에서 직접 읽습니다. 계정도 없고, 어디에도 업로드하지 않습니다.""",
    whatsnew="""첫 출시 🎉
• SIM·eSIM별 상세 정보 — 통신사, 번호, PLMN, 슬롯
• 기록 차트가 있는 실시간 신호 측정
• 기지국 정보와 데이터 사용량(선택)
• 지연 시간 테스트, IP 주소, DNS 정보
• 홈 화면 위젯
• 라이트·다크 테마, 15개 언어""",
)

L["pt-BR"] = dict(
    title="Info do SIM: sinal e dados",
    short="Operadora, sinal, tipo de rede, torres e uso de dados de cada SIM",
    full="""Tudo sobre seus chips, sua rede e seu sinal — em um app rápido e organizado.

O Info do SIM reúne em um só lugar os detalhes que o Android esconde nos menus: a operadora de cada SIM, a força real do sinal, a rede em uso e quantos dados você gastou.

■ CARTÕES SIM
• Um cartão para cada SIM e eSIM, com visual de cartão de verdade
• Operadora, número, país, MCC-MNC (PLMN), ID da operadora
• Estado do SIM, slot e porta, SIM físico ou eSIM
• Veja qual SIM cuida dos dados, das chamadas e dos SMS

■ SINAL AO VIVO
• Força do sinal em dBm e ASU, atualizada a cada 3 segundos
• Gráfico ao vivo dos últimos minutos — ande pela casa e ache o melhor sinal
• Tipo de rede e geração: 2G, 3G, 4G LTE, 5G NR
• Roaming, estado dos dados e rede de voz

■ TORRES DE CELULAR (opcional)
• A torre à qual você está conectado: Cell ID, TAC/LAC, PCI
• Canal de frequência (EARFCN/NRARFCN), banda e largura de banda
• RSRP, RSRQ, SINR, timing advance e células vizinhas
• Usa a permissão de localização apenas se você ativar esta seção

■ USO DE DADOS (opcional)
• Uso móvel e Wi-Fi, hoje e neste mês
• Ativado pelo acesso de uso do Android — só se você quiser

■ CONEXÃO E FERRAMENTAS
• Conexão ativa: velocidade, servidores DNS, DNS privado, endereços IP
• Teste de latência com um toque
• Atalhos para rede móvel, dados, Wi-Fi e modo avião

■ MAIS
• Widget de tela inicial: operadora, rede e sinal por SIM
• Toque em qualquer valor para copiar; compartilhe o relatório em texto ou JSON
• Temas claro, escuro e do sistema · 15 idiomas
• Suporte completo a dual SIM e eSIM

PRIVACIDADE
Tudo é lido diretamente do Android no seu aparelho. Sem contas; nada é enviado para lugar nenhum.""",
    whatsnew="""Primeira versão 🎉
• Detalhes de cada SIM e eSIM — operadora, número, PLMN, slot
• Medidor de sinal ao vivo com gráfico
• Torres de celular e uso de dados opcionais
• Teste de latência, endereços IP e DNS
• Widget de tela inicial
• Temas claro e escuro, 15 idiomas""",
)

L["ru-RU"] = dict(
    title="SIM-карта: сигнал и сеть",
    short="Оператор, уровень сигнала, тип сети, базовые станции и трафик каждой SIM",
    full="""Всё о ваших SIM-картах, сети и сигнале — в одном быстром и аккуратном приложении.

Приложение собирает в одном месте то, что Android прячет по меню: оператора каждой SIM, реальную силу сигнала, тип сети и расход трафика.

■ SIM-КАРТЫ
• Карточка для каждой SIM и eSIM, оформленная как настоящая
• Оператор, номер, страна, MCC-MNC (PLMN), ID оператора
• Состояние SIM, слот и порт, физическая SIM или eSIM
• Видно, какая SIM отвечает за данные, звонки и SMS

■ СИГНАЛ В РЕАЛЬНОМ ВРЕМЕНИ
• Уровень в dBm и ASU, обновление каждые 3 секунды
• Живой график последних минут — пройдитесь и найдите зоны с лучшим приёмом
• Тип сети и поколение: 2G, 3G, 4G LTE, 5G NR
• Роуминг, состояние мобильных данных и голосовая сеть

■ БАЗОВЫЕ СТАНЦИИ (по желанию)
• Станция, к которой вы подключены: Cell ID, TAC/LAC, PCI
• Частотный канал (EARFCN/NRARFCN), диапазон и полоса
• RSRP, RSRQ, SINR и соседние соты
• Геолокация используется только если вы включите этот раздел

■ РАСХОД ТРАФИКА (по желанию)
• Мобильный и Wi-Fi трафик за сегодня и за месяц
• Включается через доступ к данным об использовании — только по вашему выбору

■ ПОДКЛЮЧЕНИЕ И ИНСТРУМЕНТЫ
• Активное подключение: скорость, DNS-серверы, приватный DNS, IP-адреса
• Тест задержки одним нажатием
• Быстрый переход к настройкам сети, трафика, Wi-Fi и режима полёта

■ И ЕЩЁ
• Виджет на главный экран: оператор, сеть и сигнал по каждой SIM
• Нажмите на любое значение, чтобы скопировать; отчёт текстом или в JSON
• Светлая, тёмная и системная темы · 15 языков
• Полная поддержка двух SIM и eSIM

КОНФИДЕНЦИАЛЬНОСТЬ
Всё читается напрямую из Android на вашем устройстве. Без аккаунтов; ничего никуда не отправляется.""",
    whatsnew="""Первый выпуск 🎉
• Данные каждой SIM и eSIM — оператор, номер, PLMN, слот
• Живой измеритель сигнала с графиком
• Базовые станции и расход трафика (по желанию)
• Тест задержки, IP-адреса и DNS
• Виджет на главный экран
• Светлая и тёмная темы, 15 языков""",
)

L["tr-TR"] = dict(
    title="SIM Kart Bilgisi ve Sinyal",
    short="Her SIM için operatör, sinyal gücü, ağ türü, baz istasyonları ve veri kullanımı",
    full="""SIM kartlarınız, ağınız ve sinyaliniz hakkında her şey — hızlı ve derli toplu tek bir uygulamada.

SIM Kart Bilgisi, Android'in menülerin arkasına sakladığı ayrıntıları tek yerde gösterir: her SIM'in operatörü, sinyalin gerçek gücü, bağlı olduğunuz ağ ve kullandığınız veri miktarı.

■ SIM KARTLAR
• Her SIM ve eSIM için gerçeğine benzeyen bir kart
• Operatör, telefon numarası, ülke, MCC-MNC (PLMN), operatör kimliği
• SIM durumu, yuva ve bağlantı noktası, fiziksel SIM veya eSIM
• Veri, arama ve SMS'i hangi SIM'in üstlendiğini görün

■ CANLI SİNYAL
• dBm ve ASU cinsinden sinyal gücü, 3 saniyede bir yenilenir
• Son dakikaların canlı grafiği — dolaşın, çekimin iyi olduğu yerleri bulun
• Ağ türü ve nesli: 2G, 3G, 4G LTE, 5G NR
• Dolaşım, mobil veri durumu ve ses ağı

■ BAZ İSTASYONLARI (isteğe bağlı)
• Bağlı olduğunuz istasyon: Hücre kimliği, TAC/LAC, PCI
• Frekans kanalı (EARFCN/NRARFCN), bant ve bant genişliği
• RSRP, RSRQ, SINR ve komşu hücreler
• Konum izni yalnızca bu bölümü açarsanız kullanılır

■ VERİ KULLANIMI (isteğe bağlı)
• Bugün ve bu ay için mobil ve Wi-Fi kullanımı
• Android'in kullanım erişimi ayarıyla — yalnızca siz isterseniz

■ BAĞLANTI VE ARAÇLAR
• Etkin bağlantı: hız, DNS sunucuları, özel DNS, IP adresleri
• Tek dokunuşla gecikme testi
• Mobil ağ, veri, Wi-Fi ve uçak modu ayarlarına kısayollar

■ DAHASI
• Ana ekran widget'ı: her SIM için operatör, ağ ve sinyal
• Herhangi bir değere dokunup kopyalayın; raporu metin veya JSON olarak paylaşın
• Açık, koyu ve sistem teması · 15 dil
• Tam çift SIM ve eSIM desteği

GİZLİLİK
Her şey cihazınızdaki Android'den doğrudan okunur. Hesap yok; hiçbir şey hiçbir yere yüklenmez.""",
    whatsnew="""İlk sürüm 🎉
• Her SIM ve eSIM'in ayrıntıları — operatör, numara, PLMN, yuva
• Geçmiş grafikli canlı sinyal ölçer
• İsteğe bağlı baz istasyonu ve veri kullanımı
• Gecikme testi, IP adresleri ve DNS bilgisi
• Ana ekran widget'ı
• Açık ve koyu tema, 15 dil""",
)

L["ur"] = dict(
    title="سم کارڈ معلومات اور سگنل",
    short="ہر سم کا کیریئر، سگنل کی طاقت، نیٹ ورک، سیل ٹاورز اور ڈیٹا کا استعمال",
    full="""آپ کے سم کارڈز، نیٹ ورک اور سگنل کی ہر معلومات — ایک تیز اور صاف ستھری ایپ میں۔

اینڈرائیڈ جو تفصیلات مینیو کے پیچھے چھپاتا ہے، یہ ایپ انہیں ایک جگہ دکھاتی ہے: ہر سم کا کیریئر، سگنل کی اصل طاقت، نیٹ ورک کی قسم اور ڈیٹا کا استعمال۔

■ سم کارڈز
• ہر سم اور eSIM کے لیے اصلی جیسا کارڈ
• کیریئر، فون نمبر، ملک، MCC-MNC ‏(PLMN)، کیریئر آئی ڈی
• سم کی حالت، سلاٹ اور پورٹ، فزیکل سم یا eSIM
• دیکھیں کون سی سم ڈیٹا، کالز اور SMS سنبھالتی ہے

■ لائیو سگنل
• dBm اور ASU میں سگنل کی طاقت، ہر 3 سیکنڈ میں تازہ
• گزشتہ منٹوں کا لائیو چارٹ — گھوم کر بہتر سگنل کی جگہ تلاش کریں
• نیٹ ورک کی قسم اور نسل: 2G، 3G، 4G LTE، 5G NR
• رومنگ، موبائل ڈیٹا کی حالت اور وائس نیٹ ورک

■ سیل ٹاورز (اختیاری)
• جس ٹاور سے جڑے ہیں: سیل آئی ڈی، TAC/LAC، PCI
• فریکوئنسی چینل (EARFCN/NRARFCN)، بینڈ اور بینڈوڈتھ
• RSRP، RSRQ، SINR اور قریبی سیل
• مقام کی اجازت صرف تب استعمال ہوتی ہے جب آپ یہ حصہ آن کریں

■ ڈیٹا کا استعمال (اختیاری)
• موبائل اور Wi-Fi استعمال، آج اور اس مہینے
• اینڈرائیڈ کی استعمال تک رسائی سے — صرف آپ کی مرضی سے

■ کنکشن اور ٹولز
• فعال کنکشن: رفتار، DNS سرورز، IP پتے
• ایک ٹچ میں لیٹنسی ٹیسٹ
• نیٹ ورک، ڈیٹا، Wi-Fi اور ہوائی جہاز موڈ کی ترتیبات کے شارٹ کٹ

■ مزید
• ہوم اسکرین ویجٹ: ہر سم کا کیریئر، نیٹ ورک اور سگنل
• کسی بھی قدر کو ٹیپ کر کے کاپی کریں؛ رپورٹ متن یا JSON میں شیئر کریں
• روشن، تاریک اور سسٹم تھیم · 15 زبانیں
• ڈوئل سم اور eSIM کی مکمل سہولت

رازداری
سب کچھ آپ کے آلے پر اینڈرائیڈ سے براہ راست پڑھا جاتا ہے۔ نہ کوئی اکاؤنٹ، نہ کچھ کہیں اپ لوڈ ہوتا ہے۔""",
    whatsnew="""پہلا ریلیز 🎉
• ہر سم اور eSIM کی تفصیلات — کیریئر، نمبر، PLMN، سلاٹ
• ہسٹری چارٹ کے ساتھ لائیو سگنل میٹر
• اختیاری سیل ٹاورز اور ڈیٹا کا استعمال
• لیٹنسی ٹیسٹ، IP پتے اور DNS معلومات
• ہوم اسکرین ویجٹ
• روشن اور تاریک تھیم، 15 زبانیں""",
)

L["zh-CN"] = dict(
    title="SIM卡信息：信号与流量",
    short="查看每张SIM卡的运营商、信号强度、网络类型、基站与流量使用",
    full="""关于您的SIM卡、网络和信号的一切——都在这个快速、清爽的应用里。

Android 把这些信息藏在层层菜单之后，本应用将它们集中展示：每张 SIM 卡的运营商、真实信号强度、当前网络类型，以及流量使用情况。

■ SIM卡
• 每张 SIM 卡和 eSIM 都有一张仿真卡片
• 运营商、电话号码、国家/地区、MCC-MNC（PLMN）、运营商ID
• SIM 卡状态、卡槽与端口、实体卡或 eSIM
• 查看哪张卡负责流量、通话和短信

■ 实时信号
• 以 dBm 和 ASU 显示信号强度，每 3 秒刷新
• 最近几分钟的实时图表——边走边找信号好的位置
• 网络类型与代际：2G、3G、4G LTE、5G NR
• 漫游、移动数据状态和语音网络

■ 基站（可选）
• 当前连接的基站：小区ID、TAC/LAC、PCI
• 频点（EARFCN/NRARFCN）、频段与带宽
• RSRP、RSRQ、SINR 以及邻近小区
• 只有开启此功能时才使用位置权限

■ 流量使用（可选）
• 今天和本月的移动数据与 Wi-Fi 用量
• 通过 Android 的使用情况访问权限开启——完全由您决定

■ 连接与工具
• 当前连接：速度、DNS 服务器、私人DNS、IP 地址
• 一键延迟测试
• 快速跳转到移动网络、流量、Wi-Fi 和飞行模式设置

■ 更多
• 主屏幕小部件：每张卡的运营商、网络和信号
• 点按任意数值即可复制；以文本或 JSON 分享完整报告
• 浅色、深色和跟随系统主题 · 15 种语言
• 完整支持双卡与 eSIM

隐私
所有信息都直接从您设备上的 Android 读取。无需账号，任何数据都不会被上传。""",
    whatsnew="""首个版本 🎉
• 每张 SIM 卡和 eSIM 的详细信息——运营商、号码、PLMN、卡槽
• 带历史图表的实时信号仪表
• 可选的基站信息与流量使用
• 延迟测试、IP 地址和 DNS 信息
• 主屏幕小部件
• 浅色与深色主题，15 种语言""",
)

LIMITS = dict(title=30, short=80, full=4000, whatsnew=500)
FILENAMES = dict(
    title="title.txt",
    short="short_description.txt",
    full="full_description.txt",
    whatsnew="whats_new.txt",
)


def main():
    failures = []
    for locale, texts in L.items():
        directory = OUT / locale
        directory.mkdir(parents=True, exist_ok=True)
        for key, text in texts.items():
            text = text.strip()
            if len(text) > LIMITS[key]:
                failures.append(f"{locale}/{key}: {len(text)} > {LIMITS[key]}")
            (directory / FILENAMES[key]).write_text(text + "\n", encoding="utf-8")
    if failures:
        print("OVER PLAY LIMITS:", *failures, sep="\n  ")
        sys.exit(1)
    print(f"wrote {len(L)} locales to {OUT}")


if __name__ == "__main__":
    main()
