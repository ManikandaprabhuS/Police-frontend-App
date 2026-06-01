import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const PoliceContactApp());
}

class PoliceContactApp extends StatelessWidget {
  const PoliceContactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Police Contact App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}