import 'package:flutter/material.dart';
import 'package:role_heroes/models/structural_attribute/structural_attribute.dart';
import 'package:role_heroes/models/structural_field.dart';
import 'package:role_heroes/models/structural_value.dart';

class SelectStructuralItem extends StatefulWidget {
  StructuralAttribute attribute;
  List<StructuralField> fields;
  List<StructuralValue> selectedValues;

  SelectStructuralItem({
    @required this.attribute,
    @required this.fields,
    @required this.selectedValues
  });

  @override
  _SelectFieldState createState() => _SelectFieldState();
}

class _SelectFieldState extends State<SelectStructuralItem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
