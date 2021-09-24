import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:role_heroes/models/structural_attribute/structural_attribute.dart';
import 'package:role_heroes/models/structural_value.dart';
import 'package:role_heroes/modules/heroes/widgets/structural_value_detail.dart';

class StructuralAttributeContent extends StatefulWidget {
  final StructuralAttribute attribute;

  const StructuralAttributeContent({
    Key key,
    @required this.attribute,
  }) : super(key: key);

  @override
  _StructuralAttributeContentState createState() => _StructuralAttributeContentState();
}

class _StructuralAttributeContentState extends State<StructuralAttributeContent> {
  List<DataRow> _getTableRows(BuildContext context) {
    List<DataRow> result = [];
    for (StructuralValue value in widget.attribute.values) {
      result.add(DataRow(
        cells: [
          DataCell(
            Text(value.name),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => StructuralValueDetail(
                  fields: widget.attribute.fields,
                  value: value,
                ),
              );
            }
          ),
        ],
      ));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> values = [];
    for (final StructuralValue value in widget.attribute.values) {
      values.add(
          ListTile(
            title: Text(value.name),
            onTap: () {
              showDialog(context: context, builder: (BuildContext context) {
                return StructuralValueDetail(fields: widget.attribute.fields, value: value);
              });
            },
          )
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 15.0),
          // padding: EdgeInsets.only(left: 25.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.attribute.name, style: Theme.of(context).textTheme.headline3),
              FloatingActionButton(onPressed: () {}, child: Icon(Icons.edit), mini: true),
            ],
          ),
        ),
        DataTable(
          headingRowHeight: 0,
          columns: [
            DataColumn(label: Text('Название')),
          ],
          rows: _getTableRows(context),
        )
      ],
    );
  }
}
