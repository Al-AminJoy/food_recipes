import 'package:flutter/material.dart';
import 'package:recepie_app/views/home_page.dart';
import 'package:recepie_app/views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

