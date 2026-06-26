import 'package:flutter/material.dart';
import 'package:isaiah_miranda_lab_7_sql_singleton_repository_mvvm_getit/di/service_locator.dart';
import 'package:isaiah_miranda_lab_7_sql_singleton_repository_mvvm_getit/providers/note_provider.dart';
import 'package:isaiah_miranda_lab_7_sql_singleton_repository_mvvm_getit/ui/note_list_screen.dart';
import 'package:provider/provider.dart';


void main() {
  setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteProvider()..fetchNotes(),
      child: MaterialApp(
        title: 'SQFlite Note Saver',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.dark().copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: ThemeMode.system,
        home: const NoteListScreen(),
      )
      
    );
  }
}
