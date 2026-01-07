import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/core/theme/app_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

/// A shimmer loading placeholder widget for skeleton loading states.
class AppShimmer extends StatelessWidget {

  const AppShimmer({this.width, this.height, this.borderRadius, super.key});

  /// Creates a rectangular shimmer
  const AppShimmer.rectangle({
    required double this.width,
    required double this.height,
    this.borderRadius,
    super.key,
  });

  /// Creates a circular shimmer (avatar placeholder)
  const AppShimmer.circular({required double size, super.key})
    : width = size,
      height = size,
      borderRadius = 999;
  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Semantics(
      label: 'Loading content',
      child: Shimmer.fromColors(
        baseColor: isDark
            ? colorScheme.surfaceContainerHighest
            : Colors.grey[300]!,
        highlightColor: isDark
            ? colorScheme.surfaceContainerHigh
            : Colors.grey[100]!,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.sm),
          ),
        ),
      ),
    );
  }
}

/// A list shimmer for loading states
class AppListShimmer extends StatelessWidget {

  const AppListShimmer({
    this.itemCount = 5,
    this.itemHeight = 80,
    this.spacing = 12,
    super.key,
  });
  final int itemCount;
  final double itemHeight;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Loading list',
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (_, __) => SizedBox(height: spacing.h),
        itemBuilder: (_, __) => AppShimmer.rectangle(
          width: double.infinity,
          height: itemHeight.h,
          borderRadius: AppRadius.md,
        ),
      ),
    );
  }
}
