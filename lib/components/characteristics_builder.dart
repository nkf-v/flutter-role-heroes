import 'package:flutter/material.dart';
import 'package:role_heroes/models/characteristic.dart';

import 'field.dart';

class CharacteristicsBuilder extends StatelessWidget {
  List<Characteristic> characteristics;

  CharacteristicsBuilder({@required this.characteristics});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characteristics.length,
      itemBuilder: itemBuild,
    );
  }

  Widget itemBuild(BuildContext context, int index) {
    Characteristic characteristic = characteristics.elementAt(index);
    return Field(name: characteristic.name, value: characteristic.value);
  }
}
