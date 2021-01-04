import 'package:meta/meta.dart';
import 'package:role_heroes/models/attribute.dart';
import 'package:role_heroes/models/characteristic.dart';

class UserHero {
  int id;
  String name;
  String note;
  List<Characteristic> characteristics;
  List<Attribute> attributes;

  UserHero({
    @required this.id,
    @required this.name,
    @required this.characteristics,
    @required this.attributes,
    this.note,
  });
}
