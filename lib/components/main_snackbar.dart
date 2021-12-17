import 'package:flutter/material.dart';

class MainSnackBar extends SnackBar {
  MainSnackBar({
    Key key,
    void Function() onVisible,
    Widget content,
    duration,
  }) : super(
    key: key,
    content: content,
    duration: (duration == null) ? Duration(seconds: 15) : duration,
    padding: EdgeInsets.all(10.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    // TODO  этим методом есть проблемы. Доразобраться.
    onVisible: onVisible,
  );
}
