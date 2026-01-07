import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/core/theme/app_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// Toast type variants
enum AppToastType { info, success, warning, error }

/// Toast position variants
enum AppToastPosition { top, bottom }

/// A toast notification component.
class AppToast {
  AppToast._();

  static OverlayEntry? _currentToast;

  /// Shows a toast message
  static void show(
    BuildContext context, {
    required String message,
    AppToastType type = AppToastType.info,
    AppToastPosition position = AppToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
    VoidCallback? onTap,
  }) {
    _dismiss();

    final overlay = Overlay.of(context);

    _currentToast = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        type: type,
        position: position,
        icon: icon,
        onTap: onTap,
        onDismiss: _dismiss,
      ),
    );

    overlay.insert(_currentToast!);

    Future.delayed(duration, _dismiss);
  }

  /// Shows a success toast
  static void success(BuildContext context, String message) {
    show(
      context,
      message: message,
      type: AppToastType.success,
      icon: Icons.check_circle_outline,
    );
  }

  /// Shows an error toast
  static void error(BuildContext context, String message) {
    show(
      context,
      message: message,
      type: AppToastType.error,
      icon: Icons.error_outline,
    );
  }

  /// Shows a warning toast
  static void warning(BuildContext context, String message) {
    show(
      context,
      message: message,
      type: AppToastType.warning,
      icon: Icons.warning_amber_outlined,
    );
  }

  /// Shows an info toast
  static void info(BuildContext context, String message) {
    show(
      context,
      message: message,
      icon: Icons.info_outline,
    );
  }

  static void _dismiss() {
    _currentToast?.remove();
    _currentToast = null;
  }
}

class _ToastWidget extends StatefulWidget {

  const _ToastWidget({
    required this.message,
    required this.type,
    required this.position,
    required this.onDismiss,
    this.icon,
    this.onTap,
  });
  final String message;
  final AppToastType type;
  final AppToastPosition position;
  final IconData? icon;
  final VoidCallback? onTap;
  final VoidCallback onDismiss;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.position == AppToastPosition.top ? -1 : 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _backgroundColor {
    switch (widget.type) {
      case AppToastType.success:
        return Colors.green;
      case AppToastType.error:
        return Colors.red;
      case AppToastType.warning:
        return Colors.orange;
      case AppToastType.info:
        return Colors.blue;
    }
  }

  String get _typeLabel {
    switch (widget.type) {
      case AppToastType.success:
        return 'Success';
      case AppToastType.error:
        return 'Error';
      case AppToastType.warning:
        return 'Warning';
      case AppToastType.info:
        return 'Information';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.position == AppToastPosition.top ? 64.h : null,
      bottom: widget.position == AppToastPosition.bottom ? 64.h : null,
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Semantics(
            label: '$_typeLabel: ${widget.message}',
            liveRegion: true,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: widget.onTap,
                onHorizontalDragEnd: (_) => widget.onDismiss(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          color: Colors.white,
                          size: 20.w,
                          semanticLabel: _typeLabel,
                        ),
                        Gap(AppSpacing.sm),
                      ],
                      Expanded(
                        child: Text(
                          widget.message,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
