import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_boilerplate/app.dart';
import 'package:flutter_mvvm_boilerplate/core/di/injection.dart';
import 'package:flutter_mvvm_boilerplate/core/error/error_boundary.dart';
import 'package:flutter_mvvm_boilerplate/core/network/connectivity_cubit.dart';
import 'package:flutter_mvvm_boilerplate/core/observer/app_bloc_observer.dart';
import 'package:flutter_mvvm_boilerplate/core/session/session_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize error boundary for global error handling
  ErrorBoundary.init();

  // Initialize dependencies
  await configureDependencies();

  // Set up BLoC observer for debugging
  Bloc.observer = AppBlocObserver();

  // Run app with error boundary and global providers
  ErrorBoundary.runGuarded(() {
    runApp(
      // Global BLoC providers
      MultiBlocProvider(
        providers: [
          // Session management (auth state)
          BlocProvider(create: (_) => sl<SessionCubit>()..checkSession()),
          // Connectivity monitoring
          BlocProvider(create: (_) => sl<ConnectivityCubit>()..init()),
        ],
        child: const App(),
      ),
    );
  });
}
