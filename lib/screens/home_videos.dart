import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../widgets/userAvatar.dart';

class HomeVideos extends StatefulWidget {
  const HomeVideos({
    super.key,
    required this.text,
    required this.videoUrl,
    required this.description,
    required this.userId,
    this.height,
  });

  final String text;
  final String description;
  final String videoUrl;
  final double? height;
  final String userId;

  @override
  State<HomeVideos> createState() => _HomeVideosState();
}

class _HomeVideosState extends State<HomeVideos> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse("${widget.videoUrl}"),
    );

    _initializeVideoPlayerFuture =
        _videoPlayerController.initialize().then((_) {
          print("✅ Video initialized: ${widget.videoUrl}");
          print("Aspect ratio: ${_videoPlayerController.value.aspectRatio}");
        }).catchError((e) {
          print("❌ Video init error: $e");
          if (e.toString().contains('MediaCodecVideoRenderer')) {
            print("🔧 ExoPlayer codec error - likely video format issue");
          }
        });

    _videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🟢 --- Video Player Section ---
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                _videoPlayerController.value.isInitialized) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: double.infinity,
                  height: widget.height ?? 220, // consistent feed height
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // 👇 Video fills box without distortion
                      FittedBox(
                        fit: BoxFit.cover,
                        // clipBehavior: Clip.hardEdge,
                        child: SizedBox(
                          width: _videoPlayerController.value.size.width,
                          height: _videoPlayerController.value.size.height,
                          child: VideoPlayer(_videoPlayerController),
                        ),
                      ),
                      // 👇 Play / pause on tap
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (_videoPlayerController.value.isPlaying) {
                              _videoPlayerController.pause();
                            } else {
                              _videoPlayerController.play();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Container(
                height: widget.height ?? 220,
                width: MediaQuery.of(context).size.width,

                color: Colors.black12,
                child: Center(
                  child: Text(
                    "Error loading video: ${snapshot.error}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            } else {
              return Container(
                height: widget.height ?? 220,
                color: Colors.black12,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),

        // 🟣 --- Video Description Section ---
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: UserAvatar(
                userId: widget.userId,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

