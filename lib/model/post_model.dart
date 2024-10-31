class PostModel {
  // final List likes;
  final String comment;
  final String title;
  final String description;
  final String id;
  final String userId;
  final String videoURL;
  final DateTime postDate;

  PostModel({
    // required this.likes,
    required this.comment,
    required this.title,
    required this.description,
    required this.id,
    required this.postDate,
    required this.userId,
    required this.videoURL,
  });
}
