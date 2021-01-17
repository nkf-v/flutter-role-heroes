import 'package:role_heroes/models/attribute.dart';
import 'package:role_heroes/models/category/category.dart';
import 'package:role_heroes/models/characteristic/characteristic.dart';
import 'package:role_heroes/models/user_hero/user_hero.dart';
import 'package:role_heroes/utils/value_types.dart';

class Mockups {
  static final List<Category> categories = [
//    Category(id: 1, name: 'Main fields'),
    Category(id: 1, name: 'Fields'),
//    Category(id: 3, name: 'Characteristics'),
//    Category(4, 'Traits'),
//    Category(5, 'Other fields'),
  ];

  static final UserHero hero = UserHero(
    id: 1,
    name: 'Hero name',
    characteristics: [
      Characteristic(id: 1, description: 'description', name: 'Wepon skills', value: 25),
      Characteristic(id: 2, description: 'description', name: 'Balistic skills', value: 25),
      Characteristic(id: 3, description: 'description', name: 'Strangth', value: 25),
      Characteristic(id: 4, description: 'description', name: 'Agility', value: 25),
      Characteristic(id: 5, description: 'description', name: 'Tough', value: 25),
      Characteristic(id: 6, description: 'description', name: 'Perception', value: 25),
      Characteristic(id: 7, description: 'description', name: 'Will power', value: 25),
      Characteristic(id: 8, description: 'description', name: 'Fellow ship', value: 25),
    ],
    attributes: [
      Attribute(id: 1, name: 'Gender', type: StringType(), value: 'male', category: Mockups.categories[0]),
      Attribute(id: 2, name: 'Age', type: IntType(), value: 24, category: Mockups.categories[0]),
      Attribute(id: 2, name: 'Money', type: IntType(), value: 900, category: Mockups.categories[0]),
    ],
    note: "Test note"
  );
}
