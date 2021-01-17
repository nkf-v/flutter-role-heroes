import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'characteristic.g.dart';

@JsonSerializable()
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

  factory Characteristic.fromJson(Map<String, dynamic> json) => _$CharacteristicFromJson(json);
  Map<String, dynamic> toJson() => _$CharacteristicToJson(this);
}
