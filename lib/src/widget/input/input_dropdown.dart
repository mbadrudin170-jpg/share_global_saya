// Path: lib/shared/widget/input/input_dropdown.dart

import 'package:flutter/material.dart';

/// Widget dropdown reusable berbasis Material 3 DropdownMenuFormField.
class InputDropdown<T> extends StatelessWidget {
  /// Nilai awal yang sedang dipilih (dipetakan ke initialSelection)
  final T? value;

  /// Label berupa String (akan dikonversi menjadi widget Text)
  final String label;

  /// Teks hint yang ditampilkan saat tidak ada nilai terpilih
  final String? hintText;

  /// Daftar item asli
  final List<T> items;

  /// Fungsi untuk mengonversi item T menjadi string label
  final String Function(T item) displayString;

  /// Fungsi yang dipanggil saat nilai berubah
  final ValueChanged<T?>? onChanged;

  /// Validator untuk form
  final String? Function(T?)? validator;

  /// Icon yang ditampilkan di sebelah kiri (leadingIcon)
  final IconData? prefixIcon;

  /// Apakah dropdown dinonaktifkan
  final bool enabled;

  /// Mode validasi otomatis
  final AutovalidateMode autovalidateMode;

  /// Apakah field wajib diisi (untuk validasi default)
  final bool wajib;

  /// Focus node untuk kontrol fokus
  final FocusNode? focusNode;

  /// Pesan error untuk validasi wajib
  final String? requiredErrorMessage;

  /// Fungsi untuk membangun item dropdown kustom
  final Widget Function(T item)? itemBuilder;

  /// Mengaktifkan fitur filter pencarian otomatis berdasarkan teks
  final bool enableFilter;

  /// Mengaktifkan pencarian teks
  final bool enableSearch;

  const InputDropdown({
    super.key,
    required this.value,
    required this.label,
    required this.items,
    required this.displayString,
    this.hintText,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.wajib = true,
    this.focusNode,
    this.requiredErrorMessage,
    this.itemBuilder,
    this.enableFilter = false, // Default bawaan Flutter source code
    this.enableSearch = true, // Default bawaan Flutter source code
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Memetakan list item T menjadi List<DropdownMenuEntry<T>>
    final entries = items.map((item) {
      final labelText = displayString(item);
      return DropdownMenuEntry<T>(
        value: item,
        label: labelText,
        enabled: enabled,
        labelWidget: itemBuilder != null ? itemBuilder!(item) : null,
      );
    }).toList();

    return DropdownMenuFormField<T>(
      // Menggunakan nama parameter yang tepat sesuai source code Flutter Anda:
      initialSelection: value,
      dropdownMenuEntries: entries,
      onSelected:
          onChanged, // FormField internal otomatis memanggil field.didChange
      focusNode: focusNode,
      autovalidateMode: autovalidateMode,
      enabled: enabled,
      enableFilter: enableFilter,
      enableSearch: enableSearch,
      menuHeight: 300,
      expandedInsets: EdgeInsets.zero, // Melebarkan dropdown agar full width
      // Menggunakan widget Text untuk parameter label sesuai tanda terima source code
      label: Text(label),
      hintText: hintText ?? 'Pilih $label...',
      leadingIcon: prefixIcon != null ? Icon(prefixIcon) : null,

      trailingIcon: Icon(
        Icons.arrow_drop_down,
        color: enabled
            ? colorScheme.primary
            : colorScheme.outline.withValues(alpha: 0.5),
      ),

      textStyle: theme.textTheme.bodyLarge?.copyWith(
        color: enabled
            ? colorScheme.onSurface
            : colorScheme.onSurface.withValues(alpha: 0.38),
      ),

      // Berdasarkan source code, inputDecorationTheme bertipe Object?
      // yang dioper langsung ke komponen TextField internal
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.outline, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        filled: true,
        fillColor: enabled
            ? colorScheme.surface
            : colorScheme.surface.withValues(alpha: 0.5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        errorStyle: theme.textTheme.bodySmall?.copyWith(
          color: colorScheme.error,
        ),
      ),

      // Validasi tetap ditangani FormField super class
      validator:
          validator ??
          (val) {
            if (wajib && val == null) {
              return requiredErrorMessage ?? '$label wajib dipilih';
            }
            return null;
          },
    );
  }
}
