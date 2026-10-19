import 'package:flutter/material.dart';

class InputTeks extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final bool wajib;
  final int? maxLength;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final TextInputAction textInputAction;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool enabled;
  final void Function(String)? onSubmitted;

  // Tambahan
  final String? hintText;
  final String? helperText;
  final TextStyle? helperStyle;
  final TextStyle? hintStyle;
  final TextCapitalization textCapitalization;
  final TextStyle? style;

  // PARAMETER UNTUK KONTROL UKURAN
  final int? minLines;
  final int? maxLines;
  final double? maxHeight;
  final double? minHeight;
  final bool isDense;
  final bool expands;
  final EdgeInsetsGeometry? contentPadding;

  // PARAMETER UNTUK filled
  final bool filled;
  final Color? fillColor;

  // PARAMETER WARNA TAMBAHAN
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? iconColor;
  final Color? cursorColor;
  final Color? labelColor;

  // Parameter Suffix Baru
  final String? suffixText;
  final TextStyle? suffixStyle;
  final Color? suffixIconColor;
  final bool autofocus;

  const InputTeks({
    super.key,
    required this.controller,
    this.label,
    this.wajib = true,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteractionIfError,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.focusNode,
    this.nextFocusNode,
    this.enabled = true,
    this.onSubmitted,
    this.maxLength,
    this.hintText,
    this.hintStyle,
    this.helperText,
    this.helperStyle,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    // NILAI DEFAULT
    this.minLines = 1,
    this.maxLines = 1,
    this.maxHeight,
    this.minHeight,
    this.isDense = false,
    this.expands = false,
    this.contentPadding,
    // DEFAULT UNTUK filled
    this.filled = false,
    this.fillColor,
    // TAMBAHKAN PARAMETER WARNA DI KONSTRUKTOR
    this.borderColor,
    this.focusedBorderColor,
    this.iconColor,
    this.cursorColor,
    this.labelColor,
    // Parameter Suffix Baru
    this.suffixText,
    this.suffixStyle,
    this.suffixIconColor,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: borderColor ?? theme.colorScheme.outline),
    );

    final focusedBorder = defaultBorder.copyWith(
      borderSide: BorderSide(
        color: focusedBorderColor ?? theme.colorScheme.primary,
        width: 2,
      ),
    );

    final textField = TextFormField(
      controller: controller,
      style: style,
      autovalidateMode: autovalidateMode,
      textInputAction: textInputAction,
      enabled: enabled,
      focusNode: focusNode,
      cursorColor: cursorColor ?? theme.colorScheme.primary,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      expands: expands,
      textCapitalization: textCapitalization,
      autofocus: autofocus,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: labelColor),
        border: defaultBorder,
        enabledBorder: defaultBorder,
        focusedBorder: focusedBorder,
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: iconColor) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon, color: suffixIconColor ?? iconColor),
                onPressed: onSuffixIconPressed,
              )
            : null,
        suffixText: suffixText,
        suffixStyle: suffixStyle,
        hintStyle: hintStyle ??
            theme.textTheme.bodyLarge?.copyWith(color: theme.hintColor),
        isDense: isDense,
        contentPadding: contentPadding,
        filled: filled,
        fillColor: fillColor,
        hintText: hintText,
        helperText: helperText,
        helperStyle: helperStyle,
      ),
      onFieldSubmitted: (v) {
        if (onSubmitted != null) {
          onSubmitted!(v);
        }
        if (textInputAction == TextInputAction.next && nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        } else if (textInputAction == TextInputAction.done) {
          FocusScope.of(context).unfocus();
        }
      },
      validator: validator ??
          (value) {
            if (wajib && (value == null || value.trim().isEmpty)) {
              return '$label wajib diisi';
            }
            return null;
          },
    );

    if (maxHeight != null || minHeight != null) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: minHeight ?? (isDense ? 48.0 : 56.0),
          maxHeight: maxHeight ?? double.infinity,
        ),
        child: textField,
      );
    }

    return textField;
  }
}
