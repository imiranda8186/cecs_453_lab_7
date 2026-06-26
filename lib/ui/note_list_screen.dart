//Displays the list of notes
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:isaiah_miranda_lab_7_sql_singleton_repository_mvvm_getit/ui/add_note_screen.dart';
import 'package:isaiah_miranda_lab_7_sql_singleton_repository_mvvm_getit/providers/note_provider.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Consumer<NoteProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.notes.isEmpty) {
            return const Center(
              child: Text('No notes yet. Tap + to add one!'),
            );
          } else {
            return ListView.builder(
              itemCount: provider.notes.length,
              itemBuilder: (context, index) {
                final note = provider.notes[index];
                return Card(
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text('${note.description} \nCreated: ${note.createdAt}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Provider.of<NoteProvider>(context, listen:false).deleteNote(note.id!);
                      }
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => AddNoteScreen(note: note)
                      ));
                    }
                  )
                );
              }
            );
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), 
        onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );
        }
      ),
    );
  }
}