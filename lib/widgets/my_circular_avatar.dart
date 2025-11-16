import 'package:flutter/material.dart';

class MyCircularAvatar extends StatelessWidget {
  MyCircularAvatar({super.key, required this.text, required this.image});

  String text;
  ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.black,
          backgroundImage: image,
        ),
        Text(text)
      ],
    );
  }
}
