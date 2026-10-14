//lib/shared/widget/input/input_autocomplete.dart

import 'package:flutter/material.dart';

/// Widget reusable generic untuk Autocomplete input
class InputAutocomplete<T extends Object> extends StatefulWidget {
  final List<T> options;
  final String Function(T) displayString;
  final void Function(T) onSelected;
  final void Function(String)? onChanged;
  final VoidCallback? onClear;
  final Widget Function(BuildContext, T)? itemBuilder;
  final String? label;
  final String? hintText;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final String? initialValue;

  const InputAutocomplete({
    super.key,
    required this.options,
    required this.displayString,
    required this.onSelected,
    this.onChanged,
    this.onClear,
    this.itemBuilder,
    this.label,
    this.hintText,
    this.validator,
    this.prefixIcon,
    this.initialValue,
  });

  @override
  State<InputAutocomplete<T>> createState() => _InputAutocompleteState<T>();
}

class _InputAutocompleteState<T extends Object>
    extends State<InputAutocomplete<T>> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant InputAutocomplete<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _controller.text = widget.initialValue ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Autocomplete<T>(
          displayStringForOption: widget.displayString,
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable.empty();
            }
            final query = textEditingValue.text.toLowerCase();
            return widget.options.where((option) {
              final text = widget.displayString(option).toLowerCase();
              var queryIndex = 0;
              var textIndex = 0;
              while (queryIndex < query.length && textIndex < text.length) {
                if (query[queryIndex] == text[textIndex]) {
                  queryIndex++;
                }
                textIndex++;
              }
              return queryIndex == query.length;
            });
          },
          onSelected: (selection) {
            _controller.text = widget.displayString(selection);
            widget.onSelected(selection);
            FocusScope.of(context).unfocus();
          },
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            // Sinkronisasi controller internal dengan controller Autocomplete
            if (_controller.text != controller.text) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                controller.text = _controller.text;
              });
            }

            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              onFieldSubmitted: (value) => onFieldSubmitted(),
              decoration: InputDecoration(
                labelText: widget.label,
                hintText: widget.hintText,
                border: const OutlineInputBorder(),
                prefixIcon: widget.prefixIcon != null
                    ? Icon(widget.prefixIcon)
                    : null,
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controller.clear();
                          _controller.clear();
                          if (widget.onClear != null) {
                            widget.onClear!();
                          }
                          setState(() {});
                        },
                      )
                    : null,
              ),
              validator: widget.validator,
              onChanged: (value) {
                _controller.text = value;
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
                setState(() {});
              },
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                child: SizedBox(
                  width: constraints.biggest.width,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options.elementAt(index);

                        if (widget.itemBuilder != null) {
                          return InkWell(
                            onTap: () => onSelected(option),
                            child: widget.itemBuilder!(context, option),
                          );
                        }

                        return ListTile(
                          title: Text(widget.displayString(option)),
                          onTap: () => onSelected(option),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
