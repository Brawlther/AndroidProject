import 'package:flutter/material.dart';
import 'ToDoItem.dart';
import 'MyListView.dart';

class ListPage extends StatelessWidget {
  final List<ToDoItem> items;
  final void Function(ToDoItem item) onSelectItem;

  const ListPage({
    super.key,
    required this.items,
    required this.onSelectItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            'Item List',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: MyListView<ToDoItem>(
            list: items,
            onTap: (item) => onSelectItem(item),
          ),
        ),
      ],
    );
  }
}