import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../models/sim_card.dart';
import '../utils/countries.dart';
import '../utils/localized_labels.dart';
import '../widgets/info_row.dart';
import '../widgets/section_card.dart';
import '../widgets/sim_card_visual.dart';

/// The SIM Cards tab: one hero card + detail sections per subscription.
class SimsTab extends StatelessWidget {
  const SimsTab({super.key, required this.sims});

  final List<SimCard> sims;

  @override
  Widget build(BuildContext context) {
    if (sims.isEmpty) {
      // Scrollable even when empty, so pull-to-refresh keeps working in the
      // exact state where the user most wants it.
      return LayoutBuilder(
        builder: (context, constraints) => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: const _EmptySims(),
            ),
          ],
        ),
      );
    }
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        for (var i = 0; i < sims.length; i++) ...[
          if (i > 0) const SizedBox(height: 24),
          SimCardVisual(sim: sims[i]),
          const SizedBox(height: 12),
          _SimDetails(sim: sims[i]),
        ],
      ],
    );
  }
}

class _SimDetails extends StatelessWidget {
  const _SimDetails({required this.sim});

  final SimCard sim;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final country = sim.countryIso;
    final embedded = sim.isEmbedded;
    return Column(
      children: [
        SectionCard(
          title: l10n.sectionSubscription,
          icon: Icons.sim_card_outlined,
          children: [
            if (sim.carrierName != null)
              InfoRow(label: l10n.labelCarrier, value: sim.carrierName!),
            if (sim.displayName != null && sim.displayName != sim.carrierName)
              InfoRow(label: l10n.labelLabel, value: sim.displayName!),
            if (sim.number != null)
              InfoRow(label: l10n.labelPhoneNumber, value: sim.number!),
            if (country != null)
              InfoRow(
                label: l10n.labelCountry,
                value:
                    '${countryFlag(country) ?? ''} ${countryName(country)} (${country.toUpperCase()})'
                        .trim(),
              ),
            if (sim.plmn != null)
              InfoRow(label: l10n.labelMccMnc, value: sim.plmn!),
            if (sim.carrierIdName != null)
              InfoRow(label: l10n.labelCarrierId, value: sim.carrierIdName!),
            if (sim.specificCarrierIdName != null &&
                sim.specificCarrierIdName != sim.carrierIdName)
              InfoRow(
                  label: l10n.labelSpecificCarrier,
                  value: sim.specificCarrierIdName!),
            InfoRow(
              label: l10n.labelSimState,
              value: localizedSimState(l10n, sim.simState),
            ),
            if (embedded != null)
              InfoRow(
                label: l10n.labelSimType,
                value: embedded ? l10n.esimEmbedded : l10n.physicalSim,
              ),
            InfoRow(
              label: l10n.labelSlot,
              value: l10n.slotN(sim.slotIndex + 1),
            ),
            if (sim.portIndex != null)
              InfoRow(label: l10n.labelPort, value: '${sim.portIndex}'),
            InfoRow(
                label: l10n.labelSubscriptionId,
                value: '${sim.subscriptionId}'),
            if (sim.isOpportunistic ?? false)
              InfoRow(label: l10n.labelOpportunistic, value: l10n.yes),
          ],
        ),
        const SizedBox(height: 12),
        SectionCard(
          title: l10n.sectionRoles,
          icon: Icons.star_outline,
          children: [
            InfoRow(
              label: l10n.labelMobileData,
              value: sim.isDefaultData ? l10n.defaultSim : l10n.notDefault,
              copyable: false,
            ),
            InfoRow(
              label: l10n.labelCalls,
              value: sim.isDefaultVoice ? l10n.defaultSim : l10n.notDefault,
              copyable: false,
            ),
            InfoRow(
              label: l10n.labelSms,
              value: sim.isDefaultSms ? l10n.defaultSim : l10n.notDefault,
              copyable: false,
            ),
          ],
        ),
      ],
    );
  }
}

class _EmptySims extends StatelessWidget {
  const _EmptySims();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sim_card_alert_outlined,
              size: 56,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noSimsTitle,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.noSimsBody,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
