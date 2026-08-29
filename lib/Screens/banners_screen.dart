import 'package:flutter/material.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Banners"),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.image),
            title: Text("Summer Sale"),
          ),
          ListTile(
            leading: Icon(Icons.image),
            title: Text("Gaming Laptops"),
          ),
        ],
      ),
    );
  }
}