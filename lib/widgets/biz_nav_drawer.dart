import 'package:bizhub/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../misc/constants.dart';
import '../routes/route_manager.dart';
import '../services/helper_user.dart';
import '../services/user_view_model.dart';

class BizNavigationDrawer extends StatelessWidget {
  const BizNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ProfileWidget(),
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
                logoutUserInUI(context);
              },
            )
          ],
        ),
      );
}
