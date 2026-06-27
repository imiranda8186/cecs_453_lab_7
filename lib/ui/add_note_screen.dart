//For adding or editing a note
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:isaiah_miranda_lab_7_sql_singleton_repository_mvvm_getit/data/note_model.dart';
import 'package:isaiah_miranda_lab_7_sql_singleton_repository_mvvm_getit/providers/note_provider.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;

  const AddNoteScreen({
    super.key,
    this.note,
  });

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  //Defining the key and controllers for the input fields
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  //Change values of titles and text fields based on whether there was a Note passed in or not
  @override
  void initState() {
    super.initState();

    String startingTitle;
    String startingDesc;

    if (widget.note !=null){
      startingTitle = widget.note!.title;
      startingDesc = widget.note!.description;
    }else{
      startingTitle = '';
      startingDesc = '';
    }
    _titleController = TextEditingController(text: startingTitle);
    _descriptionController  = TextEditingController(text: startingDesc);
  }

  //Dispose the controllers when done with them
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  //Taken from sample, added the createdAt for the note. 
  //Still calls addNote or updateNote based on if a Note was passed in or not. 
  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final note = Note(
        id: widget.note?.id,
        title: _titleController.text,
        description: _descriptionController.text,
        createdAt: DateTime.now()
      );

      final provider = Provider.of<NoteProvider>(context, listen: false);
      if (widget.note == null){
        provider.addNote(note);
      }else{
        provider.updateNote(note);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    //if the note exists, means it's editing. 
    final isEditing = widget.note!= null;
    String screenTitle = 'Add note';
    String buttonTitle = 'Add note';
    if (isEditing == true){
      screenTitle = 'Edit note';
      buttonTitle = 'Edit note';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(screenTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),

        //Creating the form for the two text fields, title and description
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value){
                  if (value == null || value.isEmpty){
                    return 'Enter a title for the note';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description'
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a description for the note';
                  }
                  return null;
                }
              ),

              SizedBox(height: 30),

              //Calls the _saveNote when pressed, updates or adds the note based on if Note was passed in or not. 
              ElevatedButton(
                onPressed: _saveNote,
                child: Text(buttonTitle),
              )
            ]
          )
        )
      )
    );
  }


}


