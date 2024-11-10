import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/widgets/customclsd_screen.dart';

import 'home_videos.dart';

class ModelBottomSheet extends StatefulWidget {
  const ModelBottomSheet(
      {super.key,
      required this.videoUrl,
      required this.videoTitle,
      required this.videoDescription});

  final String videoUrl;
  final String videoTitle;
  final String videoDescription;

  @override
  State<ModelBottomSheet> createState() => _ModelBottomSheetState();
}

class _ModelBottomSheetState extends State<ModelBottomSheet> {
  // Future<void> likePost(
  //     BuildContext context,
  //     )async {
  //   try {
  //     await FirebaseFirestore.instance.collection('post')
  //   }
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(
        children: [
          CustomClsdScreen(
              text: widget.videoTitle,
              image: const AssetImage('assets/images/Goggle.png'),
              videoUrl: widget.videoUrl,
              description: widget.videoDescription),
          Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_drop_down,
                    size: 50,
                  ))
            ],
          )
        ],
      ),
      const SizedBox(
        height: 50,
      ),
      const Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Icon(Icons.thumb_up_alt_outlined),
            Spacer(),
            Icon(Icons.thumb_down_outlined),
            Spacer(),
            Icon(Icons.messenger_outline_outlined)
          ],
        ),
      )
    ]);
  }
}
