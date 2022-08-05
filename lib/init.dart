import 'package:firstapp/routes/route_manager.dart';
import 'package:flutter/cupertino.dart';

class InitApp {
  static void initializeApp(BuildContext context) async {
    Navigator.popAndPushNamed(context, RouteManager.loginPage);
  }
}
