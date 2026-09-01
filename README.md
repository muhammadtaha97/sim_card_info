# SIM Card Info

Carrier, network, signal and device details for every SIM slot — read entirely
on device through the app's own platform channel (`MainActivity.kt`), with no
plugin between the app and `TelephonyManager` / `SubscriptionManager` /
`ConnectivityManager`.

Package: `com.tahatec.sim_card_info` · targets API 37 · min API 24.

## What it shows

- **SIM Cards** — one card per active subscription: carrier, label, number
  (when the carrier exposes it), country + flag, MCC-MNC, carrier id, SIM
  state, physical/eSIM, slot/port, and which SIM is the default for data,
  calls and SMS.
- **Network** — live signal (dBm, ASU, 0–4 level, per-radio readings) polled
  every 3 s while visible with a rolling sparkline of the last ~6 minutes,
  network type and generation (2G–5G), operator, roaming, data
  state/activity, plus the active connection: transport, metered, link
  bandwidth, DNS servers, private DNS, interface and local IPs — and a
  TCP-connect latency tool (Cloudflare / Google DNS / google.com).
- **Cell towers** (opt-in) — serving and neighbouring cells: Cell ID,
  TAC/LAC, PCI, ARFCN, 3GPP bands, bandwidth, RSRP/RSRQ/SINR, timing
  advance. Fresh via `requestCellInfoUpdate`, cached fallback below API 29.
- **Data usage** (opt-in) — mobile (all SIMs, honestly labelled — per-SIM
  needs carrier privileges) and Wi-Fi, today and this month, via
  `NetworkStatsManager`.
- **Device** — model, Android version, modem count, dual-SIM, eSIM support,
  voice/SMS capability, radio version, plus shortcuts into the system
  mobile/data-usage/Wi-Fi/airplane screens.
- **Home screen widget** — carrier, generation and signal per SIM, reading
  telephony directly so it works with the app process dead; refreshed on
  every app reload and every 30 min by the launcher.
- **Settings** — light/dark/system theme, share report as text or JSON, UMP
  privacy options (shown only where required), about.

Everything on screen copies with a tap; the full state shares as a plain-text
or JSON report (`ReportBuilder`). UI is localized in 15 languages (ar, bn,
de, en, es, fr, hi, it, ja, ko, pt, ru, tr, ur, zh); telephony values (radio
names, technical states in the report) stay English as terms of art.

## Permissions

`READ_PHONE_STATE` + `READ_PHONE_NUMBERS` (one runtime prompt) gate the SIM
and network tabs; Device and Settings work without them.
`ACCESS_FINE_LOCATION` is requested **only** when the user opts in to the
cell towers section (Android treats a cell id as location), and
`PACKAGE_USAGE_STATS` (Usage Access, a settings-screen toggle) only when the
user opts in to data usage. Neither is touched at startup.

## Monetisation

AdMob banner (anchored, adaptive) + interstitial behind
`InterstitialPolicy` (3-action warmup, ≥2 min apart), UMP consent flow before
the SDK starts. Ids live in `lib/services/ad_service.dart` and are pinned by
`test/config_test.dart`.

## Build

```
flutter test                     # includes the config/agreement gates
flutter build appbundle --release
tool/check_16kb.sh               # Play 16 KB page-size requirement
python3 tool/generate_icons.py   # regenerates every launcher asset
```

Release signing reads `android/key.properties` (not committed).
