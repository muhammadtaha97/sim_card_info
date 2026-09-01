// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Info scheda SIM';

  @override
  String get tabSims => 'SIM';

  @override
  String get tabNetwork => 'Rete';

  @override
  String get tabDevice => 'Dispositivo';

  @override
  String get tabSettings => 'Impostazioni';

  @override
  String get titleSims => 'Schede SIM';

  @override
  String get tooltipShareReport => 'Condividi rapporto';

  @override
  String get tooltipRefresh => 'Aggiorna';

  @override
  String get gateTitle => 'Serve l\'autorizzazione Telefono';

  @override
  String get gateBody =>
      'Android protegge i dettagli di SIM e rete dietro l\'autorizzazione Telefono. Tutto viene letto sul tuo dispositivo e non lo lascia mai.';

  @override
  String get grantPermission => 'Concedi autorizzazione';

  @override
  String get openAppSettings => 'Apri impostazioni app';

  @override
  String get gatePermanent =>
      'L\'autorizzazione è stata negata in modo permanente: può essere attivata solo dalle impostazioni dell\'app.';

  @override
  String get noSimsTitle => 'Nessuna SIM attiva';

  @override
  String get noSimsBody =>
      'Nessuna SIM o eSIM è attiva su questo dispositivo. Inserisci una SIM o attiva una eSIM, poi trascina per aggiornare.';

  @override
  String get sectionSubscription => 'ABBONAMENTO';

  @override
  String get sectionRoles => 'RUOLI';

  @override
  String get sectionCellular => 'RETE MOBILE';

  @override
  String get sectionServingCell => 'CELLA SERVENTE';

  @override
  String get sectionNeighbours => 'CELLE VICINE';

  @override
  String get sectionCellTowers => 'CELLE TELEFONICHE';

  @override
  String get sectionDataUsage => 'UTILIZZO DATI';

  @override
  String get sectionActiveConnection => 'CONNESSIONE ATTIVA';

  @override
  String get sectionIpAddresses => 'INDIRIZZI IP';

  @override
  String get sectionLatency => 'LATENZA';

  @override
  String get sectionDevice => 'DISPOSITIVO';

  @override
  String get sectionSimCapabilities => 'CAPACITÀ SIM';

  @override
  String get sectionCalling => 'CHIAMATE E MESSAGGI';

  @override
  String get sectionSystemSettings => 'IMPOSTAZIONI DI SISTEMA';

  @override
  String get sectionAppearance => 'ASPETTO';

  @override
  String get labelLanguage => 'Lingua';

  @override
  String get systemDefault => 'Predefinita di sistema';

  @override
  String get labelCarrier => 'Operatore';

  @override
  String get labelLabel => 'Etichetta';

  @override
  String get labelPhoneNumber => 'Numero di telefono';

  @override
  String get labelCountry => 'Paese';

  @override
  String get labelMccMnc => 'MCC-MNC (PLMN)';

  @override
  String get labelCarrierId => 'ID operatore';

  @override
  String get labelSpecificCarrier => 'Operatore specifico';

  @override
  String get labelSimState => 'Stato SIM';

  @override
  String get labelSimType => 'Tipo di SIM';

  @override
  String get labelSlot => 'Slot';

  @override
  String get labelPort => 'Porta';

  @override
  String get labelSubscriptionId => 'ID abbonamento';

  @override
  String get labelOpportunistic => 'Opportunistica';

  @override
  String get labelMobileData => 'Dati mobili';

  @override
  String get chipData => 'Dati';

  @override
  String get labelCalls => 'Chiamate';

  @override
  String get labelSms => 'SMS';

  @override
  String get labelNetworkType => 'Tipo di rete';

  @override
  String get labelVoiceNetwork => 'Rete voce';

  @override
  String get labelOperator => 'Operatore di rete';

  @override
  String get labelOperatorCode => 'Codice operatore';

  @override
  String get labelNetworkCountry => 'Paese della rete';

  @override
  String get labelRoaming => 'Roaming';

  @override
  String get labelDataEnabled => 'Dati attivi';

  @override
  String get labelDataActivity => 'Attività dati';

  @override
  String get labelPhoneType => 'Tipo di telefono';

  @override
  String get labelSignal => 'Segnale';

  @override
  String get labelStatus => 'Stato';

  @override
  String get labelConnection => 'Connessione';

  @override
  String get labelInternetAccess => 'Accesso a Internet';

  @override
  String get labelMetered => 'A consumo';

  @override
  String get labelLinkDown => 'Velocità in download';

  @override
  String get labelLinkUp => 'Velocità in upload';

  @override
  String get labelInterface => 'Interfaccia';

  @override
  String get labelDnsServer => 'Server DNS';

  @override
  String get labelPrivateDns => 'DNS privato';

  @override
  String get labelModel => 'Modello';

  @override
  String get labelDeviceCodename => 'Nome in codice';

  @override
  String get labelAndroidVersion => 'Versione Android';

  @override
  String get labelRadioVersion => 'Radio (IMEI SV)';

  @override
  String get labelTelephonyHardware => 'Hardware di telefonia';

  @override
  String get labelSimCardPresent => 'SIM presente';

  @override
  String get labelEsimSupported => 'eSIM supportata';

  @override
  String get labelActiveModems => 'Modem attivi';

  @override
  String get labelSupportedModems => 'Modem supportati';

  @override
  String get labelMaxActiveSims => 'Max SIM attive';

  @override
  String get labelDualSim => 'Dual SIM';

  @override
  String get labelVoiceCapable => 'Supporta voce';

  @override
  String get labelSmsCapable => 'Supporta SMS';

  @override
  String get labelVoiceAndData => 'Voce + dati insieme';

  @override
  String get yes => 'Sì';

  @override
  String get no => 'No';

  @override
  String get unavailable => 'Non disponibile';

  @override
  String get unknown => 'Sconosciuto';

  @override
  String get physicalSim => 'SIM fisica';

  @override
  String get esimEmbedded => 'eSIM (integrata)';

  @override
  String get defaultSim => 'SIM predefinita';

  @override
  String get notDefault => 'Non predefinita';

  @override
  String get validated => 'Convalidato';

  @override
  String get notValidated => 'Non convalidato';

  @override
  String get off => 'Disattivato';

  @override
  String get noActiveNetwork => 'Nessuna rete attiva';

  @override
  String get noActiveSim => 'Nessuna SIM attiva da misurare';

  @override
  String get noCellReported => 'Nessuna cella rilevata finora';

  @override
  String slotN(int n) {
    return 'Slot $n';
  }

  @override
  String simN(int n) {
    return 'SIM $n';
  }

  @override
  String copied(String label) {
    return '$label copiato';
  }

  @override
  String get qualityExcellent => 'Eccellente';

  @override
  String get qualityGood => 'Buono';

  @override
  String get qualityFair => 'Discreto';

  @override
  String get qualityPoor => 'Debole';

  @override
  String get qualityVeryPoor => 'Molto debole';

  @override
  String get signalNone => 'Nessun segnale o sconosciuto';

  @override
  String get simStateReady => 'Pronta';

  @override
  String get simStateAbsent => 'Assente';

  @override
  String get simStatePin => 'PIN richiesto';

  @override
  String get simStatePuk => 'PUK richiesto';

  @override
  String get simStateNetworkLocked => 'Bloccata dalla rete';

  @override
  String get simStateNotReady => 'Non pronta';

  @override
  String get simStateDisabled => 'Disattivata definitivamente';

  @override
  String get simStateIoError => 'Errore I/O della scheda';

  @override
  String get simStateRestricted => 'Scheda limitata';

  @override
  String get dataConnected => 'Connesso';

  @override
  String get dataDisconnected => 'Disconnesso';

  @override
  String get dataConnecting => 'Connessione…';

  @override
  String get dataSuspended => 'Sospeso';

  @override
  String get dataDisconnecting => 'Disconnessione…';

  @override
  String get activityIdle => 'Inattivo';

  @override
  String get activityReceiving => 'In ricezione';

  @override
  String get activitySending => 'In invio';

  @override
  String get activityBoth => 'Invio e ricezione';

  @override
  String get activityDormant => 'Dormiente';

  @override
  String get cellTowersExplainer =>
      'Vedi la cella a cui è connesso il telefono — Cell ID, codice area, PCI, canale di frequenza e bande — più le celle vicine. Android considera l\'id di cella un dato di posizione, quindi serve l\'autorizzazione Posizione. Non viene usata per altro e nulla lascia il tuo dispositivo.';

  @override
  String get showCellTowers => 'Mostra celle';

  @override
  String get locationPermanent =>
      'La posizione è stata negata in modo permanente: può essere attivata solo dalle impostazioni dell\'app.';

  @override
  String get dataUsageExplainer =>
      'Vedi quanti dati mobili e Wi-Fi ha usato questo dispositivo oggi e questo mese. Android protegge questi numeri dietro l\'impostazione Accesso all\'utilizzo — tocca sotto, consenti SIM Card Info nell\'elenco e torna qui.';

  @override
  String get grantUsageAccess => 'Concedi accesso all\'utilizzo';

  @override
  String get mobileToday => 'Mobile oggi';

  @override
  String get mobileMonth => 'Mobile questo mese';

  @override
  String get wifiToday => 'Wi-Fi oggi';

  @override
  String get wifiMonth => 'Wi-Fi questo mese';

  @override
  String get usageDisclaimer =>
      'Mobile include tutte le SIM insieme — Android non consente alle app di dividere l\'uso per SIM.';

  @override
  String get latencyExplainer =>
      'Misura l\'andata e ritorno verso Cloudflare, Google DNS e google.com sulla connessione attuale.';

  @override
  String get runTest => 'Avvia test';

  @override
  String get runAgain => 'Ripeti test';

  @override
  String get unreachable => 'Irraggiungibile';

  @override
  String get shortcutMobile => 'Impostazioni rete mobile';

  @override
  String get shortcutDataUsage => 'Utilizzo dati';

  @override
  String get shortcutWifi => 'Impostazioni Wi-Fi';

  @override
  String get shortcutAirplane => 'Modalità aereo';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeDark => 'Scuro';

  @override
  String get shareFullReport => 'Condividi rapporto completo';

  @override
  String get shareFullReportSubtitle =>
      'Dettagli di SIM, rete e dispositivo come testo';

  @override
  String get shareJson => 'Condividi rapporto in JSON';

  @override
  String get shareJsonSubtitle =>
      'Leggibile dalle macchine, per strumenti e script';

  @override
  String get shareApp => 'Condividi questa app';

  @override
  String shareAppText(String url) {
    return 'Info scheda SIM — operatore, segnale e rete per ogni SIM. $url';
  }

  @override
  String get privacyOptions => 'Opzioni privacy';

  @override
  String get privacyOptionsSubtitle => 'Cambia il consenso agli annunci';

  @override
  String privacyOptionsFailed(String message) {
    return 'Impossibile aprire le opzioni privacy: $message';
  }

  @override
  String aboutVersion(String version) {
    return 'Versione $version · di Tahatec';
  }

  @override
  String get aboutBy => 'di Tahatec';

  @override
  String get privacyNote =>
      'Tutti i dettagli di SIM, rete e dispositivo vengono letti direttamente da Android sul tuo dispositivo e questa app non li carica da nessuna parte.';

  @override
  String sparklineCaption(int dbm, String window) {
    return '$dbm dBm ora · ultimi $window';
  }

  @override
  String get windowMinute => '1 min';

  @override
  String windowMinutes(int n) {
    return '$n min';
  }
}
