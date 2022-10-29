import 'dart:async';

import 'package:firstapp/init.dart';
import 'package:firstapp/misc/constants.dart';
import 'package:firstapp/routes/route_manager.dart';
import 'package:flutter/material.dart';

import '../widgets/app_progress_indicator.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  //implement init state to initialize app
  void initState() {
    //set timer before directing to next page
    Timer(
        //set time in seconds
        const Duration(seconds: 5), () {
      //go to login page after 5 seconds of the loading page
      Navigator.popAndPushNamed(context, RouteManager.serviceProviderPage);
    });
    super.initState();
    InitApp.initializeApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "bizHub",
            style: titleStyleIndigo,
          ),
          SizedBoxH20(),
          AppProgressIndicator(),
        ],
      )),
    );
  }
}
