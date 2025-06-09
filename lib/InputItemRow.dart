import 'package:flutter/material.dart';

class InputItemRow extends StatelessWidget{
  final TextEditingController controller_01, controller_02;
  final VoidCallback callback;

  const InputItemRow({
    super.key,
    required this.controller_01,
    required this.controller_02,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            controller: controller_01,
            decoration: const InputDecoration(
              hintText:"Type the item here",
              labelText: "Item Name",
              border: OutlineInputBorder(),
            ),
          ),),
        Expanded(
          child: TextField(controller: controller_02,
              decoration: const InputDecoration(
                hintText:"Type the quantity here",
                labelText: "Item Quantity",
                border: OutlineInputBorder(),
              )
          ),),
        ElevatedButton(
            style:ElevatedButton.styleFrom(
                textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
                minimumSize: const Size(100,60),
                foregroundColor: Colors.blue
            ),onPressed: callback,
            child: const Text("Add Item")
        ),
      ],
    );
  }

}