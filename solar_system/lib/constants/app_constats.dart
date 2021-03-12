import 'package:flutter/material.dart';

class Constants {
  static const String kTitle = "Solar System";
  static const Color kBrandBackground = Color(0xFF151515);
  static const LinearGradient kGradientButton = LinearGradient(
    colors: [
      Color(0XFFEF5F53),
      Color(0XFFFA8F70),
    ],
  );
  static Shader kGradientPink = LinearGradient(
    colors: <Color>[Color(0XFFFF6CD9), Color(0XFFFF2184)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
}
