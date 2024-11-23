import 'base/base_entity.dart';

class Post extends BaseEntity {
  final int id;
  final int userId; // Foreign key to associate the post with a user
  final String title;
  final String image;

  Post({required this.id, required this.userId, required this.title, required this.image});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'], // Assuming the post has a userId field
      title: json['title'],
      image: json['image'],
    );
  }
}