import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Reports"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text("Total Revenue"),
                subtitle: const Text("₹25,68,000"),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Total Orders"),
                subtitle: const Text("1245"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}