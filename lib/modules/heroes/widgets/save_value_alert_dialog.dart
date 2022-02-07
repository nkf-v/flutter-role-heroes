import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:role_heroes/clients/api/exceptions/server_error.dart';
import 'package:role_heroes/components/main_snackbar.dart';
import 'package:role_heroes/utils/value_types.dart';
import 'package:role_heroes/widgets/pre_loader.dart';

class SaveFieldValueAlertDialog extends StatelessWidget {
  final String title;
  final IValueType type;
  dynamic value;

  final Future Function(dynamic) setValue;
  final void Function(dynamic) successSaveValue;

  final _editValueController = TextEditingController(text: '');

  SaveFieldValueAlertDialog({
    Key key,
    @required this.title,
    @required this.value,
    @required this.type,
    @required this.setValue,
    @required this.successSaveValue,
  }) : super(key: key);

  void saveValue(BuildContext context) {
    String newValue = _editValueController.text == '' ? null : _editValueController.text;
    String oldValue = this.value == null ? null : this.value.toString();

    if (newValue == oldValue) {
      PreLoader.show(context);
      this.setValue(this.value)
        .then((value) {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            MainSnackBar(
              content: Text('Значение обновлено'),
              duration: Duration(seconds: 2),
            )
          );

          this.value = newValue;
          this.successSaveValue(this.value);
        })
        .catchError((error) {
          SnackBar snackBar = MainSnackBar(
            content: Text(AppLocalizations.of(context).service_error),
          );

          if (error.runtimeType == ServerError) {
            snackBar = ServerError.toSnackBar(error);
          }

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }).whenComplete(() {
          PreLoader.hide(context);
      });
    }
  }

  void cancelEdit(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (this.value != null) {
      _editValueController.text = this.value.toString();
    }

    return AlertDialog(
      title: Text(this.title),
      content: TextField(
        onChanged: (newValue) { this.value = this.type.convertValue(newValue); },
        controller: _editValueController,
        keyboardType: this.type.getInputType(),
        autofocus: true,
        decoration: InputDecoration(
            hintText: 'Fill field',
            filled: true,
            focusedBorder: UnderlineInputBorder(),
            labelStyle: Theme.of(context).textTheme.bodyText2
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () { saveValue(context); },
          child: Text('Save'),
        ),
        ElevatedButton(
          // TODO create style
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
          onPressed: () { cancelEdit(context); },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
