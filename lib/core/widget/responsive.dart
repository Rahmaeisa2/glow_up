import 'package:flutter/cupertino.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  static double width(double inputWidth) {
    return (inputWidth / 375.0) * screenWidth; // 375 هو عرض تصميمك الأساسي
  }

  static double height(double inputHeight) {
    return (inputHeight / 812.0) * screenHeight; // 812 هو طول تصميمك الأساسي
  }
}