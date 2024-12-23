import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHomePage();
  }

  Future<void> _navigateToHomePage() async {
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return const HomeScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: MediaQuery.of(context).size.height / 2,
          child: Lottie.asset(
            'assets/lottie/splash_cart.json',
          ),
        ),
        const Center(
          child: Text(
            "Cart Management System",
            style:
                TextStyle(fontSize: 16, letterSpacing: 1.5, color: Colors.blue),
          ),
        )
      ]),
    );
  }
}
