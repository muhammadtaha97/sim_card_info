import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../models/cell_tower.dart';
import '../utils/localized_labels.dart';
import 'info_row.dart';
import 'section_card.dart';

/// The cell towers section, gated behind an explicit opt-in because it is the
/// one dataset here that costs the location permission — Android treats a
/// cell id as a location. Until the user taps enable, nothing is requested.
class CellTowersCard extends StatelessWidget {
  const CellTowersCard({
    super.key,
    required this.enabled,
    required this.granted,
    required this.permanentlyDenied,
    required this.towers,
    required this.onEnable,
    required this.onOpenSettings,
  });

  /// Whether the user has opted in to this section at all.
  final bool enabled;

  /// Whether fine location is actually granted.
  final bool granted;

  final bool permanentlyDenied;
  final List<CellTower> towers;
  final VoidCallback onEnable;
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    if (!enabled || !granted) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.cell_tower, size: 18, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    l10n.sectionCellTowers,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                l10n.cellTowersExplainer,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
              FilledButton.tonalIcon(
                onPressed: permanentlyDenied ? onOpenSettings : onEnable,
                icon: Icon(permanentlyDenied
                    ? Icons.settings_outlined
                    : Icons.cell_tower),
                label: Text(permanentlyDenied
                    ? l10n.openAppSettings
                    : l10n.showCellTowers),
              ),
              if (permanentlyDenied) ...[
                const SizedBox(height: 8),
                Text(
                  l10n.locationPermanent,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ],
          ),
        ),
      );
    }

    final registered = towers.where((tower) => tower.registered).toList();
    final neighbours = towers.where((tower) => !tower.registered).toList();

    return Column(
      children: [
        SectionCard(
          title: l10n.sectionServingCell,
          icon: Icons.cell_tower,
          children: registered.isEmpty
              ? [
                  InfoRow(
                    label: l10n.labelStatus,
                    value: l10n.noCellReported,
                    copyable: false,
                  ),
                ]
              : [
                  for (final tower in registered) ..._towerRows(l10n, tower),
                ],
        ),
        if (neighbours.isNotEmpty) ...[
          const SizedBox(height: 12),
          SectionCard(
            title: l10n.sectionNeighbours,
            icon: Icons.podcasts,
            children: [
              for (final tower in neighbours.take(8))
                InfoRow(
                  label: tower.radio,
                  value: [
                    if (tower.pci != null) 'PCI ${tower.pci}',
                    if (tower.channel != null)
                      '${tower.channelName} ${tower.channel}',
                    if (tower.dbm != null) '${tower.dbm} dBm',
                  ].join('  ·  '),
                ),
            ],
          ),
        ],
      ],
    );
  }

  List<Widget> _towerRows(AppLocalizations l10n, CellTower tower) => [
        InfoRow(label: 'Radio', value: tower.radio, copyable: false),
        if (tower.plmn != null) InfoRow(label: 'PLMN', value: tower.plmn!),
        if (tower.cellId != null)
          InfoRow(label: 'Cell ID', value: '${tower.cellId}'),
        if (tower.area != null)
          InfoRow(label: tower.areaName, value: '${tower.area}'),
        if (tower.pci != null) InfoRow(label: 'PCI', value: '${tower.pci}'),
        if (tower.channel != null)
          InfoRow(label: tower.channelName, value: '${tower.channel}'),
        if (tower.bands.isNotEmpty)
          InfoRow(
            label: tower.bands.length == 1 ? 'Band' : 'Bands',
            // 3GPP naming: NR bands are n78-style, LTE bands B3-style.
            value: tower.bands
                .map((band) => tower.radio == '5G NR' ? 'n$band' : 'B$band')
                .join(', '),
          ),
        if (tower.bandwidthKhz != null)
          InfoRow(
            label: 'Bandwidth',
            value: '${tower.bandwidthKhz! ~/ 1000} MHz',
          ),
        if (tower.dbm != null)
          InfoRow(
            label: l10n.labelSignal,
            value:
                '${tower.dbm} dBm (${localizedDbmQuality(l10n, tower.dbm!)})',
          ),
        if (tower.rsrp != null)
          InfoRow(label: 'RSRP', value: '${tower.rsrp} dBm'),
        if (tower.rsrq != null)
          InfoRow(label: 'RSRQ', value: '${tower.rsrq} dB'),
        if (tower.sinr != null)
          InfoRow(label: 'SINR', value: '${tower.sinr} dB'),
        if (tower.timingAdvance != null)
          InfoRow(label: 'Timing advance', value: '${tower.timingAdvance}'),
        if (tower.bsic != null)
          InfoRow(label: 'BSIC', value: '${tower.bsic}'),
      ];
}
