import 'package:flutter/cupertino.dart';
import 'package:role_heroes/components/characteristics_builder.dart';
import 'package:role_heroes/components/field.dart';
import 'package:role_heroes/models/attribute.dart';
import 'package:role_heroes/models/category/category.dart';
import 'package:role_heroes/models/user_hero/user_hero.dart';
import 'package:role_heroes/widgets/category_tab.dart';

abstract class IHeroDetailScreenBuilder {
  void reset();
  void buildMainFieldsCategory(UserHero hero);
  void buildCharacteristicsCategory(UserHero hero);
  void buildCategories(UserHero hero);
}

class HeroDetailScreenBuilder extends IHeroDetailScreenBuilder {
  List<CategoryTab> _categories;
  List<Widget> _views;

  @override
  void reset() {
    _categories = [];
    _views = [];
  }

  @override
  void buildMainFieldsCategory(UserHero hero) {
    _categories.add(
      CategoryTab(
        category: Category(
          id: 0,
          name: 'Base fields'
        )
      )
    );
    _views.add(
      Column(
        children: [
          Field(name: 'Name', value: hero.name),
          Field(name: 'Note', value: hero.note),
        ],
      )
    );
  }

  @override
  void buildCharacteristicsCategory(UserHero hero) {
    _categories.add(
        CategoryTab(
            category: Category(
              id: 0,
              name: 'Characteristics',
            )
        )
    );
    _views.add(
      CharacteristicsBuilder(characteristics: hero.characteristics),
    );
  }

  @override
  void buildCategories(UserHero hero) {
    Map<Category, List<Attribute>> categoriesAttributes = Map.fromIterable(hero.attributes, key: (attribute) => attribute.category, value: (attribute) => []);
    hero.attributes.forEach((Attribute attribute) {
      categoriesAttributes[attribute.category].add(attribute);
    });
    categoriesAttributes.forEach((Category category, List<Attribute> attributes) {
      _categories.add(CategoryTab(category: category));
      _views.add(ListView.builder(
          itemCount: attributes.length,
          itemBuilder: (context, index) {
            Attribute attribute = attributes.elementAt(index);
            return Field(name: attribute.name, value: attribute.value);
          }
      )
      );
    });
  }

  List<CategoryTab> getCategories() {
    return _categories;
  }

  List<Widget> getViews() {
    return _views;
  }
}