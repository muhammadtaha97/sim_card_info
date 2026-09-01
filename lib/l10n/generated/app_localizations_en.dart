// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SIM Card Info';

  @override
  String get tabSims => 'SIMs';

  @override
  String get tabNetwork => 'Network';

  @override
  String get tabDevice => 'Device';

  @override
  String get tabSettings => 'Settings';

  @override
  String get titleSims => 'SIM Cards';

  @override
  String get tooltipShareReport => 'Share report';

  @override
  String get tooltipRefresh => 'Refresh';

  @override
  String get gateTitle => 'Phone permission needed';

  @override
  String get gateBody =>
      'Android protects SIM and network details behind the Phone permission. Everything is read on your device and never leaves it.';

  @override
  String get grantPermission => 'Grant permission';

  @override
  String get openAppSettings => 'Open app settings';

  @override
  String get gatePermanent =>
      'Permission was denied permanently, so it can only be enabled from the app settings screen.';

  @override
  String get noSimsTitle => 'No active SIM cards';

  @override
  String get noSimsBody =>
      'No SIM or eSIM is active on this device. Insert a SIM or enable an eSIM, then pull to refresh.';

  @override
  String get sectionSubscription => 'SUBSCRIPTION';

  @override
  String get sectionRoles => 'ROLES';

  @override
  String get sectionCellular => 'CELLULAR';

  @override
  String get sectionServingCell => 'SERVING CELL';

  @override
  String get sectionNeighbours => 'NEIGHBOURING CELLS';

  @override
  String get sectionCellTowers => 'CELL TOWERS';

  @override
  String get sectionDataUsage => 'DATA USAGE';

  @override
  String get sectionActiveConnection => 'ACTIVE CONNECTION';

  @override
  String get sectionIpAddresses => 'IP ADDRESSES';

  @override
  String get sectionLatency => 'LATENCY';

  @override
  String get sectionDevice => 'DEVICE';

  @override
  String get sectionSimCapabilities => 'SIM CAPABILITIES';

  @override
  String get sectionCalling => 'CALLING & MESSAGING';

  @override
  String get sectionSystemSettings => 'SYSTEM SETTINGS';

  @override
  String get sectionAppearance => 'APPEARANCE';

  @override
  String get labelLanguage => 'Language';

  @override
  String get systemDefault => 'System default';

  @override
  String get labelCarrier => 'Carrier';

  @override
  String get labelLabel => 'Label';

  @override
  String get labelPhoneNumber => 'Phone number';

  @override
  String get labelCountry => 'Country';

  @override
  String get labelMccMnc => 'MCC-MNC (PLMN)';

  @override
  String get labelCarrierId => 'Carrier id';

  @override
  String get labelSpecificCarrier => 'Specific carrier';

  @override
  String get labelSimState => 'SIM state';

  @override
  String get labelSimType => 'SIM type';

  @override
  String get labelSlot => 'Slot';

  @override
  String get labelPort => 'Port';

  @override
  String get labelSubscriptionId => 'Subscription id';

  @override
  String get labelOpportunistic => 'Opportunistic';

  @override
  String get labelMobileData => 'Mobile data';

  @override
  String get chipData => 'Data';

  @override
  String get labelCalls => 'Calls';

  @override
  String get labelSms => 'SMS';

  @override
  String get labelNetworkType => 'Network type';

  @override
  String get labelVoiceNetwork => 'Voice network';

  @override
  String get labelOperator => 'Operator';

  @override
  String get labelOperatorCode => 'Operator code';

  @override
  String get labelNetworkCountry => 'Network country';

  @override
  String get labelRoaming => 'Roaming';

  @override
  String get labelDataEnabled => 'Data enabled';

  @override
  String get labelDataActivity => 'Data activity';

  @override
  String get labelPhoneType => 'Phone type';

  @override
  String get labelSignal => 'Signal';

  @override
  String get labelStatus => 'Status';

  @override
  String get labelConnection => 'Connection';

  @override
  String get labelInternetAccess => 'Internet access';

  @override
  String get labelMetered => 'Metered';

  @override
  String get labelLinkDown => 'Link down speed';

  @override
  String get labelLinkUp => 'Link up speed';

  @override
  String get labelInterface => 'Interface';

  @override
  String get labelDnsServer => 'DNS server';

  @override
  String get labelPrivateDns => 'Private DNS';

  @override
  String get labelModel => 'Model';

  @override
  String get labelDeviceCodename => 'Device codename';

  @override
  String get labelAndroidVersion => 'Android version';

  @override
  String get labelRadioVersion => 'Radio (IMEI SV)';

  @override
  String get labelTelephonyHardware => 'Telephony hardware';

  @override
  String get labelSimCardPresent => 'SIM card present';

  @override
  String get labelEsimSupported => 'eSIM supported';

  @override
  String get labelActiveModems => 'Active modems';

  @override
  String get labelSupportedModems => 'Supported modems';

  @override
  String get labelMaxActiveSims => 'Max active SIMs';

  @override
  String get labelDualSim => 'Dual SIM';

  @override
  String get labelVoiceCapable => 'Voice capable';

  @override
  String get labelSmsCapable => 'SMS capable';

  @override
  String get labelVoiceAndData => 'Voice + data at once';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get unavailable => 'Unavailable';

  @override
  String get unknown => 'Unknown';

  @override
  String get physicalSim => 'Physical SIM';

  @override
  String get esimEmbedded => 'eSIM (embedded)';

  @override
  String get defaultSim => 'Default SIM';

  @override
  String get notDefault => 'Not default';

  @override
  String get validated => 'Validated';

  @override
  String get notValidated => 'Not validated';

  @override
  String get off => 'Off';

  @override
  String get noActiveNetwork => 'No active network';

  @override
  String get noActiveSim => 'No active SIM to measure';

  @override
  String get noCellReported => 'No cell reported yet';

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
    return '$label copied';
  }

  @override
  String get qualityExcellent => 'Excellent';

  @override
  String get qualityGood => 'Good';

  @override
  String get qualityFair => 'Fair';

  @override
  String get qualityPoor => 'Poor';

  @override
  String get qualityVeryPoor => 'Very poor';

  @override
  String get signalNone => 'None or unknown';

  @override
  String get simStateReady => 'Ready';

  @override
  String get simStateAbsent => 'Absent';

  @override
  String get simStatePin => 'PIN required';

  @override
  String get simStatePuk => 'PUK required';

  @override
  String get simStateNetworkLocked => 'Network locked';

  @override
  String get simStateNotReady => 'Not ready';

  @override
  String get simStateDisabled => 'Permanently disabled';

  @override
  String get simStateIoError => 'Card I/O error';

  @override
  String get simStateRestricted => 'Card restricted';

  @override
  String get dataConnected => 'Connected';

  @override
  String get dataDisconnected => 'Disconnected';

  @override
  String get dataConnecting => 'Connecting';

  @override
  String get dataSuspended => 'Suspended';

  @override
  String get dataDisconnecting => 'Disconnecting';

  @override
  String get activityIdle => 'Idle';

  @override
  String get activityReceiving => 'Receiving';

  @override
  String get activitySending => 'Sending';

  @override
  String get activityBoth => 'Sending and receiving';

  @override
  String get activityDormant => 'Dormant';

  @override
  String get cellTowersExplainer =>
      'See the tower your phone is connected to — Cell ID, area code, PCI, frequency channel and bands — plus neighbouring towers. Android counts a cell id as location data, so this needs the location permission. It is used for nothing else and nothing leaves your device.';

  @override
  String get showCellTowers => 'Show cell towers';

  @override
  String get locationPermanent =>
      'Location was denied permanently, so it can only be enabled from the app settings screen.';

  @override
  String get dataUsageExplainer =>
      'See how much mobile data and Wi-Fi this device has used today and this month. Android keeps these numbers behind the Usage Access setting — tap below, allow SIM Card Info in the list, and come back.';

  @override
  String get grantUsageAccess => 'Grant usage access';

  @override
  String get mobileToday => 'Mobile today';

  @override
  String get mobileMonth => 'Mobile this month';

  @override
  String get wifiToday => 'Wi-Fi today';

  @override
  String get wifiMonth => 'Wi-Fi this month';

  @override
  String get usageDisclaimer =>
      'Mobile is all SIMs combined — Android does not let apps split usage per SIM.';

  @override
  String get latencyExplainer =>
      'Measures the round trip to Cloudflare, Google DNS and google.com over the current connection.';

  @override
  String get runTest => 'Run test';

  @override
  String get runAgain => 'Run again';

  @override
  String get unreachable => 'Unreachable';

  @override
  String get shortcutMobile => 'Mobile network settings';

  @override
  String get shortcutDataUsage => 'Data usage';

  @override
  String get shortcutWifi => 'Wi-Fi settings';

  @override
  String get shortcutAirplane => 'Airplane mode';

  @override
  String get themeLight => 'Light';

  @override
  String get themeSystem => 'System';

  @override
  String get themeDark => 'Dark';

  @override
  String get shareFullReport => 'Share full report';

  @override
  String get shareFullReportSubtitle =>
      'SIM, network and device details as text';

  @override
  String get shareJson => 'Share report as JSON';

  @override
  String get shareJsonSubtitle => 'Machine-readable, for tools and scripts';

  @override
  String get shareApp => 'Share this app';

  @override
  String shareAppText(String url) {
    return 'SIM Card Info — carrier, signal and network details for every SIM. $url';
  }

  @override
  String get privacyOptions => 'Privacy options';

  @override
  String get privacyOptionsSubtitle => 'Change your ads consent choice';

  @override
  String privacyOptionsFailed(String message) {
    return 'Could not open privacy options: $message';
  }

  @override
  String aboutVersion(String version) {
    return 'Version $version · by Tahatec';
  }

  @override
  String get aboutBy => 'by Tahatec';

  @override
  String get privacyNote =>
      'All SIM, network and device details are read directly from Android on your device and are never uploaded anywhere by this app.';

  @override
  String sparklineCaption(int dbm, String window) {
    return '$dbm dBm now · last $window';
  }

  @override
  String get windowMinute => 'minute';

  @override
  String windowMinutes(int n) {
    return '$n min';
  }
}
