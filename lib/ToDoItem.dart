import 'package:floor/floor.dart';

@entity
class ToDoItem {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  String name;
  int quantity;

  // Constructor
  ToDoItem(this.id, this.name, this.quantity);

  @override
  String toString(){
    return name;
  }
}