import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_prescon/models/note.dart';
import 'package:note_prescon/pages/notes/detail/notesdetail.pres.dart';
import 'package:note_prescon/state/notestate.dart';

class NotesDetailContainer extends HookConsumerWidget {
  final Note note;

  const NotesDetailContainer(this.note, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteState = ref.watch(noteStateProvider);
    final title = useState(note.title);
    final content = useState(note.content);
    final titleController = useTextEditingController(text: title.value);
    final contentController = useTextEditingController(text: content.value);

    void handleTitleChange(String input) => title.value = input;
    void handleContentChange(String input) => content.value = input;
    void handleSave() async {
      await noteState.saveNote(
        Note(
            title: title.value,
            content: content.value,
            id: note.id,
            updatedAt: DateTime.now(),
            createdAt: note.createdAt),
      );
      Navigator.of(context).pop();
    }

    return NotesDetailPresentation(
      titleController: titleController,
      contentController: contentController,
      onTitleChange: handleTitleChange,
      onContentChange: handleContentChange,
      onSave: handleSave,
    );
  }
}
