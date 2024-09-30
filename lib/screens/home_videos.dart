import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeVideos extends StatefulWidget {
  const HomeVideos({
    super.key,
    required this.text,
    required this.image,
    required this.videoUrl,
  });

  final String text;
  final ImageProvider image;
  final String videoUrl;

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
        height: 200,
        width: double.infinity,
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              VideoPlayer(
                _videoPlayerController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _videoPlayerController.seekTo(Duration(
                          seconds:
                              _videoPlayerController.value.position.inSeconds -
                                  10));
                    },
                    child: const Icon(
                      Icons.fast_rewind,
                      size: 55,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        setState(() {
                          _videoPlayerController.value.isPlaying
                              ? _videoPlayerController.pause()
                              : _videoPlayerController.play();
                        });
                      },
                      child: Icon(
                        _videoPlayerController.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 55,
                        color: Colors.white,
                      )),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      _videoPlayerController.seekTo(Duration(
                          seconds:
                              _videoPlayerController.value.position.inSeconds +
                                  10));
                    },
                    child: const Center(
                        child: Icon(
                      Icons.fast_forward,
                      size: 55,
                      color: Colors.white,
                    )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
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
            child: Text(widget.text),
          ),
        ],
      )
    ]);
  }
}
