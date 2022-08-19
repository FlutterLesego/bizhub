import 'package:firstapp/misc/constants.dart';
import 'package:firstapp/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstAppHome extends StatefulWidget {
  const FirstAppHome({Key? key}) : super(key: key);

  @override
  State<FirstAppHome> createState() => _FirstAppHomeState();
}

class _FirstAppHomeState extends State<FirstAppHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "first app",
          style: style16White,
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<UserViewModel>().logoutUserInUI(context);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: const Center(child: Text("Home Screen!")),
    );
  }
}
