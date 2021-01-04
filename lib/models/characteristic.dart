import 'package:meta/meta.dart';

class Characteristic {
  int id;
  String name;
  String description;
  int value;

  Characteristic({
      @required this.id,
      @required this.name,
      @required this.description,
      @required this.value
  });
}
