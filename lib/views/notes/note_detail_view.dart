import 'package:flutter/material.dart';
import '../../models/note_model.dart';

class NoteDetailView extends StatelessWidget {
  final NoteModel note;

  const NoteDetailView({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            note.content,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
