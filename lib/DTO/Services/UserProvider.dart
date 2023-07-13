import 'package:BovinApp/DTO/User.dart';
import 'package:flutter/material.dart';

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
