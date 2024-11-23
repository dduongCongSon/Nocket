import 'package:locket/models/base/base_entity.dart';
import 'package:locket/models/post.dart';
import 'package:locket/responses/user_login.dart';

class Member extends BaseEntity {
  final int id;
  final String firstName;
  final String lastName;
  final String nickname;
  final String? phoneNumber;
  final String email;
  final String address;
  final String password; // Assuming you want to store this securely
  final bool isActive;
  final String? statusName; // Can be nullable
  final String dateOfBirth;
  final String? avatarUrl;
  final String roleName;
  final List<Post> posts; // List of posts related to this user

  Member({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.nickname,
    this.phoneNumber,
    required this.email,
    required this.address,
    required this.password, // Store this securely
    required this.isActive,
    this.statusName,
    required this.dateOfBirth,
    this.avatarUrl,
    required this.roleName,
    this.posts = const [], // Initialize posts as an empty list by default
    DateTime? createdAt,
    DateTime? updatedAt,
  }){
    // If no createdAt is provided, initialize it with the current time
    if (createdAt == null) {
      onCreate();
    } else {
      this.createdAt = createdAt;
      this.updatedAt = updatedAt ?? createdAt;
    }
  }

  factory Member.fromJson(Map<String, dynamic> json) {
    var postsFromJson = json['posts'] as List<dynamic>? ?? [];
    List<Post> postList = postsFromJson.map((postJson) => Post.fromJson(postJson)).toList();

    return Member(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      nickname: json['nickname'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      address: json['address'],
      password: json['password'], // Be cautious with sensitive data
      isActive: json['is_active'] == 1, // Convert from int to bool
      statusName: json['status_name'],
      dateOfBirth: json['date_of_birth'],
      avatarUrl: json['avatar_url'],
      roleName: json['role_name'],
      posts: postList,
      createdAt: json.containsKey('created_at') ? DateTime.parse(json['created_at']) : null,
      updatedAt: json.containsKey('updated_at') ? DateTime.parse(json['updated_at']) : null,
    );
  }
}