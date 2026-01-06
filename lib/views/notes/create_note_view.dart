import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/note_viewmodel.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({super.key});

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      appBar: AppBar(
        title: const Text('Create Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Title required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 6,
                validator: (value) =>
                value == null || value.isEmpty ? 'Content required' : null,
              ),
              const SizedBox(height: 24),

              noteVM.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print('🟡 Creating note...');
                    await noteVM.createNote(
                      title: _titleController.text.trim(),
                      content: _contentController.text.trim(),
                    );

                    if (context.mounted) {
                      print('🟢 Refreshing notes list');
                      await noteVM.fetchNotes();
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text('Save Note'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
