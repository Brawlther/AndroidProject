import 'package:flutter/material.dart';

class ItemDetail<T> extends StatelessWidget{
  final T item;
  final VoidCallback callback1;
  final VoidCallback callback2;

  const ItemDetail({
    super.key,
    required this.item,
    required this.callback1,
    required this.callback2
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text(style: const TextStyle(fontSize: 18),this.item.toString()),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              minimumSize: const Size.fromHeight(60),
              foregroundColor: Colors.blue,
            ),
            onPressed: callback1,
            child: const Text("Delete"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              minimumSize: const Size.fromHeight(60),
              foregroundColor: Colors.blue,
            ),
            onPressed: callback2,
            child: const Text("Close"),
          )
        ]
    );
  }

}