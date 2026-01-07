import 'package:flutter_mvvm_boilerplate/core/di/injection.dart';

/// Convenience function to get a dependency from the service locator.
/// Usage: `final authRepo = getIt<AuthRepository>();`
T getIt<T extends Object>() => sl<T>();
