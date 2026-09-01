import 'package:flutter_test/flutter_test.dart';
import 'package:sim_card_info/utils/countries.dart';
import 'package:sim_card_info/utils/labels.dart';

void main() {
  group('networkTypeName', () {
    test('maps the constants Android documents', () {
      expect(networkTypeName(13), 'LTE');
      expect(networkTypeName(20), '5G NR');
      expect(networkTypeName(3), 'UMTS');
      expect(networkTypeName(16), 'GSM');
      expect(networkTypeName(18), 'IWLAN (Wi-Fi calling)');
      expect(networkTypeName(0), 'Unknown');
    });

    test('degrades honestly on unmapped and missing values', () {
      expect(networkTypeName(null), 'Unavailable');
      expect(networkTypeName(99), 'Type 99');
    });
  });

  group('networkGeneration', () {
    test('assigns every documented type its marketing generation', () {
      expect(networkGeneration(1), '2G'); // GPRS
      expect(networkGeneration(2), '2G'); // EDGE
      expect(networkGeneration(16), '2G'); // GSM
      expect(networkGeneration(3), '3G'); // UMTS
      expect(networkGeneration(15), '3G'); // HSPA+
      expect(networkGeneration(17), '3G'); // TD-SCDMA
      expect(networkGeneration(13), '4G'); // LTE
      expect(networkGeneration(19), '4G'); // LTE CA
      expect(networkGeneration(20), '5G'); // NR
    });

    test('unknown and IWLAN have no generation', () {
      expect(networkGeneration(0), isNull);
      expect(networkGeneration(18), isNull);
      expect(networkGeneration(null), isNull);
    });

    test('every named type except unknown/IWLAN has a generation', () {
      for (var type = 1; type <= 20; type++) {
        if (type == 18) continue;
        expect(networkGeneration(type), isNotNull,
            reason: 'type $type has a name but no generation');
      }
    });
  });

  group('state labels', () {
    test('SIM states', () {
      expect(simStateName(5), 'Ready');
      expect(simStateName(1), 'Absent');
      expect(simStateName(2), 'PIN required');
      expect(simStateName(null), 'Unavailable');
    });

    test('data states and activity', () {
      expect(dataStateName(2), 'Connected');
      expect(dataStateName(0), 'Disconnected');
      expect(dataActivityName(3), 'Sending and receiving');
      expect(dataActivityName(0), 'Idle');
    });

    test('phone types', () {
      expect(phoneTypeName(1), 'GSM');
      expect(phoneTypeName(2), 'CDMA');
    });
  });

  group('signal quality', () {
    test('dBm buckets are ordered and cover the range', () {
      expect(dbmQuality(-60), 'Excellent');
      expect(dbmQuality(-80), 'Excellent');
      expect(dbmQuality(-85), 'Good');
      expect(dbmQuality(-95), 'Fair');
      expect(dbmQuality(-105), 'Poor');
      expect(dbmQuality(-120), 'Very poor');
    });

    test('level names', () {
      expect(signalLevelName(4), 'Excellent');
      expect(signalLevelName(0), 'None or unknown');
      expect(signalLevelName(null), 'Unavailable');
    });
  });

  group('formatBandwidth', () {
    test('kbps below 1000 stays in kbps', () {
      expect(formatBandwidth(750), '750 kbps');
    });

    test('Mbps with one decimal below 100', () {
      expect(formatBandwidth(51200), '51.2 Mbps');
    });

    test('whole Mbps at 100 and above', () {
      expect(formatBandwidth(262144), '262 Mbps');
    });
  });

  group('countries', () {
    test('flag is computed from regional indicators', () {
      expect(countryFlag('ae'), '🇦🇪');
      expect(countryFlag('US'), '🇺🇸');
      expect(countryFlag('pk'), '🇵🇰');
    });

    test('flag rejects malformed codes', () {
      expect(countryFlag(null), isNull);
      expect(countryFlag('a'), isNull);
      expect(countryFlag('a1'), isNull);
      expect(countryFlag('abc'), isNull);
    });

    test('names cover the codes telephony actually reports', () {
      expect(countryName('ae'), 'United Arab Emirates');
      expect(countryName('gb'), 'United Kingdom');
      expect(countryName('us'), 'United States');
      expect(countryName('in'), 'India');
      expect(countryName('pk'), 'Pakistan');
    });

    test('an unmapped code falls back to the code itself', () {
      expect(countryName('zz'), 'ZZ');
      expect(countryName(null), 'Unknown');
      expect(countryName(''), 'Unknown');
    });
  });
}
