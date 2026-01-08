import 'package:flutter/material.dart';

import 'package:flutter_mvvm_boilerplate/core/theme/app_spacing.dart';

/// Card type variants
enum AppCardType { elevated, filled, outlined }

/// A dynamic, reusable card component with configurable type and interaction.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.type = AppCardType.elevated,
    this.onTap,
    this.onLongPress,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.elevation,
    this.showChevron = false,
    this.semanticLabel,
    super.key,
  });
  final Widget child;
  final AppCardType type;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? elevation;
  final bool showChevron;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveRadius = borderRadius ?? AppRadius.md;

    Widget cardContent = Padding(
      padding: padding ?? EdgeInsets.all(AppSpacing.md),
      child: showChevron
          ? Row(
              children: [
                Expanded(child: child),
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant,
                  semanticLabel: 'Navigate forward',
                ),
              ],
            )
          : child,
    );

    if (onTap != null || onLongPress != null) {
      cardContent = Semantics(
        button: true,
        label: semanticLabel,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(effectiveRadius),
          child: cardContent,
        ),
      );
    }

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: _buildCard(context, colorScheme, effectiveRadius, cardContent),
    );
  }

  Widget _buildCard(
    BuildContext context,
    ColorScheme colorScheme,
    double radius,
    Widget content,
  ) {
    switch (type) {
      case AppCardType.elevated:
        return Card(
          elevation: elevation ?? 2,
          color: backgroundColor ?? colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          clipBehavior: Clip.antiAlias,
          child: content,
        );

      case AppCardType.filled:
        return Card(
          elevation: 0,
          color: backgroundColor ?? colorScheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          clipBehavior: Clip.antiAlias,
          child: content,
        );

      case AppCardType.outlined:
        return Card(
          elevation: 0,
          color: backgroundColor ?? colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: borderColor ?? colorScheme.outlineVariant),
          ),
          clipBehavior: Clip.antiAlias,
          child: content,
        );
    }
  }
}
