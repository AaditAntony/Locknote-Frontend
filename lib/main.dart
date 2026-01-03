import 'package:flutter/material.dart';

void main() {
  runApp(const LockNoteApp());
}

class LockNoteApp extends StatelessWidget {
  const LockNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            'LockNote App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
