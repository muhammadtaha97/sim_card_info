import 'package:flutter_test/flutter_test.dart';
import 'package:sim_card_info/models/cell_tower.dart';
import 'package:sim_card_info/models/data_usage.dart';
import 'package:sim_card_info/models/signal_info.dart';
import 'package:sim_card_info/models/sim_card.dart';
import 'package:sim_card_info/models/telephony_overview.dart';
import 'package:sim_card_info/services/report_builder.dart';
import 'package:sim_card_info/services/signal_history.dart';
import 'package:sim_card_info/utils/labels.dart';

void main() {
  group('formatBytes', () {
    test('steps through the units at 1024', () {
      expect(formatBytes(0), '0 B');
      expect(formatBytes(1023), '1023 B');
      expect(formatBytes(1536), '1.5 KB');
      expect(formatBytes(5 * 1024 * 1024), '5.0 MB');
      expect(formatBytes(250 * 1024 * 1024), '250 MB');
      expect(formatBytes(3 * 1024 * 1024 * 1024), '3.0 GB');
    });
  });

  group('latencyQuality', () {
    test('buckets are ordered', () {
      expect(latencyQuality(10), 'Excellent');
      expect(latencyQuality(60), 'Good');
      expect(latencyQuality(120), 'Fair');
      expect(latencyQuality(400), 'Poor');
    });
  });

  group('SignalHistory', () {
    SignalInfo signal(int subId, int dbm) => SignalInfo(
          subscriptionId: subId,
          slotIndex: 0,
          cells: [CellSignal(radio: 'LTE', dbm: dbm)],
        );

    test('records per subscription and keeps order', () {
      final history = SignalHistory();
      final t0 = DateTime(2026, 9, 1, 12);
      history.record([signal(1, -80), signal(2, -95)], now: t0);
      history.record([signal(1, -82)], now: t0.add(const Duration(seconds: 3)));

      expect(history.samplesFor(1).map((s) => s.dbm), [-80, -82]);
      expect(history.samplesFor(2).map((s) => s.dbm), [-95]);
      expect(history.samplesFor(99), isEmpty);
    });

    test('caps at capacity, dropping the oldest', () {
      final history = SignalHistory(capacity: 3);
      final t0 = DateTime(2026, 9, 1, 12);
      for (var i = 0; i < 5; i++) {
        history.record([signal(1, -80 - i)],
            now: t0.add(Duration(seconds: 3 * i)));
      }
      expect(history.samplesFor(1).map((s) => s.dbm), [-82, -83, -84]);
    });

    test('a reading without dBm is skipped, not recorded as garbage', () {
      final history = SignalHistory();
      history.record(
        [const SignalInfo(subscriptionId: 1, slotIndex: 0, level: 2)],
        now: DateTime(2026, 9, 1),
      );
      expect(history.samplesFor(1), isEmpty);
    });
  });

  group('CellTower', () {
    test('parses the uniform Kotlin shape', () {
      final tower = CellTower.fromMap(const {
        'registered': true,
        'radio': '5G NR',
        'plmn': '424-03',
        'cellId': 343233245,
        'area': 3021,
        'pci': 218,
        'channel': 640000,
        'bands': [78],
        'dbm': -84,
        'level': 3,
        'rsrp': -84,
        'rsrq': -11,
        'sinr': 18,
      });
      expect(tower.registered, isTrue);
      expect(tower.channelName, 'NRARFCN');
      expect(tower.areaName, 'TAC');
      expect(tower.bands, [78]);
    });

    test('names the channel and area per radio', () {
      CellTower named(String radio) =>
          CellTower(registered: false, radio: radio);
      expect(named('LTE').channelName, 'EARFCN');
      expect(named('LTE').areaName, 'TAC');
      expect(named('WCDMA').channelName, 'UARFCN');
      expect(named('WCDMA').areaName, 'LAC');
      expect(named('GSM').channelName, 'ARFCN');
      expect(named('GSM').areaName, 'LAC');
    });
  });

  group('JSON report', () {
    final overview = TelephonyOverview(
      permissions: const PermissionStates(
        phoneState: true,
        phoneNumbers: true,
        showRationale: false,
      ),
      sims: const [
        SimCard(
          subscriptionId: 1,
          slotIndex: 0,
          carrierName: 'du',
          countryIso: 'ae',
          mcc: '424',
          mnc: '03',
          dataNetworkType: 20,
          isRoaming: false,
        ),
      ],
      device: const DeviceSummary(manufacturer: 'Google', model: 'Pixel 9'),
      connectivity: const ConnectivitySummary(
        connected: true,
        transports: ['Wi-Fi'],
      ),
    );

    test('is valid JSON with the headline fields', () {
      final json = ReportBuilder.buildJson(
        overview: overview,
        usage: const DataUsage(granted: true, mobileToday: 1024),
        appVersion: '1.0.0 (1)',
      );
      expect(json, contains('"carrier": "du"'));
      expect(json, contains('"plmn": "424-03"'));
      expect(json, contains('"networkType": "5G NR"'));
      expect(json, contains('"generation": "5G"'));
      expect(json, contains('"mobileToday": 1024'));
      expect(json, isNot(contains('null')));
    });

    test('usage is omitted when not granted', () {
      final json = ReportBuilder.buildJson(
        overview: overview,
        usage: DataUsage.denied,
      );
      expect(json, isNot(contains('dataUsageBytes')));
    });
  });
}
