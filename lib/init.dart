// ignore_for_file: use_build_context_synchronously

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:firstapp/routes/route_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'services/service_view_model.dart';
import 'services/user_view_model.dart';

class InitApp {
  //api keys for backendless
  static const String apiKeyAndroid = 'B55C94D4-F218-43C5-9D3B-6FBB02FECBFC';
  static const String apiKeyIOS = '7095D503-DC3E-4A60-88E5-5CCD1F95A042';
  static const String appID = 'BCB6B236-BDDD-98CB-FFBD-96E39787DE00';

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
      List<Map<dynamic, dynamic>?>? map = await Backendless.data
          .of("ServiceEntry")
          .find()
          .onError((error, stackTrace) {
        result = error.toString();
      });
      context.read<ServiceViewModel>().getAllServices.toString();
      Navigator.popAndPushNamed(context, RouteManager.firstAppHomePage);
    }
  }
}
