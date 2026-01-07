import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/note_model.dart';
import '../../viewmodels/note_viewmodel.dart';

class EditNoteView extends StatefulWidget {
  final NoteModel note;

  const EditNoteView({
    super.key,
    required this.note,
  });

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteVM = context.watch<NoteViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F8),

      // 🟣 APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A1B9A),
        elevation: 0,
        title: const Text(
          'Edit Note',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      // 📄 BODY
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 📝 NOTE CARD
              Expanded(
                child: Container(
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
                    children: [
                      // TITLE
                      TextFormField(
                        controller: _titleController,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Title',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Title is required';
                          }
                          return null;
                        },
                      ),

                      const Divider(),

                      // CONTENT
                      Expanded(
                        child: TextFormField(
                          controller: _contentController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          expands: true,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.grey.shade800,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Edit your note...',
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Content is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 💾 UPDATE BUTTON
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A1B9A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: noteVM.isLoading
                      ? null
                      : () async {
                    if (_formKey.currentState!.validate()) {
                      await noteVM.updateNote(
                        id: widget.note.id,
                        title: _titleController.text.trim(),
                        content: _contentController.text.trim(),
                      );

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: noteVM.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    'Update Note',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
