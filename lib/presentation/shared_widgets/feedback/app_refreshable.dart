import 'package:flutter/material.dart';

/// Pull-to-refresh wrapper widget.
///
/// Usage:
/// ```dart
/// AppRefreshable(
///   onRefresh: () async => context.read<MyCubit>().refresh(),
///   child: ListView(...),
/// )
/// ```
class AppRefreshable extends StatelessWidget {
  const AppRefreshable({
    required this.onRefresh,
    required this.child,
    super.key,
    this.color,
    this.backgroundColor,
    this.displacement = 40.0,
    this.edgeOffset = 0.0,
    this.enabled = true,
  });

  /// Callback when user pulls to refresh.
  final Future<void> Function() onRefresh;

  /// Child widget (must be scrollable).
  final Widget child;

  /// Color of the refresh indicator.
  final Color? color;

  /// Background color of the refresh indicator.
  final Color? backgroundColor;

  /// Distance from the top before refresh triggers.
  final double displacement;

  /// Edge offset for the indicator.
  final double edgeOffset;

  /// Whether refresh is enabled.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? Theme.of(context).colorScheme.primary,
      backgroundColor: backgroundColor,
      displacement: displacement,
      edgeOffset: edgeOffset,
      child: child,
    );
  }
}

/// Empty state widget for lists.
///
/// Usage:
/// ```dart
/// if (items.isEmpty) {
///   return AppEmptyState(
///     icon: Icons.inbox_outlined,
///     title: 'No items yet',
///     message: 'Add your first item to get started',
///     action: ElevatedButton(
///       onPressed: () => _addItem(),
///       child: Text('Add Item'),
///     ),
///   );
/// }
/// ```
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    this.icon,
    this.iconWidget,
    this.title,
    this.message,
    this.action,
  });

  /// Icon to display.
  final IconData? icon;

  /// Custom icon widget (overrides [icon]).
  final Widget? iconWidget;

  /// Title text.
  final String? title;

  /// Message text.
  final String? message;

  /// Action button.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget ??
                (icon != null
                    ? Icon(icon, size: 64, color: theme.colorScheme.outline)
                    : const SizedBox.shrink()),
            if (title != null) ...[
              const SizedBox(height: 16),
              Text(
                title!,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[const SizedBox(height: 24), action!],
          ],
        ),
      ),
    );
  }
}

/// Loading overlay widget.
///
/// Usage:
/// ```dart
/// Stack(
///   children: [
///     MainContent(),
///     if (isLoading) AppLoadingOverlay(),
///   ],
/// )
/// ```
class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({
    super.key,
    this.message,
    this.backgroundColor,
    this.opacity = 0.7,
  });

  /// Optional loading message.
  final String? message;

  /// Background color.
  final Color? backgroundColor;

  /// Background opacity.
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor =
        backgroundColor ??
        (theme.brightness == Brightness.light ? Colors.white : Colors.black);

    return Container(
      color: bgColor.withValues(alpha: opacity),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(message!, style: theme.textTheme.bodyMedium),
            ],
          ],
        ),
      ),
    );
  }
}
