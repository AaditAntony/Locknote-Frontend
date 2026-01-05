import '../core/api/api_client.dart';
import '../core/constants/api_constants.dart';
import '../models/note_model.dart';

class NoteService {
  Future<List<NoteModel>> fetchNotes() async {
    print('🟡 NoteService.fetchNotes() START');

    final response = await ApiClient.dio.get(
      ApiConstants.notes,
    );

    print('📥 Status: ${response.statusCode}');
    print('📦 Raw response: ${response.data}');

    final List list = response.data as List;

    final notes = list.map((e) => NoteModel.fromJson(e)).toList();

    print('✅ Parsed notes count: ${notes.length}');
    return notes;
  }
}
