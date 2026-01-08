import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_boilerplate/core/di/injection.dart';
import 'package:flutter_mvvm_boilerplate/core/router/route_names.dart';
import 'package:flutter_mvvm_boilerplate/core/theme/app_spacing.dart';
import 'package:flutter_mvvm_boilerplate/presentation/splash/bloc/splash_cubit.dart';
import 'package:flutter_mvvm_boilerplate/presentation/splash/bloc/splash_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Splash screen shown on app launch.
///
/// Uses [SplashCubit] to:
/// - Check authentication status
/// - Navigate to appropriate screen
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SplashCubit>()..initialize(),
      child: const _SplashPageContent(),
    );
  }
}

class _SplashPageContent extends StatelessWidget {
  const _SplashPageContent();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: (_) {},
          authenticated: () => context.goNamed(RouteNames.home),
          unauthenticated: () => context.goNamed(RouteNames.login),
          error: (_) {}, // Error is shown in UI
        );
      },
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
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
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
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
                    // State-based content
                    _buildStateContent(context, state, colorScheme),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStateContent(
    BuildContext context,
    SplashState state,
    ColorScheme colorScheme,
  ) {
    return state.when(
      initial: () => const SizedBox.shrink(),
      loading: (message) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 24.w,
            height: 24.w,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onPrimary),
            ),
          ),
          if (message != null) ...[
            Gap(AppSpacing.md),
            Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onPrimary.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
      authenticated: () =>
          Icon(Icons.check_circle, size: 32.w, color: Colors.green),
      unauthenticated: () => const SizedBox.shrink(),
      error: (message) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 32.w, color: Colors.red),
          Gap(AppSpacing.sm),
          Text(
            message,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary),
            textAlign: TextAlign.center,
          ),
          Gap(AppSpacing.md),
          ElevatedButton(
            onPressed: () => context.read<SplashCubit>().retry(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
