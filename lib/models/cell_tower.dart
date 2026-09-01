/// One serving or neighbour cell, in the uniform shape the Kotlin side
/// produces for every radio technology. Null means "this radio or API level
/// does not report that field" and the row is hidden.
class CellTower {
  const CellTower({
    required this.registered,
    required this.radio,
    this.plmn,
    this.cellId,
    this.area,
    this.pci,
    this.channel,
    this.bands = const [],
    this.bandwidthKhz,
    this.bsic,
    this.dbm,
    this.level,
    this.rsrp,
    this.rsrq,
    this.sinr,
    this.timingAdvance,
  });

  /// True for the cell the phone is camped on; false for a neighbour.
  final bool registered;

  final String radio;
  final String? plmn;

  /// NCI (NR), CI (LTE), CID (WCDMA/GSM) — always the tower's cell identity.
  final int? cellId;

  /// TAC on LTE/NR, LAC on WCDMA/GSM.
  final int? area;

  /// Physical cell id (LTE/NR), PSC (WCDMA), CPID (TD-SCDMA).
  final int? pci;

  /// The frequency channel: NRARFCN / EARFCN / UARFCN / ARFCN.
  final int? channel;

  final List<int> bands;
  final int? bandwidthKhz;
  final int? bsic;
  final int? dbm;
  final int? level;
  final int? rsrp;
  final int? rsrq;

  /// SINR on NR, RSSNR on LTE.
  final int? sinr;

  final int? timingAdvance;

  factory CellTower.fromMap(Map<Object?, Object?> map) => CellTower(
        registered: map['registered'] as bool? ?? false,
        radio: map['radio'] as String? ?? 'Unknown',
        plmn: map['plmn'] as String?,
        cellId: (map['cellId'] as num?)?.toInt(),
        area: map['area'] as int?,
        pci: map['pci'] as int?,
        channel: map['channel'] as int?,
        bands: (map['bands'] as List<Object?>? ?? const [])
            .whereType<int>()
            .toList(),
        bandwidthKhz: map['bandwidthKhz'] as int?,
        bsic: map['bsic'] as int?,
        dbm: map['dbm'] as int?,
        level: map['level'] as int?,
        rsrp: map['rsrp'] as int?,
        rsrq: map['rsrq'] as int?,
        sinr: map['sinr'] as int?,
        timingAdvance: map['timingAdvance'] as int?,
      );

  /// What the channel number is called on this radio.
  String get channelName => switch (radio) {
        '5G NR' => 'NRARFCN',
        'LTE' => 'EARFCN',
        'WCDMA' || 'TD-SCDMA' => 'UARFCN',
        'GSM' => 'ARFCN',
        _ => 'Channel',
      };

  /// What the area code is called on this radio.
  String get areaName => switch (radio) {
        '5G NR' || 'LTE' => 'TAC',
        _ => 'LAC',
      };
}
