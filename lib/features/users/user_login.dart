import 'package:locket/features/users/member.dart';

class UserLoginResponse {
  final String tokenType;
  final int id;
  final Member member;
  final List<String> roles;
  final String message;
  final String token;
  final String refreshToken;

  UserLoginResponse({
    required this.tokenType,
    required this.id,
    required this.member,
    required this.roles,
    required this.message,
    required this.token,
    required this.refreshToken,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) {
    return UserLoginResponse(
      tokenType: json['tokenType'],
      id: json['id'],
      member: Member.fromJson(json['member']),
      roles: List<String>.from(json['roles']),
      message: json['message'],
      token: json['token'],
      refreshToken: json['refresh_token'],
    );
  }

  //convert UserLoginResponse to Member
  Member toMember() {
    return member; // Just return the member since it's already a Member object
  }
}
