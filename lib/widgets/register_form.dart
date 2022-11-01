import 'package:firstapp/misc/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../misc/validators.dart';
import '../view_models/user_view_model.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late TextEditingController bizNameController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    bizNameController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    locationController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    bizNameController.dispose();
    nameController.dispose();
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
    return Form(
        key: context.read<UserViewModel>().registerFormKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "bizHub",
                style: titleStyleIndigo,
              ),
              const SizedBoxH20(),
              TextFormField(
                validator: validateBizName,
                controller: nameController,
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
              TextFormField(
                validator: validatePhone,
                controller: phoneController,
                decoration: formDecoration(
                  "Phone Number",
                  Icons.mail_outline,
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
                    'Sign up',
                    style: style16White,
                  ),
                  onPressed: () {
                    context.read<UserViewModel>().createServiceProviderInUI(
                        context,
                        bizName: bizNameController.text.trim(),
                        email: emailController.text.trim(),
                        phone: phoneController.text.trim(),
                        location: locationController.text.trim(),
                        password: passwordController.text.trim(),
                        confirmPassword: confirmPasswordController.text.trim());
                  }),
            ],
          ),
        ));
  }
}
