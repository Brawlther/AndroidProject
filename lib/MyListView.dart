import 'package:flutter/widgets.dart';

class MyListView<T> extends StatelessWidget{
  final List<T> list;
  final void Function(int index) onLongPressItem;

  const MyListView({
    super.key,
    required this.list,
    required this.onLongPressItem
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Center(
            child: GestureDetector(
              onLongPress: () => {onLongPressItem(index)},
              child: Text(
                "${index + 1}: $item",
                style: const TextStyle(fontSize: 18),
              ),
            )
        );
      },
    );
  }
}