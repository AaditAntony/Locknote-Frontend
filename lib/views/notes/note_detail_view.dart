import 'package:flutter/material.dart';
import '../../models/note_model.dart';

class NoteDetailView extends StatelessWidget {
  final NoteModel note;

  const NoteDetailView({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F8),

      // 🟣 APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A1B9A),
        elevation: 0,
        title: const Text(
          'Note',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      // 📄 BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 📝 TITLE
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 16),

              // 🟣 DIVIDER
              Container(
                height: 3,
                width: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF6A1B9A),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 20),

              // 📄 CONTENT (FULL, SCROLLABLE)
              Text(
                note.content,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
