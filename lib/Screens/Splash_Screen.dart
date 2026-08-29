import 'dart:async';

import 'package:flutter/material.dart';
import 'package:laptopharbor01/Screens/dashboard_screen.dart';
import 'login_screen.dart'; // apna next page import karo

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // 3 second baad next page pe jayega
    Timer(const Duration(seconds: 30), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff12006b), Color(0xff2d0dbf)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            // Logo
            Image.asset('assets/image/shopping.png', height: 130),

            const SizedBox(height: 20),

            const Text(
              "LaptopHarbor",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Find Your Perfect Laptop",
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),

            const Spacer(),

            const CircularProgressIndicator(color: Colors.white),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
