import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:firstapp/misc/constants.dart';
import 'package:firstapp/models/user_model.dart';
import 'package:firstapp/routes/route_manager.dart';
import 'package:firstapp/view_models/user_view_model.dart';
import 'package:firstapp/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBoxH20(),
          ProfileWidget(
            imagePath: context.read<UserViewModel>().currentUser!.getProperty('imagePath'),
            onClicked: () async {
              Navigator.popAndPushNamed(context, RouteManager.editProfilePage);
            },
          ),
          const SizedBoxH20(),
          buildName(context),
          const SizedBoxH10(),
          buildEmail(context),
          const SizedBoxH10(),
          buildPhoneNumber(context),
          const SizedBoxH30(),
          Center(child: buildButton()),
        ],
      ),
    );
  }

  Widget buildName(BuildContext context) => Column(
        children: [
          Text(
            context.read<UserViewModel>().currentUser!.getProperty('bizName'),
            style: title26Indigo,
          )
        ],
      );

  Widget buildEmail(BuildContext context) => Column(
        children: [
          Text(
            context.read<UserViewModel>().currentUser!.getProperty('email'),
            style: style16Indigo,
          )
        ],
      );

  Widget buildPhoneNumber(BuildContext context) => Column(
        children: [
          Text(
            context.read<UserViewModel>().currentUser!.getProperty('phoneNumber'),
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
