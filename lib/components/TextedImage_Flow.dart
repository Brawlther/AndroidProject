import 'package:flutter/material.dart';
import 'TextedImage.dart';

class TextedImageFlow extends TextedImage  {
  final String label;
  final String imageFileName;

  const TextedImageFlow({super.key,
    required this.label,
    required this.imageFileName,
  }) : super(label: label,imageFileName: imageFileName);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              CircleAvatar(
                  backgroundImage: AssetImage(imageFileName),
                  radius:80
              ),
              Text(
                label,
                style: const TextStyle(
                    fontSize: 36.0,
                    color:Colors.white,
                    shadows:[
                      Shadow(
                        offset: Offset(1.0, 1.0), // X and Y offset
                        blurRadius: 4.5,          // how blurry
                        color: Colors.black,      // shadow color
                      ),
                    ],
                    backgroundColor:Colors.transparent
                ),
              )]),
      ]
    );
  }
}