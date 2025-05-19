import 'package:flutter/material.dart';

import 'TextedImage.dart';

class TextedImageBottom extends TextedImage  {
  static SizedBox smallSizedBox = const SizedBox(height:10);
  const TextedImageBottom({super.key,
    required super.label,
    required super.imageFileName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
        children:[
          CircleAvatar(
              backgroundImage: AssetImage(imageFileName),
              radius:TextedImage.imageSize
          ),
          smallSizedBox,
          Text(
              label,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)
          ),
        ]);
  }
}