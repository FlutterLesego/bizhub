// ignore_for_file: use_build_context_synchronously

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:bizhub/routes/route_manager.dart';
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
    //initialize app with database
    await Backendless.initApp(
        androidApiKey: apiKeyAndroid,
        iosApiKey: apiKeyIOS,
        applicationId: appID);
    String result = await context.read<UserViewModel>().checkIfUserLoggedIn();
    //director the user to service provider page if already logged in
    if (result == 'OK') {
      context
          .read<ServiceViewModel>()
          .getServices(context.read<UserViewModel>().currentUser!.email);
      Navigator.popAndPushNamed(context, RouteManager.serviceProviderPage);
    } else {
      //director the user to the bizhub home page if not logged in
      context.read<ServiceViewModel>().getServices;
      Navigator.popAndPushNamed(context, RouteManager.bizhubHomePage);
    }
  }
}
