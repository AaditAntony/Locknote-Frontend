import 'package:dio/dio.dart';
import '../core/api/api_client.dart';
import '../models/note_model.dart';

class NoteService {
  final Dio _dio = ApiClient.dio;

  Future<List<NoteModel>> getNotes() async {
    final response = await _dio.get('/notes');

    return (response.data as List)
        .map((json) => NoteModel.fromJson(json))
        .toList();
  }

  Future<void> createNote({
    required String title,
    required String content,
  }) async {
    await _dio.post(
      '/notes',
      data: {
        'title': title,
        'content': content,
      },
    );
  }

  Future<void> updateNote({
    required int id,
    required String title,
    required String content,
  }) async {
    await _dio.put(
      '/notes/$id',
      data: {
        'title': title,
        'content': content,
      },
    );
  }

  Future<void> deleteNote(int id) async {
    await _dio.delete('/notes/$id');
  }
}
