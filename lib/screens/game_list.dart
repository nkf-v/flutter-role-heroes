import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  static const routeName = '/games';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Text('Game list screen'),
      ),
    );
  }
}
