import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  int id;
  String name;
  String description;

  Game({
    @required this.id,
    @required this.name,
    @required this.description,
  });

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}
