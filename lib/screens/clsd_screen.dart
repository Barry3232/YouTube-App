import 'package:flutter/material.dart';
import '../widgets/comment.dart';
import '../widgets/customclsd_screen.dart';
import 'home_videos.dart';

class ModelBottomSheet extends StatefulWidget {
  const ModelBottomSheet({
    super.key,
    required this.videoUrl,
    required this.videoTitle,
    required this.videoDescription,
  });

  final String videoUrl;
  final String videoTitle;
  final String videoDescription;

  @override
  State<ModelBottomSheet> createState() => _ModelBottomSheetState();
}

class _ModelBottomSheetState extends State<ModelBottomSheet> {
  bool isLiked = false;
  bool isDisliked = false;
  int likeCount = 0;
  int disLikeCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CustomClsdScreen(
              text: widget.videoTitle,
              image: const AssetImage('assets/images/Goggle.png'),
              videoUrl: widget.videoUrl,
              description: widget.videoDescription,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_drop_down, size: 50),
            ),
          ],
        ),
        // const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                  color: isLiked ? Colors.red : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    if (isLiked) {
                      isLiked = false;
                      likeCount--;
                    } else {
                      isLiked = true;
                      likeCount++;
                      if (isDisliked) {
                        isDisliked = false;
                        disLikeCount--;
                      }
                    }
                  });
                },
              ),

              Text("$likeCount"),

              const Spacer(),

              IconButton(

                icon: Icon(
                  isDisliked ? Icons.thumb_down_alt : Icons.thumb_down_outlined,
                  color: isDisliked ? Colors.red : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    if (isDisliked) {
                      isDisliked = false;
                      disLikeCount--;
                    } else {
                      isDisliked = true;
                      disLikeCount++;
                      if (isLiked) {
                        isLiked = false;
                        likeCount--;
                      }
                    }
                  });
                },
              ),
              Text("$disLikeCount"),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showCommentsBottomSheet(context);
                },
                icon: const Icon(Icons.messenger_outline_outlined),)

            ],
          ),
        ),
      ],
    );
  }
}
