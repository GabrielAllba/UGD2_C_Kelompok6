import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE pemesanan(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        id_user INTEGER,
        tipe_kamar TEXT,
        harga_dasar INTEGER,
        harga INTEGER,
        tanggal_checkin TEXT, 
        tanggal_checkout TEXT, 
        qr_code TEXT
      ) 
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('pemesanan.db', version: 2,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> addPemesanan(
      int id_user,
      String tipe_kamar,
      int harga,
      int harga_dasar,
      String tanggal_checkin,
      String tanggal_checkout,
      String qr_code) async {
    final db = await SQLHelper.db();
    final data = {
      'id_user': id_user,
      'tipe_kamar': tipe_kamar,
      'harga': harga,
      'harga_dasar': harga_dasar,
      'tanggal_checkin': tanggal_checkin,
      'tanggal_checkout': tanggal_checkout,
      'qr_code': qr_code,
    };
    return await db.insert('pemesanan', data);
  }

  static Future<List<Map<String, dynamic>>> getPemesanan() async {
    final db = await SQLHelper.db();
    return db.query('pemesanan');
  }

  static Future<List<Map<String, dynamic>>> getPemesananById(int id) async {
    final db = await SQLHelper.db();
    return db.query('pemesanan', where: 'id_ = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getPemesananByQuery(
      String query, int id_user) async {
    final db = await SQLHelper.db();
    final queryResult = await db.query('pemesanan',
        where: 'id_user = ? AND tipe_kamar LIKE ?',
        whereArgs: [id_user, '%$query%']);
    return queryResult;
  }

  static Future<void> getDataAndPrint() async {
    List<Map<String, dynamic>> pemesananData = await getPemesanan();
    print('555555');
    for (Map<String, dynamic> data in pemesananData) {
      print('66666');
      int id = data['id'];
      int idUser = data['id_user'];
      String tipeKamar = data['tipe_kamar'];
      int price = data['harga'];
      String checkin = data['tanggal_checkin'];
      String checkout = data['tanggal_checkout'];
      print('77777777');

      print('ID: $id');
      print('User ID: $idUser');
      print('Tipe Kamar: $tipeKamar');
      print('Price: $price');
      print('Checkin: $checkin');
      print('Checkout: $checkout');
    }
  }

  static Future<List<Map<String, dynamic>>> getPemesananViaUser(
      int id_user) async {
    final db = await SQLHelper.db();
    return db.query('pemesanan', where: 'id_user = ?', whereArgs: [id_user]);
  }

  static Future<int> getTotalPemesananViaUser(int idUser) async {
    final db = await SQLHelper.db();
    final result = await db.rawQuery(
      'SELECT COUNT(*) AS total FROM pemesanan WHERE id_user = ?',
      [idUser],
    );

    if (result.isNotEmpty) {
      final total = result.first['total'];
      return total as int;
    } else {
      return 0;
    }
  }

  static Future<int> editPemesanan(
      int id,
      String tipe_kamar,
      int harga,
      int harga_dasar,
      String tanggal_checkin,
      String tanggal_checkout,
      String qr_code) async {
    final db = await SQLHelper.db();

    Duration difference = DateTime.parse(tanggal_checkout)
        .difference(DateTime.parse(tanggal_checkin));
    int selisih = difference.inDays;
    int price = selisih * harga_dasar;
    print(selisih);
    print(harga_dasar);
    final data = {
      'tipe_kamar': tipe_kamar,
      'harga': price,
      'harga_dasar': harga_dasar,
      'tanggal_checkin': tanggal_checkin,
      'tanggal_checkout': tanggal_checkout,
      'qr_code': qr_code,
    };

    return await db.update('pemesanan', data, where: "id = $id");
  }

  static Future<int> editPemesananWithId(
      int id, String tanggal_checkin, String tanggal_checkout) async {
    final db = await SQLHelper.db();
    final data = {
      'tanggal_checkin': tanggal_checkin,
      'tanggal_checkout': tanggal_checkout
    };

    return await db.update('pemesanan', data, where: "id = $id");
  }

  static Future<int> deletePemesanan(int id) async {
    final db = await SQLHelper.db();
    return db.delete('pemesanan', where: "id = $id");
  }

  static Future<bool> isQRCodeExistsForUser(String parameter) async {
    final pemesananData = await SQLHelper.getPemesanan();
    for (Map<String, dynamic> data in pemesananData) {
      final qrCode = data['qr_code'];
      if (qrCode == parameter) {
        return true;
      }
    }
    return false;
  }
}
