// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'dart:io';

import 'package:firstapp/view_models/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

import '../misc/constants.dart';
import '../misc/validators.dart';
import '../utils/user_preferences.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/profile_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      key: context.read<UserViewModel>().updateFormKey,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBoxH20(),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {
              final image =
                  await ImagePicker().getImage(source: ImageSource.gallery);

              if (image == null) return;
              final directory = await getApplicationDocumentsDirectory();
              final name = basename(image.path);
              final imageFile = File('${directory.path}/$name');
              final newImage = await File(image.path).copy(imageFile.path);
            },
          ),
          const SizedBoxH20(),
          TextFormField(
            textInputAction: TextInputAction.next,
            validator: validateName,
            controller: nameController,
            decoration: formDecoration(
              'Full Name',
              Icons.person,
            ),
          ),
          const SizedBoxH10(),
          TextFormField(
            textInputAction: TextInputAction.done,
            validator: validateEmail,
            controller: emailController,
            decoration: formDecoration(
              'Email Address',
              Icons.email,
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            validator: validatePhone,
            controller: phoneController,
            decoration: formDecoration(
              'Phone Number',
              Icons.call,
            ),
          ),
          const SizedBoxH10(),
          TextFormField(
            textInputAction: TextInputAction.done,
            validator: validatePassword,
            controller: passwordController,
            decoration: formDecoration(
              'Password',
              Icons.lock_outline,
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            validator: validateConfirmPassword,
            controller: confirmPasswordController,
            decoration: formDecoration(
              'Confirm Password',
              Icons.lock_outline,
            ),
          ),
          CupertinoButton(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.indigo,
              child: const Text(
                'SAVE CHANGES',
                style: style16White,
              ),
              onPressed: () {
                context.read<UserViewModel>().updateUserInUI(context,
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    phone: phoneController.text.trim(),
                    password: passwordController.text.trim(),
                    confirmPassword: confirmPasswordController.text.trim());
              }),
        ],
      ),
    );
  }
}
