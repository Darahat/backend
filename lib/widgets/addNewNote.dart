import 'package:flutter/material.dart';
import 'package:backend_app/model/note.dart';

class AddNewNote extends StatefulWidget {
  final Function(Note) onNoteAdded;

  AddNewNote({required this.onNoteAdded});

  @override
  _AddNewNoteState createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Note'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Create a new Note instance using the provided data.
                Note newNote = Note(
                  title: titleController.text,
                  description: descriptionController.text,
                );
                // Callback to notify the parent about the new note.
                widget.onNoteAdded(newNote);
                // Clear text fields after adding a new note.
                titleController.clear();
                descriptionController.clear();
              },
              child: Text('Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}
