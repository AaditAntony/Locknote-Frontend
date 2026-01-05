import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/note_viewmodel.dart';

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
      print('🟡 NotesListView initState → fetchNotes');
      context.read<NoteViewModel>().fetchNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final noteVM = context.watch<NoteViewModel>();

    if (noteVM.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (noteVM.error != null) {
      return Scaffold(
        body: Center(child: Text(noteVM.error!)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: ListView.builder(
        itemCount: noteVM.notes.length,
        itemBuilder: (context, index) {
          final note = noteVM.notes[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.content),
          );
        },
      ),
    );
  }
}
