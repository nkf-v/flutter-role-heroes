import 'package:flutter/material.dart';
import 'package:role_heroes/components/flushbar.dart';
import 'package:role_heroes/components/preloader.dart';
import 'package:role_heroes/constants.dart';
import 'package:role_heroes/controllers/user_hero.dart';
import 'package:role_heroes/models/user_hero/user_hero.dart';
import 'package:role_heroes/screens/hero_detail.dart';
import 'package:role_heroes/utils/enum_helper.dart';

enum ActionByUserHero { Delete }

class HeroList extends StatefulWidget {
  final int gameId;
  // TODO replace get controller realize
  final IUserHeroController controller = UserHeroController();

  HeroList({@required this.gameId});

  @override
  State<StatefulWidget> createState() {
    return _HeroListState();
  }
}

class _HeroListState extends State<HeroList> {
  ActionByUserHero currentAction;

  onSelectAction(ActionByUserHero action, int heroId) async {
    MainFlushbar processFlushbar = MainFlushbar(message: 'Process', showProgressIndicator: true)..show(context);
    if (action == ActionByUserHero.Delete) {
      widget.controller.deleteHero(heroId).then((value) {
        processFlushbar.dismiss();
        MainFlushbar(
            message: 'Delete hero success',
            statusColor: Colors.green,
            duration: Duration(seconds: 1)
        )..show(context);
        setState(() {});
      }).catchError((error) {
        processFlushbar.dismiss();
        MainFlushbar(
            message: error.toString(),
            statusColor: Colors.red,
            duration: Duration(seconds: 3)
        )..show(context);
      });
    }
  }

  Widget builderHeroMenu(int heroId) {
    return PopupMenuButton<ActionByUserHero>(
      onSelected: (action) { onSelectAction(action, heroId); },
      itemBuilder: (BuildContext context) => ActionByUserHero.values
        .map((action) =>
          PopupMenuItem<ActionByUserHero>(
            value: action,
            child: Text(EnumHelper.getLabelEnum<ActionByUserHero>(action)),
          )
        ).toList(),
    );
  }

  @override
  build(BuildContext context) {
    // TODO: Learn RefreshIndicator
    return FutureBuilder(
      future: widget.controller.userHeroes(widget.gameId),
      builder: (BuildContext context, AsyncSnapshot<List<UserHero>> snapshot) {
        Widget result = Center(
          child: PreLoader(),
        );

        if (snapshot.hasData) {
          return Container(
            padding: EdgeInsets.all(gDefaultPadding / 2),
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                UserHero userHero = snapshot.data.elementAt(index);
                return InkWell(
                  key: ValueKey(userHero.id),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        HeroDetailScreen.routeName, arguments: <
                        String,
                        dynamic>{'heroId': userHero.id});
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(gDefaultPadding / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(userHero.name),
                              builderHeroMenu(userHero.id),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        return result;
      },
    );
  }
}
