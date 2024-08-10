import 'package:flutter/material.dart';

class HomeVideos extends StatelessWidget {
  HomeVideos({super.key,
    required this.text,
    required this.color,
    required this.image,
  });


  String text;
  Color color;
  ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(

        height: 200,
        width: double.infinity,
        color: color,
        child: const Text('chikd'),
      ),
      Row(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircleAvatar(
                  backgroundImage: image,
                  minRadius: 25,
                  // child: image == null
                  // ?Text(
                  //  'L',
                  //   style: TextStyle(fontSize: 28),
                  // )
                  ),
                ),

            ],
          ),
           Expanded(
            child: Text(
                text),
          )
        ],
      )
    ]);
  }
}
