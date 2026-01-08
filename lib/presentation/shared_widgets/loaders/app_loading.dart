import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/core/theme/app_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// Loading overlay type variants
enum AppLoadingType { circular, linear, dots }

/// A dynamic loading overlay component.
class AppLoading extends StatelessWidget {
  const AppLoading({
    this.type = AppLoadingType.circular,
    this.message,
    this.color,
    this.size,
    super.key,
  });

  /// Creates a full-screen overlay loading widget
  const AppLoading.overlay({this.message, this.color, super.key})
    : type = AppLoadingType.circular,
      size = null;
  final AppLoadingType type;
  final String? message;
  final Color? color;
  final double? size;

  /// Shows a full-screen loading overlay
  static Future<T> showOverlay<T>(
    BuildContext context, {
    required Future<T> Function() future,
    String? message,
  }) async {
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => AppLoading.overlay(message: message),
      ),
    );

    try {
      final result = await future();
      if (context.mounted) Navigator.of(context).pop();
      return result;
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveColor = color ?? colorScheme.primary;

    // Full screen overlay
    if (message != null) {
      return PopScope(
        canPop: false,
        child: Semantics(
          label: message ?? 'Loading',
          child: Material(
            color: Colors.black54,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildIndicator(effectiveColor),
                    Gap(AppSpacing.md),
                    Text(
                      message!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Semantics(label: 'Loading', child: _buildIndicator(effectiveColor));
  }

  Widget _buildIndicator(Color indicatorColor) {
    switch (type) {
      case AppLoadingType.circular:
        return SizedBox(
          width: size ?? 32.w,
          height: size ?? 32.w,
          child: CircularProgressIndicator.adaptive(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
          ),
        );

      case AppLoadingType.linear:
        return SizedBox(
          width: size ?? 120.w,
          child: LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
          ),
        );

      case AppLoadingType.dots:
        return _DotsLoading(color: indicatorColor, size: size ?? 8.w);
    }
  }
}

// Helper to avoid lint warning
void unawaited(Future<void>? future) {}

/// Animated dots loading indicator
class _DotsLoading extends StatefulWidget {
  const _DotsLoading({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  State<_DotsLoading> createState() => _DotsLoadingState();
}

class _DotsLoadingState extends State<_DotsLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            final offset = index * 0.2;
            final value = (_controller.value + offset) % 1.0;
            final scale = 0.5 + (value < 0.5 ? value : 1.0 - value) * 0.5;

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              width: widget.size * scale,
              height: widget.size * scale,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
              ),
            );
          },
        );
      }),
    );
  }
}
