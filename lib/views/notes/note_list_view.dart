import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/note_viewmodel.dart';
import '../../viewmodels/auth_viewmodel.dart';
import 'create_note_view.dart';
import 'note_detail_view.dart';
import 'edit_note_view.dart';

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
      backgroundColor: const Color(0xFFF5F3F8),

      // 🟣 APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A1B9A),
        title: const Text(
          'My Notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthViewModel>().logout(context);
            },
          ),
        ],
      ),

      // 📄 BODY
      body: noteVM.isLoading
          ? const Center(child: CircularProgressIndicator())
          : noteVM.notes.isEmpty
          ? _emptyState()
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: noteVM.notes.length,
        itemBuilder: (context, index) {
          final note = noteVM.notes[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NoteDetailView(note: note),
                ),
              );
            },
            onLongPress: () {
              _showOptions(context, note);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 📄 CONTENT PREVIEW
                  Text(
                    note.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // ➕ FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6A1B9A),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateNoteView(),
            ),
          );
        },
      ),
    );
  }

  // 🟣 EMPTY STATE
  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_alt_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text(
            'No notes yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap + to create your first note',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ⚙️ OPTIONS SHEET
  void _showOptions(BuildContext context, note) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditNoteView(note: note),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  context.read<NoteViewModel>().deleteNote(note.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
