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
    _setLoading(true);
    try {
      _notes = await _noteService.getNotes();
      _error = null;
    } catch (e) {
      _error = 'Failed to load notes';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addNote({
    required String title,
    required String content,
  }) async {
    _setLoading(true);
    try {
      await _noteService.createNote(
        title: title,
        content: content,
      );
      await fetchNotes();
    } catch (e) {
      _error = 'Failed to create note';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateNote({
    required int id,
    required String title,
    required String content,
  }) async {
    _setLoading(true);
    try {
      await _noteService.updateNote(
        id: id,
        title: title,
        content: content,
      );
      await fetchNotes();
    } catch (e) {
      _error = 'Failed to update note';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteNote(int id) async {
    _setLoading(true);
    try {
      await _noteService.deleteNote(id);
      await fetchNotes();
    } catch (e) {
      _error = 'Failed to delete note';
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
