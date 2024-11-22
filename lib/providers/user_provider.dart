import 'package:flutter/material.dart';
import 'package:locket/resources/auth_methods.dart';
import 'package:locket/responses/user_login.dart';

class UserProvider with ChangeNotifier {
  UserLoginResponse? _user;

  UserLoginResponse? get user => _user; // Getter for the user object

  set user(UserLoginResponse? newUser) {
    _user = newUser;
    notifyListeners(); // Notify listeners about the change
  }

  Future<void> loginUser(BuildContext context, String email, String password) async {
    AuthMethods authMethods = AuthMethods();
    _user = await authMethods.loginUser(email: email, password: password); // Store the entire UserLoginResponse object

    if (_user != null) {
      notifyListeners(); // Notify listeners about the change
    } else {
      // Handle login failure (you might want to throw an error or show a message)
    }
  }

  void logout() {
    _user = null; // Clear the user on logout
    notifyListeners(); // Notify listeners about the change
  }

  // Future<void> refreshUser() async {
  //   AuthMethods authMethods = AuthMethods();
  //   User user = await authMethods.getUserDetails();
  //   _user = user;
  //   notifyListeners();
  // }
}
