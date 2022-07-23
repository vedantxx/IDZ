import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'database.dart';

class MyDatabaseHelper {
  MyDatabaseHelper ._privateConstructor();
  static final MyDatabaseHelper instance = MyDatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,'idz.db');
    return await openDatabase(path,version: 1,onCreate: _onCreate);
  }

  Future _onCreate(Database db,int version) async {
    await db.execute('CREATE TABLE IDZ(id INTEGER PRIMARY KEY, name TEXT, password TEXT)');
  }

  Future<List<MyDatabase>> getDatabase() async {
    Database db = await instance.database;
    var entries = await db.query('IDZ',orderBy: 'name');
    List<MyDatabase> entryList = entries.isNotEmpty
        ? entries.map((e) => MyDatabase.fromMap(e)).toList()
        : [];
    return entryList;
  }

  Future<int> add(MyDatabase myDatabase) async {
    Database db = await instance.database;
    return await db.insert('IDZ', myDatabase.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('IDZ', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(MyDatabase myDatabase) async {
    Database db = await instance.database;
    return await db.update('IDZ', myDatabase.toMap(), where: 'id = ?', whereArgs: [myDatabase.id]);
  }

}