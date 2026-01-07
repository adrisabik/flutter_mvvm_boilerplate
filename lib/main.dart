import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_mvvm_boilerplate/app.dart';
import 'package:flutter_mvvm_boilerplate/core/config/env_config.dart';
import 'package:flutter_mvvm_boilerplate/core/di/injection.dart';
import 'package:flutter_mvvm_boilerplate/core/observer/app_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set environment (can be changed based on build flavor)
  EnvConfig.current = EnvConfig.dev;

  // Initialize dependencies
  await configureDependencies();

  // Set up BLoC observer for debugging
  Bloc.observer = AppBlocObserver();

  runApp(const App());
}
