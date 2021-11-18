import 'package:flutter/material.dart';
import 'package:quizz/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primaryColor: const Color(0xFF55C1EF),
      ),
      home: const Home(),
    );
  }
}
