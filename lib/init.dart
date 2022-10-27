import 'package:firstapp/routes/route_manager.dart';
import 'package:flutter/cupertino.dart';

class InitApp {
  //api keys for backendless
  static const String apiKeyAndroid = 
  'EF5F3F88-0879-47EE-A497-92A3C9E405BC';
  static const String apiKeyIOS = 
  '41A53273-5B94-4AC0-898D-9AE415CFE7B5';
  static const String appID = 
  '94377661-594D-75D5-FFEE-EE0348067700';

  static void initializeApp(BuildContext context) async {
    Navigator.popAndPushNamed(context, RouteManager.loginPage);
  }
}
