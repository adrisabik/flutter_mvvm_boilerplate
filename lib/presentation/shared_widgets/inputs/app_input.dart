import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Input type variants
enum AppInputType { text, email, password, phone, number, multiline, search }

/// Input size variants
enum AppInputSize { small, medium, large }

/// A dynamic, reusable text input component with configurable type, size, and validation.
class AppInput extends StatefulWidget {

  const AppInput({
    this.label,
    this.hint,
    this.helperText,
    this.type = AppInputType.text,
    this.size = AppInputSize.medium,
    this.controller,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLength,
    this.maxLines,
    this.textInputAction,
    this.focusNode,
    this.inputFormatters,
    this.semanticLabel,
    super.key,
  });
  final String? label;
  final String? hint;
  final String? helperText;
  final AppInputType type;
  final AppInputSize size;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int? maxLength;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final String? semanticLabel;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.type == AppInputType.password;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      label: widget.semanticLabel ?? widget.label,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        obscureText: _obscureText,
        keyboardType: _keyboardType,
        textInputAction: widget.textInputAction ?? _defaultTextInputAction,
        maxLength: widget.maxLength,
        maxLines: _maxLines,
        inputFormatters: widget.inputFormatters ?? _defaultFormatters,
        style: TextStyle(fontSize: _fontSize),
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          helperText: widget.helperText,
          prefixIcon: _buildPrefixIcon(),
          suffixIcon: _buildSuffixIcon(),
          contentPadding: _contentPadding,
          isDense: widget.size == AppInputSize.small,
        ),
      ),
    );
  }

  double get _fontSize {
    switch (widget.size) {
      case AppInputSize.small:
        return 12.sp;
      case AppInputSize.medium:
        return 14.sp;
      case AppInputSize.large:
        return 16.sp;
    }
  }

  EdgeInsets get _contentPadding {
    switch (widget.size) {
      case AppInputSize.small:
        return EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h);
      case AppInputSize.medium:
        return EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h);
      case AppInputSize.large:
        return EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h);
    }
  }

  int get _maxLines {
    if (widget.type == AppInputType.multiline) {
      return widget.maxLines ?? 4;
    }
    return 1;
  }

  TextInputType get _keyboardType {
    switch (widget.type) {
      case AppInputType.email:
        return TextInputType.emailAddress;
      case AppInputType.phone:
        return TextInputType.phone;
      case AppInputType.number:
        return TextInputType.number;
      case AppInputType.multiline:
        return TextInputType.multiline;
      case AppInputType.search:
      case AppInputType.text:
      case AppInputType.password:
        return TextInputType.text;
    }
  }

  TextInputAction get _defaultTextInputAction {
    if (widget.type == AppInputType.multiline) {
      return TextInputAction.newline;
    }
    if (widget.type == AppInputType.search) {
      return TextInputAction.search;
    }
    return TextInputAction.next;
  }

  List<TextInputFormatter>? get _defaultFormatters {
    switch (widget.type) {
      case AppInputType.phone:
        return [FilteringTextInputFormatter.digitsOnly];
      case AppInputType.number:
        return [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))];
      case AppInputType.text:
      case AppInputType.email:
      case AppInputType.password:
      case AppInputType.multiline:
      case AppInputType.search:
        return null;
    }
  }

  Widget? _buildPrefixIcon() {
    final icon = widget.prefixIcon ?? _defaultPrefixIcon;
    if (icon == null) return null;
    return Icon(icon);
  }

  IconData? get _defaultPrefixIcon {
    switch (widget.type) {
      case AppInputType.email:
        return Icons.email_outlined;
      case AppInputType.password:
        return Icons.lock_outlined;
      case AppInputType.phone:
        return Icons.phone_outlined;
      case AppInputType.search:
        return Icons.search;
      case AppInputType.text:
      case AppInputType.number:
      case AppInputType.multiline:
        return null;
    }
  }

  Widget? _buildSuffixIcon() {
    // Password toggle
    if (widget.type == AppInputType.password) {
      return IconButton(
        icon: Icon(
          _obscureText
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          semanticLabel: _obscureText ? 'Show password' : 'Hide password',
        ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      );
    }

    // Clear button for search
    if (widget.type == AppInputType.search && widget.controller != null) {
      return IconButton(
        icon: const Icon(Icons.clear, semanticLabel: 'Clear search'),
        onPressed: () {
          widget.controller!.clear();
          widget.onChanged?.call('');
        },
      );
    }

    // Custom suffix icon
    if (widget.suffixIcon != null) {
      return IconButton(
        icon: Icon(widget.suffixIcon),
        onPressed: widget.onSuffixTap,
      );
    }

    return null;
  }
}
