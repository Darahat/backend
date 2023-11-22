import 'package:flutter/material.dart';
import 'package:backend_app/model/note.dart';

class NoteList extends StatefulWidget {
  final List<Note> notes;

  NoteList({required this.notes});

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note List'),
      ),
      body: ListView.builder(
        itemCount: widget.notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.notes[index].title),
            subtitle: Text(widget.notes[index].description),
          );
        },
      ),
    );
  }
}
