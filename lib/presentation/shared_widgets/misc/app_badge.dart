import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Badge type variants
enum AppBadgeType { count, dot, label }

/// Badge position variants
enum AppBadgePosition { topRight, topLeft, bottomRight, bottomLeft }

/// A dynamic badge component for notification counts or status dots.
class AppBadge extends StatelessWidget {
  const AppBadge({
    required this.child,
    this.type = AppBadgeType.count,
    this.position = AppBadgePosition.topRight,
    this.count,
    this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.show = true,
    this.semanticLabel,
    super.key,
  });

  /// Creates a count badge
  const AppBadge.count({
    required this.child,
    required int this.count,
    this.position = AppBadgePosition.topRight,
    this.backgroundColor,
    this.foregroundColor,
    this.semanticLabel,
    super.key,
  }) : type = AppBadgeType.count,
       label = null,
       show = true;

  /// Creates a dot badge
  const AppBadge.dot({
    required this.child,
    this.position = AppBadgePosition.topRight,
    this.backgroundColor,
    this.show = true,
    this.semanticLabel,
    super.key,
  }) : type = AppBadgeType.dot,
       count = null,
       label = null,
       foregroundColor = null;

  /// Creates a label badge
  const AppBadge.label({
    required this.child,
    required String this.label,
    this.position = AppBadgePosition.topRight,
    this.backgroundColor,
    this.foregroundColor,
    this.semanticLabel,
    super.key,
  }) : type = AppBadgeType.label,
       count = null,
       show = true;
  final Widget child;
  final AppBadgeType type;
  final AppBadgePosition position;
  final int? count;
  final String? label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool show;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    if (!show ||
        (type == AppBadgeType.count && (count == null || count == 0))) {
      return child;
    }

    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = backgroundColor ?? colorScheme.error;
    final fgColor = foregroundColor ?? Colors.white;

    return Semantics(
      label: _getSemanticsLabel(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          child,
          Positioned(
            top: _isTop ? -4.h : null,
            bottom: !_isTop ? -4.h : null,
            right: _isRight ? -4.w : null,
            left: !_isRight ? -4.w : null,
            child: _buildBadge(bgColor, fgColor),
          ),
        ],
      ),
    );
  }

  String _getSemanticsLabel() {
    if (semanticLabel != null) return semanticLabel!;
    switch (type) {
      case AppBadgeType.count:
        return '$count notifications';
      case AppBadgeType.dot:
        return 'Has notification';
      case AppBadgeType.label:
        return label ?? '';
    }
  }

  bool get _isTop =>
      position == AppBadgePosition.topRight ||
      position == AppBadgePosition.topLeft;

  bool get _isRight =>
      position == AppBadgePosition.topRight ||
      position == AppBadgePosition.bottomRight;

  Widget _buildBadge(Color bgColor, Color fgColor) {
    switch (type) {
      case AppBadgeType.dot:
        return Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
        );

      case AppBadgeType.count:
        final displayCount = count! > 99 ? '99+' : count.toString();
        return Container(
          constraints: BoxConstraints(minWidth: 18.w),
          height: 18.h,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: Center(
            child: Text(
              displayCount,
              style: TextStyle(
                color: fgColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );

      case AppBadgeType.label:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            label!,
            style: TextStyle(
              color: fgColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
    }
  }
}
