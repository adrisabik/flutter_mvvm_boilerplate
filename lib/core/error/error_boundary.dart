import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/core/config/env_config.dart';
import 'package:flutter_mvvm_boilerplate/core/theme/app_spacing.dart';
import 'package:flutter_mvvm_boilerplate/core/utils/logger.dart';
import 'package:gap/gap.dart';

/// Global error handling configuration.
///
/// Call [ErrorBoundary.init] in main() before runApp() to set up
/// global error handlers for both Flutter and Dart errors.
///
/// Example:
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   ErrorBoundary.init();
///   runApp(const App());
/// }
/// ```
class ErrorBoundary {
  ErrorBoundary._();

  /// Initialize global error handlers.
  static void init() {
    // Handle Flutter framework errors
    FlutterError.onError = (FlutterErrorDetails details) {
      Log.e(
        'Flutter Error',
        error: details.exception,
        stackTrace: details.stack,
      );

      // In debug mode, show the default red error screen
      if (kDebugMode) {
        FlutterError.presentError(details);
      }
    };

    // Handle errors outside of Flutter framework
    PlatformDispatcher.instance.onError = (error, stack) {
      Log.e('Platform Error', error: error, stackTrace: stack);
      return true; // Prevents the app from crashing
    };

    // Customize the error widget shown in release mode
    if (!kDebugMode) {
      ErrorWidget.builder = (FlutterErrorDetails details) {
        return AppErrorBoundaryWidget(details: details);
      };
    }
  }

  /// Run a function in a zone that catches all errors.
  ///
  /// Use this to wrap your entire app for comprehensive error catching:
  /// ```dart
  /// void main() {
  ///   ErrorBoundary.runGuarded(() {
  ///     runApp(const App());
  ///   });
  /// }
  /// ```
  static void runGuarded(VoidCallback body) {
    runZonedGuarded(body, (error, stackTrace) {
      Log.e('Uncaught Error', error: error, stackTrace: stackTrace);
    });
  }
}

/// A user-friendly error widget shown when a widget fails to build.
///
/// This replaces the default red error screen in release mode.
class AppErrorBoundaryWidget extends StatelessWidget {
  const AppErrorBoundaryWidget({
    required this.details,
    super.key,
    this.onRetry,
  });

  final FlutterErrorDetails details;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surface,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: colorScheme.error),
                Gap(AppSpacing.lg),
                Text(
                  'Something went wrong',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(AppSpacing.sm),
                Text(
                  'We apologize for the inconvenience.\n'
                  'Please try again or restart the app.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                // Show error details in debug mode
                if (EnvConfig.current.isDev) ...[
                  Gap(AppSpacing.lg),
                  Container(
                    padding: EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      details.exception.toString(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onErrorContainer,
                        fontFamily: 'monospace',
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
                if (onRetry != null) ...[
                  Gap(AppSpacing.xl),
                  FilledButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A widget that catches errors in its child tree and shows a fallback.
///
/// Use this to wrap individual widgets that might fail:
/// ```dart
/// ErrorBoundaryWrapper(
///   fallback: (error) => Text('Failed to load'),
///   child: SomeRiskyWidget(),
/// )
/// ```
class ErrorBoundaryWrapper extends StatefulWidget {
  const ErrorBoundaryWrapper({
    required this.child,
    super.key,
    this.fallback,
    this.onError,
  });

  final Widget child;
  final Widget Function(Object error)? fallback;
  final void Function(Object error, StackTrace stack)? onError;

  @override
  State<ErrorBoundaryWrapper> createState() => _ErrorBoundaryWrapperState();
}

class _ErrorBoundaryWrapperState extends State<ErrorBoundaryWrapper> {
  Object? _error;

  @override
  void initState() {
    super.initState();
  }

  void _resetError() {
    setState(() {
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.fallback?.call(_error!) ??
          AppErrorBoundaryWidget(
            details: FlutterErrorDetails(exception: _error!),
            onRetry: _resetError,
          );
    }

    return widget.child;
  }
}
