import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// 1. THE MODEL
class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

// 2. THE MAIN ENTRY POINT
void main() {
  runApp(const MaterialApp(home: ApiPracticeScreen()));
}

// 3. THE UI AND FETCH LOGIC
class ApiPracticeScreen extends StatefulWidget {
  const ApiPracticeScreen({super.key});

  @override
  State<ApiPracticeScreen> createState() => _ApiPracticeScreenState();
}

class _ApiPracticeScreenState extends State<ApiPracticeScreen> {
  // Function to fetch data from a real placeholder API
  Future<User> fetchUserData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API Practice")),
      body: Center(
        child: FutureBuilder<User>(
          future: fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("ID: ${snapshot.data!.id}", style: const TextStyle(fontSize: 20)),
                  Text("Name: ${snapshot.data!.name}", style: const TextStyle(fontSize: 20)),
                  Text("Email: ${snapshot.data!.email}", style: const TextStyle(fontSize: 20)),
                ],
              );
            } else {
              return const Text("Error loading data");
            }
          },
        ),
      ),
    );
  }
}