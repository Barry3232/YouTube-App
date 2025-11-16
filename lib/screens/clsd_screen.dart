import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../widgets/comment.dart';
import '../widgets/customclsd_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ModelBottomSheet extends StatefulWidget {
  const ModelBottomSheet({
    super.key,
    required this.videoUrl,
    required this.videoTitle,
    required this.videoDescription,
    required this.videoId,
  });

  final String videoUrl;
  final String videoTitle;
  final String videoDescription;
  final String videoId;

  @override
  State<ModelBottomSheet> createState() => _ModelBottomSheetState();
}

class _ModelBottomSheetState extends State<ModelBottomSheet> {
  bool isLiked = false;
  bool isDisliked = false;
  int likeCount = 0;
  int disLikeCount = 0;

  final currentUser = FirebaseAuth.instance.currentUser;
  final dbRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _loadLikeDislikeStatus();
  }

  //show initial like/dislike state from firebase

  Future<void> _loadLikeDislikeStatus() async {
    final videoRef = dbRef.child('posts/${widget.videoId}');
    final snapshot = await videoRef.get();

    if (snapshot.exists) {
      final data = Map<dynamic, dynamic>.from(snapshot.value as Map);

      final likes = Map<String, dynamic>.from(data['likes'] ?? {});
      final dislikes = Map<String, dynamic>.from(data['dislikes'] ?? {});
      setState(() {
        likeCount = likes.length;
        disLikeCount = dislikes.length;
        isLiked = likes.containsKey(currentUser?.uid);
        isDisliked = dislikes.containsKey(currentUser?.uid);
      });
    }
  }

  //Toggle like

  Future<void> _toggleLike() async {
    final userId = currentUser?.uid;
    if (userId == null) return;

    final likesRef = dbRef.child('posts/${widget.videoId}/likes/$userId');
    final dislikeRef = dbRef.child('posts/${widget.videoId}/dislikes/$userId');

    if (isLiked) {
      await likesRef.remove();
    } else {
      await likesRef.set(true);
      await dislikeRef.remove();
    }
    _loadLikeDislikeStatus();
  }

  // toggle dislike
  Future<void> _toggleDislike() async {
    final userId = currentUser?.uid;
    if (userId == null) return;

    final likesRef = dbRef.child('posts/${widget.videoId}/likes/$userId');
    final dislikeRef = dbRef.child('posts/${widget.videoId}/dislikes/$userId');

    if (isDisliked) {
      await dislikeRef.remove();
    } else {
      await dislikeRef.set(true);
      await likesRef.remove();
    }
    _loadLikeDislikeStatus();
  }

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
          child: StreamBuilder(
              stream: dbRef.child('posts/${widget.videoId}').onValue,
              builder: (context, snapshot) {
                if (!snapshot.hasData ||
                    snapshot.data!.snapshot.value == null) {
                  return const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  );
                }

                final data = Map<dynamic, dynamic>.from(
                    snapshot.data!.snapshot.value as Map);
                final likes = Map<String, dynamic>.from(data['likes'] ?? {});
                final dislikes =
                    Map<String, dynamic>.from(data['dislikes'] ?? {});
                final likeCount = likes.length;
                final disLikeCount = dislikes.length;
                final isLiked = likes.containsKey(currentUser?.uid);
                final isDisliked = dislikes.containsKey(currentUser?.uid);

                return Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked
                            ? Icons.thumb_up_alt
                            : Icons.thumb_up_alt_outlined,
                        color: isLiked ? Colors.red : Colors.black,
                      ),
                      onPressed: _toggleLike,

                    ),
                    Text("$likeCount"),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        isDisliked
                            ? Icons.thumb_down_alt
                            : Icons.thumb_down_outlined,
                        color: isDisliked ? Colors.red : Colors.black,
                      ),
                      onPressed: _toggleDislike,

                    ),
                    Text("$disLikeCount"),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        final currentUser = FirebaseAuth.instance.currentUser;
                        final currentUserId = currentUser?.uid ?? '';
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            builder: (context) {
                              return CommentsBottomSheet(
                                userId: currentUserId,
                                videoId: widget.videoId,
                              );
                            });
                      },
                      icon: const Icon(Icons.messenger_outline_outlined),
                    )
                  ],
                );
              }),
        ),
      ],
    );
  }
}
