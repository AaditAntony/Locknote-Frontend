import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/note_viewmodel.dart';
import 'views/auth/login_view.dart';

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LockNote',
        theme: AppTheme.lightTheme,
        home: const LoginView(),
      ),
    );
  }
}
