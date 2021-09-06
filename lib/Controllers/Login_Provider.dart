import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  String userName;
  String password;
  int userType;
  int userId;
  // String companyOrBoyName;

  void getUserName(String name) {
    userName = name;
    notifyListeners();
  }

  void getPassword(String pass) {
    password = pass;
    notifyListeners();
  }

  void getUserType(int type) {
    userType = type;
    notifyListeners();
  }

  void getUserId(int id) {
    userId = id;
    notifyListeners();
  }
}
