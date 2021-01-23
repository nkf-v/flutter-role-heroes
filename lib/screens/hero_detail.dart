import 'package:flutter/material.dart';
import 'package:role_heroes/components/preloader.dart';
import 'package:role_heroes/controllers/user_hero.dart';
import 'package:role_heroes/models/user_hero/user_hero.dart';
import 'package:role_heroes/utils/builders/hero_detail_screen_builder.dart';
import 'package:role_heroes/widgets/app_bar_hero_detail.dart';
import 'package:role_heroes/widgets/category_tab.dart';

class HeroDetailScreen extends StatefulWidget {
  static String routeName = '/hero';
  // TODO replace get controller realize
  IUserHeroController controller = UserHeroController();

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
      future: widget.controller.userHero(heroId),
      builder: (context, AsyncSnapshot<UserHero> snapshot) {
        Widget result = Scaffold(
          body: Center(
            child: PreLoader(),
          ),
        );

        if (snapshot.hasData) {
          UserHero hero = snapshot.data;

          screenBuilder.reset();
          screenBuilder.buildMainFieldsCategory(hero, widget.controller);
          screenBuilder.buildCharacteristicsCategory(hero, widget.controller);
          screenBuilder.buildCategories(hero);

          List<CategoryTab> categories = screenBuilder.getCategories();

          result = DefaultTabController(
            length: categories.length,
            child: Scaffold(
              appBar: AppBarHeroDetail(title: hero.name, tabs: categories),
              body: TabBarView(
                children: screenBuilder.getViews(),
              ),
            ),
          );
        }
        else if (snapshot.hasError) {
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
