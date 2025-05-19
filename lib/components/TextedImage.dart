import 'package:flutter/material.dart';
abstract class TextedImage extends StatelessWidget{
  static double imageSize=80;
  final String label;
  final String imageFileName;
  const TextedImage({super.key,
    required this.label,
    required this.imageFileName,
  });
}