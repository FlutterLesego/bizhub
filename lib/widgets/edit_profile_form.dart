// ignore_for_file: deprecated_member_use, depend_on_referenced_packages, must_be_immutable

import 'dart:io';

import 'package:firstapp/services/user_view_model.dart';
import 'package:firstapp/widgets/radio_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../misc/constants.dart';
import '../misc/validators.dart';
import '../services/helper_user.dart';

class EditProfileForm extends StatefulWidget {
  static const route = '/EditProfilePage';

  const EditProfileForm({Key? key}) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final bizNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final cipcNumberController = TextEditingController();
  final idNumberController = TextEditingController();
  BusinessTypeEnum? _businessTypeEnum;

  XFile? imageXFile;

  String bizImageUrl = "";

  Future _pickImage(String bizImage) async {
    imageXFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
      bizImageUrl = imageXFile!.path.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    bizNameController.text =
        context.read<UserViewModel>().currentUser!.getProperty('name');
    emailController.text = context.read<UserViewModel>().currentUser!.email;
    phoneController.text =
        context.read<UserViewModel>().currentUser!.getProperty('phoneNumber');
    locationController.text =
        context.read<UserViewModel>().currentUser!.getProperty('location');
    passwordController.text = context
        .read<UserViewModel>()
        .currentUser!
        .getProperty('confirmPassword');
    confirmPasswordController.text = context
        .read<UserViewModel>()
        .currentUser!
        .getProperty('confirmPassword');
    _businessTypeEnum!.index;
    cipcNumberController.text =
        context.read<UserViewModel>().currentUser!.getProperty('cipcNumber');
    idNumberController.text =
        context.read<UserViewModel>().currentUser!.getProperty('idNumber');
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

    completeAddress = '${pmark.locality}'; //get location step by step

    locationController.text = completeAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: registerFormKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: InkWell(
                onTap: () {
                  _pickImage(bizImageUrl);
                },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 5,
                  backgroundColor: Colors.indigo.shade50,
                  backgroundImage:
                      imageXFile == null ? null : FileImage(File(bizImageUrl)),
                  child: imageXFile == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              size: MediaQuery.of(context).size.width / 5,
                            )
                          ],
                        )
                      : null,
                ),
              )),
              const SizedBoxH10(),
              TextFormField(
                validator: validateBizName,
                controller: bizNameController,
                decoration: formDecoration(
                  "Biz Name",
                  Icons.person_outline,
                ),
              ),
              const SizedBoxH10(),
              TextFormField(
                validator: validateEmail,
                controller: emailController,
                decoration: formDecoration(
                  "Email Address",
                  Icons.mail_outline,
                ),
              ),
              const SizedBoxH10(),
              TextFormField(
                validator: validatePhone,
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: formDecoration(
                  "Phone Number",
                  Icons.phone_outlined,
                ),
              ),
              const SizedBoxH10(),
              //
              //business type radio
              //Registered business button
              //
              const Text(
                "Business Registration Type",
                style: style14grey,
              ),
              const SizedBoxH5(),
              Row(
                children: [
                  RadioButton(
                      title: BusinessTypeEnum.Registered.name,
                      selectedBusinessType: _businessTypeEnum,
                      value: BusinessTypeEnum.Registered,
                      onChanged: (newValue) {
                        setState(() {
                          _businessTypeEnum = newValue;
                        });
                      }),
                  const SizedBoxW10(),
                  RadioButton(
                      title: BusinessTypeEnum.Unregistered.name,
                      selectedBusinessType: _businessTypeEnum,
                      value: BusinessTypeEnum.Unregistered,
                      onChanged: (newValue) {
                        setState(() {
                          _businessTypeEnum = newValue;
                        });
                      }),
                ],
              ),
              const SizedBoxH10(),
              if (_businessTypeEnum == BusinessTypeEnum.Registered)
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: cipcNumberController,
                    validator: validateCIPC,
                    keyboardType: TextInputType.number,
                    decoration: formDecoration(
                        "CIPC registration number", Icons.business))
              else if (_businessTypeEnum == BusinessTypeEnum.Unregistered)
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: idNumberController,
                  validator: validateIDNumber,
                  keyboardType: TextInputType.number,
                  decoration: formDecoration(
                      "Biz Owner ID Number", Icons.perm_identity_sharp),
                ),

              const SizedBoxH10(),
              //business location
              //
              TextFormField(
                controller: locationController,
                enabled: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validateLocation,
                textInputAction: TextInputAction.next,
                decoration: formDecoration("Biz Location", Icons.location_pin),
              ),
              const SizedBoxH10(),
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
                    "Update Location",
                    style: TextStyle(color: Colors.white),
                  )),
              const SizedBoxH10(),
              TextFormField(
                validator: validatePassword,
                controller: passwordController,
                decoration: formDecoration(
                  "Password",
                  Icons.lock_outline,
                ),
              ),
              const SizedBoxH10(),
              TextFormField(
                validator: validateConfirmPassword,
                controller: confirmPasswordController,
                decoration: formDecoration(
                  "Confirm Password",
                  Icons.lock_outline,
                ),
              ),
              const SizedBoxH20(),
              CupertinoButton(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.indigo,
                  child: const Text(
                    'Update Profile',
                    style: style16White,
                  ),
                  onPressed: () {
                    updateUserInUI(context,
                        bizLogo: bizImageUrl.toString().trim(),
                        name: bizNameController.text.trim(),
                        email: emailController.text.trim(),
                        phoneNumber: phoneController.text.trim(),
                        location: locationController.text.trim(),
                        password: passwordController.text.trim(),
                        confirmPassword: confirmPasswordController.text.trim(),
                        businessType: _businessTypeEnum!,
                        cipcNumber: cipcNumberController.text.trim(),
                        idNumber: idNumberController.text.trim());
                  }),
            ],
          ),
        ));
  }
}
