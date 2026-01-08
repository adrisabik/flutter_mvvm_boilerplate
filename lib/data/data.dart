/// Data layer exports.
///
/// Import this file to access all data layer components:
/// ```dart
/// import 'package:flutter_mvvm_boilerplate/data/data.dart';
/// ```
library;

// DataSources - Local
export 'datasources/local/secure_storage_service.dart';

// DataSources - Remote
export 'datasources/remote/auth_remote_datasource.dart';

// Models
export 'models/api_response_model.dart';
export 'models/user_model.dart';

// Repositories
export 'repositories/auth_repository_impl.dart';
