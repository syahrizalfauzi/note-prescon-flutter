import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_prescon/models/note.dart';
import 'package:note_prescon/pages/notes/list/noteslist.pres.dart';
import 'package:note_prescon/state/notestate.dart';

class NotesListContainer extends HookConsumerWidget {
  const NotesListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteState = ref.watch(noteStateProvider);
    final isLoading = useState(true);

    useEffect(() {
      void initNoteState() async {
        await noteState.init();
        isLoading.value = false;
      }

      initNoteState();
    }, []);

    void handleNoteTap(Note note) {
      Navigator.of(context).pushNamed('/detail', arguments: note);
    }

    void handleNoteLongPress(Note note) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Delete Note?"),
              content: Text("Are you sure you want to delete '${note.title}'?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child:
                      const Text('Cancel', style: TextStyle(color: Colors.red)),
                ),
                TextButton(
                  onPressed: () async {
                    await noteState.deleteNote(note);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          });
    }

    if (isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    return NotesListPresentation(
      notes: noteState.notes,
      onNoteTap: handleNoteTap,
      onNoteLongPress: handleNoteLongPress,
    );
  }
}
