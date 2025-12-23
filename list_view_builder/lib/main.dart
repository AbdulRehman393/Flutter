import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: FruitScreen()));
}

class FruitScreen extends StatelessWidget {
  // 1. The Data Source: A simple list of strings
  final List<String> fruits = ["Apple", "Banana", "Mango", "Orange", "Grapes"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fruit List")),
      body: ListView.builder(
        // 2. itemCount: Tells the builder how many rows to create
        itemCount: fruits.length, 
        
        // 3. itemBuilder: Runs once for every item in the list
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              // index 0 gets "Apple", [0] gets the letter 'A'
              child: Text(fruits[index][0]), 
            ),
            title: Text(fruits[index]), // Displays the full name
            subtitle: Text("Fresh Fruit"),
            trailing: Icon(Icons.shopping_cart),
          );
        },
      ),
    );
  }
}