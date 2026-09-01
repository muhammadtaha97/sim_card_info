import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../services/analytics_service.dart';
import '../services/latency_service.dart';
import '../utils/localized_labels.dart';
import 'info_row.dart';

/// On-demand TCP connect latency to a few well-known endpoints. Runs only
/// when tapped — the app makes no network calls of its own otherwise.
class LatencyCard extends StatefulWidget {
  const LatencyCard({super.key, this.service});

  /// Injectable so widget tests don't open real sockets.
  final LatencyService? service;

  @override
  State<LatencyCard> createState() => _LatencyCardState();
}

class _LatencyCardState extends State<LatencyCard> {
  late final LatencyService _service = widget.service ?? LatencyService();
  List<LatencyResult>? _results;
  bool _running = false;

  Future<void> _run() async {
    AnalyticsService.logLatencyTest();
    setState(() => _running = true);
    final results = await _service.run();
    if (!mounted) return;
    setState(() {
      _results = results;
      _running = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final results = _results;
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 8, 4),
              child: Row(
                children: [
                  Icon(Icons.network_ping, size: 18, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    l10n.sectionLatency,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const Spacer(),
                  if (_running)
                    const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  else
                    TextButton.icon(
                      onPressed: _run,
                      icon: const Icon(Icons.play_arrow, size: 18),
                      label:
                          Text(results == null ? l10n.runTest : l10n.runAgain),
                    ),
                ],
              ),
            ),
            if (results == null && !_running)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  l10n.latencyExplainer,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ),
            if (results != null)
              for (final result in results)
                InfoRow(
                  label: result.host,
                  value: result.milliseconds == null
                      ? l10n.unreachable
                      : '${result.milliseconds} ms (${localizedLatencyQuality(l10n, result.milliseconds!)})',
                  copyable: false,
                ),
          ],
        ),
      ),
    );
  }
}
