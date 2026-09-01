import 'package:flutter_test/flutter_test.dart';
import 'package:sim_card_info/models/signal_info.dart';
import 'package:sim_card_info/models/sim_card.dart';
import 'package:sim_card_info/models/telephony_overview.dart';
import 'package:sim_card_info/services/report_builder.dart';

TelephonyOverview _overview({List<SimCard> sims = const []}) =>
    TelephonyOverview(
      permissions: const PermissionStates(
        phoneState: true,
        phoneNumbers: true,
        showRationale: false,
      ),
      sims: sims,
      device: const DeviceSummary(
        manufacturer: 'Google',
        model: 'Pixel 9',
        androidVersion: '17',
        activeModemCount: 2,
        esimSupported: true,
      ),
      connectivity: const ConnectivitySummary(
        connected: true,
        transports: ['Wi-Fi'],
        validated: true,
        metered: false,
        dnsServers: ['192.168.1.1'],
      ),
    );

const _sim = SimCard(
  subscriptionId: 3,
  slotIndex: 0,
  carrierName: 'du',
  countryIso: 'ae',
  mcc: '424',
  mnc: '03',
  isEmbedded: false,
  isDefaultData: true,
  isDefaultVoice: true,
  isDefaultSms: false,
  simState: 5,
  networkOperatorName: 'du',
  networkCountryIso: 'ae',
  isRoaming: false,
  dataNetworkType: 20,
  dataState: 2,
);

void main() {
  test('a full report carries the fields a support thread needs', () {
    final report = ReportBuilder.build(
      overview: _overview(sims: const [_sim]),
      signals: const [
        SignalInfo(
          subscriptionId: 3,
          slotIndex: 0,
          level: 4,
          cells: [CellSignal(radio: '5G NR', dbm: -78, asu: 40, level: 4)],
        ),
      ],
      appVersion: '1.0.0 (1)',
    );

    expect(report, contains('App version: 1.0.0 (1)'));
    expect(report, contains('— SIM 1 —'));
    expect(report, contains('Carrier: du'));
    expect(report, contains('SIM country: United Arab Emirates (AE)'));
    expect(report, contains('MCC-MNC: 424-03'));
    expect(report, contains('SIM state: Ready'));
    expect(report, contains('SIM type: Physical SIM'));
    expect(report, contains('Default for: Data, Calls'));
    expect(report, contains('Network type: 5G NR (5G)'));
    expect(report, contains('Roaming: No'));
    expect(report, contains('Signal: -78 dBm (Excellent, 5G NR)'));
    expect(report, contains('Device: Google Pixel 9'));
    expect(report, contains('Connection: Wi-Fi'));
    expect(report, contains('DNS: 192.168.1.1'));
  });

  test('null fields are omitted, never rendered as "null"', () {
    final report = ReportBuilder.build(
      overview: _overview(
        sims: const [SimCard(subscriptionId: 1, slotIndex: 0)],
      ),
    );
    expect(report, isNot(contains('null')));
    expect(report, isNot(contains('Phone number:')));
    expect(report, isNot(contains('MCC-MNC:')));
  });

  test('no SIMs is stated rather than silently empty', () {
    final report = ReportBuilder.build(overview: _overview());
    expect(report, contains('No active SIM cards.'));
  });

  test('signal falls back to the level word when no dBm is available', () {
    final report = ReportBuilder.build(
      overview: _overview(sims: const [_sim]),
      signals: const [SignalInfo(subscriptionId: 3, slotIndex: 0, level: 2)],
    );
    expect(report, contains('Signal: Fair'));
  });

  test('signals are matched by subscription id, not list position', () {
    final report = ReportBuilder.build(
      overview: _overview(sims: const [_sim]),
      signals: const [
        SignalInfo(subscriptionId: 99, slotIndex: 1, level: 1),
        SignalInfo(
          subscriptionId: 3,
          slotIndex: 0,
          cells: [CellSignal(radio: 'LTE', dbm: -95, level: 2)],
        ),
      ],
    );
    expect(report, contains('Signal: -95 dBm (Fair, LTE)'));
  });
}
