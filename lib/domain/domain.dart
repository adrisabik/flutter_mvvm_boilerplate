/// Domain layer exports.
///
/// Import this file to access all domain layer components:
/// ```dart
/// import 'package:flutter_mvvm_boilerplate/domain/domain.dart';
/// ```
library;

// Entities
export 'entities/user.dart';

// Repositories (interfaces)
export 'repositories/auth_repository.dart';

// Use cases
export 'usecases/auth/login_usecase.dart';
export 'usecases/auth/logout_usecase.dart';
export 'usecases/usecase.dart';
