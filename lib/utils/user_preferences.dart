import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class UserPreferences {
  //shared preferences instance
  static late SharedPreferences _prefferences;

//used key for storing data of the user
  static const _keyUSer = 'user';
  static const myUser = User(
    imagePath: 'assets/images/lesego.jpg',
    name: 'Lesego Rabanye',
    emailAddress: 'lesegorabanye@gmail.com',
    phoneNumber: 0632152281,
    password: 'Awe@1234',
    confirmPassword: 'Awe@1234'
  );

  static Future init() async =>
      _prefferences = await SharedPreferences.getInstance();

//persist local data with this method
  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _prefferences.setString(_keyUSer, json);
  }
}
