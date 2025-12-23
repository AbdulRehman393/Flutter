import 'package:flutter/material.dart';

// The entry point of the app
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false, // Removes the red 'debug' banner
    home: CounterWidget(),
  ));
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  // This variable holds the "State"
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The background color changes based on the count being Even or Odd
      backgroundColor: count % 2 == 0 ? Colors.green : Colors.red,
      
      appBar: AppBar(
        title: const Text("Stateful Counter"),
        centerTitle: true,
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Press the button to change color",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              // setState tells Flutter to rebuild the UI with the new count
              onPressed: () {
                setState(() {
                  count++;
                });
              },
              child: Text(
                "Count: $count",
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}