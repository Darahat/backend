// main.dart
import 'package:flutter/material.dart';
import 'model/note.dart';
import 'package:backend_app/services/noteControllers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NoteListScreen(),
    );
  }
}

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<Note> notes = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int? selectedNoteId;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  void refreshNotes() async {
    List<Note>? fetchedNotes = await NoteRepository.getAllNote();
    setState(() {
      notes = fetchedNotes ?? [];
    });
  }

  void _showEditDialog(Note note) {
    titleController.text = note.title;
    descriptionController.text = note.description;
    selectedNoteId = note.id;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Note editedNote = Note(
                  id: selectedNoteId,
                  title: titleController.text,
                  description: descriptionController.text,
                );
                await NoteRepository.updateNote(editedNote);
                Navigator.pop(context);
                refreshNotes();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Note newNote = Note(
                title: titleController.text,
                description: descriptionController.text,
              );
              await NoteRepository.addNote(newNote);
              titleController.clear();
              descriptionController.clear();
              refreshNotes();
            },
            child: Text('Add Note (${notes.length})'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                print(notes[index].id);
                return ListTile(
                  title: Text(notes[index].title),
                  subtitle: Text(notes[index].description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditDialog(notes[index]);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await NoteRepository.deleteNote(notes[index]);
                          refreshNotes();
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    // Handle tapping on a note (if needed)
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class $ {}
