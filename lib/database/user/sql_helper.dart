import 'package:sqflite/sqflite.dart' as sql;
import 'dart:typed_data';

import 'package:ugd2_c_kelompok6/models/kelompok.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username TEXT,
        password TEXT,
        email TEXT,
        notelp TEXT,
        date TEXT,
        gambar BLOB
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
      String notelp, String date, Uint8List foto) async {
    final db = await SQLHelper.db();
    final data = {
      'username': username,
      'password': password,
      'email': email,
      'notelp': notelp,
      'date': date,
      'gambar': foto
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

  static Future<bool> isUsernameExists(String username) async {
    final db = await SQLHelper.db();
    final count = sql.Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM user WHERE username = ?',
      [username],
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

  static Future<Map<String, dynamic>> getUserById(int id) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> result = await db.query(
      'user',
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.isNotEmpty ? result[0] : {};
  }

  static Future<int> editUser(int id, String username, String password,
      String email, String notelp, String date, Uint8List gambar) async {
    final db = await SQLHelper.db();
    final data = {
      'username': username,
      'password': password,
      'email': email,
      'notelp': notelp,
      'date': date,
      'gambar': gambar
    };

    return await db.update('user', data, where: "id = $id");
  }

  static Future<int> editById(int id, String username, String password,
      String email, String notelp, Uint8List gambar) async {
    final db = await SQLHelper.db();
    final data = {
      'username': username,
      'password': password,
      'email': email,
      'notelp': notelp,
      'gambar': gambar
    };
    return await db.update('user', data, where: "id = ?", whereArgs: [id]);
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

  static Future<Orang> convertToOrang(Map<String, dynamic> data) async {
    final id = data['id'];
    final username = data['username'] as String;
    final email = data['email'] as String;
    final password = data['password'] as String;
    final notelp = data['notelp'] as String;
    final date = data['date'] as String;
    final Uint8List gambar = data['gambar'] as Uint8List;

    return Orang(
      id: id,
      username: username,
      email: email,
      password: password,
      noTelp: notelp,
      date: date,
      gambar: gambar,
    );
  }
}
