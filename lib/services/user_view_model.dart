// ignore_for_file: use_build_context_synchronously, unused_field, recursive_getters, body_might_complete_normally_nullable, avoid_print

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:bizhub/models/service_entry.dart';
import 'package:flutter/cupertino.dart';

class UserViewModel with ChangeNotifier {
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
// -----update service provider-----//
  Future<String> updateServiceProvider(BackendlessUser user) async {
    String result = 'OK';
    DataQueryBuilder queryBuilder = DataQueryBuilder();
    queryBuilder.whereClause = "user = user";
    Backendless.data
        .of('Users')
        .find(queryBuilder)
        .then((users) {})
        .onError((error, stackTrace) {
      result = error.toString();
    });

    _showUserProgress = true;
    _userProgressText = 'Updating details...';
    notifyListeners();

    try {
      await Backendless.userService.update(user);
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
}
