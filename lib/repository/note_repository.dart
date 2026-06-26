//Abstracts the data source
import 'package:isaiah_miranda_lab_7_sql_singleton_repository_mvvm_getit/data/note_model.dart';
import 'package:isaiah_miranda_lab_7_sql_singleton_repository_mvvm_getit/data/db_helper.dart';

class NoteRepository{
  final DBHelper _dbHelper = DBHelper();

  Future<List<Note>> getNotes() => _dbHelper.getNotes();
  Future<int> insertNote(Note note) => _dbHelper.insertNote(note);
  Future<int> updateNote(Note note) => _dbHelper.updateNote(note);
  Future<int> deleteNote(int id) => _dbHelper.deleteNote(id);
}
