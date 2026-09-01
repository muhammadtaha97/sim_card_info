/// One radio's signal reading inside a subscription's snapshot.
class CellSignal {
  const CellSignal({required this.radio, this.dbm, this.asu, this.level});

  /// Human name of the radio technology: "5G NR", "LTE", "WCDMA", "GSM"…
  final String radio;

  /// Received power in dBm. Null when the modem reports the sentinel
  /// "unavailable" value, which the Kotlin side already filters out.
  final int? dbm;

  /// Arbitrary Strength Unit, the classic 0–31 (GSM) / 0–97 (LTE) scale.
  final int? asu;

  /// 0 (none/unknown) to 4 (great) — the same bucket the status bar uses.
  final int? level;

  factory CellSignal.fromMap(Map<Object?, Object?> map) => CellSignal(
        radio: map['radio'] as String? ?? 'Unknown',
        dbm: map['dbm'] as int?,
        asu: map['asu'] as int?,
        level: map['level'] as int?,
      );
}

/// Live signal snapshot for one subscription.
class SignalInfo {
  const SignalInfo({
    required this.subscriptionId,
    required this.slotIndex,
    this.level,
    this.networkType,
    this.cells = const [],
  });

  final int subscriptionId;
  final int slotIndex;

  /// Overall 0–4 bucket for the subscription.
  final int? level;

  final int? networkType;
  final List<CellSignal> cells;

  /// The strongest reading with a real dBm, for the headline number.
  CellSignal? get primaryCell {
    CellSignal? best;
    for (final cell in cells) {
      final dbm = cell.dbm;
      if (dbm == null) continue;
      if (best == null || dbm > best.dbm!) best = cell;
    }
    return best ?? (cells.isEmpty ? null : cells.first);
  }

  factory SignalInfo.fromMap(Map<Object?, Object?> map) => SignalInfo(
        subscriptionId: map['subscriptionId'] as int? ?? -1,
        slotIndex: map['slotIndex'] as int? ?? -1,
        level: map['level'] as int?,
        networkType: map['networkType'] as int?,
        cells: (map['cells'] as List<Object?>? ?? const [])
            .whereType<Map<Object?, Object?>>()
            .map(CellSignal.fromMap)
            .toList(),
      );
}
