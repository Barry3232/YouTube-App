import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:youtube_v/widgets/userAvatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // for time formatting

class CommentsBottomSheet extends StatefulWidget {
  const CommentsBottomSheet({
    super.key,
    required this.userId,
    required this.videoId, // identifies which video the comment belongs to
  });

  final String userId;
  final String videoId;

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  TextEditingController commentController = TextEditingController();

  final dbRef = FirebaseDatabase.instance.ref(); // root reference
  final currentUser = FirebaseAuth.instance.currentUser; // user auth instance

  final List<String> comments = [];

  void addComment() async {
    final commentText = commentController.text.trim();

    if (commentText.isEmpty) return;

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You need to be logged in to comment")));
      return;
    }

    try{
      final userId = currentUser.uid;
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      final commentRef = FirebaseDatabase.instance
          .ref('posts/${widget.videoId}/comments')
          .push();

      final commentData = {
        'id': commentRef.key,
        'userId': userId,
        'comment': commentText,
        'timestamp': timestamp,
      };

      await commentRef.set(commentData);

      commentController.clear();
      print("✅ Comment sent successfully");
    }catch (e){
      print("❌ FAILED TO SEND COMMENT: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send comment: $e")),
      );
    }
  }

  Future<void> deleteComment(String videoId, String commentId) async {
    await FirebaseDatabase.instance
        .ref('posts/$videoId/comments/$commentId')
        .remove();
  }

  @override
  Widget build(BuildContext context) {
    final commentStream = dbRef
        .child('posts/${widget.videoId}/comments')
        .orderByChild('timestamp')
        .onValue;
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(children: [
              const SizedBox(
                width: double.infinity,
              ),
              const Text(
                "Comments",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(
                color: Colors.grey[300],
              ),
              Expanded(
                  child: StreamBuilder(
                      stream: commentStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (!snapshot.hasData ||
                            snapshot.data!.snapshot.value == null) {
                          return const Center(
                            child: Text('No comment yet.'),
                          );
                        }

                        final data = Map<dynamic, dynamic>.from(
                            snapshot.data!.snapshot.value as Map);

                        final comments = data.entries.toList()
                          ..sort((a, b) => (a.value['timestamp'] ?? 0)
                              .compareTo(b.value['timestamp'] ?? 0));

                        return ListView.builder(
                          controller: scrollController,
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment = comments[index].value;
                            final ts = comment['timestamp'] ?? 0;
                            final formattedTime = ts is int && ts > 0
                                ? DateFormat('yyyy-MM-dd hh:mm a').format(
                                    DateTime.fromMillisecondsSinceEpoch(ts))
                                : 'Unknown time';
                            return ListTile(
                              leading: UserAvatar(userId: comment['userId']),

                            title: Text(comment['comment'] ?? ''),
                              subtitle: Text(formattedTime),
                              trailing: comment['userId'] ==
                                      FirebaseAuth.instance.currentUser?.uid
                                  ? IconButton(
                                      onPressed: () => deleteComment(
                                          widget.videoId, comments[index].key),
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 15,
                                        color: Colors.grey,
                                      ))
                                  : null,
                            );
                          },
                        );
                      })),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                          hintText: 'Add a comment....',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 15,
                          )),
                    )),
                    IconButton(
                      onPressed: addComment,
                      icon: const Icon(Icons.send),
                    )
                  ],
                ),
              )
            ]),
          );
        });
  }
}
