import 'package:flutter/widgets.dart';

class MyListView<T> extends StatelessWidget{
  final List<T> list;
  const MyListView({
    super.key,
    required this.list
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Center(
            child: Text(
              "${index + 1}: $item",
              style: const TextStyle(fontSize: 18),
            )
        );
      },
    );
  }

}