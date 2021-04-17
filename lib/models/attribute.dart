import 'package:flutter/material.dart';
import 'package:role_heroes/models/category/category.dart';
import 'package:role_heroes/utils/value_types.dart';

class Attribute {
  int id;
  String name;

  IValueType type;
  dynamic _value;
  Category category;

  Attribute({
    @required this.id,
    @required this.name,
    @required this.type,
    @required dynamic value,
    @required this.category,
  }) {
    _value = value;
  }

  get value {
    var result;
    if (_value != null)
      result = type.convertValue(_value.toString());
    return result;
  }

  set value(dynamic value) {
    _value = value;
  }

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      id: json['id'] as int,
      name: json['name'] as String,
      type: ValueTypeFactory.getTypeBuName(json['type']),
      value: json['value'] ?? null,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
    );
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'type': type.getNameType(),
    'value': value,
    'category': category.toJson(),
  };
}
