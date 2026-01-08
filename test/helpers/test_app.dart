import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_boilerplate/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

/// A test wrapper widget that provides necessary context for widget tests.
///
/// Usage:
/// ```dart
/// await tester.pumpWidget(
///   TestApp(
///     child: MyWidget(),
///   ),
/// );
/// ```
class TestApp extends StatelessWidget {
  const TestApp({
    required this.child,
    super.key,
    this.providers,
    this.themeMode = ThemeMode.light,
    this.navigatorObservers,
    this.locale,
  });

  /// The widget under test.
  final Widget child;

  /// Optional BLoC providers.
  final List<BlocProvider>? providers;

  /// Theme mode for the test.
  final ThemeMode themeMode;

  /// Navigator observers for navigation tests.
  final List<NavigatorObserver>? navigatorObservers;

  /// Locale for localization tests.
  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    Widget app = MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: locale,
      navigatorObservers: navigatorObservers ?? [],
      home: Scaffold(body: child),
    );

    if (providers != null && providers!.isNotEmpty) {
      app = MultiBlocProvider(providers: providers!, child: app);
    }

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, _) => app,
    );
  }
}

/// Extension for widget testing.
extension WidgetTesterX on WidgetTester {
  /// Pump widget with TestApp wrapper.
  Future<void> pumpTestApp(
    Widget child, {
    List<BlocProvider>? providers,
    ThemeMode themeMode = ThemeMode.light,
  }) async {
    await pumpWidget(
      TestApp(providers: providers, themeMode: themeMode, child: child),
    );
  }

  /// Pump and settle with TestApp wrapper.
  Future<void> pumpTestAppAndSettle(
    Widget child, {
    List<BlocProvider>? providers,
    ThemeMode themeMode = ThemeMode.light,
  }) async {
    await pumpTestApp(child, providers: providers, themeMode: themeMode);
    await pumpAndSettle();
  }

  /// Find widget by key and tap.
  Future<void> tapByKey(String key) async {
    await tap(find.byKey(Key(key)));
    await pump();
  }

  /// Find widget by text and tap.
  Future<void> tapByText(String text) async {
    await tap(find.text(text));
    await pump();
  }

  /// Enter text in a text field by key.
  Future<void> enterTextByKey(String key, String text) async {
    await enterText(find.byKey(Key(key)), text);
    await pump();
  }
}

/// Golden test configuration.
class GoldenConfig {
  GoldenConfig._();

  /// Default device sizes for golden tests.
  static const deviceSizes = {
    'iphone_se': Size(375, 667),
    'iphone_14': Size(390, 844),
    'iphone_14_pro_max': Size(430, 932),
    'pixel_5': Size(393, 851),
    'ipad_mini': Size(768, 1024),
  };
}
