// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'SIM-Karten-Info';

  @override
  String get tabSims => 'SIMs';

  @override
  String get tabNetwork => 'Netz';

  @override
  String get tabDevice => 'Gerät';

  @override
  String get tabSettings => 'Einstellungen';

  @override
  String get titleSims => 'SIM-Karten';

  @override
  String get tooltipShareReport => 'Bericht teilen';

  @override
  String get tooltipRefresh => 'Aktualisieren';

  @override
  String get gateTitle => 'Telefon-Berechtigung erforderlich';

  @override
  String get gateBody =>
      'Android schützt SIM- und Netzdetails hinter der Telefon-Berechtigung. Alles wird auf deinem Gerät gelesen und verlässt es nie.';

  @override
  String get grantPermission => 'Berechtigung erteilen';

  @override
  String get openAppSettings => 'App-Einstellungen öffnen';

  @override
  String get gatePermanent =>
      'Die Berechtigung wurde dauerhaft verweigert und kann nur noch in den App-Einstellungen aktiviert werden.';

  @override
  String get noSimsTitle => 'Keine aktiven SIM-Karten';

  @override
  String get noSimsBody =>
      'Auf diesem Gerät ist keine SIM oder eSIM aktiv. Lege eine SIM ein oder aktiviere eine eSIM und ziehe dann zum Aktualisieren.';

  @override
  String get sectionSubscription => 'ABONNEMENT';

  @override
  String get sectionRoles => 'ROLLEN';

  @override
  String get sectionCellular => 'MOBILFUNK';

  @override
  String get sectionServingCell => 'VERSORGENDE ZELLE';

  @override
  String get sectionNeighbours => 'NACHBARZELLEN';

  @override
  String get sectionCellTowers => 'FUNKMASTEN';

  @override
  String get sectionDataUsage => 'DATENVERBRAUCH';

  @override
  String get sectionActiveConnection => 'AKTIVE VERBINDUNG';

  @override
  String get sectionIpAddresses => 'IP-ADRESSEN';

  @override
  String get sectionLatency => 'LATENZ';

  @override
  String get sectionDevice => 'GERÄT';

  @override
  String get sectionSimCapabilities => 'SIM-FUNKTIONEN';

  @override
  String get sectionCalling => 'ANRUFE & NACHRICHTEN';

  @override
  String get sectionSystemSettings => 'SYSTEMEINSTELLUNGEN';

  @override
  String get sectionAppearance => 'DARSTELLUNG';

  @override
  String get labelLanguage => 'Sprache';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get labelCarrier => 'Anbieter';

  @override
  String get labelLabel => 'Bezeichnung';

  @override
  String get labelPhoneNumber => 'Telefonnummer';

  @override
  String get labelCountry => 'Land';

  @override
  String get labelMccMnc => 'MCC-MNC (PLMN)';

  @override
  String get labelCarrierId => 'Anbieter-ID';

  @override
  String get labelSpecificCarrier => 'Spezifischer Anbieter';

  @override
  String get labelSimState => 'SIM-Status';

  @override
  String get labelSimType => 'SIM-Typ';

  @override
  String get labelSlot => 'Steckplatz';

  @override
  String get labelPort => 'Port';

  @override
  String get labelSubscriptionId => 'Abonnement-ID';

  @override
  String get labelOpportunistic => 'Opportunistisch';

  @override
  String get labelMobileData => 'Mobile Daten';

  @override
  String get chipData => 'Daten';

  @override
  String get labelCalls => 'Anrufe';

  @override
  String get labelSms => 'SMS';

  @override
  String get labelNetworkType => 'Netztyp';

  @override
  String get labelVoiceNetwork => 'Sprachnetz';

  @override
  String get labelOperator => 'Netzbetreiber';

  @override
  String get labelOperatorCode => 'Betreibercode';

  @override
  String get labelNetworkCountry => 'Netzland';

  @override
  String get labelRoaming => 'Roaming';

  @override
  String get labelDataEnabled => 'Daten aktiviert';

  @override
  String get labelDataActivity => 'Datenaktivität';

  @override
  String get labelPhoneType => 'Telefontyp';

  @override
  String get labelSignal => 'Signal';

  @override
  String get labelStatus => 'Status';

  @override
  String get labelConnection => 'Verbindung';

  @override
  String get labelInternetAccess => 'Internetzugang';

  @override
  String get labelMetered => 'Getaktet';

  @override
  String get labelLinkDown => 'Download-Geschwindigkeit';

  @override
  String get labelLinkUp => 'Upload-Geschwindigkeit';

  @override
  String get labelInterface => 'Schnittstelle';

  @override
  String get labelDnsServer => 'DNS-Server';

  @override
  String get labelPrivateDns => 'Privates DNS';

  @override
  String get labelModel => 'Modell';

  @override
  String get labelDeviceCodename => 'Gerät-Codename';

  @override
  String get labelAndroidVersion => 'Android-Version';

  @override
  String get labelRadioVersion => 'Funkmodul (IMEI SV)';

  @override
  String get labelTelephonyHardware => 'Telefonie-Hardware';

  @override
  String get labelSimCardPresent => 'SIM-Karte vorhanden';

  @override
  String get labelEsimSupported => 'eSIM unterstützt';

  @override
  String get labelActiveModems => 'Aktive Modems';

  @override
  String get labelSupportedModems => 'Unterstützte Modems';

  @override
  String get labelMaxActiveSims => 'Max. aktive SIMs';

  @override
  String get labelDualSim => 'Dual-SIM';

  @override
  String get labelVoiceCapable => 'Sprachfähig';

  @override
  String get labelSmsCapable => 'SMS-fähig';

  @override
  String get labelVoiceAndData => 'Sprache + Daten gleichzeitig';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get unavailable => 'Nicht verfügbar';

  @override
  String get unknown => 'Unbekannt';

  @override
  String get physicalSim => 'Physische SIM';

  @override
  String get esimEmbedded => 'eSIM (eingebettet)';

  @override
  String get defaultSim => 'Standard-SIM';

  @override
  String get notDefault => 'Nicht Standard';

  @override
  String get validated => 'Validiert';

  @override
  String get notValidated => 'Nicht validiert';

  @override
  String get off => 'Aus';

  @override
  String get noActiveNetwork => 'Kein aktives Netzwerk';

  @override
  String get noActiveSim => 'Keine aktive SIM zum Messen';

  @override
  String get noCellReported => 'Noch keine Zelle gemeldet';

  @override
  String slotN(int n) {
    return 'Steckplatz $n';
  }

  @override
  String simN(int n) {
    return 'SIM $n';
  }

  @override
  String copied(String label) {
    return '$label kopiert';
  }

  @override
  String get qualityExcellent => 'Ausgezeichnet';

  @override
  String get qualityGood => 'Gut';

  @override
  String get qualityFair => 'Mittelmäßig';

  @override
  String get qualityPoor => 'Schwach';

  @override
  String get qualityVeryPoor => 'Sehr schwach';

  @override
  String get signalNone => 'Kein Signal oder unbekannt';

  @override
  String get simStateReady => 'Bereit';

  @override
  String get simStateAbsent => 'Nicht eingelegt';

  @override
  String get simStatePin => 'PIN erforderlich';

  @override
  String get simStatePuk => 'PUK erforderlich';

  @override
  String get simStateNetworkLocked => 'Netzgesperrt';

  @override
  String get simStateNotReady => 'Nicht bereit';

  @override
  String get simStateDisabled => 'Dauerhaft deaktiviert';

  @override
  String get simStateIoError => 'Karten-E/A-Fehler';

  @override
  String get simStateRestricted => 'Karte eingeschränkt';

  @override
  String get dataConnected => 'Verbunden';

  @override
  String get dataDisconnected => 'Getrennt';

  @override
  String get dataConnecting => 'Verbindet';

  @override
  String get dataSuspended => 'Angehalten';

  @override
  String get dataDisconnecting => 'Wird getrennt';

  @override
  String get activityIdle => 'Inaktiv';

  @override
  String get activityReceiving => 'Empfängt';

  @override
  String get activitySending => 'Sendet';

  @override
  String get activityBoth => 'Sendet und empfängt';

  @override
  String get activityDormant => 'Ruhend';

  @override
  String get cellTowersExplainer =>
      'Zeigt den Funkmast, mit dem dein Telefon verbunden ist — Zell-ID, Gebietscode, PCI, Frequenzkanal und Bänder — sowie Nachbarmasten. Android zählt eine Zell-ID als Standortdaten, daher ist die Standortberechtigung nötig. Sie wird für nichts anderes verwendet und nichts verlässt dein Gerät.';

  @override
  String get showCellTowers => 'Funkmasten anzeigen';

  @override
  String get locationPermanent =>
      'Der Standort wurde dauerhaft verweigert und kann nur noch in den App-Einstellungen aktiviert werden.';

  @override
  String get dataUsageExplainer =>
      'Zeigt, wie viel mobile Daten und WLAN dieses Gerät heute und diesen Monat verbraucht hat. Android schützt diese Zahlen hinter der Nutzungszugriff-Einstellung — unten tippen, SIM Card Info in der Liste erlauben und zurückkommen.';

  @override
  String get grantUsageAccess => 'Nutzungszugriff erteilen';

  @override
  String get mobileToday => 'Mobil heute';

  @override
  String get mobileMonth => 'Mobil diesen Monat';

  @override
  String get wifiToday => 'WLAN heute';

  @override
  String get wifiMonth => 'WLAN diesen Monat';

  @override
  String get usageDisclaimer =>
      'Mobil umfasst alle SIMs zusammen — Android erlaubt Apps keine Aufteilung pro SIM.';

  @override
  String get latencyExplainer =>
      'Misst die Laufzeit zu Cloudflare, Google DNS und google.com über die aktuelle Verbindung.';

  @override
  String get runTest => 'Test starten';

  @override
  String get runAgain => 'Erneut testen';

  @override
  String get unreachable => 'Nicht erreichbar';

  @override
  String get shortcutMobile => 'Mobilfunk-Einstellungen';

  @override
  String get shortcutDataUsage => 'Datenverbrauch';

  @override
  String get shortcutWifi => 'WLAN-Einstellungen';

  @override
  String get shortcutAirplane => 'Flugmodus';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeSystem => 'System';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get shareFullReport => 'Vollständigen Bericht teilen';

  @override
  String get shareFullReportSubtitle =>
      'SIM-, Netz- und Gerätedetails als Text';

  @override
  String get shareJson => 'Bericht als JSON teilen';

  @override
  String get shareJsonSubtitle => 'Maschinenlesbar, für Tools und Skripte';

  @override
  String get shareApp => 'Diese App teilen';

  @override
  String shareAppText(String url) {
    return 'SIM-Karten-Info — Anbieter-, Signal- und Netzdetails für jede SIM. $url';
  }

  @override
  String get privacyOptions => 'Datenschutzoptionen';

  @override
  String get privacyOptionsSubtitle => 'Deine Einwilligung zu Werbung ändern';

  @override
  String privacyOptionsFailed(String message) {
    return 'Datenschutzoptionen konnten nicht geöffnet werden: $message';
  }

  @override
  String aboutVersion(String version) {
    return 'Version $version · von Tahatec';
  }

  @override
  String get aboutBy => 'von Tahatec';

  @override
  String get privacyNote =>
      'Alle SIM-, Netz- und Gerätedetails werden direkt von Android auf deinem Gerät gelesen und von dieser App nirgendwohin hochgeladen.';

  @override
  String sparklineCaption(int dbm, String window) {
    return '$dbm dBm jetzt · letzte $window';
  }

  @override
  String get windowMinute => 'Minute';

  @override
  String windowMinutes(int n) {
    return '$n Min.';
  }
}
