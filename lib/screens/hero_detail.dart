import 'package:flutter/material.dart';
import 'package:role_heroes/components/preloader.dart';
import 'package:role_heroes/controllers/user_hero.dart';
import 'package:role_heroes/modules/heroes/controller/user_hero.dart';
import 'package:role_heroes/modules/heroes/models/user_hero.dart';
import 'package:role_heroes/utils/builders/hero_detail_screen_builder.dart';
import 'package:role_heroes/widgets/category_tab.dart';

class HeroDetailScreen extends StatefulWidget {
  static String routeName = '/hero';
  final IUserHeroController controller = UserHeroController();

  @override
  State<StatefulWidget> createState() {
    return _HeroDetailScreenState(screenBuilder: HeroDetailScreenBuilder());
  }
}

class _HeroDetailScreenState extends State<HeroDetailScreen> {
  int heroId;
  IHeroDetailScreenBuilder screenBuilder;

  _HeroDetailScreenState({@required this.screenBuilder});

  @override
  Widget build(BuildContext context) {
    heroId = (ModalRoute.of(context).settings.arguments as Map<String, dynamic>)['heroId'] as int;
    return FutureBuilder(
      future: widget.controller.getDetail(heroId),
      builder: (context, AsyncSnapshot<UserHero> snapshot) {
        Widget result = Scaffold(
          body: Center(
            child: PreLoader(),
          ),
        );

        if (snapshot.hasData) {
          UserHero hero = snapshot.data;

          screenBuilder.reset();
          screenBuilder.build(hero, widget.controller);
          Map<CategoryTab, Widget> mapWidgets = screenBuilder.getResult();

          List<CategoryTab> categories = mapWidgets.keys.toList();

          result = DefaultTabController(
            length: categories.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Hero'),
                bottom: TabBar(tabs: categories, isScrollable: true),
              ),
              body: TabBarView(
                children: mapWidgets.values.toList(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          result = Scaffold(
            body: Center(
              child: Text(snapshot.error.toString()),
            ),
          );
        }

        return result;
      },
    );
  }
}
