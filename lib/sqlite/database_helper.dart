import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final String dbName = 'contacts.sqlite';

  static Future<Database> databaseConnection() async {
    String dbPath = join(await getDatabasesPath(), dbName);

    if (await databaseExists(dbPath)) {
      print('The database already exists, no need to copy it');
    } else {
      // İlk yüklemede çalışır ve sadece uygulama silinirse tekrar çalışır.
      ByteData data = await rootBundle.load('database/$dbName');
      List<int> bytes =
          data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes, flush: true);
      print('Database copied');
    }

    return openDatabase(dbPath);
  }
}
