import 'package:dio/dio.dart';
import 'package:music_app/models/api_client.dart';
import 'package:music_app/models/progress.dart';

class SyncService {
  final ApiClient _apiClient;

  SyncService(this._apiClient);

  Future<List<Map<String, dynamic>>> fetchAllLevels() async {
    final response = await _apiClient.get('api/levels');
    return (response.data as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> fetchLevelsSince(DateTime since) async {
    final sinceStr = since.toUtc().toIso8601String();
    final response = await _apiClient.get('/api/levels?since=$sinceStr');
    return (response.data as List).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>?> fetchLevelById(String id) async {
    try {
      final response = await _apiClient.get('/api/levels/$id');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  Future<DateTime?> fetchLastModified() async {
    final response = await _apiClient.get('/api/levels/last-modified');
    final lastMod = response.data['lastModified'];
    if (lastMod == null) return null;
    return DateTime.tryParse(lastMod as String);
  }

  Future<void> syncProgress(List<Map<String, dynamic>> progress) async {
    await _apiClient.post('api/progress/sync', data: progress);
  }

  Future<int> pushProgress(List<Progress> attempts) async {
    if (attempts.isEmpty) return 0;
    final payload = attempts.map((a) => a.toJson()).toList();
    final response = await _apiClient.post('/api/progress/sync', data: payload);
    if (response.statusCode == 200) {
      return attempts.length;
    } else {
      throw Exception('Failed to sync progress');
    }
  }
}
