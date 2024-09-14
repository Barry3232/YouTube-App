import 'package:flutter/material.dart';
import '../model/post_model.dart';
import '../service/firebase_database_service.dart';
import 'home_videos.dart';
import 'package:video_player/video_player.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() {
    return FirstScreenState();
  }
}

class FirstScreenState extends State<FirstScreen> {
  bool isLoadingPosts = false;
  List<PostModel> allPostList = [];

  Future<void> fetchPost() async {
    setState(() {
      isLoadingPosts = true;
    });
    FirebaseDBService()
        .readAllPost()
        .then((fbPost) {
          final data = fbPost.value as Map;
          data.forEach((key, value) {
            final newPost = PostModel(
                title: value['title'],
                description: value['description'],
                id: DateTime.now().toString(),
                postDate: DateTime.parse(value['postDate']),
                userId: value['userId'],
                videoURL: value['videoUrl']);
            allPostList.add(newPost);
          });
          // print( fbPost.value);
        })
        .catchError((err) => print(err))
        .whenComplete(() => setState(() {
              isLoadingPosts = false;
            }));
  }

  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    fetchPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              const Image(
                  height: 50,
                  width: 40,
                  image: AssetImage(
                      'assets/images/vecteezy_youtube-logo-png-youtube-logo.png')),
              const Text(
                'YouTube',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 100,
              ),
              InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {},
                  child: const Icon(Icons.cast)),
              const Spacer(),
              InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {},
                  child: const Icon(Icons.notifications_none_outlined)),
              const Spacer(),
              InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {},
                  child: const Icon(Icons.search_outlined)),
            ],
          ),
        ),
        body: isLoadingPosts
            ? const SizedBox(
                height: 50, width: 50, child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (context, index) =>
                    HomeVideos(
                    text: allPostList[index].title,
                    image: const AssetImage('assets/images/Goggle.png')),
                separatorBuilder: (context, _) => const SizedBox(
                      height: 10,
                    ),
                itemCount: allPostList.length));
  }
}
