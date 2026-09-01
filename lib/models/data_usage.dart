/// Device data-usage totals from NetworkStatsManager.
///
/// Cellular is all SIMs combined: the per-subscription split needs the
/// subscriber id, which has been carrier-privileged since Android 10 — no
/// public app can report it honestly, so this one does not pretend to.
class DataUsage {
  const DataUsage({
    required this.granted,
    this.mobileToday,
    this.mobileMonth,
    this.wifiToday,
    this.wifiMonth,
  });

  /// Whether the Usage Access special permission is granted; everything else
  /// is null when it is not.
  final bool granted;

  final int? mobileToday;
  final int? mobileMonth;
  final int? wifiToday;
  final int? wifiMonth;

  factory DataUsage.fromMap(Map<Object?, Object?> map) => DataUsage(
        granted: map['granted'] as bool? ?? false,
        mobileToday: (map['mobileToday'] as num?)?.toInt(),
        mobileMonth: (map['mobileMonth'] as num?)?.toInt(),
        wifiToday: (map['wifiToday'] as num?)?.toInt(),
        wifiMonth: (map['wifiMonth'] as num?)?.toInt(),
      );

  static const denied = DataUsage(granted: false);
}
