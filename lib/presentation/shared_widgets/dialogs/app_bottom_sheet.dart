import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/core/theme/app_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Bottom sheet height variants
enum AppBottomSheetHeight { auto, half, full }

/// A dynamic bottom sheet component with configurable height and header.
class AppBottomSheet extends StatelessWidget {

  const AppBottomSheet({
    required this.child,
    this.title,
    this.height = AppBottomSheetHeight.auto,
    this.showDragHandle = true,
    this.showCloseButton = false,
    this.onClose,
    this.padding,
    super.key,
  });
  final Widget child;
  final String? title;
  final AppBottomSheetHeight height;
  final bool showDragHandle;
  final bool showCloseButton;
  final VoidCallback? onClose;
  final EdgeInsets? padding;

  /// Shows a bottom sheet with the given content
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    AppBottomSheetHeight height = AppBottomSheetHeight.auto,
    bool showDragHandle = true,
    bool showCloseButton = false,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (_) => AppBottomSheet(
        title: title,
        height: height,
        showDragHandle: showDragHandle,
        showCloseButton: showCloseButton,
        onClose: () => Navigator.of(context).pop(),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      container: true,
      label: title ?? 'Bottom sheet',
      child: Container(
        constraints: BoxConstraints(maxHeight: _maxHeight(context)),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.lg),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            if (showDragHandle)
              Semantics(
                label: 'Drag to dismiss',
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 12.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),

            // Header
            if (title != null || showCloseButton)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    if (title != null)
                      Expanded(
                        child: Text(title!, style: textTheme.titleLarge),
                      ),
                    if (showCloseButton)
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          semanticLabel: 'Close bottom sheet',
                        ),
                        onPressed: onClose ?? () => Navigator.of(context).pop(),
                      ),
                  ],
                ),
              ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: padding ?? EdgeInsets.all(AppSpacing.lg),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _maxHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    switch (height) {
      case AppBottomSheetHeight.auto:
        return screenHeight * 0.9;
      case AppBottomSheetHeight.half:
        return screenHeight * 0.5;
      case AppBottomSheetHeight.full:
        return screenHeight * 0.95;
    }
  }
}
