import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Button type variants
enum AppButtonType { filled, outlined, text, tonal }

/// Button size variants
enum AppButtonSize { small, medium, large }

/// A dynamic, reusable button component with configurable type, size, and icon.
class AppButton extends StatelessWidget {

  const AppButton({
    required this.text,
    this.onPressed,
    this.type = AppButtonType.filled,
    this.size = AppButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.backgroundColor,
    this.foregroundColor,
    this.semanticLabel,
    super.key,
  });
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isLoading;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: semanticLabel ?? text,
      child: SizedBox(
        width: isFullWidth ? double.infinity : null,
        height: _height,
        child: _buildButton(context, colorScheme),
      ),
    );
  }

  double get _height {
    switch (size) {
      case AppButtonSize.small:
        return 36.h;
      case AppButtonSize.medium:
        return 48.h;
      case AppButtonSize.large:
        return 56.h;
    }
  }

  double get _fontSize {
    switch (size) {
      case AppButtonSize.small:
        return 12.sp;
      case AppButtonSize.medium:
        return 14.sp;
      case AppButtonSize.large:
        return 16.sp;
    }
  }

  double get _iconSize {
    switch (size) {
      case AppButtonSize.small:
        return 16.w;
      case AppButtonSize.medium:
        return 20.w;
      case AppButtonSize.large:
        return 24.w;
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case AppButtonSize.small:
        return EdgeInsets.symmetric(horizontal: 12.w);
      case AppButtonSize.medium:
        return EdgeInsets.symmetric(horizontal: 16.w);
      case AppButtonSize.large:
        return EdgeInsets.symmetric(horizontal: 24.w);
    }
  }

  Widget _buildButton(BuildContext context, ColorScheme colorScheme) {
    final child = _buildChild(colorScheme);

    switch (type) {
      case AppButtonType.filled:
        return FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            padding: _padding,
            textStyle: TextStyle(fontSize: _fontSize),
          ),
          child: child,
        );

      case AppButtonType.outlined:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: foregroundColor ?? colorScheme.primary,
            padding: _padding,
            textStyle: TextStyle(fontSize: _fontSize),
          ),
          child: child,
        );

      case AppButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor ?? colorScheme.primary,
            padding: _padding,
            textStyle: TextStyle(fontSize: _fontSize),
          ),
          child: child,
        );

      case AppButtonType.tonal:
        return FilledButton.tonal(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            padding: _padding,
            textStyle: TextStyle(fontSize: _fontSize),
          ),
          child: child,
        );
    }
  }

  Widget _buildChild(ColorScheme colorScheme) {
    if (isLoading) {
      return SizedBox(
        width: _iconSize,
        height: _iconSize,
        child: CircularProgressIndicator.adaptive(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            type == AppButtonType.filled
                ? colorScheme.onPrimary
                : colorScheme.primary,
          ),
        ),
      );
    }

    final hasLeading = leadingIcon != null;
    final hasTrailing = trailingIcon != null;

    if (!hasLeading && !hasTrailing) {
      return Text(text);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasLeading) ...[
          Icon(leadingIcon, size: _iconSize),
          SizedBox(width: 8.w),
        ],
        Text(text),
        if (hasTrailing) ...[
          SizedBox(width: 8.w),
          Icon(trailingIcon, size: _iconSize),
        ],
      ],
    );
  }
}
