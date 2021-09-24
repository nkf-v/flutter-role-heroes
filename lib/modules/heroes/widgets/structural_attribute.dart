import 'package:flutter/material.dart';
import 'package:role_heroes/constants.dart';
import 'package:role_heroes/models/structural_attribute/structural_attribute.dart';
import 'package:role_heroes/modules/heroes/widgets/structural_attribute_content.dart';

class StructuralAttributeWidget extends StatefulWidget {
  final StructuralAttribute attribute;

  const StructuralAttributeWidget({
    Key key,
    @required this.attribute,
  }) : super(key: key);

  @override
  _StructuralAttributeWidgetState createState() => _StructuralAttributeWidgetState();
}

class _StructuralAttributeWidgetState extends State<StructuralAttributeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: gDefaultMargin, vertical: gDefaultMargin / 2),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(gDefaultPadding),
        child: StructuralAttributeContent(
          attribute: this.widget.attribute,
        ),
      ),
    );
  }
}
