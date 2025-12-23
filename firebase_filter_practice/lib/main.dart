import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  // Required for Firebase to initialize before the app starts
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: FirebaseFilterScreen()));
}

class FirebaseFilterScreen extends StatelessWidget {
  const FirebaseFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CS Dept: Age > 40"),
        backgroundColor: Colors.orangeAccent,
      ),
      // 1. StreamBuilder listens to real-time changes in Firestore
      body: StreamBuilder<QuerySnapshot>(
        // 2. The Filter Query: Filtering by 'CS' and Age > 40
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('department', isEqualTo: 'CS')
            .where('age', isGreaterThan: 40)
            .snapshots(),
        builder: (context, snapshot) {
          // Check if data is still loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Check for errors (like missing index in Firebase)
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          // 3. Displaying the list if data exists
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;

            if (docs.isEmpty) {
              return const Center(child: Text("No users match the criteria."));
            }

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                // Convert document to a Map
                var userData = docs[index].data() as Map<String, dynamic>;
                
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: const Icon(Icons.verified_user, color: Colors.blue),
                    title: Text(userData['name'] ?? 'No Name'), // Displays name
                    subtitle: Text("Age: ${userData['age']}"), // Displays age
                    trailing: Text(
                      userData['department'], // Displays "CS"
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }
}