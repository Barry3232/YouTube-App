import 'package:flutter/material.dart';
import 'package:youtube_app/screens/shorts_screen.dart';
import 'package:youtube_app/screens/subscription_screen.dart';
import 'package:youtube_app/screens/upload_screen.dart';
import 'package:youtube_app/screens/you_screen.dart';

import 'home_videos.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() {
    return FirstScreenState();
  }
}

class FirstScreenState extends State<FirstScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeVideos(
              color: Colors.red,
                image: const AssetImage('assets/images/Thomas Stone.png'),
                text:
                    'First flutter application course - Flutter for beginners - Flutter tutorial',
              ),
            const SizedBox(
              height: 15,
            ),
            HomeVideos(
                color: Colors.brown,
              image: const AssetImage('assets/images/Polina Kranz.png'),
              text:
                    'First flutter application course - Flutter for beginners - Flutter tutorial',),
            const SizedBox(
              height: 15,
            ),
            HomeVideos(
              color: Colors.green,
              image: const AssetImage('assets/images/Jens Röhrdanz.png'),
                text:
                    'First flutter application course - Flutter for beginners - Flutter tutorial',),
            const SizedBox(
              height: 15,
            ),
            HomeVideos(
              color: Colors.black,
              image: const AssetImage('assets/images/Allie Goldman.png'),
                text:
                    'First flutter application course - Flutter for beginners - Flutter tutorial', ),
            const SizedBox(
              height: 15,
            ),
            HomeVideos(
              color: Colors.blueGrey,
              image: const AssetImage('assets/images/Omari Norris.png'),
                text:
                    'First flutter application course - Flutter for beginners - Flutter tutorial', ),
          ],
        ),
      ),
    );
  }
}
