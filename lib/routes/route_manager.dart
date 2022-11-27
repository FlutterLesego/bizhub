// ignore: avoid_web_libraries_in_flutter, unused_import

import 'package:firstapp/pages/first_app_home.dart';
import 'package:firstapp/pages/loading_page.dart';
import 'package:firstapp/pages/profile_page.dart';
import 'package:firstapp/pages/view_ratings_page.dart';
import 'package:firstapp/pages/view_service_page.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/categories_page.dart';
import '../pages/directory_page.dart';
import '../pages/edit_profile_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/service_provider_page.dart';
import '../widgets/add_service.dart';

class RouteManager {
  static const String loadingPage = '/';
  static const String loginPage = '/loginPage';
  static const String registerPage = 'registerPage';
  static const String firstAppHomePage = 'firstAppHomePage';
  static const String profilePage = 'profilePage';
  static const String editProfilePage = 'editProfilePage';
  static const String serviceProviderPage = 'serviceProviderPage';
  static const String serviceAddPage = 'serviceAddPage';
  static const String directoryPage = 'directoryPage';
  static const String categoriesPage = 'categoriesPage';
  static const String viewServicePage = 'viewServicePage';
  static const String viewRatingsPage = 'viewRatingsPage';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      //route for loading page
      case loadingPage:
        return MaterialPageRoute(
          builder: (context) => const LoadingPage(),
        );

      //route for login page
      case loginPage:
        return MaterialPageRoute(builder: (context) => const LoginPage());

      //route for register page
      case registerPage:
        return MaterialPageRoute(builder: (context) => const RegisterPage());

      //route for home page
      case firstAppHomePage:
        return MaterialPageRoute(builder: (context) => const FirstAppHome());

      //profile page route
      case profilePage:
        return MaterialPageRoute(builder: (context) => const ProfilePage());

      case editProfilePage:
        return MaterialPageRoute(builder: (context) => EditProfilePage());

      //route for service provider home screen
      case serviceProviderPage:
        return MaterialPageRoute(
            builder: (context) => const ServiceProviderPage());

      //route for adding a service
      case serviceAddPage:
        return MaterialPageRoute(builder: (context) => const ServiceAdd());

      //route for directory
      case directoryPage:
        return MaterialPageRoute(builder: (context) => const DirectoryPage());

      //route for categories page
      case categoriesPage:
        return MaterialPageRoute(builder: (context) => const CategoriesPage());

      //route for viewing a particular service
      case viewServicePage:
        return MaterialPageRoute(builder: (context) => const ViewServicePage());

      //route for viewing ratings for a service
      case viewRatingsPage:
        return MaterialPageRoute(builder: (context) => const ViewRatingsPage());

      default:
        throw Exception("No route found!");
    }
  }
}
