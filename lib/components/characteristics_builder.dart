import 'package:flutter/material.dart';
import 'package:role_heroes/controllers/user_hero.dart';
import 'package:role_heroes/models/characteristic/characteristic.dart';
import 'package:role_heroes/modules/heroes/models/user_hero.dart';
import 'package:role_heroes/modules/heroes/widgets/field.dart';
import 'package:role_heroes/utils/value_types.dart';

class CharacteristicsBuilder extends StatelessWidget {
  final IUserHeroController controller;

  UserHero hero;

  CharacteristicsBuilder({
    @required this.hero,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hero.characteristics.length,
      itemBuilder: itemBuild,
    );
  }

  Widget itemBuild(BuildContext context, int index) {
    Characteristic characteristic = hero.characteristics.elementAt(index);
    return Field(
      name: characteristic.name,
      type: IntType(),
      value: characteristic.value,
      setValue: (value) {
        characteristic.value = value;
        return controller.updateCharacteristic(hero, characteristic);
      },
    );
  }
}
