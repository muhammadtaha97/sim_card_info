import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';

/// Friendly explainer shown in place of SIM/network content until the phone
/// permission is granted.
///
/// Two shapes: while the system dialog can still appear, the button requests;
/// after a permanent denial (no rationale, still missing) the dialog will
/// never show again, so the button opens the app's settings screen instead —
/// a request button that silently does nothing is the worst outcome.
class PermissionGate extends StatelessWidget {
  const PermissionGate({
    super.key,
    required this.permanentlyDenied,
    required this.onRequest,
    required this.onOpenSettings,
  });

  final bool permanentlyDenied;
  final VoidCallback onRequest;
  final VoidCallback onOpenSettings;

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
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.sim_card_outlined,
                size: 48,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.gateTitle,
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              l10n.gateBody,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),
            FilledButton.icon(
              onPressed: permanentlyDenied ? onOpenSettings : onRequest,
              icon: Icon(
                permanentlyDenied ? Icons.settings_outlined : Icons.lock_open,
              ),
              label: Text(
                permanentlyDenied ? l10n.openAppSettings : l10n.grantPermission,
              ),
            ),
            if (permanentlyDenied) ...[
              const SizedBox(height: 10),
              Text(
                l10n.gatePermanent,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
