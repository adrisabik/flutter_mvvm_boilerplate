import 'package:flutter_mvvm_boilerplate/core/constants/storage_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure storage service for sensitive data like tokens.
class SecureStorageService {

  SecureStorageService()
    : _storage = const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      );
  final FlutterSecureStorage _storage;

  // Token management
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: StorageKeys.accessToken, value: token);
  }

  Future<String?> getAccessToken() async {
    return _storage.read(key: StorageKeys.accessToken);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: StorageKeys.refreshToken, value: token);
  }

  Future<String?> getRefreshToken() async {
    return _storage.read(key: StorageKeys.refreshToken);
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.refreshToken);
  }

  // User data
  Future<void> saveUserData(String userData) async {
    await _storage.write(key: StorageKeys.userData, value: userData);
  }

  Future<String?> getUserData() async {
    return _storage.read(key: StorageKeys.userData);
  }

  Future<void> clearUserData() async {
    await _storage.delete(key: StorageKeys.userData);
  }

  // Clear all
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
