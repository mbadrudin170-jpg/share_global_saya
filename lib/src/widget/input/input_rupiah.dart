// path: lib/shared/widget/input/input_rupiah.dart

import 'package:core_shared/src/widget/input/rupiah_input_formatter.dart';
import 'package:flutter/material.dart';

class InputRupiah extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool wajib;
  final IconData? prefixIcon;
  final TextInputAction textInputAction;
  final bool enabled;
  final bool readOnly;
  final AutovalidateMode autovalidateMode;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final VoidCallback? onClear; // BARU: callback saat tombol clear ditekan
  final bool showClearButton; // BARU: kontrol apakah tampilkan tombol clear
  final String? Function(String?)? validator;
  final String? hintText;

  static final RupiahInputFormatter _formatter = RupiahInputFormatter();

  static double parseRupiah(String formatted) {
    try {
      // Bersihkan semua karakter kecuali digit dan koma
      final clean = formatted.replaceAll(RegExp(r'[^\d,]'), '');
      if (clean.isEmpty) {
        return 0.0;
      }
      // Ganti koma (pemisah desimal Indonesia) dengan titik
      final withDotDecimal = clean.replaceAll(',', '.');
      return double.tryParse(withDotDecimal) ?? 0.0;
    } catch (_) {
      return 0.0;
    }
  }

  double get numericValue => parseRupiah(controller.text);

  static double parse(String formatted) => parseRupiah(formatted);

  const InputRupiah({
    super.key,
    required this.controller,
    this.label = 'Jumlah',
    this.wajib = true,
    this.prefixIcon,
    this.textInputAction = TextInputAction.next,
    this.enabled = true,
    this.readOnly = false,
    this.autovalidateMode = AutovalidateMode.onUserInteractionIfError,
    this.focusNode,
    this.nextFocusNode,
    this.onSubmitted,
    this.onChanged,
    this.onClear, // BARU
    this.showClearButton =
        false, // BARU, default false agar tidak breaking change
    this.validator,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      autovalidateMode: autovalidateMode,
      textInputAction: textInputAction,
      enabled: enabled,
      readOnly: readOnly,
      focusNode: focusNode,
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      onFieldSubmitted: (v) {
        if (onSubmitted != null) {
          onSubmitted!(v);
        }
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
      inputFormatters: [_formatter],
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        // BARU: Tambahkan suffixIcon untuk tombol clear
        suffixIcon: showClearButton && controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  if (onClear != null) {
                    onClear!();
                  }
                },
              )
            : null,
        hintText: hintText,
      ),
      validator: (value) {
        // Validasi internal
        if (wajib && (value == null || value.trim().isEmpty)) {
          return '$label wajib diisi';
        }
        if (value != null && value.isNotEmpty) {
          final unformatted = parseRupiah(value);
          if (unformatted.isNaN) {
            return 'Input harus berupa angka yang valid';
          }
        }
        // Validasi eksternal
        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
    );
  }
}
