import 'package:flutter/material.dart';

class InputItemColumn extends StatelessWidget{
  final TextEditingController controller_01;
  final TextEditingController controller_02;
  final VoidCallback callback;

  const InputItemColumn({
    super.key,
    required this.controller_01,
    required this.controller_02,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // makes children expand horizontally
      children: [
        TextField(
          controller: controller_01,
          decoration: const InputDecoration(
            hintText: "Type the item here",
            labelText: "Item Name",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12), // spacing between fields
        TextField(
          controller: controller_02,
          decoration: const InputDecoration(
            hintText: "Type the quantity here",
            labelText: "Item Quantity",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16), // spacing before button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            minimumSize: const Size.fromHeight(60),
            foregroundColor: Colors.blue,
          ),
          onPressed: callback,
          child: const Text("Add"),
        ),
      ],
    );
  }

}