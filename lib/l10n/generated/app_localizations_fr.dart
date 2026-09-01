// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Infos carte SIM';

  @override
  String get tabSims => 'SIM';

  @override
  String get tabNetwork => 'Réseau';

  @override
  String get tabDevice => 'Appareil';

  @override
  String get tabSettings => 'Réglages';

  @override
  String get titleSims => 'Cartes SIM';

  @override
  String get tooltipShareReport => 'Partager le rapport';

  @override
  String get tooltipRefresh => 'Actualiser';

  @override
  String get gateTitle => 'Autorisation Téléphone requise';

  @override
  String get gateBody =>
      'Android protège les détails de la SIM et du réseau derrière l\'autorisation Téléphone. Tout est lu sur votre appareil et n\'en sort jamais.';

  @override
  String get grantPermission => 'Accorder l\'autorisation';

  @override
  String get openAppSettings => 'Ouvrir les paramètres de l\'app';

  @override
  String get gatePermanent =>
      'L\'autorisation a été refusée définitivement ; elle ne peut être activée que depuis les paramètres de l\'app.';

  @override
  String get noSimsTitle => 'Aucune carte SIM active';

  @override
  String get noSimsBody =>
      'Aucune SIM ou eSIM n\'est active sur cet appareil. Insérez une SIM ou activez une eSIM, puis tirez pour actualiser.';

  @override
  String get sectionSubscription => 'ABONNEMENT';

  @override
  String get sectionRoles => 'RÔLES';

  @override
  String get sectionCellular => 'RÉSEAU MOBILE';

  @override
  String get sectionServingCell => 'CELLULE SERVEUSE';

  @override
  String get sectionNeighbours => 'CELLULES VOISINES';

  @override
  String get sectionCellTowers => 'ANTENNES-RELAIS';

  @override
  String get sectionDataUsage => 'CONSOMMATION DE DONNÉES';

  @override
  String get sectionActiveConnection => 'CONNEXION ACTIVE';

  @override
  String get sectionIpAddresses => 'ADRESSES IP';

  @override
  String get sectionLatency => 'LATENCE';

  @override
  String get sectionDevice => 'APPAREIL';

  @override
  String get sectionSimCapabilities => 'CAPACITÉS SIM';

  @override
  String get sectionCalling => 'APPELS ET MESSAGES';

  @override
  String get sectionSystemSettings => 'PARAMÈTRES SYSTÈME';

  @override
  String get sectionAppearance => 'APPARENCE';

  @override
  String get labelLanguage => 'Langue';

  @override
  String get systemDefault => 'Par défaut du système';

  @override
  String get labelCarrier => 'Opérateur';

  @override
  String get labelLabel => 'Libellé';

  @override
  String get labelPhoneNumber => 'Numéro de téléphone';

  @override
  String get labelCountry => 'Pays';

  @override
  String get labelMccMnc => 'MCC-MNC (PLMN)';

  @override
  String get labelCarrierId => 'ID opérateur';

  @override
  String get labelSpecificCarrier => 'Opérateur spécifique';

  @override
  String get labelSimState => 'État de la SIM';

  @override
  String get labelSimType => 'Type de SIM';

  @override
  String get labelSlot => 'Emplacement';

  @override
  String get labelPort => 'Port';

  @override
  String get labelSubscriptionId => 'ID d\'abonnement';

  @override
  String get labelOpportunistic => 'Opportuniste';

  @override
  String get labelMobileData => 'Données mobiles';

  @override
  String get chipData => 'Données';

  @override
  String get labelCalls => 'Appels';

  @override
  String get labelSms => 'SMS';

  @override
  String get labelNetworkType => 'Type de réseau';

  @override
  String get labelVoiceNetwork => 'Réseau voix';

  @override
  String get labelOperator => 'Opérateur réseau';

  @override
  String get labelOperatorCode => 'Code opérateur';

  @override
  String get labelNetworkCountry => 'Pays du réseau';

  @override
  String get labelRoaming => 'Itinérance';

  @override
  String get labelDataEnabled => 'Données activées';

  @override
  String get labelDataActivity => 'Activité des données';

  @override
  String get labelPhoneType => 'Type de téléphone';

  @override
  String get labelSignal => 'Signal';

  @override
  String get labelStatus => 'État';

  @override
  String get labelConnection => 'Connexion';

  @override
  String get labelInternetAccess => 'Accès Internet';

  @override
  String get labelMetered => 'Facturée à l\'usage';

  @override
  String get labelLinkDown => 'Débit descendant';

  @override
  String get labelLinkUp => 'Débit montant';

  @override
  String get labelInterface => 'Interface';

  @override
  String get labelDnsServer => 'Serveur DNS';

  @override
  String get labelPrivateDns => 'DNS privé';

  @override
  String get labelModel => 'Modèle';

  @override
  String get labelDeviceCodename => 'Nom de code';

  @override
  String get labelAndroidVersion => 'Version d\'Android';

  @override
  String get labelRadioVersion => 'Radio (IMEI SV)';

  @override
  String get labelTelephonyHardware => 'Matériel de téléphonie';

  @override
  String get labelSimCardPresent => 'SIM présente';

  @override
  String get labelEsimSupported => 'eSIM prise en charge';

  @override
  String get labelActiveModems => 'Modems actifs';

  @override
  String get labelSupportedModems => 'Modems pris en charge';

  @override
  String get labelMaxActiveSims => 'Max de SIM actives';

  @override
  String get labelDualSim => 'Double SIM';

  @override
  String get labelVoiceCapable => 'Voix possible';

  @override
  String get labelSmsCapable => 'SMS possibles';

  @override
  String get labelVoiceAndData => 'Voix + données simultanées';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get unavailable => 'Indisponible';

  @override
  String get unknown => 'Inconnu';

  @override
  String get physicalSim => 'SIM physique';

  @override
  String get esimEmbedded => 'eSIM (intégrée)';

  @override
  String get defaultSim => 'SIM par défaut';

  @override
  String get notDefault => 'Pas par défaut';

  @override
  String get validated => 'Validé';

  @override
  String get notValidated => 'Non validé';

  @override
  String get off => 'Désactivé';

  @override
  String get noActiveNetwork => 'Aucun réseau actif';

  @override
  String get noActiveSim => 'Aucune SIM active à mesurer';

  @override
  String get noCellReported => 'Aucune cellule signalée pour l\'instant';

  @override
  String slotN(int n) {
    return 'Emplacement $n';
  }

  @override
  String simN(int n) {
    return 'SIM $n';
  }

  @override
  String copied(String label) {
    return '$label copié';
  }

  @override
  String get qualityExcellent => 'Excellent';

  @override
  String get qualityGood => 'Bon';

  @override
  String get qualityFair => 'Moyen';

  @override
  String get qualityPoor => 'Faible';

  @override
  String get qualityVeryPoor => 'Très faible';

  @override
  String get signalNone => 'Aucun signal ou inconnu';

  @override
  String get simStateReady => 'Prête';

  @override
  String get simStateAbsent => 'Absente';

  @override
  String get simStatePin => 'PIN requis';

  @override
  String get simStatePuk => 'PUK requis';

  @override
  String get simStateNetworkLocked => 'Verrouillée réseau';

  @override
  String get simStateNotReady => 'Pas prête';

  @override
  String get simStateDisabled => 'Désactivée définitivement';

  @override
  String get simStateIoError => 'Erreur E/S de la carte';

  @override
  String get simStateRestricted => 'Carte restreinte';

  @override
  String get dataConnected => 'Connecté';

  @override
  String get dataDisconnected => 'Déconnecté';

  @override
  String get dataConnecting => 'Connexion…';

  @override
  String get dataSuspended => 'Suspendu';

  @override
  String get dataDisconnecting => 'Déconnexion…';

  @override
  String get activityIdle => 'Inactif';

  @override
  String get activityReceiving => 'Réception';

  @override
  String get activitySending => 'Envoi';

  @override
  String get activityBoth => 'Envoi et réception';

  @override
  String get activityDormant => 'Dormant';

  @override
  String get cellTowersExplainer =>
      'Affichez l\'antenne à laquelle votre téléphone est connecté — Cell ID, code de zone, PCI, canal de fréquence et bandes — ainsi que les antennes voisines. Android considère un id de cellule comme une donnée de localisation : l\'autorisation Localisation est donc requise. Elle ne sert à rien d\'autre et rien ne quitte votre appareil.';

  @override
  String get showCellTowers => 'Afficher les antennes';

  @override
  String get locationPermanent =>
      'La localisation a été refusée définitivement ; elle ne peut être activée que depuis les paramètres de l\'app.';

  @override
  String get dataUsageExplainer =>
      'Consultez la quantité de données mobiles et de Wi-Fi utilisée aujourd\'hui et ce mois-ci. Android protège ces chiffres derrière le réglage Accès à l\'utilisation — touchez ci-dessous, autorisez SIM Card Info dans la liste et revenez.';

  @override
  String get grantUsageAccess => 'Accorder l\'accès à l\'utilisation';

  @override
  String get mobileToday => 'Mobile aujourd\'hui';

  @override
  String get mobileMonth => 'Mobile ce mois-ci';

  @override
  String get wifiToday => 'Wi-Fi aujourd\'hui';

  @override
  String get wifiMonth => 'Wi-Fi ce mois-ci';

  @override
  String get usageDisclaimer =>
      'Mobile regroupe toutes les SIM — Android ne permet pas de répartir l\'usage par SIM.';

  @override
  String get latencyExplainer =>
      'Mesure l\'aller-retour vers Cloudflare, Google DNS et google.com sur la connexion actuelle.';

  @override
  String get runTest => 'Lancer le test';

  @override
  String get runAgain => 'Relancer';

  @override
  String get unreachable => 'Injoignable';

  @override
  String get shortcutMobile => 'Paramètres du réseau mobile';

  @override
  String get shortcutDataUsage => 'Consommation de données';

  @override
  String get shortcutWifi => 'Paramètres Wi-Fi';

  @override
  String get shortcutAirplane => 'Mode avion';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeDark => 'Sombre';

  @override
  String get shareFullReport => 'Partager le rapport complet';

  @override
  String get shareFullReportSubtitle =>
      'Détails SIM, réseau et appareil en texte';

  @override
  String get shareJson => 'Partager le rapport en JSON';

  @override
  String get shareJsonSubtitle => 'Lisible par machine, pour outils et scripts';

  @override
  String get shareApp => 'Partager cette app';

  @override
  String shareAppText(String url) {
    return 'Infos carte SIM — opérateur, signal et réseau pour chaque SIM. $url';
  }

  @override
  String get privacyOptions => 'Options de confidentialité';

  @override
  String get privacyOptionsSubtitle =>
      'Modifier votre consentement aux annonces';

  @override
  String privacyOptionsFailed(String message) {
    return 'Impossible d\'ouvrir les options de confidentialité : $message';
  }

  @override
  String aboutVersion(String version) {
    return 'Version $version · par Tahatec';
  }

  @override
  String get aboutBy => 'par Tahatec';

  @override
  String get privacyNote =>
      'Tous les détails SIM, réseau et appareil sont lus directement depuis Android sur votre appareil et ne sont jamais envoyés ailleurs par cette app.';

  @override
  String sparklineCaption(int dbm, String window) {
    return '$dbm dBm maintenant · dernières $window';
  }

  @override
  String get windowMinute => 'minute';

  @override
  String windowMinutes(int n) {
    return '$n min';
  }
}
