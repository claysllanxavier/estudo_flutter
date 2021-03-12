import 'package:flutter/material.dart';

import 'package:solar_system/config/theme/theme.dart';
import 'package:solar_system/constants/app_constats.dart';
import 'package:solar_system/screens/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.kTitle,
      theme: appThemeData,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
