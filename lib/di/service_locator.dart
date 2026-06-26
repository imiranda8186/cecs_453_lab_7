//Dependency injection setup
import 'package:get_it/get_it.dart';
import 'package:isaiah_miranda_lab_7_sql_singleton_repository_mvvm_getit/repository/note_repository.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => NoteRepository());
}
