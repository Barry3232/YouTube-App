import 'package:flutter/material.dart';
import 'package:youtube_app/screens/first_screen.dart';
import 'package:youtube_app/screens/you_screen.dart';
import 'package:youtube_app/screens/subscription_screen.dart';
import 'package:youtube_app/screens/upload_screen.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({super.key});

  @override
  State<ShortsScreen> createState() {
    return ShortsScreenState();
  }
}

class ShortsScreenState extends State<ShortsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,

      body: SafeArea(child: Container(),),

    );
  }
}
