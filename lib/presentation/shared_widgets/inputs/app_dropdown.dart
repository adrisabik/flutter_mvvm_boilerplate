import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Dropdown size variants
enum AppDropdownSize { small, medium, large }

/// A dynamic dropdown component with configurable size and styling.
class AppDropdown<T> extends StatelessWidget {

  const AppDropdown({
    required this.items,
    required this.itemLabel,
    this.value,
    this.label,
    this.hint,
    this.helperText,
    this.validator,
    this.onChanged,
    this.size = AppDropdownSize.medium,
    this.enabled = true,
    this.prefixIcon,
    this.semanticLabel,
    super.key,
  });
  final T? value;
  final List<T> items;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final String Function(T) itemLabel;
  final AppDropdownSize size;
  final bool enabled;
  final IconData? prefixIcon;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? label ?? 'Dropdown selector',
      child: DropdownButtonFormField<T>(
        initialValue: value,
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(itemLabel(item), style: TextStyle(fontSize: _fontSize)),
          );
        }).toList(),
        onChanged: enabled ? onChanged : null,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          helperText: helperText,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon)
              : null,
          contentPadding: _contentPadding,
          isDense: size == AppDropdownSize.small,
        ),
        style: TextStyle(fontSize: _fontSize),
        isExpanded: true,
      ),
    );
  }

  double get _fontSize {
    switch (size) {
      case AppDropdownSize.small:
        return 12.sp;
      case AppDropdownSize.medium:
        return 14.sp;
      case AppDropdownSize.large:
        return 16.sp;
    }
  }

  EdgeInsets get _contentPadding {
    switch (size) {
      case AppDropdownSize.small:
        return EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h);
      case AppDropdownSize.medium:
        return EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h);
      case AppDropdownSize.large:
        return EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h);
    }
  }
}
