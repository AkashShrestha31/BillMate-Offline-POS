import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/localization_extension.dart';
import 'package:hotel/src/core/helpers/error_message_helper.dart';

/// Full-tab error state used by main shell tabs and similar screens.
class TabErrorView extends StatelessWidget {
  const TabErrorView({
    super.key,
    required this.title,
    required this.message,
    this.onRetry,
    this.icon,
    this.isNoInternet = false,
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;
  final IconData? icon;
  final bool isNoInternet;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = isNoInternet ? Colors.orange : Colors.red;
    final displayMessage = ErrorMessageHelper.format(message);

    return ColoredBox(
      color: const Color(0xFFF4F5F7),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: accent.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon ??
                      (isNoInternet
                          ? Icons.wifi_off_rounded
                          : Icons.error_outline_rounded),
                  size: 48,
                  color: accent.shade400,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                displayMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: Text(context.l10n.tryAgain),
                  style: FilledButton.styleFrom(
                    backgroundColor: scheme.primary,
                    foregroundColor: scheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
