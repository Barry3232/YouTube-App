import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class HomeVideos extends StatefulWidget {
  const HomeVideos({
    super.key,
    required this.text,
    required this.image,
    required this.videoUrl,
    required this.description,
    this.height,
  });

  final String text;
  final String description;
  final ImageProvider image;
  final String videoUrl;
  final double? height;

  @override
  State<HomeVideos> createState() => _HomeVideosState();
}

class _HomeVideosState extends State<HomeVideos> {
  late VideoPlayerController _videoPlayerController;

  // String get text => '';

  // late String text;

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((value) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: widget.height ?? 200,
        width: double.infinity,
        color: Colors.grey,
        child:
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child:
            Stack(
          children: [
            Center(
              child: AspectRatio(
                // aspectRatio: _videoPlayerController.value.aspectRatio,
                // _videoPlayerController.value.aspectRatio
                aspectRatio: 1.7,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _videoPlayerController.value.isPlaying
                          ? _videoPlayerController.pause()
                          : _videoPlayerController.play();
                    });
                  },
                  child: VideoPlayer(
                    _videoPlayerController,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // ),
      Row(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircleAvatar(
                  backgroundImage: widget.image,
                  minRadius: 25,
                ),
              ),
            ],
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.text),
              Text(widget.description),
            ],
          )

              //,
              ),
        ],
      )
    ]);
  }
}
