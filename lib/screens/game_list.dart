import 'package:flutter/material.dart';
import 'package:role_heroes/components/game_list.dart';
import 'package:role_heroes/widgets/app_bar_default.dart';

class GameScreen extends StatelessWidget {
  static const routeName = '/games';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Games'),
      body: Container(
        child: GameList(),
      ),
    );
  }
}
