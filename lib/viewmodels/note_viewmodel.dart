import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../services/note_service.dart';

class NoteViewModel extends ChangeNotifier {
  final NoteService _noteService = NoteService();

  List<NoteModel> _notes = [];
  List<NoteModel> get notes => _notes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchNotes() async {
    print('🟡 NoteViewModel.fetchNotes() START');

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _notes = await _noteService.fetchNotes();
      print('✅ Notes loaded: ${_notes.length}');
    } catch (e) {
      _error = 'Failed to load notes';
      print('❌ Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
      print('🔵 NoteViewModel.fetchNotes() END');
    }
  }
}
