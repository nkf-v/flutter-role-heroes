import 'package:flutter/material.dart';
import 'package:role_heroes/models/category.dart';

class CategoryTab extends Tab {
  CategoryTab({@required Category category}) : super(child: Text(category.name));
}