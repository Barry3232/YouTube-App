import 'package:flutter/material.dart';

class MyPost extends StatelessWidget {
  MyPost({super.key,
  required this.color,
  });


  Color color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
    );
  }
}
