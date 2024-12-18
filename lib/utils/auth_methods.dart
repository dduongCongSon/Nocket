import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:locket/features/users/data.dart';
import 'package:locket/features/users/member.dart';
import 'package:locket/features/users/user_login.dart';
import 'package:locket/features/auth/auth_service.dart';

class AuthMethods {
  final Dio _dio = Dio(); // Create a Dio instance
  final AuthService _authService = AuthService();
  List<Member> users = [hoang, son];

  // Logging in user via HTTP request
  Future<UserLoginResponse?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return null;
      }

      final user = users.firstWhere(
            (user) => user.email == email && user.password == password,
        orElse: () => Member(
          id: 0,
          firstName: 'Default',
          lastName: 'User',
          nickname: 'default',
          phoneNumber: null,
          email: 'default@example.com',
          address: 'Unknown',
          password: '',
          isActive: false,
          statusName: 'UNKNOWN',
          dateOfBirth: '2000-01-01',
          avatarUrl: '',
          roleName: 'ROLE_UNKNOWN',
          posts: [],
        ),
      );

      if (user.id != 0) {
        // Use raw object data directly, no need to call fromJson
        UserLoginResponse userResponse = hoangLoginResponse;
        if(user.email == 'giang@'){
          userResponse = hoangLoginResponse;
        }else if(user.email == 'son@'){
          userResponse = sonLoginResponse;
        }

        // Save tokens to SharedPreferences
        await _authService.saveTokens(hoangLoginResponse.token, hoangLoginResponse.refreshToken);

        return userResponse; // Return the UserLoginResponse object directly
      } else {
        // Handle login failure
        return null;
      }

    } catch (e) {
      if (kDebugMode) {
        print("Exception occurred during login: $e");
      }
      return null; // Return null on exception
    }
  }

  // Get user details
  // Future<User> getUserDetails() async {
  //   User currentUser = _auth.currentUser!;
  //   DocumentSnapshot documentSnapshot =
  //   await _firestore.collection('users').doc(currentUser.uid).get();
  //   return User.fromDocument(documentSnapshot);
  // }

  // Signing out user via HTTP request
  Future<String> signOut() async {
    String res = "Some error occurred";

    try {
      const String url = 'http://localhost:4000/api/v1/users/logout';

      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      if (response.statusCode == 200) {
        res = "success"; // Assuming logout was successful
      } else {
        res = response.data['message'] ?? "Logout failed";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  // Signing Up User
  Future<String> signUpUser() async {
    return "success";
  }
}
