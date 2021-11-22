import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_prescon/models/note.dart';
import 'package:note_prescon/pages/notes/detail/notesdetail.con.dart';
import 'package:note_prescon/pages/notes/list/noteslist.con.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Notes',
        onGenerateRoute: (route) {
          switch (route.name) {
            case '/':
              return MaterialPageRoute(
                builder: (context) => const NotesListContainer(),
              );
            case '/detail':
              return MaterialPageRoute(
                builder: (context) => NotesDetailContainer(
                  route.arguments as Note,
                ),
              );
          }
        },
      ),
    );
  }
}
