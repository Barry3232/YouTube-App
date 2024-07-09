import 'package:flutter/material.dart';
import 'package:youtube_app/screens/first_screen.dart';
import 'package:youtube_app/screens/shorts_screen.dart';
import 'package:youtube_app/screens/upload_screen.dart';
import 'package:youtube_app/screens/you_screen.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() {
    return SubscriptionScreenState();
  }
}

class SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const Image(
                height: 50,
                width: 40,
                image: AssetImage(
                    'assets/images/vecteezy_youtube-logo-png-youtube-logo.png')),
            const Text(
              'YouTube',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 100,
            ),
            InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {},
                child: const Icon(Icons.cast)),
            const Spacer(),
            InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {},
                child: const Icon(Icons.notifications_none_outlined)),
            const Spacer(),
            InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {},
                child: const Icon(Icons.search_outlined)),
          ],
        ),
      ),

    );
  }
}
