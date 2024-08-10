import 'package:firebase_database/firebase_database.dart';
import 'package:youtube_app/model/post_model.dart';

class FirebaseDBService{
    DatabaseReference dbRef = FirebaseDatabase.instance.ref('posts');

    Future<void> addPost(PostModel post)async{
      await dbRef.child(post.userId).set({
        "title": post.title,
        "description": post.description,
        "videoUrl": post.videoURL,
        "userId": post.userId,
        "postDate": post.postDate.toIso8601String()
      });

    }

    Future<DataSnapshot> readAllPost()async{
     return
      await dbRef.get();

    }

}