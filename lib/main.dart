import 'package:flutter/material.dart';
import 'package:locknote/views/auth/login_view.dart';
import 'package:provider/provider.dart';

import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/note_viewmodel.dart';

void main() {
  runApp(const LockNoteApp());
}

class LockNoteApp extends StatelessWidget {
  const LockNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => NoteViewModel()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  LoginView(),

    ),
    );
  }
}
