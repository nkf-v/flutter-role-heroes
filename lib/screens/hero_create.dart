import 'package:flutter/material.dart';
import 'package:role_heroes/components/hero_create.dart';
import 'package:role_heroes/widgets/app_bar_default.dart';

class HeroCreateScreen extends StatelessWidget {
  static String routeName = '/heroes/create';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Create hero',),
      body: HeroCreateForm(),
    );
  }
}
