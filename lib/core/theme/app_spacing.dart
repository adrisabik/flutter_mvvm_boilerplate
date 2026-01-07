import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Spacing design tokens following Material Design guidelines.
/// Use these instead of magic numbers for consistent spacing.
abstract class AppSpacing {
  /// 2px - Micro spacing, divider margins
  static double get xxs => 2.h;

  /// 4px - Icon margins, tight spacing
  static double get xs => 4.h;

  /// 8px - Between related items
  static double get sm => 8.h;

  /// 16px - Standard section spacing
  static double get md => 16.h;

  /// 24px - Between major sections
  static double get lg => 24.h;

  /// 32px - Page padding, large gaps
  static double get xl => 32.h;

  /// 48px - Hero sections, major separators
  static double get xxl => 48.h;
}

/// Border radius design tokens.
abstract class AppRadius {
  /// 4px - Tags, chips
  static double get xs => 4.r;

  /// 8px - Buttons, inputs
  static double get sm => 8.r;

  /// 12px - Cards, containers
  static double get md => 12.r;

  /// 16px - Bottom sheets, modals
  static double get lg => 16.r;

  /// 24px - Large cards, hero sections
  static double get xl => 24.r;

  /// 999px - Pills, avatars, circular
  static double get full => 999.r;
}

/// Icon size tokens.
abstract class AppIconSize {
  /// 16px - Small icons
  static double get sm => 16.w;

  /// 24px - Default icons
  static double get md => 24.w;

  /// 32px - Large icons
  static double get lg => 32.w;

  /// 48px - Extra large icons
  static double get xl => 48.w;
}
