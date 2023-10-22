import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username TEXT,
        password TEXT,
        email TEXT,
        notelp TEXT,
        date TEXT
      ) 
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('user.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> addUser(String username, String password, String email,
      String notelp, String date) async {
    final db = await SQLHelper.db();
    final data = {
      'username': username,
      'password': password,
      'email': email,
      'notelp': notelp,
      'date': date
    };
    return await db.insert('user', data);
  }

  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await SQLHelper.db();
    return db.query('user');
  }

  static Future<bool> isEmailExists(String email) async {
    final db = await SQLHelper.db();
    final count = sql.Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM user WHERE email = ?',
      [email],
    ));

    if (count == 0) {
      return false;
    }
    return true;
  }

  static Future<List<Map<String, dynamic>>> getViaUser(String username) async {
    final db = await SQLHelper.db();
    return db.query('user', where: 'username = ?', whereArgs: [username]);
  }

  static Future<int> editUser(int id, String username, String password,
      String email, String notelp, String date) async {
    final db = await SQLHelper.db();
    final data = {
      'username': username,
      'password': password,
      'email': email,
      'notelp': notelp,
      'date': date
    };

    return await db.update('user', data, where: "id = $id");
  }

  static Future<int> editUserByUserName(
      String username, String password, String email, String notelp) async {
    final db = await SQLHelper.db();
    final data = {
      'username': username,
      'password': password,
      'email': email,
      'notelp': notelp,
    };
    return await db
        .update('user', data, where: "username = ?", whereArgs: [username]);
  }

  static Future<int> deleteUser(int id) async {
    final db = await SQLHelper.db();
    return db.delete('user', where: "id = $id");
  }

  static Future<Map<String, dynamic>> getUserByUsername(String username) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> result = await db.query(
      'user',
      where: 'username = ?',
      whereArgs: [username],
    );
    return result.isNotEmpty ? result[0] : {};
  }
}
