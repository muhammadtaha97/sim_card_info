import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('ur'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'SIM Card Info'**
  String get appTitle;

  /// No description provided for @tabSims.
  ///
  /// In en, this message translates to:
  /// **'SIMs'**
  String get tabSims;

  /// No description provided for @tabNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get tabNetwork;

  /// No description provided for @tabDevice.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get tabDevice;

  /// No description provided for @tabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabSettings;

  /// No description provided for @titleSims.
  ///
  /// In en, this message translates to:
  /// **'SIM Cards'**
  String get titleSims;

  /// No description provided for @tooltipShareReport.
  ///
  /// In en, this message translates to:
  /// **'Share report'**
  String get tooltipShareReport;

  /// No description provided for @tooltipRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get tooltipRefresh;

  /// No description provided for @gateTitle.
  ///
  /// In en, this message translates to:
  /// **'Phone permission needed'**
  String get gateTitle;

  /// No description provided for @gateBody.
  ///
  /// In en, this message translates to:
  /// **'Android protects SIM and network details behind the Phone permission. Everything is read on your device and never leaves it.'**
  String get gateBody;

  /// No description provided for @grantPermission.
  ///
  /// In en, this message translates to:
  /// **'Grant permission'**
  String get grantPermission;

  /// No description provided for @openAppSettings.
  ///
  /// In en, this message translates to:
  /// **'Open app settings'**
  String get openAppSettings;

  /// No description provided for @gatePermanent.
  ///
  /// In en, this message translates to:
  /// **'Permission was denied permanently, so it can only be enabled from the app settings screen.'**
  String get gatePermanent;

  /// No description provided for @noSimsTitle.
  ///
  /// In en, this message translates to:
  /// **'No active SIM cards'**
  String get noSimsTitle;

  /// No description provided for @noSimsBody.
  ///
  /// In en, this message translates to:
  /// **'No SIM or eSIM is active on this device. Insert a SIM or enable an eSIM, then pull to refresh.'**
  String get noSimsBody;

  /// No description provided for @sectionSubscription.
  ///
  /// In en, this message translates to:
  /// **'SUBSCRIPTION'**
  String get sectionSubscription;

  /// No description provided for @sectionRoles.
  ///
  /// In en, this message translates to:
  /// **'ROLES'**
  String get sectionRoles;

  /// No description provided for @sectionCellular.
  ///
  /// In en, this message translates to:
  /// **'CELLULAR'**
  String get sectionCellular;

  /// No description provided for @sectionServingCell.
  ///
  /// In en, this message translates to:
  /// **'SERVING CELL'**
  String get sectionServingCell;

  /// No description provided for @sectionNeighbours.
  ///
  /// In en, this message translates to:
  /// **'NEIGHBOURING CELLS'**
  String get sectionNeighbours;

  /// No description provided for @sectionCellTowers.
  ///
  /// In en, this message translates to:
  /// **'CELL TOWERS'**
  String get sectionCellTowers;

  /// No description provided for @sectionDataUsage.
  ///
  /// In en, this message translates to:
  /// **'DATA USAGE'**
  String get sectionDataUsage;

  /// No description provided for @sectionActiveConnection.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE CONNECTION'**
  String get sectionActiveConnection;

  /// No description provided for @sectionIpAddresses.
  ///
  /// In en, this message translates to:
  /// **'IP ADDRESSES'**
  String get sectionIpAddresses;

  /// No description provided for @sectionLatency.
  ///
  /// In en, this message translates to:
  /// **'LATENCY'**
  String get sectionLatency;

  /// No description provided for @sectionDevice.
  ///
  /// In en, this message translates to:
  /// **'DEVICE'**
  String get sectionDevice;

  /// No description provided for @sectionSimCapabilities.
  ///
  /// In en, this message translates to:
  /// **'SIM CAPABILITIES'**
  String get sectionSimCapabilities;

  /// No description provided for @sectionCalling.
  ///
  /// In en, this message translates to:
  /// **'CALLING & MESSAGING'**
  String get sectionCalling;

  /// No description provided for @sectionSystemSettings.
  ///
  /// In en, this message translates to:
  /// **'SYSTEM SETTINGS'**
  String get sectionSystemSettings;

  /// No description provided for @sectionAppearance.
  ///
  /// In en, this message translates to:
  /// **'APPEARANCE'**
  String get sectionAppearance;

  /// No description provided for @labelLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get labelLanguage;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemDefault;

  /// No description provided for @labelCarrier.
  ///
  /// In en, this message translates to:
  /// **'Carrier'**
  String get labelCarrier;

  /// No description provided for @labelLabel.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get labelLabel;

  /// No description provided for @labelPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get labelPhoneNumber;

  /// No description provided for @labelCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get labelCountry;

  /// No description provided for @labelMccMnc.
  ///
  /// In en, this message translates to:
  /// **'MCC-MNC (PLMN)'**
  String get labelMccMnc;

  /// No description provided for @labelCarrierId.
  ///
  /// In en, this message translates to:
  /// **'Carrier id'**
  String get labelCarrierId;

  /// No description provided for @labelSpecificCarrier.
  ///
  /// In en, this message translates to:
  /// **'Specific carrier'**
  String get labelSpecificCarrier;

  /// No description provided for @labelSimState.
  ///
  /// In en, this message translates to:
  /// **'SIM state'**
  String get labelSimState;

  /// No description provided for @labelSimType.
  ///
  /// In en, this message translates to:
  /// **'SIM type'**
  String get labelSimType;

  /// No description provided for @labelSlot.
  ///
  /// In en, this message translates to:
  /// **'Slot'**
  String get labelSlot;

  /// No description provided for @labelPort.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get labelPort;

  /// No description provided for @labelSubscriptionId.
  ///
  /// In en, this message translates to:
  /// **'Subscription id'**
  String get labelSubscriptionId;

  /// No description provided for @labelOpportunistic.
  ///
  /// In en, this message translates to:
  /// **'Opportunistic'**
  String get labelOpportunistic;

  /// No description provided for @labelMobileData.
  ///
  /// In en, this message translates to:
  /// **'Mobile data'**
  String get labelMobileData;

  /// No description provided for @chipData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get chipData;

  /// No description provided for @labelCalls.
  ///
  /// In en, this message translates to:
  /// **'Calls'**
  String get labelCalls;

  /// No description provided for @labelSms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get labelSms;

  /// No description provided for @labelNetworkType.
  ///
  /// In en, this message translates to:
  /// **'Network type'**
  String get labelNetworkType;

  /// No description provided for @labelVoiceNetwork.
  ///
  /// In en, this message translates to:
  /// **'Voice network'**
  String get labelVoiceNetwork;

  /// No description provided for @labelOperator.
  ///
  /// In en, this message translates to:
  /// **'Operator'**
  String get labelOperator;

  /// No description provided for @labelOperatorCode.
  ///
  /// In en, this message translates to:
  /// **'Operator code'**
  String get labelOperatorCode;

  /// No description provided for @labelNetworkCountry.
  ///
  /// In en, this message translates to:
  /// **'Network country'**
  String get labelNetworkCountry;

  /// No description provided for @labelRoaming.
  ///
  /// In en, this message translates to:
  /// **'Roaming'**
  String get labelRoaming;

  /// No description provided for @labelDataEnabled.
  ///
  /// In en, this message translates to:
  /// **'Data enabled'**
  String get labelDataEnabled;

  /// No description provided for @labelDataActivity.
  ///
  /// In en, this message translates to:
  /// **'Data activity'**
  String get labelDataActivity;

  /// No description provided for @labelPhoneType.
  ///
  /// In en, this message translates to:
  /// **'Phone type'**
  String get labelPhoneType;

  /// No description provided for @labelSignal.
  ///
  /// In en, this message translates to:
  /// **'Signal'**
  String get labelSignal;

  /// No description provided for @labelStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get labelStatus;

  /// No description provided for @labelConnection.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get labelConnection;

  /// No description provided for @labelInternetAccess.
  ///
  /// In en, this message translates to:
  /// **'Internet access'**
  String get labelInternetAccess;

  /// No description provided for @labelMetered.
  ///
  /// In en, this message translates to:
  /// **'Metered'**
  String get labelMetered;

  /// No description provided for @labelLinkDown.
  ///
  /// In en, this message translates to:
  /// **'Link down speed'**
  String get labelLinkDown;

  /// No description provided for @labelLinkUp.
  ///
  /// In en, this message translates to:
  /// **'Link up speed'**
  String get labelLinkUp;

  /// No description provided for @labelInterface.
  ///
  /// In en, this message translates to:
  /// **'Interface'**
  String get labelInterface;

  /// No description provided for @labelDnsServer.
  ///
  /// In en, this message translates to:
  /// **'DNS server'**
  String get labelDnsServer;

  /// No description provided for @labelPrivateDns.
  ///
  /// In en, this message translates to:
  /// **'Private DNS'**
  String get labelPrivateDns;

  /// No description provided for @labelModel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get labelModel;

  /// No description provided for @labelDeviceCodename.
  ///
  /// In en, this message translates to:
  /// **'Device codename'**
  String get labelDeviceCodename;

  /// No description provided for @labelAndroidVersion.
  ///
  /// In en, this message translates to:
  /// **'Android version'**
  String get labelAndroidVersion;

  /// No description provided for @labelRadioVersion.
  ///
  /// In en, this message translates to:
  /// **'Radio (IMEI SV)'**
  String get labelRadioVersion;

  /// No description provided for @labelTelephonyHardware.
  ///
  /// In en, this message translates to:
  /// **'Telephony hardware'**
  String get labelTelephonyHardware;

  /// No description provided for @labelSimCardPresent.
  ///
  /// In en, this message translates to:
  /// **'SIM card present'**
  String get labelSimCardPresent;

  /// No description provided for @labelEsimSupported.
  ///
  /// In en, this message translates to:
  /// **'eSIM supported'**
  String get labelEsimSupported;

  /// No description provided for @labelActiveModems.
  ///
  /// In en, this message translates to:
  /// **'Active modems'**
  String get labelActiveModems;

  /// No description provided for @labelSupportedModems.
  ///
  /// In en, this message translates to:
  /// **'Supported modems'**
  String get labelSupportedModems;

  /// No description provided for @labelMaxActiveSims.
  ///
  /// In en, this message translates to:
  /// **'Max active SIMs'**
  String get labelMaxActiveSims;

  /// No description provided for @labelDualSim.
  ///
  /// In en, this message translates to:
  /// **'Dual SIM'**
  String get labelDualSim;

  /// No description provided for @labelVoiceCapable.
  ///
  /// In en, this message translates to:
  /// **'Voice capable'**
  String get labelVoiceCapable;

  /// No description provided for @labelSmsCapable.
  ///
  /// In en, this message translates to:
  /// **'SMS capable'**
  String get labelSmsCapable;

  /// No description provided for @labelVoiceAndData.
  ///
  /// In en, this message translates to:
  /// **'Voice + data at once'**
  String get labelVoiceAndData;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @unavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get unavailable;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @physicalSim.
  ///
  /// In en, this message translates to:
  /// **'Physical SIM'**
  String get physicalSim;

  /// No description provided for @esimEmbedded.
  ///
  /// In en, this message translates to:
  /// **'eSIM (embedded)'**
  String get esimEmbedded;

  /// No description provided for @defaultSim.
  ///
  /// In en, this message translates to:
  /// **'Default SIM'**
  String get defaultSim;

  /// No description provided for @notDefault.
  ///
  /// In en, this message translates to:
  /// **'Not default'**
  String get notDefault;

  /// No description provided for @validated.
  ///
  /// In en, this message translates to:
  /// **'Validated'**
  String get validated;

  /// No description provided for @notValidated.
  ///
  /// In en, this message translates to:
  /// **'Not validated'**
  String get notValidated;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @noActiveNetwork.
  ///
  /// In en, this message translates to:
  /// **'No active network'**
  String get noActiveNetwork;

  /// No description provided for @noActiveSim.
  ///
  /// In en, this message translates to:
  /// **'No active SIM to measure'**
  String get noActiveSim;

  /// No description provided for @noCellReported.
  ///
  /// In en, this message translates to:
  /// **'No cell reported yet'**
  String get noCellReported;

  /// No description provided for @slotN.
  ///
  /// In en, this message translates to:
  /// **'Slot {n}'**
  String slotN(int n);

  /// No description provided for @simN.
  ///
  /// In en, this message translates to:
  /// **'SIM {n}'**
  String simN(int n);

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'{label} copied'**
  String copied(String label);

  /// No description provided for @qualityExcellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get qualityExcellent;

  /// No description provided for @qualityGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get qualityGood;

  /// No description provided for @qualityFair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get qualityFair;

  /// No description provided for @qualityPoor.
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get qualityPoor;

  /// No description provided for @qualityVeryPoor.
  ///
  /// In en, this message translates to:
  /// **'Very poor'**
  String get qualityVeryPoor;

  /// No description provided for @signalNone.
  ///
  /// In en, this message translates to:
  /// **'None or unknown'**
  String get signalNone;

  /// No description provided for @simStateReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get simStateReady;

  /// No description provided for @simStateAbsent.
  ///
  /// In en, this message translates to:
  /// **'Absent'**
  String get simStateAbsent;

  /// No description provided for @simStatePin.
  ///
  /// In en, this message translates to:
  /// **'PIN required'**
  String get simStatePin;

  /// No description provided for @simStatePuk.
  ///
  /// In en, this message translates to:
  /// **'PUK required'**
  String get simStatePuk;

  /// No description provided for @simStateNetworkLocked.
  ///
  /// In en, this message translates to:
  /// **'Network locked'**
  String get simStateNetworkLocked;

  /// No description provided for @simStateNotReady.
  ///
  /// In en, this message translates to:
  /// **'Not ready'**
  String get simStateNotReady;

  /// No description provided for @simStateDisabled.
  ///
  /// In en, this message translates to:
  /// **'Permanently disabled'**
  String get simStateDisabled;

  /// No description provided for @simStateIoError.
  ///
  /// In en, this message translates to:
  /// **'Card I/O error'**
  String get simStateIoError;

  /// No description provided for @simStateRestricted.
  ///
  /// In en, this message translates to:
  /// **'Card restricted'**
  String get simStateRestricted;

  /// No description provided for @dataConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get dataConnected;

  /// No description provided for @dataDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get dataDisconnected;

  /// No description provided for @dataConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting'**
  String get dataConnecting;

  /// No description provided for @dataSuspended.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get dataSuspended;

  /// No description provided for @dataDisconnecting.
  ///
  /// In en, this message translates to:
  /// **'Disconnecting'**
  String get dataDisconnecting;

  /// No description provided for @activityIdle.
  ///
  /// In en, this message translates to:
  /// **'Idle'**
  String get activityIdle;

  /// No description provided for @activityReceiving.
  ///
  /// In en, this message translates to:
  /// **'Receiving'**
  String get activityReceiving;

  /// No description provided for @activitySending.
  ///
  /// In en, this message translates to:
  /// **'Sending'**
  String get activitySending;

  /// No description provided for @activityBoth.
  ///
  /// In en, this message translates to:
  /// **'Sending and receiving'**
  String get activityBoth;

  /// No description provided for @activityDormant.
  ///
  /// In en, this message translates to:
  /// **'Dormant'**
  String get activityDormant;

  /// No description provided for @cellTowersExplainer.
  ///
  /// In en, this message translates to:
  /// **'See the tower your phone is connected to — Cell ID, area code, PCI, frequency channel and bands — plus neighbouring towers. Android counts a cell id as location data, so this needs the location permission. It is used for nothing else and nothing leaves your device.'**
  String get cellTowersExplainer;

  /// No description provided for @showCellTowers.
  ///
  /// In en, this message translates to:
  /// **'Show cell towers'**
  String get showCellTowers;

  /// No description provided for @locationPermanent.
  ///
  /// In en, this message translates to:
  /// **'Location was denied permanently, so it can only be enabled from the app settings screen.'**
  String get locationPermanent;

  /// No description provided for @dataUsageExplainer.
  ///
  /// In en, this message translates to:
  /// **'See how much mobile data and Wi-Fi this device has used today and this month. Android keeps these numbers behind the Usage Access setting — tap below, allow SIM Card Info in the list, and come back.'**
  String get dataUsageExplainer;

  /// No description provided for @grantUsageAccess.
  ///
  /// In en, this message translates to:
  /// **'Grant usage access'**
  String get grantUsageAccess;

  /// No description provided for @mobileToday.
  ///
  /// In en, this message translates to:
  /// **'Mobile today'**
  String get mobileToday;

  /// No description provided for @mobileMonth.
  ///
  /// In en, this message translates to:
  /// **'Mobile this month'**
  String get mobileMonth;

  /// No description provided for @wifiToday.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi today'**
  String get wifiToday;

  /// No description provided for @wifiMonth.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi this month'**
  String get wifiMonth;

  /// No description provided for @usageDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Mobile is all SIMs combined — Android does not let apps split usage per SIM.'**
  String get usageDisclaimer;

  /// No description provided for @latencyExplainer.
  ///
  /// In en, this message translates to:
  /// **'Measures the round trip to Cloudflare, Google DNS and google.com over the current connection.'**
  String get latencyExplainer;

  /// No description provided for @runTest.
  ///
  /// In en, this message translates to:
  /// **'Run test'**
  String get runTest;

  /// No description provided for @runAgain.
  ///
  /// In en, this message translates to:
  /// **'Run again'**
  String get runAgain;

  /// No description provided for @unreachable.
  ///
  /// In en, this message translates to:
  /// **'Unreachable'**
  String get unreachable;

  /// No description provided for @shortcutMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile network settings'**
  String get shortcutMobile;

  /// No description provided for @shortcutDataUsage.
  ///
  /// In en, this message translates to:
  /// **'Data usage'**
  String get shortcutDataUsage;

  /// No description provided for @shortcutWifi.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi settings'**
  String get shortcutWifi;

  /// No description provided for @shortcutAirplane.
  ///
  /// In en, this message translates to:
  /// **'Airplane mode'**
  String get shortcutAirplane;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @shareFullReport.
  ///
  /// In en, this message translates to:
  /// **'Share full report'**
  String get shareFullReport;

  /// No description provided for @shareFullReportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'SIM, network and device details as text'**
  String get shareFullReportSubtitle;

  /// No description provided for @shareJson.
  ///
  /// In en, this message translates to:
  /// **'Share report as JSON'**
  String get shareJson;

  /// No description provided for @shareJsonSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Machine-readable, for tools and scripts'**
  String get shareJsonSubtitle;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share this app'**
  String get shareApp;

  /// No description provided for @shareAppText.
  ///
  /// In en, this message translates to:
  /// **'SIM Card Info — carrier, signal and network details for every SIM. {url}'**
  String shareAppText(String url);

  /// No description provided for @privacyOptions.
  ///
  /// In en, this message translates to:
  /// **'Privacy options'**
  String get privacyOptions;

  /// No description provided for @privacyOptionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Change your ads consent choice'**
  String get privacyOptionsSubtitle;

  /// No description provided for @privacyOptionsFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open privacy options: {message}'**
  String privacyOptionsFailed(String message);

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version} · by Tahatec'**
  String aboutVersion(String version);

  /// No description provided for @aboutBy.
  ///
  /// In en, this message translates to:
  /// **'by Tahatec'**
  String get aboutBy;

  /// No description provided for @privacyNote.
  ///
  /// In en, this message translates to:
  /// **'All SIM, network and device details are read directly from Android on your device and are never uploaded anywhere by this app.'**
  String get privacyNote;

  /// No description provided for @sparklineCaption.
  ///
  /// In en, this message translates to:
  /// **'{dbm} dBm now · last {window}'**
  String sparklineCaption(int dbm, String window);

  /// No description provided for @windowMinute.
  ///
  /// In en, this message translates to:
  /// **'minute'**
  String get windowMinute;

  /// No description provided for @windowMinutes.
  ///
  /// In en, this message translates to:
  /// **'{n} min'**
  String windowMinutes(int n);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'bn',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'it',
    'ja',
    'ko',
    'pt',
    'ru',
    'tr',
    'ur',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bn':
      return AppLocalizationsBn();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
