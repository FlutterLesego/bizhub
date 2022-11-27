// ignore_for_file: use_build_context_synchronously

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/routes/route_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'services/service_view_model.dart';
import 'services/user_view_model.dart';

class InitApp {
  //api keys for backendless
  // static const String apiKeyAndroid = 'BC6FAE11-A586-4282-90CF-B47421B5299B';
  // static const String apiKeyIOS = '7C7B13A1-6824-44DC-8C1B-4A2DD6F8682E';
  // static const String appID = 'BCB6B236-BDDD-98CB-FFBD-96E39787DE00';

  static void initializeApp(BuildContext context) async {
    await Firebase.initializeApp();
    // await Backendless.initApp(
    //     androidApiKey: apiKeyAndroid,
    //     iosApiKey: apiKeyIOS,
    //     applicationId: appID);
    String result = await context.read<UserViewModel>().checkIfUserLoggedIn();
    if (result == 'OK') {
      context
          .read<ServiceViewModel>()
          .getServices(context.read<UserViewModel>().currentUser!.email);
      Navigator.popAndPushNamed(context, RouteManager.serviceProviderPage);
    } else {
      Navigator.popAndPushNamed(context, RouteManager.firstAppHomePage);
    }
  }
}
