import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/role');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.6, 1],
            colors: [
              Color.fromARGB(255, 56, 110, 238),
              Color.fromARGB(255, 105, 147, 227),
            ],
          ),
        ),
        child: Center(
          child: Image.asset("assets/images/IBM-Symbol.png", width: 150),
        ),
      ),
    );
  }
}
