import 'package:flutter/material.dart';

class ResponsiveTextSize {
  static double getSize(BuildContext context, double size) {
    // Dynamically calculate responsive size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Use the smaller dimension (width or height) to scale the size
    double scaleFactor = (screenWidth < screenHeight ? screenWidth : screenHeight) / 1000;

    // Return the scaled size
    return size * scaleFactor;
  }
}
