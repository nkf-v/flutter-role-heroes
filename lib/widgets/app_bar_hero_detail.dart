import 'package:flutter/material.dart';
import 'package:role_heroes/widgets/category_tab.dart';

import '../constants.dart';

class AppBarHeroDetail extends AppBar {
  AppBarHeroDetail({
    @required String title,
    @required List<CategoryTab> tabs,
  }) : super(
      backgroundColor: Colors.white,
      elevation: 0,
      bottom: TabBar(tabs: tabs, isScrollable: true),
      title: Text(title, style: TextStyle(color: gTextColor),),
  );
}