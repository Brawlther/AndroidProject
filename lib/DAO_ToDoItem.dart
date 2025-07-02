import 'package:floor/floor.dart';
import 'ToDoItem.dart';

@dao
abstract class DAO_ToDoItem {
  @Query('SELECT * FROM ToDoItem')
  Future<List<ToDoItem>> findAllItems();

  @insert
  Future<void> insertItem(ToDoItem item);

  @delete
  Future<void> deleteItem(ToDoItem item);
}