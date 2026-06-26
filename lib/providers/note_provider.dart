//Manages the app's state and business logic
import 'package:flutter/material.dart';
import 'package:isaiah_miranda_lab_7_sql_singleton_repository_mvvm_getit/repository/note_repository.dart';
import 'package:isaiah_miranda_lab_7_sql_singleton_repository_mvvm_getit/data/note_model.dart';
import 'package:isaiah_miranda_lab_7_sql_singleton_repository_mvvm_getit/di/service_locator.dart';

class NoteProvider extends ChangeNotifier {
  final NoteRepository _repository = getIt<NoteRepository>();
  List<Note> _notes = [];
  bool _isLoading = false;

  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;

  Future<void> fetchNotes()async {
    _isLoading = true;
    notifyListeners();
    _notes = await _repository.getNotes();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addNote(Note note) async{
    await _repository.insertNote(note);
    await fetchNotes();
  }

  Future<void> updateNote(Note note) async{
    await _repository.updateNote(note);
    await fetchNotes();
  }

  Future<void> deleteNote(int id) async {
    await _repository.deleteNote(id);
    await fetchNotes();
  }
}