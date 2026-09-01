import 'sim_card.dart';

/// The permission answer that gates almost everything on screen.
class PermissionStates {
  const PermissionStates({
    required this.phoneState,
    required this.phoneNumbers,
    required this.showRationale,
    this.location = false,
    this.usageAccess = false,
    this.showLocationRationale = true,
  });

  final bool phoneState;
  final bool phoneNumbers;

  /// Fine location, which gates the cell towers section only.
  final bool location;

  /// The Usage Access special grant, which gates the data usage section only.
  final bool usageAccess;

  /// False together with a missing permission means "denied permanently":
  /// the system dialog will not appear again and only the app settings
  /// screen can change the answer.
  final bool showRationale;

  /// Same flag for the location permission.
  final bool showLocationRationale;

  factory PermissionStates.fromMap(Map<Object?, Object?> map) =>
      PermissionStates(
        phoneState: map['phoneState'] as bool? ?? false,
        phoneNumbers: map['phoneNumbers'] as bool? ?? false,
        showRationale: map['showRationale'] as bool? ?? true,
        location: map['location'] as bool? ?? false,
        usageAccess: map['usageAccess'] as bool? ?? false,
        showLocationRationale: map['showLocationRationale'] as bool? ?? true,
      );

  static const denied = PermissionStates(
    phoneState: false,
    phoneNumbers: false,
    showRationale: true,
  );
}

/// Device-level telephony capabilities.
class DeviceSummary {
  const DeviceSummary({
    this.manufacturer,
    this.model,
    this.device,
    this.androidVersion,
    this.sdkInt,
    this.hasTelephony,
    this.esimSupported,
    this.activeModemCount,
    this.supportedModemCount,
    this.isVoiceCapable,
    this.isSmsCapable,
    this.hasIccCard,
    this.isConcurrentVoiceAndData,
    this.deviceSoftwareVersion,
    this.maxActiveSubscriptions,
  });

  final String? manufacturer;
  final String? model;
  final String? device;
  final String? androidVersion;
  final int? sdkInt;
  final bool? hasTelephony;
  final bool? esimSupported;
  final int? activeModemCount;
  final int? supportedModemCount;
  final bool? isVoiceCapable;
  final bool? isSmsCapable;
  final bool? hasIccCard;
  final bool? isConcurrentVoiceAndData;
  final String? deviceSoftwareVersion;
  final int? maxActiveSubscriptions;

  factory DeviceSummary.fromMap(Map<Object?, Object?> map) => DeviceSummary(
        manufacturer: map['manufacturer'] as String?,
        model: map['model'] as String?,
        device: map['device'] as String?,
        androidVersion: map['androidVersion'] as String?,
        sdkInt: map['sdkInt'] as int?,
        hasTelephony: map['hasTelephony'] as bool?,
        esimSupported: map['esimSupported'] as bool?,
        activeModemCount: map['activeModemCount'] as int?,
        supportedModemCount: map['supportedModemCount'] as int?,
        isVoiceCapable: map['isVoiceCapable'] as bool?,
        isSmsCapable: map['isSmsCapable'] as bool?,
        hasIccCard: map['hasIccCard'] as bool?,
        isConcurrentVoiceAndData: map['isConcurrentVoiceAndData'] as bool?,
        deviceSoftwareVersion: map['deviceSoftwareVersion'] as String?,
        maxActiveSubscriptions: map['maxActiveSubscriptions'] as int?,
      );
}

/// The active network link as ConnectivityManager reports it.
class ConnectivitySummary {
  const ConnectivitySummary({
    required this.connected,
    this.transports = const [],
    this.validated,
    this.metered,
    this.downstreamKbps,
    this.upstreamKbps,
    this.interfaceName,
    this.dnsServers = const [],
    this.privateDnsActive,
    this.privateDnsServer,
    this.addresses = const [],
    this.domains,
  });

  final bool connected;
  final List<String> transports;
  final bool? validated;
  final bool? metered;
  final int? downstreamKbps;
  final int? upstreamKbps;
  final String? interfaceName;
  final List<String> dnsServers;
  final bool? privateDnsActive;
  final String? privateDnsServer;
  final List<String> addresses;
  final String? domains;

  factory ConnectivitySummary.fromMap(Map<Object?, Object?> map) =>
      ConnectivitySummary(
        connected: map['connected'] as bool? ?? false,
        transports: (map['transports'] as List<Object?>? ?? const [])
            .whereType<String>()
            .toList(),
        validated: map['validated'] as bool?,
        metered: map['metered'] as bool?,
        downstreamKbps: map['downstreamKbps'] as int?,
        upstreamKbps: map['upstreamKbps'] as int?,
        interfaceName: map['interfaceName'] as String?,
        dnsServers: (map['dnsServers'] as List<Object?>? ?? const [])
            .whereType<String>()
            .toList(),
        privateDnsActive: map['privateDnsActive'] as bool?,
        privateDnsServer: map['privateDnsServer'] as String?,
        addresses: (map['addresses'] as List<Object?>? ?? const [])
            .whereType<String>()
            .toList(),
        domains: map['domains'] as String?,
      );
}

/// Everything getOverview returns in one call.
class TelephonyOverview {
  const TelephonyOverview({
    required this.permissions,
    required this.sims,
    required this.device,
    required this.connectivity,
  });

  final PermissionStates permissions;
  final List<SimCard> sims;
  final DeviceSummary device;
  final ConnectivitySummary connectivity;

  factory TelephonyOverview.fromMap(Map<Object?, Object?> map) =>
      TelephonyOverview(
        permissions: PermissionStates.fromMap(
          map['permissions'] as Map<Object?, Object?>? ?? const {},
        ),
        sims: (map['sims'] as List<Object?>? ?? const [])
            .whereType<Map<Object?, Object?>>()
            .map(SimCard.fromMap)
            .toList(),
        device: DeviceSummary.fromMap(
          map['device'] as Map<Object?, Object?>? ?? const {},
        ),
        connectivity: ConnectivitySummary.fromMap(
          map['connectivity'] as Map<Object?, Object?>? ?? const {},
        ),
      );
}
