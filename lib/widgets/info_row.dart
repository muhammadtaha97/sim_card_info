import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/generated/app_localizations.dart';

/// One labelled value row; a tap copies the value.
///
/// Copying is the whole reason a SIM info app is opened — an IMSI prefix, a
/// number, a DNS server all end up pasted somewhere — so every row copies
/// rather than a dedicated icon on a chosen few. The row, not a
/// SelectableText, owns the tap: a SelectableText inside an InkWell swallows
/// the tap and the copy never fires (a bug already shipped once in a sibling).
class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.copyable = true,
  });

  final String label;
  final String value;
  final IconData? icon;
  final bool copyable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: copyable
          ? () {
              Clipboard.setData(ClipboardData(text: value));
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context).copied(label)),
                    duration: const Duration(seconds: 2),
                  ),
                );
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
            ],
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
