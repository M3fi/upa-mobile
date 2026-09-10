import '../entities/entities.dart';

abstract class AuthRepository {
  Future<String> login(String email, String password);
  Future<String?> getToken();
  Future<void> logout();
}
