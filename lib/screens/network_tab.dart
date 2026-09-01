import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../models/cell_tower.dart';
import '../models/data_usage.dart';
import '../models/signal_info.dart';
import '../models/sim_card.dart';
import '../models/telephony_overview.dart';
import '../services/signal_history.dart';
import '../utils/countries.dart';
import '../utils/labels.dart';
import '../utils/localized_labels.dart';
import '../widgets/cell_towers_card.dart';
import '../widgets/data_usage_card.dart';
import '../widgets/info_row.dart';
import '../widgets/latency_card.dart';
import '../widgets/section_card.dart';
import '../widgets/signal_meter.dart';
import '../widgets/signal_sparkline.dart';

/// The Network tab: live signal per SIM (with its recent history), the
/// serving network's details, the opt-in cell towers and data usage
/// sections, the active data connection, and the latency tool.
class NetworkTab extends StatelessWidget {
  const NetworkTab({
    super.key,
    required this.sims,
    required this.signals,
    required this.connectivity,
    required this.addresses,
    required this.signalHistory,
    this.cellTowers = const [],
    this.cellTowersEnabled = false,
    this.locationGranted = false,
    this.locationPermanentlyDenied = false,
    this.onEnableCellTowers,
    this.onOpenAppSettings,
    this.dataUsage = DataUsage.denied,
    this.onGrantUsageAccess,
  });

  final List<SimCard> sims;
  final List<SignalInfo> signals;
  final ConnectivitySummary connectivity;
  final List<({String interface, String address, bool isIPv6})> addresses;
  final SignalHistory signalHistory;
  final List<CellTower> cellTowers;
  final bool cellTowersEnabled;
  final bool locationGranted;
  final bool locationPermanentlyDenied;
  final VoidCallback? onEnableCellTowers;
  final VoidCallback? onOpenAppSettings;
  final DataUsage dataUsage;
  final VoidCallback? onGrantUsageAccess;

  SignalInfo? _signalFor(int subscriptionId) {
    for (final signal in signals) {
      if (signal.subscriptionId == subscriptionId) return signal;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        for (final sim in sims) ...[
          _NetworkCard(
            sim: sim,
            signal: _signalFor(sim.subscriptionId),
            history: signalHistory.samplesFor(sim.subscriptionId),
          ),
          const SizedBox(height: 12),
        ],
        if (sims.isEmpty) ...[
          const _NoCellular(),
          const SizedBox(height: 12),
        ],
        if (sims.isNotEmpty) ...[
          CellTowersCard(
            enabled: cellTowersEnabled,
            granted: locationGranted,
            permanentlyDenied: locationPermanentlyDenied,
            towers: cellTowers,
            onEnable: onEnableCellTowers ?? () {},
            onOpenSettings: onOpenAppSettings ?? () {},
          ),
          const SizedBox(height: 12),
        ],
        DataUsageCard(
          usage: dataUsage,
          onGrant: onGrantUsageAccess ?? () {},
        ),
        const SizedBox(height: 12),
        _ConnectivityCard(connectivity: connectivity),
        if (addresses.isNotEmpty) ...[
          const SizedBox(height: 12),
          SectionCard(
            title: AppLocalizations.of(context).sectionIpAddresses,
            icon: Icons.lan_outlined,
            children: [
              for (final addr in addresses)
                InfoRow(
                  label:
                      '${addr.interface} · ${addr.isIPv6 ? 'IPv6' : 'IPv4'}',
                  value: addr.address,
                ),
            ],
          ),
        ],
        const SizedBox(height: 12),
        const LatencyCard(),
      ],
    );
  }
}

class _NetworkCard extends StatelessWidget {
  const _NetworkCard({required this.sim, this.signal, this.history = const []});

  final SimCard sim;
  final SignalInfo? signal;
  final List<SignalSample> history;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final cell = signal?.primaryCell;
    final networkType = signal?.networkType ?? sim.dataNetworkType;
    final generation = networkGeneration(networkType);
    final netCountry = sim.networkCountryIso;

    return SectionCard(
      title:
          '${(sim.isEmbedded ?? false) ? 'eSIM' : l10n.simN(sim.slotIndex + 1)} · ${sim.carrierName ?? l10n.unknown}'
              .toUpperCase(),
      icon: Icons.cell_tower,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: SignalMeter(
            dbm: cell?.dbm,
            level: signal?.level,
            radio: cell?.radio,
          ),
        ),
        if (history.length >= 2)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: SignalSparkline(samples: history),
          ),
        if (signal != null && signal!.cells.length > 1)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final extra in signal!.cells)
                  if (extra.dbm != null)
                    Chip(
                      visualDensity: VisualDensity.compact,
                      label: Text(
                        '${extra.radio}  ${extra.dbm} dBm',
                        style: theme.textTheme.labelSmall,
                      ),
                    ),
              ],
            ),
          ),
        InfoRow(
          label: l10n.labelNetworkType,
          value: generation == null
              ? networkTypeName(networkType)
              : '${networkTypeName(networkType)} ($generation)',
        ),
        if (sim.voiceNetworkType != null &&
            sim.voiceNetworkType != networkType)
          InfoRow(
            label: l10n.labelVoiceNetwork,
            value: networkTypeName(sim.voiceNetworkType),
          ),
        if (sim.networkOperatorName != null)
          InfoRow(label: l10n.labelOperator, value: sim.networkOperatorName!),
        if (sim.networkOperator != null)
          InfoRow(label: l10n.labelOperatorCode, value: sim.networkOperator!),
        if (netCountry != null)
          InfoRow(
            label: l10n.labelNetworkCountry,
            value:
                '${countryFlag(netCountry) ?? ''} ${countryName(netCountry)}'
                    .trim(),
          ),
        InfoRow(
          label: l10n.labelRoaming,
          value: localizedYesNo(l10n, sim.isRoaming),
          copyable: false,
        ),
        InfoRow(
          label: l10n.labelMobileData,
          value: localizedDataState(l10n, sim.dataState),
          copyable: false,
        ),
        if (sim.isDataEnabled != null)
          InfoRow(
            label: l10n.labelDataEnabled,
            value: localizedYesNo(l10n, sim.isDataEnabled),
            copyable: false,
          ),
        InfoRow(
          label: l10n.labelDataActivity,
          value: localizedDataActivity(l10n, sim.dataActivity),
          copyable: false,
        ),
        InfoRow(
          label: l10n.labelPhoneType,
          value: phoneTypeName(sim.phoneType),
          copyable: false,
        ),
      ],
    );
  }
}

class _ConnectivityCard extends StatelessWidget {
  const _ConnectivityCard({required this.connectivity});

  final ConnectivitySummary connectivity;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (!connectivity.connected) {
      return SectionCard(
        title: l10n.sectionActiveConnection,
        icon: Icons.wifi_off,
        children: [
          InfoRow(
            label: l10n.labelStatus,
            value: l10n.noActiveNetwork,
            copyable: false,
          ),
        ],
      );
    }
    return SectionCard(
      title: l10n.sectionActiveConnection,
      icon: Icons.swap_vert,
      children: [
        if (connectivity.transports.isNotEmpty)
          InfoRow(
            label: l10n.labelConnection,
            value: connectivity.transports.join(' + '),
            copyable: false,
          ),
        if (connectivity.validated != null)
          InfoRow(
            label: l10n.labelInternetAccess,
            value: connectivity.validated! ? l10n.validated : l10n.notValidated,
            copyable: false,
          ),
        if (connectivity.metered != null)
          InfoRow(
            label: l10n.labelMetered,
            value: localizedYesNo(l10n, connectivity.metered),
            copyable: false,
          ),
        if (connectivity.downstreamKbps != null)
          InfoRow(
            label: l10n.labelLinkDown,
            value: formatBandwidth(connectivity.downstreamKbps!),
            copyable: false,
          ),
        if (connectivity.upstreamKbps != null)
          InfoRow(
            label: l10n.labelLinkUp,
            value: formatBandwidth(connectivity.upstreamKbps!),
            copyable: false,
          ),
        if (connectivity.interfaceName != null)
          InfoRow(label: l10n.labelInterface, value: connectivity.interfaceName!),
        for (final dns in connectivity.dnsServers)
          InfoRow(label: l10n.labelDnsServer, value: dns),
        if (connectivity.privateDnsActive != null)
          InfoRow(
            label: l10n.labelPrivateDns,
            value: connectivity.privateDnsActive!
                ? (connectivity.privateDnsServer ?? l10n.yes)
                : l10n.off,
          ),
      ],
    );
  }
}

class _NoCellular extends StatelessWidget {
  const _NoCellular();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      title: l10n.sectionCellular,
      icon: Icons.signal_cellular_off,
      children: [
        InfoRow(
          label: l10n.labelStatus,
          value: l10n.noActiveSim,
          copyable: false,
        ),
      ],
    );
  }
}
