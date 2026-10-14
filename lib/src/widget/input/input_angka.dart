// path: lib/shared/widget/input/input_angka.dart

import 'package:core_shared/src/widget/input/thousands_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputAngka extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool wajib;
  final IconData? prefixIcon;
  final TextInputAction textInputAction;
  final bool enabled;
  final TextInputType keyboardType;
  final AutovalidateMode autovalidateMode;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool autofocus;

  const InputAngka({
    super.key,
    required this.controller,
    this.label = 'Jumlah',
    this.wajib = true,
    this.autofocus = false,
    this.prefixIcon,
    this.textInputAction = TextInputAction.next,
    this.enabled = true,
    this.keyboardType = TextInputType.number,
    this.autovalidateMode = AutovalidateMode.onUserInteractionIfError,
    this.focusNode,
    this.nextFocusNode,
    this.onSubmitted,
    this.onChanged,
    this.inputFormatters,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autovalidateMode: autovalidateMode,
      textInputAction: textInputAction,
      enabled: enabled,
      focusNode: focusNode,
      onChanged: onChanged,
      autofocus: autofocus,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      onFieldSubmitted: (v) {
        if (onSubmitted != null) {
          onSubmitted!(v);
        }
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
      inputFormatters:
          inputFormatters ?? [ThousandsAndNegativeInputFormatter()],
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
      validator: (value) {
        // Jalankan validasi default terlebih dahulu
        if (wajib && (value == null || value.trim().isEmpty)) {
          return '$label wajib diisi';
        }

        if (value != null && value.isNotEmpty) {
          final numericString = value.replaceAll(RegExp(r'[^0-9\-]'), '');
          if (numericString.isEmpty || numericString == '-') {
            return 'Masukkan angka yang valid';
          }

          if (double.tryParse(numericString) == null) {
            return 'Masukkan angka yang valid';
          }
        }

        // Jika validasi default lolos, jalankan validasi kustom jika ada
        if (validator != null) {
          return validator!(value);
        }

        // Jika semua validasi lolos
        return null;
      },
    );
  }
}
