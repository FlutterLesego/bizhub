// ignore_for_file: use_build_context_synchronously

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:firstapp/routes/route_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'services/service_view_model.dart';
import 'services/user_view_model.dart';

class InitApp {
  //api keys for backendless
  static const String apiKeyAndroid = 'EF5F3F88-0879-47EE-A497-92A3C9E405BC';
  static const String apiKeyIOS = '41A53273-5B94-4AC0-898D-9AE415CFE7B5';
  static const String appID = '94377661-594D-75D5-FFEE-EE0348067700';

  static void initializeApp(BuildContext context) async {
    await Backendless.initApp(
        androidApiKey: apiKeyAndroid,
        iosApiKey: apiKeyIOS,
        applicationId: appID);
    String result = await context.read<UserViewModel>().checkIfUserLoggedIn();
    if (result == 'OK') {
      context
          .read<ServiceViewModel>()
          .getServices(context.read<UserViewModel>().currentUser!.email);
      Navigator.popAndPushNamed(context, RouteManager.serviceProviderPage);
    } else {
      Navigator.popAndPushNamed(context, RouteManager.loginPage);
    }
  }
}
