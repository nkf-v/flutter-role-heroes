import 'package:flutter/material.dart';
import 'package:role_heroes/components/preloader.dart';
import 'package:role_heroes/constants.dart';
import 'package:role_heroes/controllers/user_hero.dart';
import 'package:role_heroes/models/user_hero/user_hero.dart';
import 'package:role_heroes/screens/hero_detail.dart';

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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.controller.userHeroes(widget.gameId),
      builder: (BuildContext context, AsyncSnapshot<List<UserHero>> snapshot) {
        Widget result = Container(
          alignment: Alignment.center,
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
                  onTap: () { Navigator.of(context).pushNamed(HeroDetailScreen.routeName, arguments: <String, dynamic>{'heroId': userHero.id}); },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(gDefaultPadding / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userHero.name),
                        ],
                      ),
                    ),
                  ),
                );
              }
            ),
          );
        }
        else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        return result;
      },
    );
  }
}