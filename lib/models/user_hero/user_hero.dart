import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:role_heroes/models/attribute.dart';
import 'package:role_heroes/models/characteristic/characteristic.dart';

part 'user_hero.g.dart';

@JsonSerializable()
class UserHero {
  int id;
  String name;
  String note;
  List<Characteristic> characteristics;
  List<Attribute> attributes;

  UserHero({
    @required this.id,
    @required this.name,
    this.characteristics,
    this.attributes,
    this.note,
  });

  factory UserHero.fromJson(Map<String, dynamic> json) => _$UserHeroFromJson(json);
  Map<String, dynamic> toJson() => _$UserHeroToJson(this);
}
