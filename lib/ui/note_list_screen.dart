//Displays the list of notes
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:isaiah_miranda_lab_7_sql_singleton_repository_mvvm_getit/ui/add_note_screen.dart';
import 'package:isaiah_miranda_lab_7_sql_singleton_repository_mvvm_getit/providers/note_provider.dart';


//Mostly taken from the sample code, only minor changes like adding buttons and editing properties. 
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
                    //Display ID, Title, Description, and Date it was created (or updated). 
                    title: Text('${note.id} \n${note.title}'),
                    subtitle: Text('${note.description} \nCreated: ${note.createdAt}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      //The two buttons, one edits the selected note and the other deletes it.
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            //Passes in the note to the next screen so that it knows that
                            //The note is not null, so it becomes edit mode
                            Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AddNoteScreen(note: note)
                      ));
                          }
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Provider.of<NoteProvider>(context, listen: false).deleteNote(note.id!);
                          }
                        )
                      ]
                    ),
                    //Changed onTap to null so that tapping the list doesn't do anything, must tap one of the buttons. 
                    onTap: () {
                      null;
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