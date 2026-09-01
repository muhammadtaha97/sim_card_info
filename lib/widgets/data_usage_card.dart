import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../models/data_usage.dart';
import '../utils/labels.dart';
import 'info_row.dart';
import 'section_card.dart';

/// Data usage totals, gated behind Android's Usage Access special grant —
/// a settings-screen toggle, not a dialog, so the button jumps straight to
/// that screen and the section fills in when the user comes back.
class DataUsageCard extends StatelessWidget {
  const DataUsageCard({
    super.key,
    required this.usage,
    required this.onGrant,
  });

  final DataUsage usage;
  final VoidCallback onGrant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    if (!usage.granted) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.data_usage, size: 18, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    l10n.sectionDataUsage,
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
                l10n.dataUsageExplainer,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
              FilledButton.tonalIcon(
                onPressed: onGrant,
                icon: const Icon(Icons.data_usage),
                label: Text(l10n.grantUsageAccess),
              ),
            ],
          ),
        ),
      );
    }

    String bytes(int? value) =>
        value == null ? l10n.unavailable : formatBytes(value);

    return SectionCard(
      title: l10n.sectionDataUsage,
      icon: Icons.data_usage,
      children: [
        InfoRow(
          label: l10n.mobileToday,
          value: bytes(usage.mobileToday),
          copyable: false,
        ),
        InfoRow(
          label: l10n.mobileMonth,
          value: bytes(usage.mobileMonth),
          copyable: false,
        ),
        InfoRow(
          label: l10n.wifiToday,
          value: bytes(usage.wifiToday),
          copyable: false,
        ),
        InfoRow(
          label: l10n.wifiMonth,
          value: bytes(usage.wifiMonth),
          copyable: false,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: Text(
            l10n.usageDisclaimer,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
