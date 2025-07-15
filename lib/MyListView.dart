import 'package:flutter/widgets.dart';
import 'package:my_cst2335_labs/ToDoItem.dart';

class MyListView<T extends ToDoItem> extends StatelessWidget {
  final List<T> list;
  final void Function(T item) onTap;

  const MyListView({
    super.key,
    required this.list,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Center(
          child: GestureDetector(
            onTap: () => onTap(item),
            child: Text(
              item.toItemName(),
              style: const TextStyle(fontSize: 18)
            ),
          ),
        );
      },
    );
  }
}
