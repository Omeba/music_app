import 'package:music_app/models/api_client.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

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
    return token;
  }
}
