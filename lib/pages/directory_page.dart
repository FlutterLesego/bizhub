import 'package:firstapp/misc/constants.dart';
import 'package:flutter/material.dart';

import '../routes/route_manager.dart';
import '../widgets/login_form.dart';

class DirectoryPage extends StatefulWidget {
  const DirectoryPage({Key? key}) : super(key: key);

  @override
  State<DirectoryPage> createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              Navigator.popAndPushNamed(
                  context, RouteManager.serviceProviderPage);
            }),
        backgroundColor: Colors.indigo,
        title: const Text('Add a service', style: style16White),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const Text("bizHub", style: titleStyleIndigo),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: SingleChildScrollView(
                child: LoginForm(),
              ),
            ),
          )
        ]),
      )),
    );
  }
}
