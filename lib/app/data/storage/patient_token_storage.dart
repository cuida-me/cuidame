import 'package:shared_preferences/shared_preferences.dart';

abstract class PatientTokenStorage {
  Future<String?> getToken();
  Future<void> setToken(String? token);
  Future<bool?> removeToken();
}

class PatientTokenStorageImpl implements PatientTokenStorage {
  final _keyToken = 'patient_access_token';

  @override
  Future<String?> getToken() async {
    final cache = await SharedPreferences.getInstance();
    return cache.getString(_keyToken);
  }

  @override
  Future<void> setToken(String? token) async {
    final cache = await SharedPreferences.getInstance();
    if (token != null) await cache.setString(_keyToken, token);
  }

  @override
  Future<bool?> removeToken() async {
    final cache = await SharedPreferences.getInstance();
    return await cache.remove(_keyToken);
  }
}
