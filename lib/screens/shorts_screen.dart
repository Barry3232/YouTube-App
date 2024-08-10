import 'package:flutter/material.dart';
import 'package:youtube_app/posts/post.dart';


class ShortsScreen extends StatefulWidget {
  const ShortsScreen({super.key});


  @override
  State<ShortsScreen> createState() {
    return ShortsScreenState();
  }
}

class ShortsScreenState extends State<ShortsScreen> {


  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      PageView(
        scrollDirection: Axis.vertical,
        controller: _controller,
        children: [
          MyPost(color: Colors.grey),
          MyPost(color: Colors.blueAccent),
          MyPost(color: Colors.greenAccent),
          MyPost(color: Colors.brown),
          MyPost(color: Colors.black),
        ],
      ),
    );
  }
}

