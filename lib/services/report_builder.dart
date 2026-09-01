import 'dart:convert';

import '../models/data_usage.dart';
import '../models/signal_info.dart';
import '../models/sim_card.dart';
import '../models/telephony_overview.dart';
import '../utils/countries.dart';
import '../utils/labels.dart';

/// Builds the plain-text report behind "Share report" and "Copy all".
///
/// Pure so it can be unit-tested: everything on screen that the user might
/// want to paste into a support ticket or a chat goes through here, and a
/// null field is omitted rather than rendered as "null".
abstract final class ReportBuilder {
  static String build({
    required TelephonyOverview overview,
    List<SignalInfo> signals = const [],
    String? appVersion,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('SIM Card Info report');
    if (appVersion != null) buffer.writeln('App version: $appVersion');
    buffer.writeln();

    if (overview.sims.isEmpty) {
      buffer.writeln('No active SIM cards.');
    }
    for (final sim in overview.sims) {
      _writeSim(buffer, sim, _signalFor(signals, sim.subscriptionId));
      buffer.writeln();
    }

    _writeDevice(buffer, overview.device);
    buffer.writeln();
    _writeConnectivity(buffer, overview.connectivity);

    return buffer.toString().trimRight();
  }

  /// The same data as [build] but machine-readable, for the JSON share
  /// option. Deliberately raw: ints stay ints, ISO codes stay codes, nulls
  /// are dropped — a tool on the receiving end wants values, not prose.
  static String buildJson({
    required TelephonyOverview overview,
    List<SignalInfo> signals = const [],
    DataUsage? usage,
    String? appVersion,
  }) {
    Map<String, Object> clean(Map<String, Object?> map) => {
          for (final entry in map.entries)
            if (entry.value != null) entry.key: entry.value!,
        };

    final payload = clean({
      'app': clean({'name': 'SIM Card Info', 'version': appVersion}),
      'sims': [
        for (final sim in overview.sims)
          clean({
            'slot': sim.slotIndex + 1,
            'subscriptionId': sim.subscriptionId,
            'carrier': sim.carrierName,
            'label': sim.displayName,
            'number': sim.number,
            'countryIso': sim.countryIso,
            'plmn': sim.plmn,
            'carrierId': sim.carrierId,
            'carrierIdName': sim.carrierIdName,
            'simState': sim.simState == null ? null : simStateName(sim.simState),
            'isEmbedded': sim.isEmbedded,
            'defaultData': sim.isDefaultData,
            'defaultVoice': sim.isDefaultVoice,
            'defaultSms': sim.isDefaultSms,
            'networkOperator': sim.networkOperatorName,
            'networkCountryIso': sim.networkCountryIso,
            'networkType': sim.dataNetworkType == null
                ? null
                : networkTypeName(sim.dataNetworkType),
            'generation': networkGeneration(sim.dataNetworkType),
            'roaming': sim.isRoaming,
            'dataState':
                sim.dataState == null ? null : dataStateName(sim.dataState),
            'signal': () {
              final signal = _signalFor(signals, sim.subscriptionId);
              final cell = signal?.primaryCell;
              if (signal == null) return null;
              return clean({
                'level': signal.level,
                'dbm': cell?.dbm,
                'asu': cell?.asu,
                'radio': cell?.radio,
              });
            }(),
          }),
      ],
      'device': clean({
        'manufacturer': overview.device.manufacturer,
        'model': overview.device.model,
        'androidVersion': overview.device.androidVersion,
        'sdkInt': overview.device.sdkInt,
        'activeModemCount': overview.device.activeModemCount,
        'esimSupported': overview.device.esimSupported,
      }),
      'connectivity': clean({
        'connected': overview.connectivity.connected,
        'transports': overview.connectivity.transports,
        'validated': overview.connectivity.validated,
        'metered': overview.connectivity.metered,
        'dnsServers': overview.connectivity.dnsServers,
        'addresses': overview.connectivity.addresses,
      }),
      'dataUsageBytes': usage == null || !usage.granted
          ? null
          : clean({
              'mobileToday': usage.mobileToday,
              'mobileMonth': usage.mobileMonth,
              'wifiToday': usage.wifiToday,
              'wifiMonth': usage.wifiMonth,
            }),
    });
    return const JsonEncoder.withIndent('  ').convert(payload);
  }

  static SignalInfo? _signalFor(List<SignalInfo> signals, int subscriptionId) {
    for (final signal in signals) {
      if (signal.subscriptionId == subscriptionId) return signal;
    }
    return null;
  }

  static void _line(StringBuffer buffer, String label, Object? value) {
    if (value == null) return;
    final text = value is bool ? (value ? 'Yes' : 'No') : value.toString();
    if (text.isEmpty) return;
    buffer.writeln('$label: $text');
  }

  static void _writeSim(StringBuffer buffer, SimCard sim, SignalInfo? signal) {
    buffer.writeln('— SIM ${sim.slotIndex + 1} —');
    _line(buffer, 'Carrier', sim.carrierName ?? sim.displayName);
    if (sim.displayName != null && sim.displayName != sim.carrierName) {
      _line(buffer, 'Label', sim.displayName);
    }
    _line(buffer, 'Phone number', sim.number);
    final country = sim.countryIso;
    if (country != null) {
      _line(buffer, 'SIM country',
          '${countryName(country)} (${country.toUpperCase()})');
    }
    _line(buffer, 'MCC-MNC', sim.plmn);
    _line(buffer, 'Carrier id', sim.carrierIdName);
    _line(buffer, 'SIM state', simStateName(sim.simState));
    _line(buffer, 'SIM type',
        sim.isEmbedded == null ? null : (sim.isEmbedded! ? 'eSIM' : 'Physical SIM'));
    final roles = [
      if (sim.isDefaultData) 'Data',
      if (sim.isDefaultVoice) 'Calls',
      if (sim.isDefaultSms) 'SMS',
    ];
    if (roles.isNotEmpty) _line(buffer, 'Default for', roles.join(', '));
    _line(buffer, 'Network operator', sim.networkOperatorName);
    final netCountry = sim.networkCountryIso;
    if (netCountry != null) {
      _line(buffer, 'Network country',
          '${countryName(netCountry)} (${netCountry.toUpperCase()})');
    }
    if (sim.dataNetworkType != null) {
      final generation = networkGeneration(sim.dataNetworkType);
      _line(
        buffer,
        'Network type',
        generation == null
            ? networkTypeName(sim.dataNetworkType)
            : '${networkTypeName(sim.dataNetworkType)} ($generation)',
      );
    }
    _line(buffer, 'Roaming', sim.isRoaming);
    _line(buffer, 'Mobile data', dataStateName(sim.dataState));
    final cell = signal?.primaryCell;
    if (cell != null && cell.dbm != null) {
      _line(buffer, 'Signal',
          '${cell.dbm} dBm (${dbmQuality(cell.dbm!)}, ${cell.radio})');
    } else if (signal?.level != null) {
      _line(buffer, 'Signal', signalLevelName(signal!.level));
    }
  }

  static void _writeDevice(StringBuffer buffer, DeviceSummary device) {
    buffer.writeln('— Device —');
    if (device.manufacturer != null || device.model != null) {
      _line(buffer, 'Device',
          [device.manufacturer, device.model].whereType<String>().join(' '));
    }
    _line(buffer, 'Android', device.androidVersion);
    _line(buffer, 'SIM slots (modems)', device.activeModemCount);
    _line(buffer, 'eSIM supported', device.esimSupported);
    _line(buffer, 'Voice capable', device.isVoiceCapable);
    _line(buffer, 'SMS capable', device.isSmsCapable);
  }

  static void _writeConnectivity(
      StringBuffer buffer, ConnectivitySummary connectivity) {
    buffer.writeln('— Connectivity —');
    if (!connectivity.connected) {
      buffer.writeln('No active network.');
      return;
    }
    if (connectivity.transports.isNotEmpty) {
      _line(buffer, 'Connection', connectivity.transports.join(' + '));
    }
    _line(buffer, 'Internet validated', connectivity.validated);
    _line(buffer, 'Metered', connectivity.metered);
    if (connectivity.dnsServers.isNotEmpty) {
      _line(buffer, 'DNS', connectivity.dnsServers.join(', '));
    }
  }
}
