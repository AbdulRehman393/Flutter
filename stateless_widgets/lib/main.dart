import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("StatelessWidget with Constructor"),
        ),
        body: Center(
          child: Greeting(name: 'Ahmad'), // Passing name here
        ),
      ),
    );
  }
}

class Greeting extends StatelessWidget {
  final String name;

  Greeting({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello $name!',
      style: TextStyle(fontSize: 25, color: Colors.blue), // Ensure visible
    );
  }
}

