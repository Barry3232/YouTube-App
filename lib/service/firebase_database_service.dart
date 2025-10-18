import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
import '../model/post_model.dart';

class FirebaseDBService {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('posts');
  var uuid = const Uuid();

  Future<void> addPost(PostModel post) async {
    await dbRef.child(uuid.v4()).set({
      "title": post.title,
      "description": post.description,
      "videoUrl": post.videoUrl,
      "userId": post.userId,
      "postDate": post.postDate.toIso8601String(),
    });
  }

  Future<DatabaseEvent> readAllPost() async {
    return await dbRef.once();
  }

}
