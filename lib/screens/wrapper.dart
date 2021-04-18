import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twisun/models/user_model.dart';
import 'package:twisun/screens/home/home_screen.dart';
import 'package:twisun/screens/splash/splash_screen.dart';

class Wrapper extends StatelessWidget {
  static String routeName = "/wrapper";
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return SplashScreen();
    } else {
      return HomeScreen();
      /*
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (route) => false);*/
    }
  }
}
