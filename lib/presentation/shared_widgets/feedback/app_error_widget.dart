import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/core/theme/app_spacing.dart';
import 'package:flutter_mvvm_boilerplate/presentation/shared_widgets/buttons/app_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// A widget to display when an error occurs.
class AppErrorWidget extends StatelessWidget {

  const AppErrorWidget({
    required this.message,
    this.onRetry,
    this.retryText = 'Try Again',
    super.key,
  });
  final String message;
  final VoidCallback? onRetry;
  final String retryText;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: 'Error: $message',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 64.w,
                color: colorScheme.error,
                semanticLabel: 'Error icon',
              ),
              Gap(AppSpacing.md),
              Text(
                message,
                style: textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                Gap(AppSpacing.lg),
                AppButton(
                  text: retryText,
                  type: AppButtonType.outlined,
                  onPressed: onRetry,
                  semanticLabel: 'Retry: $retryText',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
