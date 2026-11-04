import '../datasources/api_client.dart';
import '../datasources/auth_storage.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _api;
  final AuthStorage _storage;

  AuthRepositoryImpl(this._api, this._storage);

  @override
  Future<String> login(String email, String password) async {
    final response = await _api.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    final token = response.data['accessToken'] as String;
    await _storage.saveToken(token);
    return token;
  }

  @override
  Future<String?> getToken() => _storage.getToken();

  @override
  Future<void> logout() => _storage.clearToken();
}
