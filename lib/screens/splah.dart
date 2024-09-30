import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LoginScreen())));
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
        controller.repeat(reverse: true);
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
              height: 130,
              width: 100,
              image: AssetImage(
                  'assets/images/vecteezy_youtube-logo-png-youtube-logo.png')),
          Padding(
            padding: const EdgeInsets.only(right: 60, left: 60),
            child: LinearProgressIndicator(
              color: Colors.red,
              value: controller.value,
            ),
          ),
          LinearProgressIndicator(),
        ],
      ),
    );
  }
}
