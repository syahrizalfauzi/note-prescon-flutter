import 'package:flutter/material.dart';

class NotesDetailPresentation extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;
  final Function(String) onTitleChange;
  final Function(String) onContentChange;
  final Function() onSave;

  const NotesDetailPresentation({
    Key? key,
    required this.titleController,
    required this.contentController,
    required this.onTitleChange,
    required this.onContentChange,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
        actions: [IconButton(onPressed: onSave, icon: const Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
              onChanged: onTitleChange,
              maxLines: 1,
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                decoration:
                    const InputDecoration(labelText: "Put your notes here..."),
                onChanged: onContentChange,
                maxLines: null,
                expands: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
