import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/note_viewmodel.dart';
import '../auth/login_view.dart';
import 'create_note_view.dart';
import 'edit_note_view.dart';
import 'note_detail_view.dart';

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

      // 🔝 APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A1B9A),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Notes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              print('🔴 Logout tapped');

              final authVM = context.read<AuthViewModel>();
              final noteVM = context.read<NoteViewModel>();

              await authVM.logout();
              noteVM.clearNotes();

              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginView()),
                      (route) => false,
                );
              }
            },
          ),
        ],
      ),

      // ➕ FLOATING BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6A1B9A),
        onPressed: () {
          print('🟡 Navigate to CreateNoteView');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateNoteView()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      // 📄 BODY
      body: noteVM.isLoading
          ? const Center(child: CircularProgressIndicator())
          : noteVM.notes.isEmpty
          ? const Center(
        child: Text(
          'No notes found',
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: noteVM.notes.length,
        itemBuilder: (context, index) {
          final note = noteVM.notes[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 14),
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2E2E2E),
                  ),
                ),

                const SizedBox(height: 8),

                // 📄 CONTENT PREVIEW
                Text(
                  note.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 12),

                // 🔧 ACTION ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 👉 VIEW DETAIL
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                NoteDetailView(note: note),
                          ),
                        );
                      },
                      child: const Text(
                        'View',
                        style: TextStyle(
                          color: Color(0xFF6A1B9A),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // 👉 EDIT / DELETE
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Color(0xFF6A1B9A),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    EditNoteView(note: note),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            context
                                .read<NoteViewModel>()
                                .deleteNote(note.id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
