import 'package:firstapp/misc/constants.dart';
import 'package:firstapp/models/user_model.dart';
import 'package:firstapp/routes/route_manager.dart';
import 'package:firstapp/utils/user_preferences.dart';
import 'package:firstapp/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBoxH20(),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {
              Navigator.popAndPushNamed(context, RouteManager.editProfilePage);
            },
          ),
          const SizedBoxH20(),
          buildName(user),
          const SizedBoxH10(),
          buildEmail(user),
          const SizedBoxH10(),
          buildPhoneNumber(user),
          const SizedBoxH30(),
          Center(child: buildButton()),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: title26Indigo,
          )
        ],
      );

  Widget buildEmail(User user) => Column(
        children: [
          Text(
            user.emailAddress,
            style: style16Indigo,
          )
        ],
      );

  Widget buildPhoneNumber(User user) => Column(
        children: [
          Text(
            user.phoneNumber.toString(),
            style: style16Indigo,
          )
        ],
      );

  Widget buildButton() => ButtonBar(
        alignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton.icon(
              onPressed: () async {
                await Navigator.popAndPushNamed(context, RouteManager.editProfilePage);
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.indigo,
              ),
              label: const Text(
                'Edit Profile',
                style: style14Black,
              )),
          TextButton.icon(
            onPressed: () {
            },
            icon: const Icon(
              Icons.delete_forever_outlined,
              color: Colors.indigo,
            ),
            label: const Text(
              'Delete Account',
              style: style14Black,
            ),
          ),
        ],
      );
}
