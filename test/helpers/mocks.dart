import 'package:flutter_mvvm_boilerplate/core/network/dio_client.dart';
import 'package:flutter_mvvm_boilerplate/core/network/network_info.dart';
import 'package:flutter_mvvm_boilerplate/domain/repositories/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

// ═══════════════════════════════════════════════════════════════════════════
// REPOSITORY MOCKS
// ═══════════════════════════════════════════════════════════════════════════

/// Mock for AuthRepository.
class MockAuthRepository extends Mock implements AuthRepository {}

// ═══════════════════════════════════════════════════════════════════════════
// NETWORK MOCKS
// ═══════════════════════════════════════════════════════════════════════════

/// Mock for DioClient.
class MockDioClient extends Mock implements DioClient {}

/// Mock for NetworkInfo.
class MockNetworkInfo extends Mock implements NetworkInfo {}

// ═══════════════════════════════════════════════════════════════════════════
// STUB HELPERS
// ═══════════════════════════════════════════════════════════════════════════

/// Helper to stub network connectivity.
void stubNetworkConnected(MockNetworkInfo mock, {bool isConnected = true}) {
  when(() => mock.isConnected).thenAnswer((_) async => isConnected);
}

/// Helper to stub auth state.
void stubAuthLoggedIn(MockAuthRepository mock, {bool isLoggedIn = true}) {
  when(() => mock.isLoggedIn()).thenAnswer((_) async => isLoggedIn);
}

// ═══════════════════════════════════════════════════════════════════════════
// CALLBACK CLASSES FOR MOCKTAIL
// ═══════════════════════════════════════════════════════════════════════════

/// Callback mock for void functions.
class MockVoidCallback extends Mock {
  void call();
}

/// Callback mock for functions with one parameter.
class MockCallback<T> extends Mock {
  void call(T value);
}
