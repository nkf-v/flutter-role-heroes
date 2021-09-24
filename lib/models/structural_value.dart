import 'package:meta/meta.dart';
import 'package:role_heroes/models/structural_field_value.dart';

class StructuralValue {
  int id;
  String name;
  String description;
  List<StructuralFieldValue> fields;

  StructuralValue({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.fields,
  });

  factory StructuralValue.fromData(Map data) {
    List<StructuralFieldValue> fields = [];
    if (data.containsKey('fields')) {
      for (final Map fieldData in data['fields'])
        fields.add(StructuralFieldValue.fromData(fieldData));
    }

    return StructuralValue(
      id: data['id'] as int,
      name: data['name'] as String,
      description: data['description'] as String,
      fields: fields,
    );
  }
}
