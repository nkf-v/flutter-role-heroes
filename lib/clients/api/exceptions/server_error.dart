import 'package:flutter/cupertino.dart';

class ServerError implements Exception {
  Map _data;

  ServerError({
    @required data,
  }) {
    this._data = data;
  }

  Map get data => this._data;

  Map get errors => this.data['errors'];
}
