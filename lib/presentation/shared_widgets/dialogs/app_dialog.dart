import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/core/theme/app_spacing.dart';
import 'package:flutter_mvvm_boilerplate/presentation/shared_widgets/buttons/app_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// Dialog type variants
enum AppDialogType { alert, confirm, custom }

/// A dynamic dialog component with configurable type and actions.
class AppDialog extends StatelessWidget {

  const AppDialog({
    this.title,
    this.message,
    this.content,
    this.type = AppDialogType.alert,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.isDismissible = true,
    this.icon,
    this.iconColor,
    super.key,
  });
  final String? title;
  final String? message;
  final Widget? content;
  final AppDialogType type;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isDismissible;
  final IconData? icon;
  final Color? iconColor;

  /// Shows an alert dialog with single action
  static Future<void> showAlert(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = 'OK',
    IconData? icon,
    Color? iconColor,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => AppDialog(
        title: title,
        message: message,
        confirmText: buttonText,
        icon: icon,
        iconColor: iconColor,
        onConfirm: () => Navigator.of(context).pop(),
      ),
    );
  }

  /// Shows a confirm dialog with two actions
  static Future<bool?> showConfirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    IconData? icon,
    Color? iconColor,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AppDialog(
        type: AppDialogType.confirm,
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        icon: icon,
        iconColor: iconColor,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    );
  }

  /// Shows a custom dialog with custom content
  static Future<T?> showCustom<T>(
    BuildContext context, {
    required Widget content, String? title,
    bool isDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissible,
      builder: (_) => AppDialog(
        type: AppDialogType.custom,
        title: title,
        content: content,
        isDismissible: isDismissible,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      contentPadding: EdgeInsets.all(AppSpacing.lg),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 48.w,
              color: iconColor ?? colorScheme.primary,
              semanticLabel: title,
            ),
            Gap(AppSpacing.md),
          ],
          if (title != null) ...[
            Text(
              title!,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(AppSpacing.sm),
          ],
          if (message != null)
            Text(
              message!,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          if (content != null) content!,
          if (type != AppDialogType.custom) ...[
            Gap(AppSpacing.lg),
            _buildActions(context),
          ],
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    if (type == AppDialogType.alert) {
      return AppButton(
        text: confirmText ?? 'OK',
        onPressed: onConfirm,
        isFullWidth: true,
        semanticLabel: confirmText ?? 'Dismiss dialog',
      );
    }

    return Row(
      children: [
        Expanded(
          child: AppButton(
            text: cancelText ?? 'Cancel',
            type: AppButtonType.outlined,
            onPressed: onCancel,
            semanticLabel: cancelText ?? 'Cancel action',
          ),
        ),
        Gap(AppSpacing.sm),
        Expanded(
          child: AppButton(
            text: confirmText ?? 'Confirm',
            onPressed: onConfirm,
            semanticLabel: confirmText ?? 'Confirm action',
          ),
        ),
      ],
    );
  }
}
