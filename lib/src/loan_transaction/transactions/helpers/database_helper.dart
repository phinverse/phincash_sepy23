import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'my_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE contacts (
            id INTEGER PRIMARY KEY,
            name TEXT,
            phone_number TEXT,
            is_uploaded INTEGER
          )
        ''');
      },
    );
  }

  Future<void> markContactsAsUploaded() async {
    final db = await database;
    await db.update(
      'contacts',
      {'is_uploaded': 1},
      where: 'is_uploaded = 0',
    );
  }

  // Other database operations can be added here if needed

  Future<void> close() async {
    final db = await database;
    db.close();
  }

  Future<bool> areContactsUploaded() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM contacts WHERE is_uploaded = 0');
    return result.isNotEmpty && Sqflite.firstIntValue(result) == 0;
  }
}
