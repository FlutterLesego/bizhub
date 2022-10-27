import 'package:firstapp/utils/user_preferences.dart';
import 'package:flutter/material.dart';

import '../misc/constants.dart';
import '../routes/route_manager.dart';
import 'app_progress_indicator.dart';
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

//header of the drawer
  Widget buildHeader(BuildContext context) => Material(

        color: Colors.indigoAccent.shade100,
        child: InkWell(
          onTap: () async {
            Navigator.pop(context);
            Navigator.of(context).pushNamed(RouteManager.profilePage);
          },
          child: Container(
            padding: EdgeInsets.only(
                top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               ProfileWidget(
                imagePath: UserPreferences.myUser.imagePath,
                onClicked: () async {
                 Navigator.popAndPushNamed(context, RouteManager.profilePage);
                },
              ),
                const SizedBoxH10(),
                Text(
                  UserPreferences.myUser.name,
                  style: style14White,
                ),
                const SizedBoxH10(),
                Text(UserPreferences.myUser.emailAddress)
              ],
            ),
          ),
        ),
      );

//menu items of the drawer
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          runSpacing: 15,
          children: [
            ListTile(
              leading: const Icon(
                Icons.home_outlined,
                color: Colors.indigo,
              ),
              title: const Text(
                'Home',
                style: style16Indigo,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteManager.firstAppHomePage);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.favorite_border,
                color: Colors.indigo,
              ),
              title: const Text(
                'Favourites',
                style: style16Indigo,
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, RouteManager.favouritesPage);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                color: Colors.indigo,
              ),
              title: const Text(
                'Notifications',
                style: style16Indigo,
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, RouteManager.notificationsPage);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.receipt_long_outlined,
                color: Colors.indigo,
              ),
              title: const Text(
                'History',
                style: style16Indigo,
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context,RouteManager.historyPage);
              },
            ),
            const Divider(
              height: 20.0,
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.indigo,
              ),
              title: const Text(
                'Logout',
                style: style16Indigo,
              ),
              onTap: () async {
                const AppProgressIndicator(text: "Logging out...");
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteManager.loginPage);
              },
            )
          ],
        ),
      );
}