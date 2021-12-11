import 'package:flutter/material.dart';
import 'package:role_heroes/components/main_snackbar.dart';
import 'package:role_heroes/components/pre_loader_widget.dart';
import 'package:role_heroes/controllers/structural_attribute.dart';
import 'package:role_heroes/modules/heroes/models/user_hero.dart';
import 'package:role_heroes/modules/structural_attribute/controllers/controller.dart';
import 'package:role_heroes/modules/structural_attribute/models/structural_attribute.dart';
import 'package:role_heroes/modules/structural_attribute/models/structural_value.dart';
import 'package:role_heroes/modules/structural_attribute/widgets/structural_value_detail.dart';

class StructuralAttributeValuesSelect extends StatefulWidget {
  final UserHero hero;
  final StructuralAttribute attribute;
  final IStructuralAttributeController controller = StructuralAttributeController();

  StructuralAttributeValuesSelect({
    Key key,
    @required this.hero,
    @required this.attribute,
  }) : super(key: key);

  @override
  _StructuralAttributeValuesSelectState createState() => _StructuralAttributeValuesSelectState();
}

class _StructuralAttributeValuesSelectState extends State<StructuralAttributeValuesSelect> {
  final TextEditingController controller = new TextEditingController();
  String _query = '';

  List<DataRow> _getDataRowsFromValues(List<StructuralValue> values) {
    values = values.where((value) {
      final String query = _query.toLowerCase();
      final bool queryContainToDescription = value.description == null && query == ''
        || value.description != null && value.description.toLowerCase().contains(query);
      return value.name.toLowerCase().contains(query)
          || queryContainToDescription;
    }).toList();

    return values.map((StructuralValue value) {
      return DataRow(
        cells: [
          DataCell(
            Text(value.name),
            onTap: () {
              showDialog(context: context, builder: (BuildContext context) => StructuralValueDetail(fields: widget.attribute.fields, value: value));
            },
          ),
        ],
        selected: widget.attribute.values.contains(value),
        onSelectChanged: (bool selected) {
          setState(() {
            widget.attribute.selectedValue(value);
          });
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выберите значения'),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(MainSnackBar(content: Text('Прелоадер')));
              widget.controller.setUserHeroStructuralValues(widget.hero, widget.attribute)
                .then((response) {
                  Navigator.of(context).pop();
                },
                onError: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(MainSnackBar(content: Text(error.toString())));
                });
            },
            icon: Icon(Icons.done),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: controller,
              onChanged: (query) {
                setState(() {
                  _query = query;
                });
              },
              decoration: InputDecoration(
                labelText: 'Поиск',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: FutureBuilder(
                  future: widget.controller.getValues(widget.attribute),
                  builder: (BuildContext context, AsyncSnapshot<List<StructuralValue>> snapshot) {
                    if (!snapshot.hasData && snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: PreLoaderWidget(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error');
                    }

                    return DataTable(
                      columns: [
                        DataColumn(label: Text('Название')),
                      ],
                      rows: _getDataRowsFromValues(snapshot.data),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
