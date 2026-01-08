import 'package:flutter_mvvm_boilerplate/core/error/failures.dart';
import 'package:flutter_mvvm_boilerplate/domain/entities/user.dart';

/// Test fixtures for common data objects.
///
/// Usage:
/// ```dart
/// final user = Fixtures.user;
/// final users = Fixtures.users(count: 5);
/// ```
abstract class Fixtures {
  // ═══════════════════════════════════════════════════════════════════════════
  // USER FIXTURES
  // ═══════════════════════════════════════════════════════════════════════════

  /// Sample user entity.
  static User get user =>
      const User(id: '1', email: 'test@example.com', name: 'Test User');

  /// Generate list of users.
  static List<User> users({int count = 10}) {
    return List.generate(
      count,
      (i) => User(
        id: '${i + 1}',
        email: 'user${i + 1}@example.com',
        name: 'User ${i + 1}',
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // FAILURE FIXTURES
  // ═══════════════════════════════════════════════════════════════════════════

  /// Sample server failure.
  static ServerFailure get serverFailure =>
      const ServerFailure(message: 'Server error occurred', statusCode: 500);

  /// Sample network failure.
  static NetworkFailure get networkFailure => const NetworkFailure();

  /// Sample auth failure.
  static AuthFailure get authFailure =>
      const AuthFailure(message: 'Invalid credentials');

  /// Sample validation failure.
  static ValidationFailure get validationFailure => const ValidationFailure(
    message: 'Validation failed',
    fieldErrors: {
      'email': 'Invalid email format',
      'password': 'Password too short',
    },
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // JSON FIXTURES
  // ═══════════════════════════════════════════════════════════════════════════

  /// Sample user JSON response.
  static Map<String, dynamic> get userJson => {
    'id': '1',
    'email': 'test@example.com',
    'name': 'Test User',
  };

  /// Sample API error response.
  static Map<String, dynamic> get errorJson => {
    'success': false,
    'message': 'An error occurred',
    'code': 'ERROR_CODE',
  };

  /// Sample paginated response.
  static Map<String, dynamic> paginatedJson<T>({
    required List<Map<String, dynamic>> data,
    int page = 1,
    int perPage = 10,
    int total = 100,
  }) {
    return {
      'data': data,
      'meta': {
        'page': page,
        'per_page': perPage,
        'total': total,
        'total_pages': (total / perPage).ceil(),
      },
    };
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DATETIME FIXTURES
  // ═══════════════════════════════════════════════════════════════════════════

  /// Fixed timestamp for tests (2024-01-15 10:30:00 UTC).
  static DateTime get fixedDateTime => DateTime.utc(2024, 1, 15, 10, 30);

  /// Date string for tests.
  static String get dateString => '2024-01-15';

  /// DateTime string for tests.
  static String get dateTimeString => '2024-01-15T10:30:00.000Z';
}

/// Extension for creating variations of fixtures.
extension UserFixtureX on User {
  /// Create a copy with overrides for testing.
  User withOverrides({
    String? id,
    String? email,
    String? name,
    String? avatarUrl,
    bool? isEmailVerified,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
