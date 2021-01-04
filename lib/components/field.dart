import 'package:flutter/material.dart';

import '../constants.dart';

class Field extends StatelessWidget {
  String name;
  dynamic value;

  final _editValueController = TextEditingController();

  Field({
    @required this.name,
    @required this.value,
  });

  Widget viewValue(BuildContext context) {
    return Text(
      value.toString(),
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  Widget contentForAlert(context) {
    _editValueController.text = value.toString();
    return TextField(
      controller: _editValueController,
      keyboardType: TextInputType.text,
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
    if (newValue != value.toString()) {
      value = newValue;
    }
  }

  void cancelEdit(BuildContext context) {
    Navigator.pop(context);
  }

  void onSubmitField(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        // TODO Create dialog how statefull
        return AlertDialog(
          title: Text(name),
          content: contentForAlert(context),
          actions: [
            FlatButton(
                onPressed: () { saveValue(context); },
                child: Text('Save')
            ),
            FlatButton(
                onPressed: () { cancelEdit(context); },
                child: Text('Cancel')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSubmitField(context);
      },
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
              Text(
                name,
                style: Theme.of(context).textTheme.headline3,
              ),
              viewValue(context),
            ],
          ),
        ),
      ),
    );
  }
}
