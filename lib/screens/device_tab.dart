import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../models/telephony_overview.dart';
import '../utils/localized_labels.dart';
import '../widgets/info_row.dart';
import '../widgets/section_card.dart';

/// The Device tab: what the hardware itself supports, independent of which
/// SIMs happen to be inserted, plus shortcuts into the system screens the
/// user would otherwise dig for. Works fully without the phone permission.
class DeviceTab extends StatelessWidget {
  const DeviceTab({super.key, required this.device, this.onOpenSystemScreen});

  final DeviceSummary device;
  final ValueChanged<String>? onOpenSystemScreen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    String yesNo(bool? value) => localizedYesNo(l10n, value);
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        SectionCard(
          title: l10n.sectionDevice,
          icon: Icons.smartphone,
          children: [
            if (device.manufacturer != null || device.model != null)
              InfoRow(
                label: l10n.labelModel,
                value: [device.manufacturer, device.model]
                    .whereType<String>()
                    .join(' '),
              ),
            if (device.device != null)
              InfoRow(label: l10n.labelDeviceCodename, value: device.device!),
            if (device.androidVersion != null)
              InfoRow(
                label: l10n.labelAndroidVersion,
                value:
                    '${device.androidVersion}${device.sdkInt != null ? ' (API ${device.sdkInt})' : ''}',
              ),
            if (device.deviceSoftwareVersion != null)
              InfoRow(
                label: l10n.labelRadioVersion,
                value: device.deviceSoftwareVersion!,
              ),
          ],
        ),
        const SizedBox(height: 12),
        SectionCard(
          title: l10n.sectionSimCapabilities,
          icon: Icons.sim_card_outlined,
          children: [
            InfoRow(
              label: l10n.labelTelephonyHardware,
              value: yesNo(device.hasTelephony),
              copyable: false,
            ),
            InfoRow(
              label: l10n.labelSimCardPresent,
              value: yesNo(device.hasIccCard),
              copyable: false,
            ),
            InfoRow(
              label: l10n.labelEsimSupported,
              value: yesNo(device.esimSupported),
              copyable: false,
            ),
            if (device.activeModemCount != null)
              InfoRow(
                label: l10n.labelActiveModems,
                value: '${device.activeModemCount}',
                copyable: false,
              ),
            if (device.supportedModemCount != null)
              InfoRow(
                label: l10n.labelSupportedModems,
                value: '${device.supportedModemCount}',
                copyable: false,
              ),
            if (device.maxActiveSubscriptions != null)
              InfoRow(
                label: l10n.labelMaxActiveSims,
                value: '${device.maxActiveSubscriptions}',
                copyable: false,
              ),
            InfoRow(
              label: l10n.labelDualSim,
              value: switch (device.activeModemCount) {
                null => l10n.unavailable,
                > 1 => l10n.yes,
                _ => l10n.no,
              },
              copyable: false,
            ),
          ],
        ),
        const SizedBox(height: 12),
        SectionCard(
          title: l10n.sectionCalling,
          icon: Icons.call_outlined,
          children: [
            InfoRow(
              label: l10n.labelVoiceCapable,
              value: yesNo(device.isVoiceCapable),
              copyable: false,
            ),
            InfoRow(
              label: l10n.labelSmsCapable,
              value: yesNo(device.isSmsCapable),
              copyable: false,
            ),
            InfoRow(
              label: l10n.labelVoiceAndData,
              value: yesNo(device.isConcurrentVoiceAndData),
              copyable: false,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 2),
                child: Row(
                  children: [
                    Icon(Icons.open_in_new,
                        size: 18, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      l10n.sectionSystemSettings,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                          ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.sim_card_outlined),
                title: Text(l10n.shortcutMobile),
                onTap: () => onOpenSystemScreen?.call('mobile'),
              ),
              const Divider(indent: 16, endIndent: 16),
              ListTile(
                leading: const Icon(Icons.data_usage),
                title: Text(l10n.shortcutDataUsage),
                onTap: () => onOpenSystemScreen?.call('dataUsage'),
              ),
              const Divider(indent: 16, endIndent: 16),
              ListTile(
                leading: const Icon(Icons.wifi),
                title: Text(l10n.shortcutWifi),
                onTap: () => onOpenSystemScreen?.call('wifi'),
              ),
              const Divider(indent: 16, endIndent: 16),
              ListTile(
                leading: const Icon(Icons.airplanemode_active),
                title: Text(l10n.shortcutAirplane),
                onTap: () => onOpenSystemScreen?.call('airplane'),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ],
    );
  }
}
