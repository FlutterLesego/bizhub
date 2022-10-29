import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:firstapp/routes/route_manager.dart';
import 'package:firstapp/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

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

//create a new user
  Future<String> createUserAccount(BackendlessUser user) async {
    String result = 'OK';

    _showUserProgress = true;
    _userProgressText = 'Creating account';
    notifyListeners();
//register new user
    try {
      await Backendless.userService.register(user);
      BizHubEntry emptyEntry = BizHubEntry(services: {}, username: user.email);
      await Backendless.data
          .of('BizHubEntry')
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

//check if user exists
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

      if (currentUserObjectId != null) {
        Map<dynamic, dynamic>? mapOfCurrentUser = await Backendless.data
            .of("Users")
            .findById(currentUserObjectId)
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

//check if user exists inUI
  void checkIfUserExists(String username) async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "email = '$username'";

    await Backendless.data
        .withClass<BackendlessUser>()
        .find(queryBuilder)
        .then((value) {
      if (value == null || value.length == 0) {
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
  void loginUserInUI(BuildContext context,
      {required String email, required String password}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (loginFormKey.currentState?.validate() ?? false) {
      Navigator.of(context).popAndPushNamed(RouteManager.firstAppHomePage);
      //showSnackBar();
    }
  }

  void createUserInUI(
    BuildContext context, {
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (registerFormKey.currentState?.validate() ?? false) {
      if (confirmPassword.toString().trim() != password.toString().trim()) {
        showSnackBar(context, 'passwords do not match', 2000);
      } else {
        Backendless user = BackendlessUser()
          ..email = email.trim()
          ..password = password.trim();

        String result =
            await context.read<UserViewModel>().createUserAccount(user);
        if (result != 'OK') {
          showSnackBar(context, result, 3000);
        } else {
          showSnackBar(context, 'Account Created successfully!', 3000);
          Navigator.of(context).popAndPushNamed(RouteManager.firstAppHomePage);
        }

      }
    }
  }

  void updateUserInUI(
    BuildContext context, {
    required String name,
    required String email,
    required String phone,
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
    Navigator.popAndPushNamed(context, RouteManager.loginPage);
  }

  void resetPasswordInUI(BuildContext context, {required String email}) async {
    if (email.isEmpty) {
      showSnackBar(context,
          'Please enter email address and click on "Reset Password"', 4000);
    } else {
      showSnackBar(context, 'Reset instructions sent to $email ', 3000);
    }
  }
}
