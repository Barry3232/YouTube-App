import 'package:flutter/material.dart';

class MyCircularAvatar extends StatelessWidget {
  MyCircularAvatar({super.key, required this.text});

  String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundColor: Colors.black,
        ),
        Text(text)
      ],
    );
  }
}
