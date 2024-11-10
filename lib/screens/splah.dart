import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/screens/registration_screen.dart';
import 'nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? controller;

  var auth = FirebaseAuth.instance;
  var isLogin = false;

  checkIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  void initState() {
    checkIfLogin();
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10),
      )..addListener(() {
          setState(() {});
        });

      super.initState();
    });
    Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                isLogin ? const NavBar() : const SignUpScreen())));
  }

  @override
  void dispose() {
    controller?.dispose();
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
                color: Colors.red, value: (controller?.value ?? 1) * 2),
          ),
        ],
      ),
    );
  }
}
