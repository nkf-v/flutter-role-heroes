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
    duration: (duration == null) ? Duration(milliseconds: 1500) : duration,
    padding: EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    onVisible: onVisible,
  );
}
