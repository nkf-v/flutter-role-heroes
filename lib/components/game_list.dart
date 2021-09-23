import 'package:flutter/material.dart';
import 'package:role_heroes/components/game_card.dart';
import 'package:role_heroes/components/preloader.dart';
import 'package:role_heroes/constants.dart';
import 'package:role_heroes/controllers/game.dart';
import 'package:role_heroes/modules/games/controllers/controller.dart';
import 'package:role_heroes/modules/games/models/game.dart';

import 'main_snackbar.dart';

class GameList extends StatefulWidget {
  // TODO replace get controller realize
  final IGameController controller = GameController();

  @override
  State<StatefulWidget> createState() {
    return _GameListState();
  }
}

class _GameListState extends State<GameList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.controller.games(),
      builder: (BuildContext context, AsyncSnapshot<List<Game>> snapshot) {
        Widget result = Container(
          alignment: AlignmentDirectional.center,
          child: PreLoader(),
        );

        if (snapshot.hasData) {
          result = Container(
            padding: EdgeInsets.all(gDefaultPadding / 2),
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return GameCard(game: snapshot.data.elementAt(index));
              }
            ),
          );
        } else if (snapshot.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(MainSnackBar(content: Text('Не удалось получить игры')));

          result = Container(
            alignment: Alignment.center,
            child: Text(snapshot.error, style: Theme.of(context).textTheme.bodyText2),
          );
        }

        return result;
      }
    );
  }
}
