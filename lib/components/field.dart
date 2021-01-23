import 'package:flutter/material.dart';
import 'package:role_heroes/components/flushbar.dart';
import 'package:role_heroes/utils/value_types.dart';

import '../constants.dart';

class Field extends StatefulWidget {
  String name;
  IValueType type;
  dynamic value;
  Future Function(dynamic) setValue;

  Field({
    @required this.name,
    @required this.type,
    @required this.value,
    @required this.setValue,
  });

  @override
  State<StatefulWidget> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  final _editValueController = TextEditingController();

  Widget contentForAlert(context) {
    _editValueController.text = widget.value.toString();
    return TextField(
      controller: _editValueController,
      keyboardType: widget.type.getInputType(),
      decoration: InputDecoration(
        hintText: 'Fill field',
        filled: true,
        focusedBorder: UnderlineInputBorder(),
        labelStyle: Theme.of(context).textTheme.bodyText2
      ),
    );
  }

  void saveValue(BuildContext context) {
    String newValue = _editValueController.text;
    if (newValue != widget.value.toString()) {
      MainFlushbar processFlushbar = MainFlushbar(message: 'Process', showProgressIndicator: true)..show(context);
      widget.setValue(widget.type.convertValue(newValue))
        .then((value) {
          processFlushbar.dismiss();
          MainFlushbar(
              message: 'Success update',
              statusColor: Colors.red,
              duration: Duration(seconds: 2)
          )..show(context);
          Navigator.pop(context);
          setState(() { widget.value = newValue; });
        })
        .catchError((error) {
          processFlushbar.dismiss();
          MainFlushbar(
            message: error.toString(),
            statusColor: Colors.red,
            duration: Duration(seconds: 4)
          )..show(context);
          Navigator.pop(context);
      });
    }
  }

  void cancelEdit(BuildContext context) {
    Navigator.pop(context);
  }

  void onSubmitField(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.name),
          content: contentForAlert(context),
          actions: [
            FlatButton(
              onPressed: () { saveValue(context); },
              child: Text('Save'),
            ),
            FlatButton(
              onPressed: () { cancelEdit(context); },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { onSubmitField(context); },
      child: Container(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.name, style: Theme.of(context).textTheme.headline3),
              Text(widget.value.toString(), style: Theme.of(context).textTheme.bodyText1)
            ],
          ),
        ),
      ),
    );
  }
}
