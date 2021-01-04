import 'package:flutter/material.dart';
import 'package:role_heroes/components/preloader.dart';
import 'package:role_heroes/mockups/mockups.dart';
import 'package:role_heroes/models/user_hero.dart';
import 'package:role_heroes/utils/builders/hero_detail_screen_builder.dart';
import 'package:role_heroes/widgets/app_bar_hero_detail.dart';
import 'package:role_heroes/widgets/category_tab.dart';

class HeroDetailScreen extends StatefulWidget {
  static const routeName = '/heroDetail';

  @override
  State<StatefulWidget> createState() {
    return _HeroDetailScreenState(screenBuilder: HeroDetailScreenBuilder());
  }
}

class _HeroDetailScreenState extends State<HeroDetailScreen> {
  HeroDetailScreenBuilder screenBuilder;

  _HeroDetailScreenState({this.screenBuilder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserHero(),
      builder: (context, AsyncSnapshot<UserHero> snapshot) {
        Widget result = Scaffold(
          body: Center(
            child: PreLoader(),
          ),
        );
        if (snapshot.hasData) {
          UserHero hero = snapshot.data;

          screenBuilder.reset();
          screenBuilder.buildMainFieldsCategory(hero);
          screenBuilder.buildCharacteristicsCategory(hero);
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

        return result;
      },
    );
  }

  Future<UserHero> getUserHero() async {
    // TODO get hero by api client
    await Future.delayed(Duration(seconds: 2));
    return Mockups.hero;
  }
}

class HeroDetailScreenArguments {
  int heroId;
}
