/// Centralized asset path management.
///
/// This file provides type-safe access to all application assets,
/// including images, icons, and animations (Lottie).
///
/// Usage:
/// ```dart
/// Image.asset(AppAssets.images.logo);
/// SvgPicture.asset(AppAssets.icons.home);
/// Lottie.asset(AppAssets.animations.loading);
/// ```
library;

/// Main entry point for accessing all application assets.
abstract final class AppAssets {
  /// Image assets (PNG, JPG, WebP).
  static const images = _Images();

  /// Icon assets (SVG).
  static const icons = _Icons();

  /// Lottie animation assets (JSON).
  static const animations = _Animations();
}

/// Image asset paths.
///
/// Add your image assets here following the naming convention:
/// - Use camelCase for property names
/// - Use descriptive names that indicate the image content
final class _Images {
  const _Images();

  static const String _basePath = 'assets/images';

  // ═══════════════════════════════════════════════════════════════════════════
  // BRANDING
  // ═══════════════════════════════════════════════════════════════════════════

  /// App logo.
  String get logo => '$_basePath/logo.png';

  /// App logo (dark variant).
  String get logoDark => '$_basePath/logo_dark.png';

  // ═══════════════════════════════════════════════════════════════════════════
  // PLACEHOLDERS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Default placeholder image.
  String get placeholder => '$_basePath/placeholder.png';

  /// Avatar placeholder.
  String get avatarPlaceholder => '$_basePath/avatar_placeholder.png';

  // ═══════════════════════════════════════════════════════════════════════════
  // ILLUSTRATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Empty state illustration.
  String get emptyState => '$_basePath/empty_state.png';

  /// Error state illustration.
  String get errorState => '$_basePath/error_state.png';

  /// No internet illustration.
  String get noInternet => '$_basePath/no_internet.png';

  // ═══════════════════════════════════════════════════════════════════════════
  // ONBOARDING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Onboarding step 1.
  String get onboarding1 => '$_basePath/onboarding_1.png';

  /// Onboarding step 2.
  String get onboarding2 => '$_basePath/onboarding_2.png';

  /// Onboarding step 3.
  String get onboarding3 => '$_basePath/onboarding_3.png';
}

/// Icon asset paths (SVG).
///
/// Add your icon assets here following the naming convention:
/// - Use camelCase for property names
/// - Group icons by category with comments
final class _Icons {
  const _Icons();

  static const String _basePath = 'assets/icons';

  // ═══════════════════════════════════════════════════════════════════════════
  // NAVIGATION
  // ═══════════════════════════════════════════════════════════════════════════

  /// Home icon.
  String get home => '$_basePath/ic_home.svg';

  /// Settings icon.
  String get settings => '$_basePath/ic_settings.svg';

  /// Profile icon.
  String get profile => '$_basePath/ic_profile.svg';

  /// Back arrow icon.
  String get arrowBack => '$_basePath/ic_arrow_back.svg';

  /// Forward arrow icon.
  String get arrowForward => '$_basePath/ic_arrow_forward.svg';

  // ═══════════════════════════════════════════════════════════════════════════
  // ACTIONS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Add/plus icon.
  String get add => '$_basePath/ic_add.svg';

  /// Delete icon.
  String get delete => '$_basePath/ic_delete.svg';

  /// Edit icon.
  String get edit => '$_basePath/ic_edit.svg';

  /// Search icon.
  String get search => '$_basePath/ic_search.svg';

  /// Close icon.
  String get close => '$_basePath/ic_close.svg';

  // ═══════════════════════════════════════════════════════════════════════════
  // STATUS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Success/check icon.
  String get success => '$_basePath/ic_success.svg';

  /// Warning icon.
  String get warning => '$_basePath/ic_warning.svg';

  /// Error icon.
  String get error => '$_basePath/ic_error.svg';

  /// Info icon.
  String get info => '$_basePath/ic_info.svg';
}

/// Lottie animation asset paths.
///
/// Add your Lottie JSON files here following the naming convention:
/// - Use camelCase for property names
/// - Use descriptive names that indicate the animation content
final class _Animations {
  const _Animations();

  static const String _basePath = 'assets/animations';

  // ═══════════════════════════════════════════════════════════════════════════
  // LOADERS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Generic loading animation.
  String get loading => '$_basePath/loading.json';

  /// Pull-to-refresh animation.
  String get refresh => '$_basePath/refresh.json';

  // ═══════════════════════════════════════════════════════════════════════════
  // STATES
  // ═══════════════════════════════════════════════════════════════════════════

  /// Success animation.
  String get success => '$_basePath/success.json';

  /// Error animation.
  String get error => '$_basePath/error.json';

  /// Empty state animation.
  String get empty => '$_basePath/empty.json';

  /// No internet connection animation.
  String get noConnection => '$_basePath/no_connection.json';
}
