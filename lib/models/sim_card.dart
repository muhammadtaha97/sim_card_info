/// One active subscription, as reported by the platform channel.
///
/// Every field except the ids is nullable on purpose: any individual read on
/// the Android side can be permission-gated, carrier-gated or missing on the
/// device's API level, and a null must mean "hide the row", never "crash the
/// card".
class SimCard {
  const SimCard({
    required this.subscriptionId,
    required this.slotIndex,
    this.displayName,
    this.carrierName,
    this.countryIso,
    this.mcc,
    this.mnc,
    this.number,
    this.isEmbedded,
    this.isOpportunistic,
    this.portIndex,
    this.cardId,
    this.isDefaultData = false,
    this.isDefaultVoice = false,
    this.isDefaultSms = false,
    this.simState,
    this.simOperator,
    this.simOperatorName,
    this.carrierId,
    this.carrierIdName,
    this.specificCarrierIdName,
    this.networkOperator,
    this.networkOperatorName,
    this.networkCountryIso,
    this.isRoaming,
    this.dataNetworkType,
    this.voiceNetworkType,
    this.phoneType,
    this.dataState,
    this.dataActivity,
    this.isDataEnabled,
  });

  final int subscriptionId;
  final int slotIndex;
  final String? displayName;
  final String? carrierName;
  final String? countryIso;
  final String? mcc;
  final String? mnc;
  final String? number;
  final bool? isEmbedded;
  final bool? isOpportunistic;
  final int? portIndex;
  final int? cardId;
  final bool isDefaultData;
  final bool isDefaultVoice;
  final bool isDefaultSms;
  final int? simState;
  final String? simOperator;
  final String? simOperatorName;
  final int? carrierId;
  final String? carrierIdName;
  final String? specificCarrierIdName;
  final String? networkOperator;
  final String? networkOperatorName;
  final String? networkCountryIso;
  final bool? isRoaming;
  final int? dataNetworkType;
  final int? voiceNetworkType;
  final int? phoneType;
  final int? dataState;
  final int? dataActivity;
  final bool? isDataEnabled;

  /// MCC and MNC joined the way they are printed on spec sheets, e.g. 424-02.
  String? get plmn =>
      (mcc != null && mnc != null) ? '$mcc-$mnc' : null;

  factory SimCard.fromMap(Map<Object?, Object?> map) => SimCard(
        subscriptionId: map['subscriptionId'] as int? ?? -1,
        slotIndex: map['slotIndex'] as int? ?? -1,
        displayName: map['displayName'] as String?,
        carrierName: map['carrierName'] as String?,
        countryIso: map['countryIso'] as String?,
        mcc: map['mcc'] as String?,
        mnc: map['mnc'] as String?,
        number: map['number'] as String?,
        isEmbedded: map['isEmbedded'] as bool?,
        isOpportunistic: map['isOpportunistic'] as bool?,
        portIndex: map['portIndex'] as int?,
        cardId: map['cardId'] as int?,
        isDefaultData: map['isDefaultData'] as bool? ?? false,
        isDefaultVoice: map['isDefaultVoice'] as bool? ?? false,
        isDefaultSms: map['isDefaultSms'] as bool? ?? false,
        simState: map['simState'] as int?,
        simOperator: map['simOperator'] as String?,
        simOperatorName: map['simOperatorName'] as String?,
        carrierId: map['carrierId'] as int?,
        carrierIdName: map['carrierIdName'] as String?,
        specificCarrierIdName: map['specificCarrierIdName'] as String?,
        networkOperator: map['networkOperator'] as String?,
        networkOperatorName: map['networkOperatorName'] as String?,
        networkCountryIso: map['networkCountryIso'] as String?,
        isRoaming: map['isRoaming'] as bool?,
        dataNetworkType: map['dataNetworkType'] as int?,
        voiceNetworkType: map['voiceNetworkType'] as int?,
        phoneType: map['phoneType'] as int?,
        dataState: map['dataState'] as int?,
        dataActivity: map['dataActivity'] as int?,
        isDataEnabled: map['isDataEnabled'] as bool?,
      );
}
