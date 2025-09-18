import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';
import '../utils/video_helper.dart';

class CustomClsdScreen extends StatefulWidget {
  const CustomClsdScreen({
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
  State<CustomClsdScreen> createState() => _HomeVideosState();
}

class _HomeVideosState extends State<CustomClsdScreen> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  bool _hasError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    try {
      // Validate video URL first
      final validation = VideoHelper.validateVideoUrl(widget.videoUrl);
      if (!validation['isValid']) {
        if (mounted) {
          setState(() {
            _hasError = true;
            _errorMessage = validation['error'];
          });
        }
        return;
      }

      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );
      
      _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((_) {
        if (mounted) {
          setState(() {
            _hasError = false;
            _errorMessage = null;
          });
          print("✅ Video initialized: ${widget.videoUrl}");
        }
      }).catchError((error) {
        if (mounted) {
          setState(() {
            _hasError = true;
            _errorMessage = VideoHelper.getErrorMessage(error);
          });
          print("❌ Video init error: $error");
          print("🔧 Platform info: ${VideoHelper.getPlatformSpecificMessage()}");
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = VideoHelper.getErrorMessage(e);
        });
        print("❌ Video controller creation error: $e");
      }
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Widget _buildVideoPlayer() {
    return Stack(
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio > 0
                ? _videoPlayerController.value.aspectRatio
                : 1.7,
            child: VideoPlayer(_videoPlayerController),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  _videoPlayerController.seekTo(Duration(
                      seconds:
                      _videoPlayerController.value.position.inSeconds - 10));
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
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  _videoPlayerController.seekTo(Duration(
                      seconds:
                      _videoPlayerController.value.position.inSeconds + 10));
                },
                child: const Center(
                  child: Icon(
                    Icons.fast_forward,
                    size: 55,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 50,
              color: Colors.red,
            ),
            const SizedBox(height: 10),
            const Text(
              'Video Error',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              _errorMessage ?? 'Unable to play video',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              VideoHelper.getPlatformSpecificMessage(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.orange[700],
                fontSize: 10,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _hasError = false;
                      _errorMessage = null;
                    });
                    _initializeVideoPlayer();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Show video format suggestions
                    _showVideoFormatDialog();
                  },
                  icon: const Icon(Icons.info),
                  label: const Text('Help'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showVideoFormatDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Video Format Help'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('For best compatibility, use videos with:'),
            SizedBox(height: 8),
            Text('• MP4 format'),
            Text('• H.264 codec'),
            Text('• AAC audio'),
            SizedBox(height: 8),
            Text('Common issues:'),
            SizedBox(height: 4),
            Text('• Unsupported codecs'),
            Text('• Network connectivity'),
            Text('• Invalid video URLs'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: widget.height ?? 200,
        width: double.infinity,
        color: Colors.grey,
        child: _hasError
            ? _buildErrorWidget()
            : FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      _videoPlayerController.value.isInitialized) {
                    return _buildVideoPlayer();
                  } else if (snapshot.hasError) {
                    return _buildErrorWidget();
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
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