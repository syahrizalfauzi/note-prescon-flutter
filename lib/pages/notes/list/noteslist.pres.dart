import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:note_prescon/models/note.dart';

class NotesListPresentation extends StatelessWidget {
  final List<Note> notes;
  final Function(Note) onNoteTap;
  final Function(Note) onNoteLongPress;

  const NotesListPresentation({
    Key? key,
    required this.notes,
    required this.onNoteTap,
    required this.onNoteLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Notes')),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => onNoteTap(Note.empty()),
        ),
        body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return ListTile(
              title: Text(note.title),
              onTap: () => onNoteTap(note),
              onLongPress: () => onNoteLongPress(note),
              subtitle: Text(
                note.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(DateFormat.Hm().format(note.updatedAt)),
                  Text(DateFormat.MMMEd().format(note.updatedAt)),
                ],
              ),
            );
          },
        ));
  }
}
