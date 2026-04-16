import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _keyApiKey = 'llm_api_key';
  static const _keyApiBaseUrl = 'llm_api_base_url';

  static Future<String?> getApiKey() => _storage.read(key: _keyApiKey);
  static Future<void> setApiKey(String value) =>
      _storage.write(key: _keyApiKey, value: value);

  static Future<String?> getApiBaseUrl() => _storage.read(key: _keyApiBaseUrl);
  static Future<void> setApiBaseUrl(String value) =>
      _storage.write(key: _keyApiBaseUrl, value: value);
}
