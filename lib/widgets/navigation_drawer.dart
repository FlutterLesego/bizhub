import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:firstapp/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../misc/constants.dart';
import '../routes/route_manager.dart';
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
                  imagePath: context.read<UserViewModel>().currentUser!.getProperty('imagePath'),
                  onClicked: () async {
                    Navigator.popAndPushNamed(
                        context, RouteManager.profilePage);
                  },
                ),
                const SizedBoxH10(),
                Text(
                  context
                      .read<UserViewModel>()
                      .currentUser!
                      .getProperty('name'),
                  style: style14White,
                ),
                const SizedBoxH10(),
                Text(
                  context
                      .read<UserViewModel>()
                      .currentUser!
                      .getProperty('email'),
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
                Icons.home_outlined,
                color: Colors.indigo,
              ),
              title: const Text(
                'Home',
                style: style16Indigo,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteManager.serviceProviderPage);
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
                context.read<UserViewModel>().logoutUserInUI(context);
              },
            )
          ],
        ),
      );
}
