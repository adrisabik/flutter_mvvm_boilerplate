import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App theme configuration using FlexColorScheme with Material 3.
class AppTheme {
  AppTheme._();

  /// Light theme
  static ThemeData get light => FlexThemeData.light(
    scheme: FlexScheme.indigo,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 7,
    subThemesData: _subThemesData,
    typography: Typography.material2021(),
    fontFamily: GoogleFonts.inter().fontFamily,
  );

  /// Dark theme
  static ThemeData get dark => FlexThemeData.dark(
    scheme: FlexScheme.indigo,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 13,
    subThemesData: _subThemesData,
    typography: Typography.material2021(),
    fontFamily: GoogleFonts.inter().fontFamily,
  );

  /// Sub-themes configuration
  static const FlexSubThemesData _subThemesData = FlexSubThemesData(
    blendOnLevel: 10,
    useMaterial3Typography: true,
    useM2StyleDividerInM3: true,
    // Input decoration
    inputDecoratorBorderType: FlexInputBorderType.outline,
    inputDecoratorRadius: 12,
    // Elevated button
    elevatedButtonRadius: 12,
    elevatedButtonSchemeColor: SchemeColor.primary,
    // Filled button
    filledButtonRadius: 12,
    // Outlined button
    outlinedButtonRadius: 12,
    // Text button
    textButtonRadius: 12,
    // Card
    cardRadius: 16,
    // Dialog
    dialogRadius: 20,
    // Bottom sheet
    bottomSheetRadius: 20,
    // FAB
    fabRadius: 16,
    // Chip
    chipRadius: 8,
    // AppBar
    appBarCenterTitle: true,
    appBarScrolledUnderElevation: 4,
  );
}
