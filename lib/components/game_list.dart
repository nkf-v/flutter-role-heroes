import 'package:flutter/material.dart';
import 'package:role_heroes/components/flushbar.dart';
import 'package:role_heroes/components/game_card.dart';
import 'package:role_heroes/components/preloader.dart';
import 'package:role_heroes/constants.dart';
import 'package:role_heroes/controllers/game.dart';
import 'package:role_heroes/models/game/game.dart';

class GameList extends StatefulWidget {
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
        }
        else if (snapshot.hasError) {
          result = Container(
            alignment: Alignment.center,
            child: Text('Empty', style: Theme.of(context).textTheme.bodyText2),
          );

          MainFlushbar(
            message: snapshot.error.toString(),
            duration: Duration(seconds: 5),
          ).show(context);
        }

        return result;
      }
    );
  }
}
