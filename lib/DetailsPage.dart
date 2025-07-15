import 'package:flutter/material.dart';
import 'ToDoItem.dart';
import 'ItemDetail.dart';

class DetailsPage extends StatelessWidget {
  final ToDoItem? selectedItem;
  final VoidCallback onDelete;
  final VoidCallback onClose;

  const DetailsPage({
    super.key,
    required this.selectedItem,
    required this.onDelete,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            'Select Item Detail',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        selectedItem == null ?
        const Center(child: Text("No item selected"))
            :
        ItemDetail(
          item: selectedItem!,
          callback1: onDelete,
          callback2: onClose,
        )
      ],
    );
  }
}