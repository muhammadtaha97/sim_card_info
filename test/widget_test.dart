import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sim_card_info/app.dart';
import 'package:sim_card_info/l10n/generated/app_localizations.dart';
import 'package:sim_card_info/models/cell_tower.dart';
import 'package:sim_card_info/models/data_usage.dart';
import 'package:sim_card_info/models/signal_info.dart';
import 'package:sim_card_info/models/sim_card.dart';
import 'package:sim_card_info/models/telephony_overview.dart';
import 'package:sim_card_info/screens/home_screen.dart';
import 'package:sim_card_info/services/settings_store.dart';
import 'package:sim_card_info/services/telephony_service.dart';
import 'package:sim_card_info/widgets/permission_gate.dart';
import 'package:sim_card_info/widgets/sim_card_visual.dart';

/// Fixture-backed service: what the channel would return on a dual-SIM
/// UAE phone, without a device.
class _FakeTelephony extends TelephonyService {
  _FakeTelephony({
    required this.overview,
    this.signals = const [],
    this.cellTowers = const [],
  });

  TelephonyOverview overview;
  List<SignalInfo> signals;
  List<CellTower> cellTowers;
  DataUsage dataUsage = DataUsage.denied;
  int permissionRequests = 0;
  int locationRequests = 0;
  int usageSettingsOpens = 0;
  final List<String> openedScreens = [];

  @override
  Future<TelephonyOverview?> getOverview() async => overview;

  @override
  Future<List<SignalInfo>> getSignal() async => signals;

  @override
  Future<List<({String interface, String address, bool isIPv6})>>
      localAddresses() async =>
          [(interface: 'wlan0', address: '192.168.1.20', isIPv6: false)];

  @override
  Future<PermissionStates> requestPermissions() async {
    permissionRequests++;
    return overview.permissions;
  }

  @override
  Future<PermissionStates> checkPermissions() async => overview.permissions;

  @override
  Future<void> openAppSettings() async {}

  @override
  Future<PermissionStates> requestLocationPermission() async {
    locationRequests++;
    return overview.permissions;
  }

  @override
  Future<List<CellTower>> getCellTowers() async => cellTowers;

  @override
  Future<DataUsage> getDataUsage() async => dataUsage;

  @override
  Future<void> openUsageAccessSettings() async {
    usageSettingsOpens++;
  }

  @override
  Future<void> openSystemScreen(String screen) async {
    openedScreens.add(screen);
  }

  @override
  Future<void> refreshWidget() async {}

  String? syncedLocaleTag = 'never-called';

  @override
  Future<void> setAppLocales(String? languageTag) async {
    syncedLocaleTag = languageTag;
  }
}

const _granted = PermissionStates(
  phoneState: true,
  phoneNumbers: true,
  showRationale: false,
);

const _simDu = SimCard(
  subscriptionId: 1,
  slotIndex: 0,
  carrierName: 'du',
  countryIso: 'ae',
  mcc: '424',
  mnc: '03',
  number: '+9715xxxxxxx',
  isEmbedded: false,
  isDefaultData: true,
  isDefaultVoice: true,
  isDefaultSms: true,
  simState: 5,
  networkOperatorName: 'du',
  networkCountryIso: 'ae',
  isRoaming: false,
  dataNetworkType: 20,
  dataState: 2,
  phoneType: 1,
);

const _simEtisalat = SimCard(
  subscriptionId: 2,
  slotIndex: 1,
  carrierName: 'etisalat by e&',
  countryIso: 'ae',
  mcc: '424',
  mnc: '02',
  isEmbedded: true,
  simState: 5,
  dataNetworkType: 13,
);

TelephonyOverview _overview({
  PermissionStates permissions = _granted,
  List<SimCard> sims = const [_simDu, _simEtisalat],
}) =>
    TelephonyOverview(
      permissions: permissions,
      sims: sims,
      device: const DeviceSummary(
        manufacturer: 'Google',
        model: 'Pixel 9',
        androidVersion: '17',
        sdkInt: 37,
        hasTelephony: true,
        esimSupported: true,
        activeModemCount: 2,
        isVoiceCapable: true,
        isSmsCapable: true,
      ),
      connectivity: const ConnectivitySummary(
        connected: true,
        transports: ['Wi-Fi'],
        validated: true,
        metered: false,
        dnsServers: ['192.168.1.1'],
      ),
    );

Future<SettingsStore> _settings({Map<String, Object> initial = const {}}) async {
  SharedPreferences.setMockInitialValues(initial);
  return SettingsStore.load();
}

Future<void> _pumpHome(
  WidgetTester tester,
  _FakeTelephony telephony, {
  Map<String, Object> prefs = const {},
}) async {
  // Tall surface so a dual-SIM layout fits without scrolling; the default
  // 800x600 hides the second card below the fold.
  tester.view.physicalSize = const Size(800, 2600);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final settings = await _settings(initial: prefs);
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomeScreen(settings: settings, telephony: telephony),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('SIMs tab renders one card per subscription', (tester) async {
    await _pumpHome(tester, _FakeTelephony(overview: _overview()));

    expect(find.byType(SimCardVisual), findsNWidgets(2));
    expect(find.text('du'), findsWidgets);
    expect(find.text('etisalat by e&'), findsWidgets);
    // The eSIM is badged as such, the physical SIM by slot.
    expect(find.text('eSIM'), findsOneWidget);
    expect(find.text('SIM 1'), findsOneWidget);
    // 5G badge from NETWORK_TYPE_NR.
    expect(find.text('5G'), findsOneWidget);
  });

  testWidgets('Network tab shows live signal and connectivity',
      (tester) async {
    await _pumpHome(
      tester,
      _FakeTelephony(
        overview: _overview(),
        signals: const [
          SignalInfo(
            subscriptionId: 1,
            slotIndex: 0,
            level: 3,
            networkType: 20,
            cells: [CellSignal(radio: '5G NR', dbm: -85, asu: 35, level: 3)],
          ),
        ],
      ),
    );

    await tester.tap(find.text('Network'));
    await tester.pumpAndSettle();

    expect(find.text('-85'), findsOneWidget);
    expect(find.text('Good'), findsOneWidget);
    expect(find.text('5G NR (5G)'), findsWidgets);
    expect(find.text('Wi-Fi'), findsOneWidget);
    expect(find.text('192.168.1.20'), findsOneWidget);
  });

  testWidgets('Device tab works and shows capabilities', (tester) async {
    await _pumpHome(tester, _FakeTelephony(overview: _overview()));

    await tester.tap(find.text('Device'));
    await tester.pumpAndSettle();

    expect(find.text('Google Pixel 9'), findsOneWidget);
    expect(find.text('17 (API 37)'), findsOneWidget);
    // Dual SIM derived from two active modems.
    expect(find.text('Dual SIM'), findsOneWidget);
  });

  testWidgets('permission gate shows and requests', (tester) async {
    final telephony = _FakeTelephony(
      overview: _overview(
        permissions: const PermissionStates(
          phoneState: false,
          phoneNumbers: false,
          showRationale: true,
        ),
        sims: const [],
      ),
    );
    await _pumpHome(tester, telephony);

    expect(find.byType(PermissionGate), findsOneWidget);
    expect(find.text('Grant permission'), findsOneWidget);

    // Granting flips the whole tab to content on the reload.
    telephony.overview = _overview();
    await tester.tap(find.text('Grant permission'));
    await tester.pumpAndSettle();

    expect(telephony.permissionRequests, 1);
    expect(find.byType(SimCardVisual), findsNWidgets(2));
  });

  testWidgets('permanent denial routes to app settings instead',
      (tester) async {
    await _pumpHome(
      tester,
      _FakeTelephony(
        overview: _overview(
          permissions: const PermissionStates(
            phoneState: false,
            phoneNumbers: false,
            showRationale: false,
          ),
          sims: const [],
        ),
      ),
      // A request has actually happened before — only then can the missing
      // rationale mean "denied permanently".
      prefs: const {'requested_phone_permission': true},
    );

    expect(find.text('Open app settings'), findsOneWidget);
    expect(find.text('Grant permission'), findsNothing);
  });

  testWidgets(
      'a fresh install offers the request even though rationale is false',
      (tester) async {
    // Regression: shouldShowRequestPermissionRationale is false both before
    // the first request and after a permanent denial. The release device
    // pass caught a fresh install being told "denied permanently" and sent
    // to the settings screen, where the system dialog would have worked.
    await _pumpHome(
      tester,
      _FakeTelephony(
        overview: _overview(
          permissions: const PermissionStates(
            phoneState: false,
            phoneNumbers: false,
            showRationale: false,
          ),
          sims: const [],
        ),
      ),
    );

    expect(find.text('Grant permission'), findsOneWidget);
    expect(find.text('Open app settings'), findsNothing);
  });

  testWidgets('tapping an info row copies its value', (tester) async {
    final messages = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        messages.add(call);
        return null;
      },
    );

    await _pumpHome(tester, _FakeTelephony(overview: _overview()));

    await tester.tap(find.text('MCC-MNC (PLMN)').first);
    await tester.pump();

    final copies =
        messages.where((call) => call.method == 'Clipboard.setData');
    expect(copies, isNotEmpty);
    expect((copies.first.arguments as Map)['text'], '424-03');
    expect(find.text('MCC-MNC (PLMN) copied'), findsOneWidget);
  });

  testWidgets('cell towers ask for location only on opt-in', (tester) async {
    final telephony = _FakeTelephony(
      overview: _overview(sims: const [_simDu]),
      cellTowers: const [
        CellTower(
          registered: true,
          radio: '5G NR',
          plmn: '310-260',
          cellId: 12345,
          area: 3021,
          pci: 218,
          channel: 640000,
          bands: [78],
          dbm: -84,
          level: 3,
        ),
      ],
    );
    await _pumpHome(tester, telephony);

    await tester.tap(find.text('Network'));
    await tester.pumpAndSettle();

    // The gate: nothing was requested yet, the explainer offers the opt-in.
    expect(telephony.locationRequests, 0);
    expect(find.text('Show cell towers'), findsOneWidget);
    expect(find.text('Cell ID'), findsNothing);

    // Opting in requests location; the fake grants it via the overview.
    telephony.overview = TelephonyOverview(
      permissions: const PermissionStates(
        phoneState: true,
        phoneNumbers: true,
        showRationale: false,
        location: true,
      ),
      sims: const [_simDu],
      device: telephony.overview.device,
      connectivity: telephony.overview.connectivity,
    );
    await tester.tap(find.text('Show cell towers'));
    await tester.pumpAndSettle();

    expect(telephony.locationRequests, 1);
    expect(find.text('Cell ID'), findsOneWidget);
    expect(find.text('12345'), findsOneWidget);
    expect(find.text('n78'), findsOneWidget);

    // The opt-in is remembered.
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('cell_towers_enabled'), isTrue);
  });

  testWidgets('data usage gates on Usage Access and renders once granted',
      (tester) async {
    final telephony = _FakeTelephony(overview: _overview(sims: const [_simDu]));
    await _pumpHome(tester, telephony);

    await tester.tap(find.text('Network'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Grant usage access'), 200);
    await tester.tap(find.text('Grant usage access'));
    await tester.pump();
    expect(telephony.usageSettingsOpens, 1);

    // Coming back with the grant in place fills the section in.
    telephony.overview = TelephonyOverview(
      permissions: const PermissionStates(
        phoneState: true,
        phoneNumbers: true,
        showRationale: false,
        usageAccess: true,
      ),
      sims: const [_simDu],
      device: telephony.overview.device,
      connectivity: telephony.overview.connectivity,
    );
    telephony.dataUsage = const DataUsage(
      granted: true,
      mobileToday: 5 * 1024 * 1024,
      mobileMonth: 250 * 1024 * 1024,
      wifiToday: 1024,
      wifiMonth: 3 * 1024 * 1024 * 1024,
    );
    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('5.0 MB'), 200);
    expect(find.text('5.0 MB'), findsOneWidget);
    expect(find.text('250 MB'), findsOneWidget);
    expect(find.text('3.0 GB'), findsOneWidget);
  });

  testWidgets('device tab shortcuts open the right system screens',
      (tester) async {
    final telephony = _FakeTelephony(overview: _overview());
    await _pumpHome(tester, telephony);

    await tester.tap(find.text('Device'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Wi-Fi settings'), 200);
    await tester.tap(find.text('Wi-Fi settings'));
    await tester.tap(find.text('Airplane mode'));
    await tester.pump();

    expect(telephony.openedScreens, ['wifi', 'airplane']);
  });

  testWidgets('settings tab shows the theme selector and switches mode',
      (tester) async {
    await _pumpHome(tester, _FakeTelephony(overview: _overview()));

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.byType(SegmentedButton<ThemeMode>), findsOneWidget);
    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('theme_mode'), 'dark');
  });

  testWidgets('language picker switches the app language and syncs Android',
      (tester) async {
    final telephony = _FakeTelephony(overview: _overview());
    final settings = await _settings();
    await tester.pumpWidget(
      SimCardInfoApp(settings: settings, telephony: telephony),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();
    expect(find.text('System default'), findsWidgets);

    await tester.tap(find.text('Français'));
    await tester.pumpAndSettle();

    // The whole app re-renders in French immediately…
    expect(find.text('Réglages'), findsWidgets);
    expect(find.text('Langue'), findsOneWidget);
    // …the choice is persisted…
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('app_locale'), 'fr');
    // …and mirrored into the Android 13+ per-app language setting.
    expect(telephony.syncedLocaleTag, 'fr');

    // Back to system default clears both.
    await tester.tap(find.text('Langue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Par défaut du système'));
    await tester.pumpAndSettle();
    expect(prefs.getString('app_locale'), isNull);
    expect(telephony.syncedLocaleTag, isNull);
    expect(find.text('Settings'), findsWidgets);
  });
}
