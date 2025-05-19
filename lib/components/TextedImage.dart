import 'package:flutter/material.dart';
abstract class TextedImage extends StatelessWidget{
  final String label;
  final String imageFileName;
  const TextedImage({super.key,
    required this.label,
    required this.imageFileName,
  });
}