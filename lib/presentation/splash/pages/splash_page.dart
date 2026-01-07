import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/core/constants/app_durations.dart';
import 'package:flutter_mvvm_boilerplate/core/router/route_names.dart';
import 'package:flutter_mvvm_boilerplate/core/theme/app_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Splash screen shown on app launch.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future<void>.delayed(AppDurations.splashDuration);

    if (!mounted) return;

    // TODO: Check auth state and navigate accordingly
    // For now, always go to login
    context.goNamed(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colorScheme.primary, colorScheme.primaryContainer],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Icon(
                Icons.architecture,
                size: 100.w,
                color: colorScheme.onPrimary,
              ),
              Gap(AppSpacing.lg),
              // App Name
              Text(
                'MVVM Boilerplate',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(AppSpacing.sm),
              Text(
                'Clean Architecture',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onPrimary.withValues(alpha: 0.8),
                ),
              ),
              Gap(AppSpacing.xxl),
              // Loading indicator
              SizedBox(
                width: 24.w,
                height: 24.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
