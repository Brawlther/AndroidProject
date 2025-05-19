import 'package:flutter/material.dart';

import 'TextedImage.dart';

class TextedImageBottom extends TextedImage  {
  final String label;
  final String imageFileName;

  const TextedImageBottom({super.key,
    required this.label,
    required this.imageFileName,
  }): super(label: label,imageFileName: imageFileName);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
        children:[
          CircleAvatar(
              backgroundImage: AssetImage(imageFileName),
              radius:80
          ),
          Text(
              label,
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)
          ),
        ]);
  }
}