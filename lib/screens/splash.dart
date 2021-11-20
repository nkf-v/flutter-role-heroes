import 'package:flutter/material.dart';
import 'package:role_heroes/controllers/auth.dart';
import 'package:role_heroes/screens/game_list.dart';
import 'package:role_heroes/screens/login.dart';

class SplashScreen extends StatefulWidget {
  static final routeName = '/';

  final IAuthController controller = AuthController();

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    widget.controller.checkAuth().then((isAuth) {
      if (isAuth) {
        Navigator.of(context).pushReplacementNamed(GameScreen.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }
    }).catchError((error) {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    });

    return Scaffold(
      body: Container(
        child: Center(
          // TODO change logo
          child: FlutterLogo(
            size: 200.0,
          ),
        ),
      ),
    );
  }
}
