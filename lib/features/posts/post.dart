import 'package:locket/base/base_entity.dart';

class Post extends BaseEntity {
  final int id;
  final int userId;
  final String title;
  final String image;

  // Constructor
  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    // If no createdAt is provided, initialize it with the current time
    if (createdAt == null) {
      onCreate();
    } else {
      this.createdAt = createdAt;
      this.updatedAt = updatedAt ?? createdAt;
    }
  }

  // Factory constructor to create a Post from JSON, with optional createdAt/updatedAt
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'], // Assuming the post has a userId field
      title: json['title'],
      image: json['image'],
      createdAt: json.containsKey('created_at') ? DateTime.parse(json['created_at']) : null,
      updatedAt: json.containsKey('updated_at') ? DateTime.parse(json['updated_at']) : null,
    );
  }

  @override
  String toString() {
    return 'Post{id: $id, userId: $userId, title: $title, image: $image, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}