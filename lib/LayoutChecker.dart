import 'package:flutter/cupertino.dart';

class LayoutChecker {
  static bool isLandscapeMode(BuildContext context){
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    if( (width>height) && (width > 720)) {
      return true;
    }
    return false;
  }
}