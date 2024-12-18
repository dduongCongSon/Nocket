import 'package:flutter/material.dart';
import 'package:locket/utils/auth_methods.dart';
import 'package:locket/features/users/user_login.dart';

class UserProvider with ChangeNotifier {
  UserLoginResponse? _userLoginResponse;

  UserLoginResponse? get userLoginResponse => _userLoginResponse; // Getter for the user object

  set userLoginResponse(UserLoginResponse? newUser) {
    _userLoginResponse = newUser;
    notifyListeners(); // Notify listeners about the change
  }

  Future<void> loginUser(BuildContext context, String email, String password) async {
    AuthMethods authMethods = AuthMethods();
    _userLoginResponse = await authMethods.loginUser(email: email, password: password); // Store the entire UserLoginResponse object

    if (_userLoginResponse != null) {
      notifyListeners(); // Notify listeners about the change
    } else {
      // Handle login failure (you might want to throw an error or show a message)
    }
  }

  void logout() {
    _userLoginResponse = null; // Clear the user on logout
    notifyListeners(); // Notify listeners about the change
  }

}
