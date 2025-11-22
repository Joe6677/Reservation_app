import 'package:flutter/material.dart';
import 'package:smart_school_system/Views/home_screen.dart';
import 'package:smart_school_system/Views/role_screen.dart';
import 'package:smart_school_system/Views/sign_in_screen.dart';
import 'package:smart_school_system/Views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/role': (context) => Role(),
        '/signin': (context) => SignIn(),
        '/home': (context) => Home(),
      },
    );
  }
}
