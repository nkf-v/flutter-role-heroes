import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:role_heroes/components/hero_create.dart';

class HeroCreateScreen extends StatelessWidget {
  static String routeName = '/heroes/create';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).hero_create),
      ),
      body: HeroCreateForm(),
    );
  }
}
