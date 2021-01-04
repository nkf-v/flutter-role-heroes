import 'package:flutter/material.dart';
import 'package:role_heroes/screens/hero_detail.dart';
import 'package:role_heroes/themes/light_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Role heroes',
      theme: LightTheme.build(context),
      home: HeroDetailScreen(),
//      routes: {
//        '/hero_list': (context) => HeroListScreen(),
//        HeroDetailScreen.routeName: (context) => HeroDetailScreen(),
//      },
    );
  }
}
