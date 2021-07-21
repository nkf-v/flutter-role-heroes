import 'package:flutter/material.dart';
import 'package:role_heroes/components/game_list.dart';

class GameScreen extends StatelessWidget {
  static const routeName = '/games';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GameList(),
      ),
    );
  }
}
