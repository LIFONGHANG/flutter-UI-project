import 'package:flutter/material.dart';
import 'package:flutter_ui_project_salait/Const/colors.dart';
import 'package:flutter_ui_project_salait/OnboardScreen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stylish',

      theme: ThemeData(
        scaffoldBackgroundColor: whiteColor,
      ),

      home: const SplashScreen(),
    );
  }
}