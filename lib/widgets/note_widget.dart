import 'package:backend_app/model/note.dart';
import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  const NoteWidget(
      {Key? key,
      required this.note,
      required this.onTap,
      required this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    if (note != null) {
      titleController.text = note!.title;
      descriptionController.text = note!.description;
    }
    return Scaffold(
        appBar: AppBar(
          // ignore: unnecessary_null_comparison
          title: Text(note == null ? 'Add a note' : 'Edit note'),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Column(
              children: [
                const Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 40),
                          child: Center(
                              child: Text('What are you thinking about?')),
                        )
                      ],
                    ))
              ],
            )));
  }
}
