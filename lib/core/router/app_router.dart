import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/core/di/injection.dart';
import 'package:flutter_mvvm_boilerplate/core/router/route_names.dart';
import 'package:flutter_mvvm_boilerplate/domain/repositories/auth_repository.dart';
import 'package:flutter_mvvm_boilerplate/presentation/auth/pages/login_page.dart';
import 'package:flutter_mvvm_boilerplate/presentation/home/pages/home_page.dart';
import 'package:flutter_mvvm_boilerplate/presentation/splash/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

/// App router configuration using GoRouter with auth guards.
class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  /// The GoRouter instance.
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePaths.splash,
    debugLogDiagnostics: true,
    routes: _routes,
    errorBuilder: _errorBuilder,
    redirect: _authGuard,
  );

  static final List<RouteBase> _routes = [
    // Splash
    GoRoute(
      name: RouteNames.splash,
      path: RoutePaths.splash,
      builder: (context, state) => const SplashPage(),
    ),

    // Auth Routes
    GoRoute(
      name: RouteNames.login,
      path: RoutePaths.login,
      builder: (context, state) => const LoginPage(),
    ),

    // Main Routes
    GoRoute(
      name: RouteNames.home,
      path: RoutePaths.home,
      builder: (context, state) => const HomePage(),
    ),
  ];

  /// Auth guard to protect routes
  static Future<String?> _authGuard(
    BuildContext context,
    GoRouterState state,
  ) async {
    final isLoggedIn = await sl<AuthRepository>().isLoggedIn();
    final isSplash = state.matchedLocation == RoutePaths.splash;
    final isAuthRoute =
        state.matchedLocation == RoutePaths.login ||
        state.matchedLocation == RoutePaths.register ||
        state.matchedLocation == RoutePaths.forgotPassword;

    // Allow splash screen always
    if (isSplash) return null;

    // If not logged in and trying to access protected route
    if (!isLoggedIn && !isAuthRoute) {
      return RoutePaths.login;
    }

    // If logged in and trying to access auth routes
    if (isLoggedIn && isAuthRoute) {
      return RoutePaths.home;
    }

    return null;
  }

  static Widget _errorBuilder(BuildContext context, GoRouterState state) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('Path: ${state.uri.path}'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(RoutePaths.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
