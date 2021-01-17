import 'package:flutter/material.dart';
import 'package:role_heroes/constants.dart';
import 'package:role_heroes/models/game/game.dart';

class GameCard extends StatelessWidget {
  Game game;

  GameCard({@required this.game});

  showDescription(BuildContext context, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(description),
          actions: [
            FlatButton(
                onPressed: () { Navigator.pop(context); },
                child: Text('Close')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(game.id),
      child: InkWell(
        onTap: () { print('ink'); },
        child: Padding(
          padding: const EdgeInsets.only(top: gDefaultPadding, left: gDefaultPadding, right: gDefaultPadding, bottom: gDefaultPadding / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: gDefaultMargin / 2),
                child: Row(
                  children: [
                    Text(game.name),
                  ],
                ),
              ),
              Row(
                children: [
                  OutlineButton(
                    onPressed: () { showDescription(context, game.description); },
                    child: Text('Description'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}