/// Human labels for the integer constants TelephonyManager reports.
///
/// The ints are Android's own NETWORK_TYPE_* / SIM_STATE_* / etc. values and
/// are stable API — they are mapped here rather than in Kotlin so the mapping
/// is unit-testable without a device.
library;

/// TelephonyManager.NETWORK_TYPE_* → radio name.
const Map<int, String> _networkTypeNames = {
  0: 'Unknown',
  1: 'GPRS',
  2: 'EDGE',
  3: 'UMTS',
  4: 'CDMA',
  5: 'EVDO rev. 0',
  6: 'EVDO rev. A',
  7: '1xRTT',
  8: 'HSDPA',
  9: 'HSUPA',
  10: 'HSPA',
  11: 'iDEN',
  12: 'EVDO rev. B',
  13: 'LTE',
  14: 'eHRPD',
  15: 'HSPA+',
  16: 'GSM',
  17: 'TD-SCDMA',
  18: 'IWLAN (Wi-Fi calling)',
  19: 'LTE CA',
  20: '5G NR',
};

String networkTypeName(int? type) =>
    _networkTypeNames[type] ?? (type == null ? 'Unavailable' : 'Type $type');

/// The marketing generation for a NETWORK_TYPE_* value, or null when it has
/// no meaningful one (unknown, IWLAN).
String? networkGeneration(int? type) => switch (type) {
      1 || 2 || 7 || 11 || 16 => '2G',
      3 || 4 || 5 || 6 || 8 || 9 || 10 || 12 || 14 || 15 || 17 => '3G',
      13 || 19 => '4G',
      20 => '5G',
      _ => null,
    };

/// TelephonyManager.SIM_STATE_*.
String simStateName(int? state) => switch (state) {
      0 => 'Unknown',
      1 => 'Absent',
      2 => 'PIN required',
      3 => 'PUK required',
      4 => 'Network locked',
      5 => 'Ready',
      6 => 'Not ready',
      7 => 'Permanently disabled',
      8 => 'Card I/O error',
      9 => 'Card restricted',
      null => 'Unavailable',
      _ => 'State $state',
    };

/// TelephonyManager.PHONE_TYPE_*.
String phoneTypeName(int? type) => switch (type) {
      0 => 'None',
      1 => 'GSM',
      2 => 'CDMA',
      3 => 'SIP',
      null => 'Unavailable',
      _ => 'Type $type',
    };

/// TelephonyManager.DATA_* connection states.
String dataStateName(int? state) => switch (state) {
      0 => 'Disconnected',
      1 => 'Connecting',
      2 => 'Connected',
      3 => 'Suspended',
      4 => 'Disconnecting',
      null => 'Unavailable',
      _ => 'State $state',
    };

/// TelephonyManager.DATA_ACTIVITY_*.
String dataActivityName(int? activity) => switch (activity) {
      0 => 'Idle',
      1 => 'Receiving',
      2 => 'Sending',
      3 => 'Sending and receiving',
      4 => 'Dormant',
      null => 'Unavailable',
      _ => 'Activity $activity',
    };

/// The 0–4 signal bucket as a word.
String signalLevelName(int? level) => switch (level) {
      0 => 'None or unknown',
      1 => 'Poor',
      2 => 'Fair',
      3 => 'Good',
      4 => 'Excellent',
      null => 'Unavailable',
      _ => 'Level $level',
    };

/// Rough quality word for a dBm reading (cellular scale).
String dbmQuality(int dbm) {
  if (dbm >= -80) return 'Excellent';
  if (dbm >= -90) return 'Good';
  if (dbm >= -100) return 'Fair';
  if (dbm >= -110) return 'Poor';
  return 'Very poor';
}

/// Bytes rendered the way data usage is usually read (binary steps, one
/// decimal until the number is large).
String formatBytes(int bytes) {
  if (bytes < 1024) return '$bytes B';
  const units = ['KB', 'MB', 'GB', 'TB'];
  var value = bytes.toDouble();
  var unit = -1;
  while (value >= 1024 && unit < units.length - 1) {
    value /= 1024;
    unit++;
  }
  return value >= 100
      ? '${value.round()} ${units[unit]}'
      : '${value.toStringAsFixed(1)} ${units[unit]}';
}

/// Rough quality word for a TCP connect latency.
String latencyQuality(int ms) {
  if (ms < 40) return 'Excellent';
  if (ms < 80) return 'Good';
  if (ms < 150) return 'Fair';
  return 'Poor';
}

/// Kbps rendered the way link speeds are usually read.
String formatBandwidth(int kbps) {
  if (kbps >= 1000) {
    final mbps = kbps / 1000;
    return mbps >= 100
        ? '${mbps.round()} Mbps'
        : '${mbps.toStringAsFixed(1)} Mbps';
  }
  return '$kbps kbps';
}
