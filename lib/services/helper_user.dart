// ignore_for_file: use_build_context_synchronously

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:firstapp/widgets/radio_button.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../routes/route_manager.dart';
import '../widgets/dialogs.dart';
import 'service_view_model.dart';
import 'user_view_model.dart';

final loginFormKey = GlobalKey<FormState>();
final registerFormKey = GlobalKey<FormState>();
final updateFormKey = GlobalKey<FormState>();

//log in the user in UI
void loginServiceProviderInUI(BuildContext context,
    {required String email, required String password}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  if (loginFormKey.currentState?.validate() ?? false) {
    String result = await context
        .read<UserViewModel>()
        .loginServiceProvider(email.trim(), password.trim());
    if (result != 'OK') {
      showSnackBar(context, result, 3000);
    } else {
      //get the users' services
      context.read<ServiceViewModel>().getServices(email);
      Navigator.of(context).popAndPushNamed(RouteManager.serviceProviderPage);
    }
  }
}

//create new service provider method
void createServiceProviderInUI(
  BuildContext context, {
  required String bizLogo,
  required String name,
  required String email,
  required String phoneNumber,
  required BusinessTypeEnum businessType,
  String? cipcNumber,
  String? idNumber,
  required String location,
  required String password,
  required String confirmPassword,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (registerFormKey.currentState?.validate() ?? false) {
    if (confirmPassword.toString().trim() != password.toString().trim()) {
      showSnackBar(context, 'passwords do not match', 2000);
    } else {
      BackendlessUser user = BackendlessUser()
        ..email = email.trim()
        ..password = password.trim()
        ..putProperties({
          'bizLogo': bizLogo.trim(),
          'name': name.trim(),
          'phoneNumber': phoneNumber.trim(),
          'location': location.trim(),
          'confirmPassword': confirmPassword.trim(),
          'businessType': businessType.toString().trim(),
          'cipcNumber': cipcNumber!.trim(),
          'idNumber': idNumber!.trim()
        });

      String result =
          await context.read<UserViewModel>().createServiceProvider(user);
      if (result != 'OK') {
        showSnackBar(context, result, 3000);
      } else {
        showSnackBar(context, 'Account Created Successfully!', 1500);
        showSnackBar(context, 'Please check your email and verify!', 2500);
        Navigator.of(context).popAndPushNamed(RouteManager.loginPage);
      }
    }
  }
}

void updateUserInUI(
  BuildContext context, {
  required String bizLogo,
  required String name,
  required String email,
  required String phoneNumber,
  required BusinessTypeEnum businessType,
  String? cipcNumber,
  String? idNumber,
  required String location,
  required String password,
  required String confirmPassword,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (updateFormKey.currentState?.validate() ?? false) {
    if (confirmPassword.toString().trim() != password.toString().trim()) {
      showSnackBar(context, 'passwords do not match', 2000);
    } else {
      BackendlessUser user = BackendlessUser()
        ..email = email.trim()
        ..password = password.trim()
        ..putProperties({
          'bizLogo': bizLogo.trim(),
          'name': name.trim(),
          'phoneNumber': phoneNumber.trim(),
          'location': location.trim(),
          'confirmPassword': confirmPassword.trim(),
          'businessType': businessType.toString().trim(),
          'cipcNumber': cipcNumber!.trim(),
          'idNumber': idNumber!.trim()
        });

      String result =
          await context.read<UserViewModel>().updateServiceProvider(user);
      if (result != 'OK') {
        showSnackBar(context, result, 3000);
      } else {
        showSnackBar(context, 'Details Updated Successfully!', 1500);
        Navigator.of(context).popAndPushNamed(RouteManager.profilePage);
      }
    }
  }
}

void logoutUserInUI(BuildContext context) async {
  String result = await context.read<UserViewModel>().logoutUser();

  if (result == 'OK') {
    context.read<UserViewModel>().setCurrentUserToNull();
    Navigator.popAndPushNamed(context, RouteManager.firstAppHomePage);
  } else {
    showSnackBar(context, result, 3000);
  }
}

void resetPasswordInUI(BuildContext context, {required String email}) async {
  if (email.isEmpty) {
    showSnackBar(context,
        'Please enter email address and click on "Reset Password"', 3000);
  } else {
    String result = await context.read<UserViewModel>().resetPassword(email);
    if (result == 'OK') {
      showSnackBar(context, "Reset instructions sent to $email", 3000);
    } else {
      showSnackBar(context, result, 3500);
    }
  }
}

void deleteAccountInUI(BuildContext context) {}

String completeAddress = "";
Position? position;
List<Placemark>? placeMark;

void getBusinessType(BuildContext context,
    {required ValueChanged valueChanged}) async {
  if (valueChanged.toString().isEmpty) {
    showSnackBar(context, "Please select business type", 2000);
  }
}
