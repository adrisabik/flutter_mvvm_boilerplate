/// Core layer exports.
///
/// Import this file to access all core utilities:
/// ```dart
/// import 'package:flutter_mvvm_boilerplate/core/core.dart';
/// ```
library;

// Config
export 'config/env_config.dart';

// Constants
export 'constants/app_assets.dart';
export 'constants/app_durations.dart';
export 'constants/regex_patterns.dart';
export 'constants/storage_keys.dart';

// DI
export 'di/injection.dart';

// Error handling
export 'error/error_boundary.dart';
export 'error/exceptions.dart';
export 'error/failures.dart';

// Extensions
export 'extensions/extensions.dart';

// Network
export 'network/connectivity_cubit.dart';
export 'network/connectivity_state.dart';
export 'network/dio_client.dart';
export 'network/network_info.dart';
export 'network/interceptors/auth_interceptor.dart';
export 'network/interceptors/error_interceptor.dart';

// Observer
export 'observer/app_bloc_observer.dart';

// Router
export 'router/app_router.dart';
export 'router/route_names.dart';

// Session
export 'session/session_cubit.dart';
export 'session/session_state.dart';

// Theme
export 'theme/app_colors.dart';
export 'theme/app_spacing.dart';
export 'theme/app_theme.dart';

// Utils
export 'utils/utils.dart';
