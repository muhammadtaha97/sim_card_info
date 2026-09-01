import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/generated/app_localizations.dart';
import '../models/cell_tower.dart';
import '../models/data_usage.dart';
import '../models/signal_info.dart';
import '../models/telephony_overview.dart';
import '../services/ad_service.dart';
import '../services/report_builder.dart';
import '../services/settings_store.dart';
import '../services/signal_history.dart';
import '../services/telephony_service.dart';
import '../widgets/anchored_banner.dart';
import '../widgets/permission_gate.dart';
import 'device_tab.dart';
import 'network_tab.dart';
import 'settings_tab.dart';
import 'sims_tab.dart';

/// The app shell: four tabs, the anchored banner, and all the state.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.settings, this.telephony});

  final SettingsStore settings;

  /// Injectable so widget tests can feed fixture data — the real channel
  /// only exists on an Android device.
  final TelephonyService? telephony;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with WidgetsBindingObserver {
  late final TelephonyService _telephony =
      widget.telephony ?? TelephonyService();
  final _interstitial = InterstitialAdService();
  final _policy = InterstitialPolicy();

  TelephonyOverview? _overview;
  List<SignalInfo> _signals = const [];
  List<({String interface, String address, bool isIPv6})> _addresses =
      const [];
  List<CellTower> _cellTowers = const [];
  DataUsage _dataUsage = DataUsage.denied;
  final _signalHistory = SignalHistory();
  bool _loading = true;
  int _tab = 0;
  Timer? _signalTimer;

  /// Signal readings refresh on this cadence while the Network tab is
  /// visible — fast enough to watch a bar change when walking around, slow
  /// enough to cost nothing.
  static const _signalInterval = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _interstitial.load();
    _reload(initial: true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _signalTimer?.cancel();
    _interstitial.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Coming back from Settings after flipping the permission, or from the
    // SIM manager after switching a default — the data on screen is stale.
    // _reload ends by resyncing the signal polling.
    if (state == AppLifecycleState.resumed) _reload();
    if (state == AppLifecycleState.paused) _stopSignalPolling();
  }

  Future<void> _reload({bool initial = false}) async {
    if (initial && mounted) setState(() => _loading = true);
    final overview = await _telephony.getOverview();
    final addresses = await _telephony.localAddresses();
    final signals = await _telephony.getSignal();
    // The gated sections load only once their grant is actually in place, so
    // nothing here triggers a permission the user has not opted into.
    final cellTowers =
        widget.settings.cellTowersEnabled && (overview?.permissions.location ?? false)
            ? await _telephony.getCellTowers()
            : const <CellTower>[];
    final usage = (overview?.permissions.usageAccess ?? false)
        ? await _telephony.getDataUsage()
        : DataUsage.denied;
    if (!mounted) return;
    _signalHistory.record(signals);
    setState(() {
      _overview = overview;
      _addresses = addresses;
      _signals = signals;
      _cellTowers = cellTowers;
      _dataUsage = usage;
      _loading = false;
    });
    _syncSignalPolling();
    _telephony.refreshWidget();
  }

  /// Manual refresh: reload, then maybe show the interstitial — after the
  /// action completed, never instead of it.
  Future<void> _refreshAction() async {
    await _reload();
    if (_policy.shouldShow()) _interstitial.show();
  }

  Future<void> _requestPermission() async {
    // Recorded before the dialog so the fresh-install and permanently-denied
    // states can be told apart — the rationale flag alone cannot.
    await widget.settings.markPhonePermissionRequested();
    await _telephony.requestPermissions();
    await _reload();
  }

  /// The cell towers opt-in: remember the choice, then ask for location.
  Future<void> _enableCellTowers() async {
    await widget.settings.setCellTowersEnabled(true);
    await widget.settings.markLocationPermissionRequested();
    await _telephony.requestLocationPermission();
    await _reload();
  }

  /// Signal polling refreshes cell towers too — a fresh serving cell is the
  /// whole point of that section — but only once the grant exists.
  Future<void> _pollSignal() async {
    final signals = await _telephony.getSignal();
    final wantCells = widget.settings.cellTowersEnabled &&
        (_overview?.permissions.location ?? false);
    final cells = wantCells ? await _telephony.getCellTowers() : _cellTowers;
    if (!mounted || !_shouldPollSignal) return;
    _signalHistory.record(signals);
    setState(() {
      _signals = signals;
      _cellTowers = cells;
    });
  }

  // --- signal polling ------------------------------------------------------

  bool get _shouldPollSignal =>
      _tab == 1 && (_overview?.permissions.phoneState ?? false);

  void _syncSignalPolling() {
    if (_shouldPollSignal) {
      _signalTimer ??= Timer.periodic(_signalInterval, (_) => _pollSignal());
    } else {
      _stopSignalPolling();
    }
  }

  void _stopSignalPolling() {
    _signalTimer?.cancel();
    _signalTimer = null;
  }

  // --- share ---------------------------------------------------------------

  Future<void> _shareReport() async {
    final overview = _overview;
    if (overview == null) return;
    String? version;
    try {
      final info = await PackageInfo.fromPlatform();
      version = '${info.version} (${info.buildNumber})';
    } catch (_) {
      // The report is still worth sharing without a version line.
    }
    final report = ReportBuilder.build(
      overview: overview,
      signals: _signals,
      appVersion: version,
    );
    await SharePlus.instance.share(ShareParams(text: report));
    if (_policy.shouldShow()) _interstitial.show();
  }

  Future<void> _shareJsonReport() async {
    final overview = _overview;
    if (overview == null) return;
    String? version;
    try {
      final info = await PackageInfo.fromPlatform();
      version = '${info.version} (${info.buildNumber})';
    } catch (_) {
      // The report is still worth sharing without a version line.
    }
    final report = ReportBuilder.buildJson(
      overview: overview,
      signals: _signals,
      usage: _dataUsage,
      appVersion: version,
    );
    await SharePlus.instance.share(ShareParams(text: report));
    if (_policy.shouldShow()) _interstitial.show();
  }

  // --- build ---------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final titles = [
      l10n.titleSims,
      l10n.tabNetwork,
      l10n.tabDevice,
      l10n.tabSettings,
    ];
    final overview = _overview;
    final granted = overview?.permissions.phoneState ?? false;
    final permanentlyDenied = overview != null &&
        !overview.permissions.phoneState &&
        !overview.permissions.showRationale &&
        // A fresh install also has showRationale == false; only a request
        // that has actually happened can have been permanently denied.
        widget.settings.hasRequestedPhonePermission;

    Widget body;
    if (_loading) {
      body = const Center(child: CircularProgressIndicator());
    } else {
      final gate = PermissionGate(
        permanentlyDenied: permanentlyDenied,
        onRequest: _requestPermission,
        onOpenSettings: () => _telephony.openAppSettings(),
      );
      body = IndexedStack(
        index: _tab,
        children: [
          _refreshable(
            granted
                ? SimsTab(sims: overview?.sims ?? const [])
                : _scrollable(gate),
          ),
          _refreshable(
            granted
                ? NetworkTab(
                    sims: overview?.sims ?? const [],
                    signals: _signals,
                    connectivity: overview?.connectivity ??
                        const ConnectivitySummary(connected: false),
                    addresses: _addresses,
                    signalHistory: _signalHistory,
                    cellTowers: _cellTowers,
                    cellTowersEnabled: widget.settings.cellTowersEnabled,
                    locationGranted:
                        overview?.permissions.location ?? false,
                    locationPermanentlyDenied: overview != null &&
                        !overview.permissions.location &&
                        !overview.permissions.showLocationRationale &&
                        widget.settings.hasRequestedLocationPermission,
                    onEnableCellTowers: _enableCellTowers,
                    onOpenAppSettings: () => _telephony.openAppSettings(),
                    dataUsage: _dataUsage,
                    onGrantUsageAccess: () =>
                        _telephony.openUsageAccessSettings(),
                  )
                : _scrollable(gate),
          ),
          _refreshable(
            DeviceTab(
              device: overview?.device ?? const DeviceSummary(),
              onOpenSystemScreen: (screen) =>
                  _telephony.openSystemScreen(screen),
            ),
          ),
          SettingsTab(
            settings: widget.settings,
            onShareReport: _shareReport,
            onShareJsonReport: _shareJsonReport,
            onLocaleChanged: (tag) => _telephony.setAppLocales(tag),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_tab],
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          if (_tab < 3) ...[
            IconButton(
              tooltip: l10n.tooltipShareReport,
              icon: const Icon(Icons.ios_share),
              onPressed: overview == null ? null : _shareReport,
            ),
            IconButton(
              tooltip: l10n.tooltipRefresh,
              icon: const Icon(Icons.refresh),
              onPressed: _refreshAction,
            ),
          ],
        ],
      ),
      body: SafeArea(child: body),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AnchoredBanner(),
          NavigationBar(
            selectedIndex: _tab,
            onDestinationSelected: (index) {
              setState(() => _tab = index);
              _syncSignalPolling();
            },
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.sim_card_outlined),
                selectedIcon: const Icon(Icons.sim_card),
                label: l10n.tabSims,
              ),
              NavigationDestination(
                icon: const Icon(Icons.cell_tower_outlined),
                selectedIcon: const Icon(Icons.cell_tower),
                label: l10n.tabNetwork,
              ),
              NavigationDestination(
                icon: const Icon(Icons.smartphone_outlined),
                selectedIcon: const Icon(Icons.smartphone),
                label: l10n.tabDevice,
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                label: l10n.tabSettings,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _refreshable(Widget child) =>
      RefreshIndicator(onRefresh: _refreshAction, child: child);

  /// Wraps a non-scrolling child so pull-to-refresh still works on it.
  Widget _scrollable(Widget child) => LayoutBuilder(
        builder: (context, constraints) => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: child,
            ),
          ],
        ),
      );
}
