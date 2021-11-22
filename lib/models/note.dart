import 'dart:convert';

class Note {
  final String title;
  final String content;
  final String id;
  final DateTime updatedAt;
  final DateTime createdAt;

  const Note({
    required this.title,
    required this.content,
    required this.id,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Note.empty() => Note(
        content: "",
        title: "",
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'id': id,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'] as String,
      content: map['content'] as String,
      id: map['id'] as String,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) {
    return Note.fromMap(json.decode(source));
  }
}
