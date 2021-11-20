import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:role_heroes/screens/game_list.dart';
import 'package:role_heroes/screens/hero_change_values.dart';
import 'package:role_heroes/screens/hero_create.dart';
import 'package:role_heroes/screens/hero_detail.dart';
import 'package:role_heroes/screens/hero_list.dart';
import 'package:role_heroes/screens/login.dart';
import 'package:role_heroes/screens/register.dart';
import 'package:role_heroes/screens/splash.dart';
import 'package:role_heroes/setup_get_it.dart';
import 'package:role_heroes/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Role heroes',
      theme: LightTheme.build(context),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ru', ''),
      ],
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        GameScreen.routeName: (context) => GameScreen(),
        HeroListScreen.routeName: (context) => HeroListScreen(),
        HeroDetailScreen.routeName: (context) => HeroDetailScreen(),
        HeroCreateScreen.routeName: (context) => HeroCreateScreen(),
        HeroChangeStructuralValues.routeName: (context) => HeroChangeStructuralValues(),
      },
    );
  }
}
