class PostModel {
  final String title;
  final String description;
  final String id;
  final String userId;
  final String videoUrl;
  final DateTime postDate;

  PostModel({
    required this.title,
    required this.description,
    required this.id,
    required this.postDate,
    required this.userId,
    required this.videoUrl,
  });
}
