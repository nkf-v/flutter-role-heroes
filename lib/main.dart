import 'package:flutter/material.dart';
import 'package:role_heroes/screens/hero_detail.dart';
import 'package:role_heroes/screens/login.dart';
import 'package:role_heroes/screens/register.dart';
import 'package:role_heroes/themes/light_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Role heroes',
      theme: LightTheme.build(context),
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HeroDetailScreen.routeName: (context) => HeroDetailScreen(),
      },
    );
  }
}
