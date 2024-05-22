import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('hadith_db.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, fileName);

   
    if (!(await databaseExists(path))) {
 
      ByteData data = await rootBundle.load(join('assets', fileName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }

    return await openDatabase(path);
  }

  Future<List<Map<String, dynamic>>> getHadiths() async {
    final db = await instance.database;
    return await db.query('hadith');
  }

  Future<List<Map<String, dynamic>>> getBooks() async {
    final db = await instance.database;
    return await db.query('books');
  }

  Future<List<Map<String, dynamic>>> getSections() async {
    final db = await instance.database;
    return await db.query('section');
  }
}
