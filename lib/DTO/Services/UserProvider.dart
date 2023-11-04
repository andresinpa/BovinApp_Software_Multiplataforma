import 'package:BovinApp/DTO/User.dart';
import 'package:flutter/material.dart';

/// The UserProvider class is a Dart class that manages the state of a User object and notifies
/// listeners when the user object is updated.
class UserProvider with ChangeNotifier {
  User _user = User();

  User get user => _user;

  set user(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  void updateUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }
}
