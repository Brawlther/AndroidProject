import 'package:floor/floor.dart';

@entity
class ToDoItem {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  String name;

  // Constructor
  ToDoItem(this.id, this.name);

  @override
  String toString(){
    return name;
  }
}