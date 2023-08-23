import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      path.join(dbPath, 'saved.db'),
      version: 1,
      onCreate: (db, version) => db.execute(
          'CREATE TABLE items(id TEXT PRIMARY KEY, name TEXT, title TEXT, story TEXT, script TEXT, lesson TEXT, audioUrl TEXT, imageUrl TEXT, tag TEXT, episode INTEGER)'),
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DbHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbHelper.database();
    return db.query(table);
  }

  static Future<void> deleteItemFromDb(String id, String table) async {
    final db = await DbHelper.database();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> findById(
      String id, String table) async {
    final db = await DbHelper.database();
    return await db.query(table, where: 'id = ?', whereArgs: [id]);
  }
}
