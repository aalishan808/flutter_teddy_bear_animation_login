import 'package:flutter/material.dart';
import 'package:flutter_teddy_bear_animation_login/Login.dart';
import 'package:rive/rive.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
    }
}

