import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localstorage/localstorage.dart';
import 'package:note_prescon/models/note.dart';

final noteStateProvider = ChangeNotifierProvider((_) => NoteState());

class NoteState extends ChangeNotifier {
  final storage = LocalStorage('notes');
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> init() async {
    if (!(await storage.ready)) return Future.error("Storage is not ready");

    try {
      _notes = (await storage.getItem('notes') as List)
          .map<String>((e) => e.toString())
          .map<Note>((e) {
        final n = Note.fromJson(e.toString());
        return n;
      }).toList();
    } catch (e) {
      _notes = [];
    }
    _sortNotes();
    notifyListeners();
  }

  Future<void> saveNote(Note note) async {
    if (!(await storage.ready)) return Future.error("Storage is not ready");

    final storageNotes = await _getStorageNotes();

    storageNotes.update(note.id, (value) => note, ifAbsent: () => note);
    final index = _notes.indexWhere((element) => element.id == note.id);
    if (index == -1) {
      _notes.add(note);
    } else {
      _notes[index] = note;
    }
    _sortNotes();

    final notesToSave =
        storageNotes.entries.map((e) => e.value.toJson()).toList();

    await storage.setItem('notes', notesToSave);
    notifyListeners();
  }

  Future<void> deleteNote(Note note) async {
    if (!(await storage.ready)) return Future.error("Storage is not ready");

    final storageNotes = await _getStorageNotes();

    storageNotes.removeWhere((key, _) => key == note.id);
    _notes.removeWhere((element) => element.id == note.id);
    _sortNotes();

    final notesToSave =
        storageNotes.entries.map((e) => e.value.toJson()).toList();

    await storage.setItem('notes', notesToSave);
    notifyListeners();
  }

  void _sortNotes() =>
      _notes.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
  Future<Map<String, Note>> _getStorageNotes() async {
    try {
      return Map.fromEntries(
        (await storage.getItem('notes') as List)
            .map<String>((e) => e.toString())
            .map<MapEntry<String, Note>>(
          (e) {
            Note n = Note.fromJson(e);
            return MapEntry(n.id, n);
          },
        ),
      );
    } catch (e) {
      return {};
    }
  }
}
