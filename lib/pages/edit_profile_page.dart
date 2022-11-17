// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'dart:io';
import 'package:firstapp/widgets/radio_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../misc/constants.dart';
import '../misc/validators.dart';
import '../services/helper_user.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/profile_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController bizNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController locationController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    bizNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    locationController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    bizNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String completeAddress = "";
  Position? position;
  List<Placemark>? placeMark;

////
  ///
//-----get location function-----//

  void getCurrentLocation() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      await Geolocator.openLocationSettings();
    }

    Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    position = newPosition;

    placeMark = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );

    Placemark pmark = placeMark![0];

    completeAddress =
        '${pmark.locality}, ${pmark.subAdministrativeArea}, ${pmark.administrativeArea} ${pmark.postalCode}'; //get location step by step

    locationController.text = completeAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      key: updateFormKey,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBoxH20(),
          // ProfileWidget(
          //   imagePath: '',
          //   onClicked: () async {
          //     final image =
          //         await ImagePicker().getImage(source: ImageSource.gallery);

          //     if (image == null) return;
          //     final directory = await getApplicationDocumentsDirectory();
          //     final name = basename(image.path);
          //     final imageFile = File('${directory.path}/$name');
          //     final newImage = await File(image.path).copy(imageFile.path);
          //   },
          // ),
          const SizedBoxH20(),
          TextFormField(
            textInputAction: TextInputAction.next,
            validator: validateBizName,
            controller: bizNameController,
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
            controller: locationController,
            enabled: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validateLocation,
            textInputAction: TextInputAction.next,
            decoration: formDecoration("Biz Location", Icons.location_pin),
          ),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () {
                getCurrentLocation();
              },
              icon: const Icon(
                Icons.location_searching,
                color: Colors.white,
              ),
              label: const Text(
                "Get Current Location",
                style: TextStyle(color: Colors.white),
              )),
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
                updateUserInUI(context,
                    name: bizNameController.text.trim(),
                    email: emailController.text.trim(),
                    phoneNumber: phoneController.text.trim(),
                    location: locationController.text.trim(),
                    password: passwordController.text.trim(),
                    confirmPassword: confirmPasswordController.text.trim(),
                    businessType: BusinessTypeEnum.Registered);
              }),
        ],
      ),
    );
  }
}
