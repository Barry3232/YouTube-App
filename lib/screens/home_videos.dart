// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class HomeVideos extends StatefulWidget {
//   const HomeVideos({
//     super.key,
//     required this.text,
//     required this.image,
//     required this.videoUrl,
//     required this.description,
//     this.height,
//   });
//
//   final String text;
//   final String description;
//   final ImageProvider image;
//   final String videoUrl;
//   final double? height;
//
//   @override
//   State<HomeVideos> createState() => _HomeVideosState();
// }
//
// class _HomeVideosState extends State<HomeVideos> {
//   late VideoPlayerController _videoPlayerController;
//
//   // String get text => '';
//
//   // late String text;
//
//   @override
//   void initState() {
//     _videoPlayerController = VideoPlayerController.networkUrl(
//       Uri.parse(widget.videoUrl),
//     )..initialize().then((value) {});
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: widget.height ?? 200,
//           width: double.infinity,
//           color: Colors.grey,
//           child:
//               // Padding(
//               //   padding: const EdgeInsets.all(20.0),
//               //   child:
//               Stack(
//                 children: [
//                   Center(
//                     child: AspectRatio(
//                       // aspectRatio: _videoPlayerController.value.aspectRatio,
//                       // _videoPlayerController.value.aspectRatio
//                       aspectRatio: 1.7,
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             _videoPlayerController.value.isPlaying
//                                 ? _videoPlayerController.pause()
//                                 : _videoPlayerController.play();
//                           });
//                         },
//                         child: VideoPlayer(_videoPlayerController),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//         ),
//         // ),
//         Row(
//           children: [
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: CircleAvatar(
//                     backgroundImage: widget.image,
//                     minRadius: 25,
//                   ),
//                 ),
//               ],
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [Text(widget.text), Text(widget.description)],
//               ),
//
//               //,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
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
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse("${widget.videoUrl}.mp4"),
    );
    _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((_) {
      print("✅ Video initialized: ${widget.videoUrl}");
      print("Aspect ratio: ${_videoPlayerController.value.aspectRatio}");
    }).catchError((e) {
      print("❌ Video init error: $e");
      // Handle specific ExoPlayer errors
      if (e.toString().contains('MediaCodecVideoRenderer')) {
        print("🔧 ExoPlayer codec error detected - this may be due to video format compatibility");
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.height ?? 200,
          width: double.infinity,
          color: Colors.black12,
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  _videoPlayerController.value.isInitialized) {
                return AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio > 0
                      ? _videoPlayerController.value.aspectRatio
                      : 16 / 9,
                  // _videoPlayerController.value.aspectRatio,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _videoPlayerController.value.isPlaying
                            ? _videoPlayerController.pause()
                            : _videoPlayerController.play();
                      });
                    },
                    child: VideoPlayer(_videoPlayerController),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error loading video: ${snapshot.error}"),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CircleAvatar(backgroundImage: widget.image, minRadius: 25),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(widget.text), Text(widget.description)],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
