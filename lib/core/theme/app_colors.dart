import 'package:flutter/material.dart';

/// Semantic and custom color definitions for the app.
///
/// This file complements [AppTheme] by providing:
/// - Semantic colors (success, warning, error, info)
/// - Custom brand colors not in the theme
/// - Gradient definitions
///
/// Usage:
/// ```dart
/// Container(color: AppColors.success);
/// Container(decoration: BoxDecoration(gradient: AppColors.primaryGradient));
/// ```
abstract final class AppColors {
  // ═══════════════════════════════════════════════════════════════════════════
  // SEMANTIC COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Success state color (green).
  static const Color success = Color(0xFF22C55E);

  /// Success light variant.
  static const Color successLight = Color(0xFFDCFCE7);

  /// Warning state color (amber).
  static const Color warning = Color(0xFFF59E0B);

  /// Warning light variant.
  static const Color warningLight = Color(0xFFFEF3C7);

  /// Error state color (red).
  static const Color error = Color(0xFFEF4444);

  /// Error light variant.
  static const Color errorLight = Color(0xFFFEE2E2);

  /// Info state color (blue).
  static const Color info = Color(0xFF3B82F6);

  /// Info light variant.
  static const Color infoLight = Color(0xFFDBEAFE);

  // ═══════════════════════════════════════════════════════════════════════════
  // NEUTRAL COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Pure black.
  static const Color black = Color(0xFF000000);

  /// Pure white.
  static const Color white = Color(0xFFFFFFFF);

  /// Transparent.
  static const Color transparent = Colors.transparent;

  /// Background grey (light mode).
  static const Color backgroundLight = Color(0xFFF8FAFC);

  /// Background grey (dark mode).
  static const Color backgroundDark = Color(0xFF0F172A);

  /// Border/divider color.
  static const Color border = Color(0xFFE2E8F0);

  /// Disabled state color.
  static const Color disabled = Color(0xFF94A3B8);

  /// Placeholder text color.
  static const Color placeholder = Color(0xFF9CA3AF);

  // ═══════════════════════════════════════════════════════════════════════════
  // TEXT COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Primary text color (dark).
  static const Color textPrimary = Color(0xFF1E293B);

  /// Secondary text color.
  static const Color textSecondary = Color(0xFF64748B);

  /// Tertiary/hint text color.
  static const Color textTertiary = Color(0xFF94A3B8);

  /// Inverse text (for dark backgrounds).
  static const Color textInverse = Color(0xFFFFFFFF);

  // ═══════════════════════════════════════════════════════════════════════════
  // GRADIENTS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Primary brand gradient.
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
  );

  /// Secondary gradient.
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
  );

  /// Success gradient.
  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF22C55E), Color(0xFF10B981)],
  );

  /// Sunset gradient (warm).
  static const LinearGradient sunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF97316), Color(0xFFF43F5E)],
  );

  /// Dark overlay gradient (for images).
  static const LinearGradient darkOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0xCC000000)],
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SHADOW COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Light shadow for elevated elements.
  static Color shadowLight = const Color(0xFF000000).withValues(alpha: 0.05);

  /// Medium shadow.
  static Color shadowMedium = const Color(0xFF000000).withValues(alpha: 0.1);

  /// Dark shadow.
  static Color shadowDark = const Color(0xFF000000).withValues(alpha: 0.2);
}
