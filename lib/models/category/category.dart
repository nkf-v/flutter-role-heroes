import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  int id;
  String name;

  Category({
    this.id,
    @required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType == Category)
      return id == (other as Category).id;
    return super == other;
  }
}
