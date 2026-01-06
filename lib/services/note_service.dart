import 'package:dio/dio.dart';
import '../core/api/api_client.dart';
import '../core/constants/api_constants.dart';

class NoteService {
  final Dio _dio = ApiClient.dio;

  /// Create a new note
  Future<void> createNote({
    required String title,
    required String content,
  }) async {
    try {
      print('🟡 NoteService.createNote()');
      print('📝 Title: $title');

      final response = await _dio.post(
        ApiConstants.notes,
        data: {
          'title': title,
          'content': content,
        },
      );

      print('📥 Status: ${response.statusCode}');
      print('📦 Response: ${response.data}');
    } on DioException catch (e) {
      print('❌ Create note error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Fetch all notes
  Future<List<dynamic>> fetchNotes() async {
    try {
      print('🟡 NoteService.fetchNotes()');

      final response = await _dio.get(ApiConstants.notes);

      print('📥 Status: ${response.statusCode}');
      print('📦 Notes count: ${response.data.length}');

      return response.data;
    } on DioException catch (e) {
      print('❌ Fetch notes error: ${e.response?.data}');
      rethrow;
    }
  }

  Future<void> updateNote({
    required int id,
    required String title,
    required String content,
  }) async {
    print('🟡 NoteService.updateNote()');

    final response = await ApiClient.dio.put(
      '/api/notes/$id',
      data: {
        'title': title,
        'content': content,
      },
    );

    print('📥 Update status: ${response.statusCode}');
  }

}
