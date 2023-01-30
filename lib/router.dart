import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/authentication/screens/login_screen.dart';
import 'package:amazon_clone/features/homePage/screen/home_screen.dart';
import 'package:amazon_clone/features/homePage/screen/landing_screen.dart';
import 'package:flutter/material.dart';
import 'features/homePage/screen/edituser.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const LoginScreen(),
        );
      }

    case LandingScreen.routeName:
      {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const LandingScreen(),
        );
      }

    case HomeScreen.routeName:
      {
        //final argument = settings.arguments as UserModel;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const HomeScreen(),
        );
      }

    case EditUserDetails.routeName:
      {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const EditUserDetails(),
        );
      }
    case AdminScreen.routeName:
      {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const AdminScreen(),
        );
      }

    default:
      {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("This Page Doesn't Exists"),
            ),
          ),
        );
      }
  }
}
