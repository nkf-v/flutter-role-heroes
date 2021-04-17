import 'package:flutter/material.dart';
import 'package:role_heroes/components/characteristics_builder.dart';
import 'package:role_heroes/components/field.dart';
import 'package:role_heroes/controllers/user_hero.dart';
import 'package:role_heroes/models/attribute.dart';
import 'package:role_heroes/models/category/category.dart';
import 'package:role_heroes/models/user_hero/user_hero.dart';
import 'package:role_heroes/utils/value_types.dart';
import 'package:role_heroes/widgets/category_tab.dart';

abstract class IHeroDetailScreenBuilder {
  void reset();
  void buildMainFieldsCategory(UserHero hero, IUserHeroController controller);
  void buildCharacteristicsCategory(UserHero hero, IUserHeroController controller);
  void buildCategories(UserHero hero, IUserHeroController controller);
  List<CategoryTab> getCategories();
  List<Widget> getViews();
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
  void buildMainFieldsCategory(UserHero hero, IUserHeroController controller) {
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
          Field(
            name: 'Name',
            type: StringType(),
            value: hero.name,
            setValue: (value) => controller.updateHero(hero.id, <String, String>{'name': value})
          ),
          Field(
            name: 'Note',
            type: StringType(),
            value: hero.note,
            setValue: (value) => controller.updateHero(hero.id, <String, String>{'note': value})
          ),
        ],
      )
    );
  }

  @override
  void buildCharacteristicsCategory(UserHero hero, IUserHeroController controller) {
    _categories.add(
        CategoryTab(
            category: Category(
              id: 0,
              name: 'Characteristics',
            )
        )
    );
    _views.add(
      CharacteristicsBuilder(hero: hero, controller: controller),
    );
  }

  @override
  void buildCategories(UserHero hero, IUserHeroController controller) {
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
            return Field(
              name: attribute.name,
              type: attribute.type,
              value: attribute.value,
              setValue: (value) { return controller.updateHeroAttribute(hero.id, attribute.id, <String, dynamic>{'value': value}); },
            );
          }
      )
      );
    });
  }

  @override
  List<CategoryTab> getCategories() {
    return _categories;
  }

  @override
  List<Widget> getViews() {
    return _views;
  }
}
