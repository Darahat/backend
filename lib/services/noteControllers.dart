import 'package:backend_app/model/note.dart';
import 'package:backend_app/services/databaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class NoteRepository {
  static Future<int> addNote(Note note) async {
    final db = await DatabaseHelper.getDB();
    return await db.insert("Note", note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(Note note) async {
    final db = await DatabaseHelper.getDB();
    return await db.update("Note", note.toJson(),
        where: 'id = ?',
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteNote(Note note) async {
    final db = await DatabaseHelper.getDB();
    return await db.delete("Note", where: 'id = ?', whereArgs: [note.id]);
  }

  static Future<List<Note>?> getAllNote() async {
    final db = await DatabaseHelper.getDB();
    final List<Map<String, dynamic>> maps = await db.query("Note");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Note.fromJson(maps[index]));
  }
}
