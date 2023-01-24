import 'package:flutter/material.dart';
import 'package:instagram_completion/resources/auth_methods.dart';
import 'package:instagram_completion/screens/login_screen.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User getUser(context) {
    if (_user == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
    return _user!;
  }

  void refreshUser() async {
    User user = await AuthMethods().getUserDetails();
    _user = user;
    notifyListeners();
  }
}
