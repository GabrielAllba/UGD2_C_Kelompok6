import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE search_history(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        id_user INTEGER,
        query TEXT 
      ) 
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('search_history.db', version: 2,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> addSearchHistory(int id_user, String query) async {
    final db = await SQLHelper.db();
    final data = {'id_user': id_user, 'query': query};

    return await db.insert('search_history', data);
  }

  static Future<List<Map<String, dynamic>>> getSearchHistoryByUser(
      int id_user, String query) async {
    final db = await SQLHelper.db();
    final queryResult = await db.query('search_history',
        where: 'id_user = ? AND query LIKE ?',
        whereArgs: [id_user, '%$query%']);
    return queryResult;
  }

  static Future<int> deleteSearchHistory(int id) async {
    final db = await SQLHelper.db();
    return db.delete('search_history', where: "id = $id");
  }

  static Future<bool> isSame(int id_user, String query) async {
    final db = await SQLHelper.db();
    final queryResult = await db.query('search_history',
        where: 'id_user = ? AND query = ?', whereArgs: [id_user, query]);

    return queryResult.isNotEmpty;
  }
}
