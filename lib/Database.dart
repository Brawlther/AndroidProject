import 'package:floor/floor.dart';
import 'dart:async';
import 'ToDoItem.dart';
import 'DAO_ToDoItem.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'Database.g.dart'; // This is correct

@Database(version: 1, entities: [ToDoItem])
abstract class AppDatabase extends FloorDatabase {
  DAO_ToDoItem get itemDao;
}