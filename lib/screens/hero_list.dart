import 'package:flutter/material.dart';
import 'package:role_heroes/components/hero_list.dart';
import 'package:role_heroes/screens/hero_create.dart';
import 'package:role_heroes/widgets/app_bar_default.dart';

class HeroListScreen extends StatelessWidget {
  static String routeName = '/heroes';

  @override
  Widget build(BuildContext context) {
    int gameId = (ModalRoute.of(context).settings.arguments as Map<String, dynamic>)['gameId'] as int;
    return Scaffold(
      appBar: DefaultAppBar(title: 'Heroes'),
      body: HeroList(gameId: gameId),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(HeroCreateScreen.routeName, arguments: <String, dynamic>{'gameId': gameId});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
