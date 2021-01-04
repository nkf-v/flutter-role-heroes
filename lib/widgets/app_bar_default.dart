import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DefaultAppBar extends AppBar {
  DefaultAppBar({
    @required String title
  }) : super(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(color: gTextColor),
    ),
  );
}