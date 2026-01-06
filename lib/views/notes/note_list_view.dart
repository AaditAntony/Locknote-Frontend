import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/note_viewmodel.dart';
import 'create_note_view.dart';

class NotesListView extends StatefulWidget {
  const NotesListView({super.key});

  @override
  State<NotesListView> createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NoteViewModel>().fetchNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final noteVM = context.watch<NoteViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('🟡 Navigate to CreateNoteView');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateNoteView()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: noteVM.isLoading
          ? const Center(child: CircularProgressIndicator())
          : noteVM.notes.isEmpty
          ? const Center(child: Text('No notes found'))
          : ListView.builder(
        itemCount: noteVM.notes.length,
        itemBuilder: (context, index) {
          final note = noteVM.notes[index];
          return Card(
            margin: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(note.title),
              subtitle: Text(
                note.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }
}
