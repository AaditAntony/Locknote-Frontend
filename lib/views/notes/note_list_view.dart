import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/note_viewmodel.dart';
import '../../core/storage/token_storage.dart';
import '../auth/login_view.dart';

class NotesListView extends StatefulWidget {
  const NotesListView({super.key});

  @override
  State<NotesListView> createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NoteViewModel>().fetchNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final noteVM = context.watch<NoteViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await TokenStorage.clearToken();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginView()),
                      (_) => false,
                );
              }
            },
          )
        ],
      ),
      body: Builder(
        builder: (_) {
          if (noteVM.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (noteVM.error != null) {
            return Center(child: Text(noteVM.error!));
          }

          if (noteVM.notes.isEmpty) {
            return const Center(child: Text('No notes found'));
          }

          return ListView.builder(
            itemCount: noteVM.notes.length,
            itemBuilder: (context, index) {
              final note = noteVM.notes[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
          );
        },
      ),
    );
  }
}
