import 'package:firstapp/widgets/app_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../misc/constants.dart';
import '../routes/route_manager.dart';
import '../services/helper_user.dart';
import '../services/user_view_model.dart';
import 'profile_widget.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

// - - - - header of the drawer - - - - - //
  Widget buildHeader(BuildContext context) => Material(
        color: Colors.indigo.shade50,
        child: InkWell(
          onTap: () async {
            Navigator.pop(context);
            Navigator.of(context).pushNamed(RouteManager.loginPage);
          },
          child: Container(
            padding: EdgeInsets.only(
                top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBoxH10(),
                Text(
                  "Got a Biz?",
                  style: titleStyleBlack,
                ),
                const SizedBoxH5(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login/Register",
                      style: style16Indigo,
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                )
              ],
            ),
          ),
        ),
      );

// - - - - - menu items of the drawer - - - - - //
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          runSpacing: 15,
          children: [
            ListTile(
              leading: const Icon(
                Icons.info_outlined,
                color: Colors.indigo,
              ),
              title: const Text(
                'About bizHub',
                style: style16Indigo,
              ),
              onTap: () {
                showAboutDialog(
                    context: context,
                    applicationName: "bizHub",
                    applicationVersion: "version 1.0");
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.indigo,
              ),
              title: const Text(
                'Exit App',
                style: style16Indigo,
              ),
              onTap: () async {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
}
