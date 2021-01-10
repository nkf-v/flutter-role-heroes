import 'package:flutter/material.dart';
import 'package:role_heroes/utils/value_types.dart';

import 'category.dart';

class Attribute {
  int id;
  String name;

  IValueType type;
  String _value;
  Category category;

  Attribute({
    @required this.id,
    @required this.name,
    @required this.type,
    @required dynamic value,
    @required this.category,
  }) {
    _value = value.toString();
  }

  get value => type.convertValue(_value);

  set value(dynamic value) {
    _value = value.toString();
  }
}
