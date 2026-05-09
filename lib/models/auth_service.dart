import 'package:hive/hive.dart';
import 'package:music_app/models/api_client.dart';
import 'package:riverpod/riverpod.dart';

final authServiceProvider = Provider((ref) {
  return AuthService(ref.watch(apiClientProvider), Hive.box('authBox'));
});

class AuthService {
  final ApiClient _apiClient;
  final Box _authBox;

  AuthService(this._apiClient, this._authBox);

  Future<void> sendVerificationCode(String email) async {
    await _apiClient.post('api/auth/send-code', data: {'email': email});
  }

  Future<String> verifyCode(String email, String code) async {
    final response = await _apiClient.post(
      'api/auth/verify-code',
      data: {'email': email, 'code': code},
    );
    final token = response.data['token'] as String;
    _apiClient.authToken = token;
    _authBox.put('jwt_token', token);
    return token;
  }

  Future<bool> hasValidToken() async {
    final token = _authBox.get('jwt_token');
    if (token == null || token.toString().isEmpty) {
      return false;
    }
    _apiClient.authToken = token as String;
    return true;
  }

  Future<void> logout() async {
    await _authBox.delete('jwt_token');
    _apiClient.authToken = null;
  }
}
