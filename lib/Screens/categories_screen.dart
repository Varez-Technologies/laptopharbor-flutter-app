import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List categories = [
      "Gaming Laptops",
      "Business Laptops",
      "Student Laptops",
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Categories"),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.category),
            title: Text(categories[index]),
          );
        },
      ),
    );
  }
}