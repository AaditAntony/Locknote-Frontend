import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../services/note_service.dart';

class NoteViewModel extends ChangeNotifier {
  final NoteService _noteService = NoteService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  List<NoteModel> _notes = [];
  List<NoteModel> get notes => _notes;

  /// Fetch notes
  Future<void> fetchNotes() async {
    _setLoading(true);
    _error = null;

    try {
      print('🟡 NoteViewModel.fetchNotes()');

      final data = await _noteService.fetchNotes();
      _notes = data.map((e) => NoteModel.fromJson(e)).toList();

      print('🟢 Notes loaded: ${_notes.length}');
    } catch (e) {
      _error = 'Failed to load notes';
      print('❌ Fetch notes error: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Create note
  Future<void> createNote({
    required String title,
    required String content,
  }) async {
    _setLoading(true);
    _error = null;

    try {
      print('🟡 NoteViewModel.createNote()');

      await _noteService.createNote(
        title: title,
        content: content,
      );

      print('🟢 Note created, refreshing list');
      await fetchNotes();
    } catch (e) {
      _error = 'Failed to create note';
      print('❌ Create note error: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  
  void clearNotes() {
    print('🧹 Clearing notes from memory');
    _notes.clear();
    notifyListeners();
  }


  Future<void> updateNote({
    required int id,
    required String title,
    required String content,
  }) async {
    print('🟡 NoteViewModel.updateNote()');

    await _noteService.updateNote(
      id: id,
      title: title,
      content: content,
    );

    final index = _notes.indexWhere((note) => note.id == id);

    if (index != -1) {
      final oldNote = _notes[index];

      _notes[index] = NoteModel(
        id: oldNote.id,
        title: title,
        content: content,
        deleted: oldNote.deleted,
      );

      notifyListeners();
    }

    print('🟢 Note updated in memory');
  }


}
