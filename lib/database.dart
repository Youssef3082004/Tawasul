import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;
  

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'notes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        date TEXT NOT NULL,
        time TEXT NOT NULL,
        contentState TEXT NOT NULL
      )
    ''');
  }

  // Insert a new note
  Future<int> insertNote(Map<String, dynamic> note) async {
    final db = await database;
    return await db.insert('notes', note);
  }

  // Get all notes
  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await database;
    return await db.query('notes');
  }

  // Update a note
  Future<int> updateNote(int id, Map<String, dynamic> note) async {
    final db = await database;
    return await db.update('notes', note, where: 'id = ?', whereArgs: [id]);
  }

  // Delete a note
  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteNotes() async {
    final db = await database;
    return await db.delete('notes');
  }

  Future<List<Map<String, dynamic>>> getNotesByCategory(List<String> categories) async {
    final db = await database;
    final placeholders = List.filled(categories.length, '?').join(', '); 
    return await db.query('notes',where: 'contentState IN ($placeholders)',whereArgs: categories,);
  }




  Future<int> getLastNoteId() async {
    final db = await database; // Make sure this opens your DB instance
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT id FROM notes ORDER BY id DESC LIMIT 1',
    );
    if (result.isNotEmpty) {
      return result.first['id'] as int;
    } else {
      return -1; 
    }
  }


  Future<void> resetDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'notes.db');
    await deleteDatabase(path);
    print("Database deleted. It will be recreated on next access.");
  }


  Future<Map<String, List<String>>> getEmotionsGroupedByDate(List<String> dates) async {
    if (dates.isEmpty) return {};

    final db = await database;
    final placeholders = List.filled(dates.length, '?').join(', '); 
    final List<Map<String, dynamic>> result = await db.query('notes',columns: ['date', 'contentState'],where: 'date IN ($placeholders)',whereArgs: dates,);

    Map<String, List<String>> groupedEmotions = {};
    for (var row in result) {
      String date = row['date'] as String;
      String emotion = row['contentState'] as String;
      if (groupedEmotions.containsKey(date)) {
        groupedEmotions[date]!.add(emotion);
      } else {
        groupedEmotions[date] = [emotion];
      }
    }

    return groupedEmotions;
  }

}




