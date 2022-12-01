import 'package:bizhub/init.dart';
import 'package:bizhub/misc/constants.dart';
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
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
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
