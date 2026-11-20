// path: lib/src/widget/empty_state_view.dart
import 'package:material_ui/material_ui.dart';

class EmptyStateView extends StatelessWidget {
  final IconData ikon;
  final String judul;
  final String deskripsi;
  final String? ctaLabel;
  final VoidCallback? onCta;

  const EmptyStateView({
    super.key,
    required this.ikon,
    required this.judul,
    required this.deskripsi,
    this.ctaLabel,
    this.onCta,
  }) : assert((ctaLabel == null) == (onCta == null),
            'ctaLabel dan onCta harus diisi berpasangan atau keduanya null');

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Icon(ikon, size: 64, color: colorScheme.onSurfaceVariant),
              Text(judul, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              Text(deskripsi, style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
              if (ctaLabel != null && onCta != null)
                OutlinedButton(
                  onPressed: onCta,
                  child: Text(ctaLabel!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}