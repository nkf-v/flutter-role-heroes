import 'package:flutter/material.dart';
import 'package:role_heroes/clients/api/exceptions/server_error.dart';
import 'package:role_heroes/components/main_snackbar.dart';

abstract class IErrorNotificationBuilder {
  void rest();
  void build(ServerError error);
  SnackBar getResult();
}

class ErrorNotificationBuilder implements IErrorNotificationBuilder {
  MainSnackBar _snackbar;

  @override
  void build(ServerError error) {
    List<String> textErrors = <String>[];
    for (List errors in error.errors.values.toList()) {
      for (Map errorItem in errors) {
        // TODO code replace to message
        textErrors.add(errorItem['code']);
      }
    }
    _snackbar = MainSnackBar(
      content: Text(textErrors.join("\n")),
      duration: Duration(seconds: 10),
    );
  }

  @override
  SnackBar getResult() => _snackbar;

  @override
  void rest() {
    this._snackbar = MainSnackBar(
      content: Text('Ошибка сервиса'),
      duration: Duration(seconds: 10),
    );
  }
}
