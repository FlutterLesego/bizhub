// ignore_for_file: use_build_context_synchronously, unused_field, recursive_getters, body_might_complete_normally_nullable, avoid_print

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:firstapp/models/service_entry.dart';
import 'package:firstapp/routes/route_manager.dart';
import 'package:firstapp/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'service_view_model.dart';

class UserViewModel with ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final updateFormKey = GlobalKey<FormState>();

  BackendlessUser? _currentUser;
  BackendlessUser? get currentUser => _currentUser;

  void setCurrentUserToNull() {
    _currentUser = null;
  }

  //check data if user exists
  bool _userExists = false;
  bool get userExists => _userExists;

  set userExists(bool value) {
    _userExists = value;
    notifyListeners();
  }

//show progress to the user with text
  bool _showUserProgress = false;
  bool get showUserProgress => _showUserProgress;

  String _userProgressText = '';
  String get userProgressText => userProgressText;

////-------------------------------------////
// -----register new service provider-----//
  Future<String> createServiceProvider(BackendlessUser user) async {
    String result = 'OK';

    _showUserProgress = true;
    _userProgressText = 'Creating account...';
    notifyListeners();

    try {
      await Backendless.userService.register(user);
      ServiceEntry emptyEntry =
          ServiceEntry(services: {}, username: user.email);
      await Backendless.data
          .of('ServiceEntry')
          .save(emptyEntry.toJson())
          .onError((error, stackTrace) {
        result = error.toString();
      });
    } catch (e) {
      result = getError(e.toString());
    }
    _showUserProgress = false;
    notifyListeners();
    return result;
  }

////-------------------------------------////
// -----log in service provider-----//
  Future<String> loginServiceProvider(String username, String password) async {
    String result = 'OK';

    _showUserProgress = true;
    _userProgressText = "Logging in...";
    BackendlessUser? user = await Backendless.userService
        .login(username, password, true)
        .onError((error, stackTrace) {
      result = getError(error.toString());
    });
    if (user != null) {
      _currentUser = user;
    }
    _showUserProgress = false;
    notifyListeners();

    return result;
  }

//////////////////////////////////////////////////////
// -----check if service provider is logged in-----//
  Future<String> checkIfUserLoggedIn() async {
    String result = 'OK';

    bool? validLogin = await Backendless.userService
        .isValidLogin()
        .onError((error, stackTrace) {
      result = error.toString();
    });

    if (validLogin != null && validLogin) {
      String? currentObjectId = await Backendless.userService
          .loggedInUser()
          .onError((error, stackTrace) {
        result = error.toString();
      });

      if (currentObjectId != null) {
        Map<dynamic, dynamic>? mapOfCurrentUser = await Backendless.data
            .of("Users")
            .findById(currentObjectId)
            .onError((error, stackTrace) {
          result = error.toString();
        });
        if (mapOfCurrentUser != null) {
          _currentUser = BackendlessUser.fromJson(mapOfCurrentUser);
          notifyListeners();
        } else {
          result = 'NOT OK';
        }
      } else {
        result = 'NOT OK';
      }
    } else {
      result = 'NOT OK';
    }

    return result;
  }

////-------------------------------------////
// -----log out service provider-----//
  Future<String> logoutUser() async {
    String result = 'OK';

    _showUserProgress = true;
    _userProgressText = 'Logging out...';
    notifyListeners();

    await Backendless.userService.logout().onError((error, stackTrace) {
      result = error.toString();
    });
    _showUserProgress = false;
    notifyListeners();
    return result;
  }

////-------------------------------------------////
// -----reset password for service provider-----//
  Future<String> resetPassword(String username) async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = 'Resetting password';
    notifyListeners();
    await Backendless.userService
        .restorePassword(username)
        .onError((error, stackTrace) {
      result = getError(error.toString());
    });
    _showUserProgress = false;
    notifyListeners();
    return result;
  }

////-------------------------------------////
// -----check if service provider exists-----//
  void checkIfUserExists(String username) async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "email = '$username'";

    await Backendless.data
        .withClass<BackendlessUser>()
        .find(queryBuilder)
        .then((value) {
      if (value == null || value.isEmpty) {
        _userExists = false;
        notifyListeners();
      } else {
        _userExists = true;
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

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
    required String bizName,
    required String email,
    required String phoneNumber,
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
            'name': bizName.trim(),
            'phoneNumber': phoneNumber.trim(),
            'location': location.trim(),
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
    required String bizName,
    required String email,
    required String phoneNumber,
    required String location,
    required String password,
    required String confirmPassword,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (updateFormKey.currentState?.validate() ?? false) {
      if (confirmPassword.toString().trim() != password.toString().trim()) {
        showSnackBar(context, 'passwords do not match', 2000);
      } else {
        Navigator.of(context).popAndPushNamed(RouteManager.profilePage);
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

////
  ///
//-----get location function-----//

  void getCurrentLocation(BuildContext context,
      {required String location}) async {
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
        '${pmark.subThoroughfare} ${pmark.thoroughfare}';
        //${pmark.subLocality} ${pmark.locality}, ${pmark.postalCode}
        //'; //get location step by step

    location = completeAddress.toString().trim();
  }
}

////-------------------------------////
//-----error messages for users-----//
String getError(String message) {
  if (message.contains('email address must be confirmed first')) {
    return 'Please verify your email address first';
  }
  if (message.contains('User already exists')) {
    return 'Email already exists! Please create a new user or log in.';
  }
  if (message.contains('Invalid login or password')) {
    return 'Invalid credentials! Please check your username or password.';
  }
  if (message
      .contains('User account is locked out due to too many failed logins')) {
    return 'Account locked due to many failed login attempts. Please try again after 30 minutes.';
  }
  if (message.contains('Unable to find a user with the specified identity')) {
    return 'Email address not found! Please check and try again or register a new account.';
  }
  if (message.contains(
      'Unable to resolve host "api.backendless.com": No address associated with hostname')) {
    return 'No internet connection found! Please connect and try again.';
  }
  return message;
}
